--[[--
    GameData.lua
    游戏数据总文件，注意：只有一份，全局唯一
]]
local GameData = {}

local ConstDef = require("app/def/ConstDef")
local EventDef = require("app/def/EventDef")
local EventManager = require("app/manager/EventManager")

-- local SHOOT_INTERVAL = 0.2 -- 类型：number，射击间隔
-- local ENEMY_INTERVAL = 1 -- 类型：number，敌机生成间隔

-- local bullets_ = {} -- 类型：子弹数组
-- local enemies_ = {} -- 类型：敌机数组
-- local allies_ = {} -- 类型：我方飞机数组

--[[--
    初始化数据

    @param none

    @return none
]]
function GameData:init()
    self.sp_ = 0 -- 类型：number，sp点数
    self.score_ = 0 -- 类型：number，得分
    -- self.shootTick_ = 0 -- 类型：number，开炮时间tick
    -- self.enemyTick_ = 0 -- 类型：number，敌机时间tick

    -- -- 类型：number，历史最高
    -- self.history_ = cc.UserDefault:getInstance():getIntegerForKey("history", 0)

    -- 类型：number，游戏状态
    self.gameState_ = ConstDef.GAME_STATE.INIT

    -- allies_[1] = Plane.new()
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
    帧刷新

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function GameData:update(dt)
    -- if self.gameState_ ~= ConstDef.GAME_STATE.PLAY then
    --     return
    -- end

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

    -- for i = 1, #enemies_ do
    --     enemies_[i]:update(dt)
    --     if not enemies_[i]:isDeath() then
    --         self:checkCollider(enemies_[i], bullets_, allies_)
    --     else
    --         destoryPlanes[#destoryPlanes + 1] = enemies_[i]
    --     end
    -- end

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

-- --[[--
--     命中飞机

--     @param plane 类型：EnemyPlane，敌机
--     @param bullet 类型：Bullet，子弹

--     @return none
-- ]]
-- function GameData:hitPlane(plane, bullet)
--     self.score_ = self.score_ + plane:getScore()
--     if self.score_ > self.history_ then
--         self.history_ = self.score_
--     end
--     bullet:bomb()
--     bullet:destory()
--     plane:destory()
-- end

-- --[[--
--     敌机撞到我方飞机

--     @param selfPlane 类型：Plane，我方飞机
--     @param enemyPlane 类型：EnemyPlane，敌方飞机

--     @return none
-- ]]
-- function GameData:crashPlane(selfPlane, enemyPlane)
--     self.life_ = self.life_ - enemyPlane:getDamage()
--     EventManager:doEvent(EventDef.ID.CRASH_PLANE, enemyPlane)
--     enemyPlane:destory()
-- end

-- --[[--
--     开炮

--     @param dt 类型：number，时间间隔，单位秒

--     @return none
-- ]]
-- function GameData:shoot(dt)
--     self.shootTick_ = self.shootTick_ + dt
--     if self.shootTick_ > SHOOT_INTERVAL then
--         self.shootTick_ = self.shootTick_ - SHOOT_INTERVAL

--         -- 产生子弹
--         for i = 1, #allies_ do
--             local bullet = Bullet.new()
--             bullets_[#bullets_ + 1] = bullet
--             bullet:setX(allies_[i]:getX())
--             bullet:setY(allies_[i]:getY() + 30)
--         end
--     end
-- end

-- --[[--
--     产生敌机

--     @param dt 类型：number，时间间隔，单位秒

--     @return none
-- ]]
-- function GameData:createEnemyPlane(dt)
--     self.enemyTick_ = self.enemyTick_ + dt
--     if self.enemyTick_ > ENEMY_INTERVAL then
--         self.enemyTick_ = self.enemyTick_ - ENEMY_INTERVAL
--         local enemy = EnemyPlane.new()
--         enemy:setX(math.random(display.left + 20, display.right-20))
--         enemy:setY(display.top)
--         enemies_[#enemies_ + 1] = enemy
--     end
-- end

return GameData