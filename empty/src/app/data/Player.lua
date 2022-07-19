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

function Player:ctor()
    self.towers={} --二维数组
    self.tag_ = 0 --玩家所在半区标签
    self.name_=""
    self.bullets_= {} --子弹数组
    self.monsters_ = {} --敌人数组
    self.tower_array = {} --塔阵容
    self.sp_ = 0 --sp点数
    self.sp_cost = 10 --生成塔需要的cost
    self.life=3
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
    self.life=3
    self.sp_ = 100
    self.tower_array=array
    self.tag_=tag
    EventManager:regListener(EventDef.ID.INIT_BULLET, self, function(tower)
        self:bulletCreate(tower)
    end)
end
--[[--
    设置玩家名字

    @param name: 类型：string,玩家名字
    @return none
]]
function Player:setName(name)
    self.name_=name
end
--[[--
    设置玩家所在半区标签

    @param none
    @return tag
]]
function Player:getTag()
    return self.tag_
end
--[[--
    获取玩家名字

    @param none
    @return self.name_
]]
function Player:getName()
    return self.name_
end
--[[--
    获取玩家生命

    @param none

    @return sp_cost
]]
function Player:getLife()
    return self.life
end
--[[--
    设置玩家生命

    @param none

    @return sp_cost
]]
function Player:setLife()
    return self.life
end
--[[--
    获取生成点数cost

    @param none

    @return sp_cost
]]
function Player:getSpCost()
    return self.sp_cost
end
--[[--
    设置sp点数

    @param sp_ 类型:number

    @return sp
]]
function Player:setSp(sp_)
    self.sp_=self.sp_+sp_
    return self.sp_
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
    return self.tower_array
end
--[[--
    获取怪物数组

    @param number

    @return tower_array
]]
function Player:getMonster()
    return self.monsters_
end
--[[--
    获取塔阵容第i个的强化所需费用

    @param i 类型:number,塔阵容的第几个

    @return tower_array
]]
function Player:getTowerGradeCost(i)
    return TowerDef.GRADE_COST[self.tower_array[i].grade_]
end
--[[--
    获取塔阵容

    @param i 类型:number,塔阵容的第几个

    @return tower_array
]]
function Player:getTowerGrade(i)
    return self.tower_array[i].grade_
end
--[[--
    塔阵容某个塔强化

    @param i 类型:number,塔的排序

    @return none
]]
function Player:upTowerGrade(i)
    if self.sp_ >=TowerDef.GRADE_COST[self.tower_array[i].grade_] then
        self.sp_=self.sp_-TowerDef.GRADE_COST[self.tower_array[i].grade_]
        self.tower_array[i].grade_=self.tower_array[i].grade_+1
    end
end
function Player:towerCreateCost()
    self.sp_=self.sp_-self.sp_cost
    self.sp_cost=self.sp_cost+10
end
--[[--
    塔创建

    @param none

    @return table
]]
function Player:createTower()
    local sum =0 
    for i = 1, 3 do
        for j = 1, 5 do
            if self.towers[i][j] then
                sum=sum+1
            end
        end
    end
    if sum == 15 then
        return nil
    end
    if self.sp_<self.sp_cost then
        return nil
    end
    local random = math.random(1,15)
    local x = random%5
    local y =math.modf(random/5)+1
    if x == 0 then
        x = 5
    end
    if random%5 == 0 then
        y = y-1
    end
    while self.towers[y][x]~=nil do
        random = math.random(1,15)
        x = random%5
        y =math.modf(random/5)+1
        if x == 0 then
            x = 5
        end
        if random%5 == 0 then
            y = y-1
        end
    end
    local table = {
        x = x,
        y =y,
    }
    return table
    --self:createTowerEnd(self.tower_array[id].id_,self.tower_array[id].level_,self.tower_array[id].grade_,x,y)
end

--[[--
    塔最终创建

    @param id
    @param x
    @param y

    @return number
]]
function Player:createTowerEnd(id,x,y,grade)
    local tower=Tower.new(self.tower_array[id].id_,self.tower_array[id].level_,grade or self.tower_array[id].grade_,self)
    if self.tag_==ConstDef.GAME_TAG.UP then
        tower:setX(ConstDef.TOWER_POS.UP_X+ConstDef.TOWER_POS.MOVE_X_UP*(x-1))
        tower:setY(ConstDef.TOWER_POS.UP_Y+ConstDef.TOWER_POS.MOVE_Y_UP*(y-1))
    else
        tower:setX(ConstDef.TOWER_POS.DOWN_X+ConstDef.TOWER_POS.MOVE_X_DOWN*(x-1))
        tower:setY(ConstDef.TOWER_POS.DOWN_Y+ConstDef.TOWER_POS.MOVE_Y_DOWN*(y-1))
    end
    self.towers[y][x] = tower
    --为塔添加buff
    for i = 1, #TowerDef.BUFF[id].TOWER do
        local data = TowerDef.BUFF[id].TOWER[i]
        local value = TowerDef.TABLE[id].SKILLS[i]
        tower:addBuff(BuffTable:addBuffInfo(
            nil,
            tower,
            BuffTable[data.NAME],
            data.ADDSTACK,
            true,
            data.PERMANENT,
            0,
            value.VALUE+value.VALUE_UPGRADE*(tower:getLevel()-1)+value.VALUE_ENHANCE*(tower:getGrade()-1)
        ))
    end
end
--[[--
    塔合成

    @param tower1
    @param tower2
    @param id

    @return number
]]
function Player:composeTower(tower1_x,tower1_y,tower2_x,tower2_y,id)
    self.towers[tower1_y][tower1_x]:destory()
    self.towers[tower2_y][tower2_x]:destory()
    self:createTowerEnd(self.tower_array[id].id_,tower1_x,tower1_y,self.towers[tower1_y][tower1_x]:getGrade()+1)
end
--[[--
    怪物创建

    @param life 类型:number,怪物血量
    @param sp 类型:number,怪物击败获得的sp
    @param tag 类型:number,怪物类型

    @return number
]]
function Player:createMonster(life,givesp,tag)
    local monster = Monster.new(life,givesp,tag,self)
    --给monster添加buff
    for i = 1, #ConstDef.BUFF[tag] do
        local data = ConstDef.BUFF[tag][i]
        monster:addBuff(BuffTable:addBuffInfo(
            monster,
            monster,
            BuffTable[data.NAME],
            BuffTable[data.ADDSTACK],
            true,
            BuffTable[data.PERMANENT],
            0,
            data.VALUE
        ))
    end
    monster:setTarget(ConstDef.TARGET[self.tag_])
    self.monsters_[#self.monsters_+1] = monster
end
function Player:update(dt)
    local destoryBullets = {}
    local destoryTowers = {}
    local destoryMonster = {}
    for i = 1, #self.bullets_ do
        local bullet =self.bullets_[i]
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

    for i = 1, #self.monsters_ do
        self.monsters_[i]:update(dt)
        if not self.monsters_[i]:isDeath() then
        else
            destoryMonster[#destoryMonster + 1] = self.monsters_[i]
        end
    end

    -- for i = 1, #allies_ do
    --     allies_[i]:update(dt)
    -- end

    -- 清理失效子弹
    for i = #destoryBullets, 1, -1 do
        for j = #self.bullets_, 1, -1 do
            if self.bullets_[j] == destoryBullets[i] then
                table.remove(self.bullets_, j)
            end
        end
    end

    -- 清理失效怪物
    for i = #destoryMonster, 1, -1 do
        for j = #self.monsters_, 1, -1 do
            if self.monsters_[j] == destoryMonster[i] then
                table.remove(self.monsters_, j)
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
    if tower:getPlayer()~=self then
        return
    end
    local bullet = Bullet.new(tower)
    bullet:setX(tower:getX())
    bullet:setY(tower:getY())
    self.bullets_[#self.bullets_+1] = bullet
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
        monster=self.monsters_[1]
    end
    if tower:getMode() == TowerDef.MODE.MAXLIFE then
        monster=self.monsters_[1]
        for i = 1, #self.monsters_ do
            if monster:getLife()<self.monsters_[i]:getLife() then
                monster=self.monsters_[i]
            end
        end
    end
    if tower:getMode() == TowerDef.MODE.RANDOM then
        monster =self.monsters_[math.random(1,#self.monsters_)]
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
    return self.monsters_
end
return Player