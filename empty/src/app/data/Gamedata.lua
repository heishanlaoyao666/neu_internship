--[[--
    GameData.lua
    游戏数据总文件，注意：只有一份，全局唯一
]]
local GameData = {}

local ConstDef = require("app/def/ConstDef.lua")
local EventDef = require("app/def/EventDef.lua")
local TowerDef = require("app/def/TowerDef.lua")
local EventManager = require("app/manager/EventManager.lua")

local Enemy = require("app/data/Enemy.lua")
local Tower = require("app/data/Tower.lua")
local Bullet = require("app/data/Bullet.lua")
local DamageInfo =require("app/data/DamageInfo.lua")
-- local SHOOT_INTERVAL = 0.2 -- 类型：number，射击间隔
-- local ENEMY_INTERVAL = 1 -- 类型：number，敌机生成间隔

local up_bullets_ = {} -- 类型：上方子弹数组
local down_bullets_ = {} -- 类型：下方子弹数组

local up_enemies_ = {} -- 类型：上方敌人数组
local down_enemies_ = {} -- 类型：下方敌人数组

local up_towers_ = {} -- 类型：上方塔数组
local down_towers_ = {} -- 类型：下方塔数组

local damages_ = {} --类型:伤害信息数组
local up_frist_monster = 1 --最前方怪物
local down_frist_monster = 1 --最前方怪物

local MONSTER_INTERVAL_ =1 --怪物生成间隔


--[[--
    初始化数据

    @param none

    @return none
]]
function GameData:init()
    self.sp_ = 0 -- 类型：number，sp点数
    self.opposite_ = ConstDef.GAME_TYPE.NULL --类型：number,游戏对手


    for i = 1, 15 do
        up_towers_[i] = nil
        down_towers_[i] =nil
    end
    self.monster_tick_ = 0 --类型：number,怪物生成tick
    -- 类型：number，游戏状态
    self.gameState_ = ConstDef.GAME_STATE.INIT

    
end

--[[--
    是否游戏中

    @param none

    @return boolean
]]
function GameData:isPlaying()
    return self.gameState_ == ConstDef.GAME_STATE.PLAY
end

--[[--
    设置游戏状态

    @param state 类型：number，游戏状态

    @return none
]]
function GameData:setGameState(state)
    self.gameState_ = state
    EventManager:doEvent(EventDef.ID.GAMESTATE_CHANGE, state)
end

--[[--
    获取游戏状态

    @param none

    @return number
]]
function GameData:getGameState()
    return self.gameState_
end
--[[--
    获取游戏对手

    @param none

    @return number
]]
function GameData:getGameOpposite()
    return self.opposite_
end
--[[--
    设置游戏对手

    @param opposite 类型：number，游戏对手

    @return number
]]
function GameData:setGameOpposite(opposite)
    self.opposite_ =opposite
end
--[[--
    帧刷新

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function GameData:update(dt)
    if self.gameState_ ~= ConstDef.GAME_STATE.PLAY then
        return
    end
    if self.monster_tick_>=MONSTER_INTERVAL_ then
        self.monster_tick_=self.monster_tick_-MONSTER_INTERVAL_
        -- local enemy_up = Enemy.new()
        -- enemy_up:setTarget(ConstDef.TARGET.UP)
        -- up_enemies_[#up_enemies_+1] = enemy_up
        local enemy_down = Enemy.new()
        enemy_down:setTarget(ConstDef.TARGET.DOWN)
        down_enemies_[#down_enemies_+1] = enemy_down
    end
    self.monster_tick_=self.monster_tick_+dt 
    -- self:shoot(dt)
    -- self:createEnemyPlane(dt)

    local destoryBullets = {}
    local destoryMonster = {}
    for i = 1, #down_bullets_ do
        local bullet = down_bullets_[i]
        bullet:update(dt)
        if bullet:isDeath() then
            destoryBullets[#destoryBullets + 1] = bullet
        end
    end
    for i = 1, 15 do
        if down_towers_[i] ~= nil then
            local tower = down_towers_[i]
            tower:update(dt)
            if tower:getFireTick() > tower:getFireCD() and #down_enemies_>0  then
                tower:setFireTick(-tower:getFireCD())
                local bullet = Bullet.new(down_towers_[i]:getID(),down_towers_[i]:getLevel())
                down_bullets_[#down_bullets_+1] = bullet
                bullet:setX(down_towers_[i]:getX())
                bullet:setY(down_towers_[i]:getY())
                self:bulletSetTarget(bullet,down_towers_[i]:getMode(),ConstDef.GAME_TAG.DOWN)
            end
        end
        -- if bullet:isDeath() then
        --     destoryBullets[#destoryBullets + 1] = bullet
        -- end
    end

    for i = 1, #down_enemies_ do
        down_enemies_[i]:update(dt)
        if not down_enemies_[i]:isDeath() then
            self:checkCollider(down_enemies_[i], down_bullets_)
        else
            destoryMonster[#destoryMonster + 1] = down_enemies_[i]
        end
    end

    for i = 1, #damages_ do
        damages_[i]:update(dt)
    end
    -- for i = 1, #allies_ do
    --     allies_[i]:update(dt)
    -- end

    -- 清理失效子弹
    for i = #destoryBullets, 1, -1 do
        for j = #down_bullets_, 1, -1 do
            if down_bullets_[j] == destoryBullets[i] then
                table.remove(down_bullets_, j)
            end
        end
        for j = #up_bullets_, 1, -1 do
            if up_bullets_[j] == destoryBullets[i] then
                table.remove(up_bullets_, j)
            end
        end
    end

    -- 清理失效怪物
    for i = #destoryMonster, 1, -1 do
        for j = #up_enemies_, 1, -1 do
            if up_enemies_[j] == destoryMonster[i] then
                table.remove(up_enemies_, j)
            end
        end
        for j = #down_enemies_, 1, -1 do
            if down_enemies_[j] == destoryMonster[i] then
                table.remove(down_enemies_, j)
            end
        end
    end
    
    -- -- 生命值小于0，结算
    -- if self.life_ <= 0 then
    --     self:setGameState(ConstDef.GAME_STATE.RESULT)
    -- end
end
--[[--
    子弹设置目标

    @param bullet 类型:bullet 子弹
    @param mode 类型:number 塔攻击模式
    @param tag 类型:number 标签区分上下

    @return number
]]
function GameData:bulletSetTarget(bullet,mode,tag)
    local monster = nil 
    if mode == TowerDef.MODE.FRIST then
        if tag == ConstDef.GAME_TAG.DOWN then
            monster = down_enemies_[down_frist_monster]
        end
        if tag ==ConstDef.GAME_TAG.UP then
            monster = up_enemies_[up_frist_monster]
        end
    end
    if mode == TowerDef.MODE.MAXLIFE then
        if tag == ConstDef.GAME_TAG.DOWN then
            monster=down_enemies_[1]
            for i = 1, #down_enemies_ do
                if monster:getLife()<down_enemies_[i]:getLife() then
                    monster=down_enemies_[i]
                end
            end
        end
        if tag ==ConstDef.GAME_TAG.UP then
            monster=up_enemies_[1]
            for i = 1, #up_enemies_ do
                if monster:getLife()<up_enemies_[i] then
                    monster=up_enemies_[i]
                end
            end
        end
    end
    if mode == TowerDef.MODE.RANDOM then
        if tag == ConstDef.GAME_TAG.DOWN then
            monster =down_enemies_[math.random(1,#down_enemies_)]
        end
        if tag == ConstDef.GAME_TAG.UP then
            monster =up_enemies_[math.random(1,#up_enemies_)]
        end
    end
    if monster then
        bullet:setTarget(monster:getX(),monster:getY())
    end
end
--[[--
    塔创建

    @param tower_id 类型:number 塔id
    @param level 类型:number 塔等级
    @param tag 类型:number 上下

    @return number
]]
function GameData:createTower(tower_id,level,tag)
    if tag == ConstDef.GAME_TAG.DOWN then
        local random = math.random(1,15)
        local sum = 0
        while down_towers_[random]~=nil do
            if sum == 15 then
                return
            end
            sum =sum+1
            random = math.random(1,15)
        end

        local tower = Tower.new(tower_id,level)
        local x = random%5
        local y =math.modf(random/5)+1
        if x == 0 then
            x = 5
        end
        if random%5 == 0 then
            y = y-1
        end
        print(random.." "..x.." "..y)
        tower:setX(ConstDef.TOWER_POS.DOWN_X+ConstDef.TOWER_POS.MOVE_X*(x-1))
        tower:setY(ConstDef.TOWER_POS.DOWN_Y+ConstDef.TOWER_POS.MOVE_Y*(y-1))
        down_towers_[random] = tower
    end
    
end
--[[--
    碰撞检查

    @param monster 类型：Enemy，怪物
    @param bullets 类型：Bullet数组

    @return none
]]
function GameData:checkCollider(monster, bullets)
    for i = 1, #bullets do
        local bullet = bullets[i]
        if not bullet:isDeath() then
            if monster:isCollider(bullet) then
                self:hitMonster(monster, bullet)
                break
            end
        end
    end
end
--[[--
    伤害处理

    @param monster 类型：Enemy，怪物
    @param bullet 类型：Bullet

    @return none
]]
function GameData:hitMonster(monster, bullet)
    local damage=DamageInfo.new(bullet,monster)
    damages_[#damages_+1] = damage
    bullet:destory()
end


return GameData