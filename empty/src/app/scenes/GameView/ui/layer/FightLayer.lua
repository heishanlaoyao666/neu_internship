--[[--
    主战斗层，放战斗元素
    FightLayer.lua
]]
local FightLayer = class("FightLayer", require("app/scenes/GameView/ui/layer/BaseLayer.lua"))
-- local BulletSprite = require("app.ui.node.BulletSprite")
-- local PlaneSprite = require("app.ui.node.PlaneSprite")
local GameData = require("app/data/GameData.lua")
local ConstDef = require("app.def.ConstDef.lua")
local EventDef = require("app.def.EventDef.lua")
local EventManager = require("app.manager.EventManager.lua")

--[[--
    构造函数

    @param none

    @return none
]]
function FightLayer:ctor()
    FightLayer.super.ctor(self)

    -- self.bulletMap_ = {} -- 类型：table，Key：bullet， Value：bulletSprite 子弹
    -- self.allyMap_ = {} -- 类型：table，Key：plane，Value：planeSprite 我方飞机
    -- self.enemyMap_ = {} -- 类型：table，Key：plane，Value：planeSprite 敌方飞机

    -- -- 加载音效资源
    -- audio.loadFile("sounds/fireEffect.ogg", function() end)
    -- audio.loadFile("sounds/explodeEffect.ogg", function() end)
    -- audio.loadFile("sounds/shipDestroyEffect.ogg", function() end)
    -- audio.loadFile("sounds/bgMusic.ogg", function() 
    --     audio.playBGM("sounds/bgMusic.ogg", true)
    -- end)

    self:initView()
end

--[[--
    节点进入

    @param none

    @return none
]]
function FightLayer:onEnter()
    -- EventManager:regListener(EventDef.ID.CREATE_BULLET, self, function(bullet)
    --     local bulletNode = BulletSprite.new("player/blue_bullet.png", bullet)
    --     self:addChild(bulletNode)
    --     self.bulletMap_[bullet] = bulletNode

    --     audio.playEffect("sounds/fireEffect.ogg", false)
    -- end)

    -- EventManager:regListener(EventDef.ID.DESTORY_BULLET, self, function(bullet)
    --     local node = self.bulletMap_[bullet]
    --     node:removeFromParent()
    --     self.bulletMap_[bullet] = nil
    -- end)

    -- EventManager:regListener(EventDef.ID.CREATE_ENEMY, self, function(enemy)
    --     local enemyNode = PlaneSprite.new("player/small_enemy.png", enemy)
    --     self:addChild(enemyNode)
    --     self.enemyMap_[enemy] = enemyNode
    -- end)

    -- EventManager:regListener(EventDef.ID.DESTORY_ENEMY, self, function(enemy)
    --     local node = self.enemyMap_[enemy]
    --     node:removeFromParent()
    --     self.enemyMap_[enemy] = nil
    -- end)
end

--[[--
    节点退出

    @param none

    @return none
]]
function FightLayer:onExit()
    -- EventManager:unRegListener(EventDef.ID.CREATE_BULLET, self)
    -- EventManager:unRegListener(EventDef.ID.DESTORY_BULLET, self)
    -- EventManager:unRegListener(EventDef.ID.CREATE_ENEMY, self)
    -- EventManager:unRegListener(EventDef.ID.DESTORY_ENEMY, self)
end

--[[--
    初始化界面

    @param none

    @return none
]]
function FightLayer:initView()
    -- local allies = GameData:getAllies()
    -- for i = 1, #allies do
    --     local plane = PlaneSprite.new("player/red_plane.png", allies[i])
    --     self:addChild(plane)
    --     self.allyMap_[allies[i]] = plane

    --     -- 添加飞机粒子
    --     local particle = cc.ParticleSystemQuad:create("particle/fire.plist")
    --     plane:addChild(particle)
    --     particle:setRotation(180)
    --     particle:setPosition(plane:getContentSize().width * 0.5, 5)

    --     -- 执行初始移动，游戏开始，飞机移动到制定区域
    --     if GameData:getGameState() == ConstDef.GAME_STATE.INIT then
    --         plane:setPosition(display.cx, display.bottom - 30)
    --         plane:runAction(cc.Sequence:create(
    --             cc.MoveTo:create(1, cc.p(display.cx, 200)),
    --             cc.CallFunc:create(function() 
    --                 GameData:initTo(display.cx, 200)
    --                 GameData:setGameState(ConstDef.GAME_STATE.PLAY)
    --             end))
    --         )
    --     end
    -- end

    -- local bullets = GameData:getBullets()
    -- for i = 1, #bullets do
    --     local bullet = BulletSprite.new("player/blue_bullet.png", bullets[i])
    --     self:addChild(bullet)
    --     self.bulletMap_[bullets[i]] = bullet
    -- end

    -- local enemies = GameData:getEnemies()
    -- for i = 1, #enemies do
    --     local plane = PlaneSprite.new("player/small_enemy.png", enemies[i])
    --     self:addChild(plane)
    --     self.enemyMap_[enemies[i]] = plane
    -- end

    
    -- self:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event) 
    --     if event.name == "began" then
    --         return self:onTouchBegan(event.x, event.y)
    --     elseif event.name == "moved" then
    --         self:onTouchMoved(event.x, event.y)
    --     elseif event.name == "ended" then
    --         self:onTouchEnded(event.x, event.y)   
    --     end
    -- end)
    -- self:setTouchEnabled(true)
end


--[[--
    帧刷新

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function FightLayer:update(dt)
    -- for _, node in pairs(self.bulletMap_) do
    --     node:update(dt)
    -- end

    -- for _, node in pairs(self.allyMap_) do
    --     node:update(dt)
    -- end

    -- for _, node in pairs(self.enemyMap_) do
    --     node:update(dt)
    -- end
end

return FightLayer