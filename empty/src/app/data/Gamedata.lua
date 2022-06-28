--[[--
    GameData.lua
    游戏数据总文件，注意：只有一份，全局唯一
]]
local GameData = {}

local ConstDef = require("app/def/ConstDef.lua")
local EventDef = require("app/def/EventDef.lua")
local EventManager = require("app/manager/EventManager.lua")

local Enemy = require("app/data/Enemy.lua")
local Tower = require("app/data/Tower.lua")
-- local SHOOT_INTERVAL = 0.2 -- 类型：number，射击间隔
-- local ENEMY_INTERVAL = 1 -- 类型：number，敌机生成间隔

local up_bullets_ = {} -- 类型：上方子弹数组
local down_bullets_ = {} -- 类型：下方子弹数组

local up_enemies_ = {} -- 类型：上方敌人数组
local down_enemies_ = {} -- 类型：下方敌人数组

local up_towers_ = {} -- 类型：上方塔数组
local down_towers_ = {} -- 类型：下方塔数组

--[[--
    初始化数据

    @param none

    @return none
]]
function GameData:init()
    self.sp_ = 0 -- 类型：number，sp点数

    self.opposite_ = ConstDef.GAME_TYPE.NULL --类型：number,游戏对手

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
    local enemy = Enemy.new()
        enemy:setTarget(ConstDef.TARGET.DOWN)
    down_enemies_[#down_enemies_+1] = enemy
    
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
    
    -- self:shoot(dt)
    -- self:createEnemyPlane(dt)

    -- local destoryBullets = {}
    -- local destoryPlanes = {}
    -- for i = 1, #bullets_ do
    --     local bullet = bullets_[i]
    --     bullet:update(dt)
    --     if bullet:isDeath() then
    --         destoryBullets[#destoryBullets + 1] = bullet
    --     end
    -- end

    for i = 1, #down_enemies_ do
        down_enemies_[i]:update(dt)
        
    end

    -- for i = 1, #allies_ do
    --     allies_[i]:update(dt)
    -- end

    -- -- 清理失效子弹
    -- for i = #destoryBullets, 1, -1 do
    --     for j = #bullets_, 1, -1 do
    --         if bullets_[j] == destoryBullets[i] then
    --             table.remove(bullets_, j)
    --         end
    --     end
    -- end

    -- -- 清理失效敌机
    -- for i = #destoryPlanes, 1, -1 do
    --     for j = #enemies_, 1, -1 do
    --         if enemies_[j] == destoryPlanes[i] then
    --             table.remove(enemies_, j)
    --         end
    --     end
    -- end
    
    -- -- 生命值小于0，结算
    -- if self.life_ <= 0 then
    --     self:setGameState(ConstDef.GAME_STATE.RESULT)
    -- end
end
--[[--
    塔创建

    @param tower_id 类型:number 塔id
    @param level 类型:number 塔等级

    @return number
]]
function GameData:createTower(tower_id,level)
    local tower = Tower.new(tower_id,level)
    tower:setX(100)
    tower:setY(500)
    down_towers_[1] = tower
end
--[[--
    碰撞检查

    @param enemyPlane 类型：EnemyPlane，敌机
    @param bullets 类型：Bullet数组
    @param allies 类型：Plane数组，我方飞机

    @return none
]]
function GameData:checkCollider(enemyPlane, bullets, allies)
    -- for i = 1, #bullets do
    --     local bullet = bullets[i]
    --     if not bullet:isDeath() then
    --         if enemyPlane:isCollider(bullet) then
    --             self:hitPlane(enemyPlane, bullet)
    --             break
    --         end
    --     end
    -- end

    -- for i = 1, #allies do
    --     local plane = allies[i]
    --     if enemyPlane:isCollider(plane) then
    --         self:crashPlane(plane, enemyPlane)
    --         break
    --     end
    -- end
end


return GameData