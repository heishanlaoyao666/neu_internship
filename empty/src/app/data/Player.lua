--[[--
    Player.lua
    Player基类
]]
local Player = class("Player")
local DamageInfo =require("app/data/DamageInfo.lua")
local ConstDef = require("app/def/ConstDef.lua")
local EventDef = require("app/def/EventDef.lua")
local TowerDef = require("app/def/TowerDef.lua")

local Monster = require("app/data/Enemy.lua")
local Tower = require("app/data/Tower.lua")
local Bullet = require("app/data/Bullet.lua")
local BuffTable = require("app/data/BuffTable.lua")

local EventManager = require("app/manager/EventManager.lua")
local bullets_= {} --子弹数组
local monsters_ = {} --敌人数组
local tower_array = {} --塔阵容
local sp = 0 --sp点数
local sp_cost = 10 --生成塔需要的cost
function Player:ctor()
    self.towers={} --二维数组
    self.tag_ = 0 --玩家所在半区标签
    for i = 1,3 do
        self.towers[i]={}
        for j = 1,5 do
            self.towers[i][j]=nil
        end
    end
end
--[[--
    初始化数据

    @param array
    @param tag

    @return none
]]
function Player:init(array,tag)
    sp = 100
    tower_array=array
    self.tag_=tag
    EventManager:regListener(EventDef.ID.INIT_BULLET, self, function(tower)
        self:bulletCreate(tower)
    end)
end
--[[--
    获取塔数组

    @param none

    @return towers
]]
function Player:getTowers()
    return self.towers
end
--[[--
    获取塔阵容

    @param number

    @return tower_array
]]
function Player:getTowerArray()
    return tower_array
end
--[[--
    塔创建

    @param none

    @return number
]]
function Player:createTower()
    if sp<sp_cost then
        return
    end
    sp=sp-sp_cost
    local id=math.random(1,5)
    self:createTowerEnd(tower_array[id].id_,tower_array[id].level_,tower_array[id].grade_)
end
--[[--
    塔最终创建

    @param id 
    @param level
    @param grade

    @return number
]]
function Player:createTowerEnd(id,level,grade)
    local tower=Tower.new(id,level,grade)
        local random = math.random(1,15)
        local sum = 0
        while tower_array[random]~=nil do
            if sum == 15 then
                return
            end
            sum =sum+1
            random = math.random(1,15)
        end
        local x = random%5
        local y =math.modf(random/5)+1
        if x == 0 then
            x = 5
        end
        if random%5 == 0 then
            y = y-1
        end
        print(x.." "..y)
        tower:setX(ConstDef.TOWER_POS.DOWN_X+ConstDef.TOWER_POS.MOVE_X*(x-1))
        tower:setY(ConstDef.TOWER_POS.DOWN_Y+ConstDef.TOWER_POS.MOVE_Y*(y-1))
        self.towers[y][x] = tower
    --为塔添加buff
    for i = 1, #TowerDef.BUFF[id].TOWER do
        local data = TowerDef.BUFF[id].TOWER[i]
        local value = TowerDef.TABLE[id].SKILLS[1]
        tower:addBuff(BuffTable:addBuffInfo(
            nil,
            tower,
            BuffTable[data.NAME],
            BuffTable[data.ADDSTACK],
            true,
            BuffTable[data.PERMANENT],
            0,
            value.VALUE+value.VALUE_UPGRADE*(tower:getLevel()-1)+value.VALUE_ENHANCE*(tower:getGrade()-1)
        ))
    end
end
--[[--
    怪物创建

    @param none

    @return number
]]
function Player:createMonster()
    local monster = Monster.new()
    monster:setTarget(ConstDef.TARGET[self.tag_])
    monsters_[#monsters_+1] = monster
end
function Player:update(dt)
    local destoryBullets = {}
    local destoryTowers = {}
    local destoryMonster = {}
    for i = 1, #bullets_ do
        local bullet =bullets_[i]
        bullet:update(dt)
        if bullet:isDeath() then
            destoryBullets[#destoryBullets + 1] = bullet
        else
            self:checkCollider(bullet:getTarget(),bullet)
        end
    end
    for i = 1, 3 do
        for j = 1, 5 do
            if self.towers[i][j]~=nil then
                self.towers[i][j]:update(dt)
            end
        end
    end

    for i = 1, #monsters_ do
        monsters_[i]:update(dt)
        if not monsters_[i]:isDeath() then
        else
            destoryMonster[#destoryMonster + 1] = monsters_[i]
        end
    end

    -- for i = 1, #allies_ do
    --     allies_[i]:update(dt)
    -- end

    -- 清理失效子弹
    for i = #destoryBullets, 1, -1 do
        for j = #bullets_, 1, -1 do
            if bullets_[j] == destoryBullets[i] then
                table.remove(bullets_, j)
            end
        end
    end

    -- 清理失效怪物
    for i = #destoryMonster, 1, -1 do
        for j = #monsters_, 1, -1 do
            if monsters_[j] == destoryMonster[i] then
                table.remove(monsters_, j)
            end
        end
    end
end
--[[--
    碰撞检查

    @param monster 类型：Enemy，怪物
    @param bullets 类型：Bullet数组

    @return none
]]
function Player:checkCollider(monster, bullet)
    if monster:isDeath() then
        bullet:destory()
    end
    if not bullet:isDeath() then
        if monster:isCollider(bullet) then
            self:hitMonster(monster, bullet)
        end
    end
end
--[[--
    子弹创建

    @param tower 类型:塔

    @return number
]]
function Player:bulletCreate(tower)

    local bullet = Bullet.new(tower)
    bullet:setX(tower:getX())
    bullet:setY(tower:getY())
    bullets_[#bullets_+1] = bullet
    --为子弹添加buff
    for i = 1, #TowerDef.BUFF[tower:getID()].BULLET do
        local data = TowerDef.BUFF[tower:getID()].BULLET[i]
        local value = TowerDef.TABLE[tower:getID()].SKILLS[i]
        bullet:addBuff(BuffTable:addBuffInfo(
            nil,
            bullet,
            BuffTable[data.NAME],
            BuffTable[data.ADDSTACK],
            true,
            BuffTable[data.PERMANENT],
            0,
            value.VALUE+value.VALUE_UPGRADE*(tower:getLevel()-1)+value.VALUE_ENHANCE*(tower:getGrade()-1)
        ))
    end
    local monster = nil
    if tower:getMode() == TowerDef.MODE.FRIST then
        monster=monsters_[1]
    end
    if tower:getMode() == TowerDef.MODE.MAXLIFE then
        monster=monsters_[1]
        for i = 1, #monsters_ do
            if monster:getLife()<monsters_[i]:getLife() then
                monster=monsters_[i]
            end
        end
    end
    if tower:getMode() == TowerDef.MODE.RANDOM then
        monster =monsters_[math.random(1,#monsters_)]
    end
    if monster then
        bullet:setTarget(monster)
    end
end
--[[--
    伤害处理

    @param monster 类型：Enemy，怪物
    @param bullet 类型：Bullet

    @return none
]]
function Player:hitMonster(monster, bullet)
    DamageInfo.new(bullet:getTower(),monster,bullet:getTower():getAtk(),ConstDef.DAMAGE.NORMAL,self)
    bullet:destory()
end
--[[--
    获取子弹所在半区怪物信息

    @param bullet

    @return number
]]
function Player:getMonsterForBullet(bullet)
    return monsters_
end
return Player