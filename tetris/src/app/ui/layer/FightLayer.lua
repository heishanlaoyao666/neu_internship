--[[--
    主战斗层，放战斗元素
    FightLayer.lua
]]
local FightLayer = class("FightLayer", require("app.ui.layer.BaseLayer"))
local BlockSprite = require("app.ui.node.BlockSprite")
-- local PlaneSprite = require("app.ui.node.PlaneSprite")
local GameData = require("app.data.GameData")
local ConstDef = require("app.def.ConstDef")
local EventDef = require("app.def.EventDef")
local EventManager = require("app.manager.EventManager")

--[[--
    构造函数

    @param none

    @return none
]]
function FightLayer:ctor()
    FightLayer.super.ctor(self)

    self.blockMap_ = {} -- 类型：table，Key：block， Value：blockSprite 方块

    -- 加载音效资源
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
    EventManager:regListener(EventDef.ID.CREATE_BLOCK, self, function(type,block)
        local blockNode = BlockSprite.new("t_"..type..".png", block)
        self:addChild(blockNode)
        self.blockMap_[block] = blockNode
    end)

    EventManager:regListener(EventDef.ID.DESTORY_BLOCK, self, function(block)
        local node = self.blockMap_[block]
        node:removeFromParent()
        self.blockMap_[block] = nil
    end)
end

--[[--
    节点退出

    @param none

    @return none
]]
function FightLayer:onExit()
    EventManager:unRegListener(EventDef.ID.CREATE_BLOCK, self)
    EventManager:unRegListener(EventDef.ID.DESTORY_BLOCK, self)
end

--[[--
    初始化界面

    @param none

    @return none
]]
function FightLayer:initView()
    GameData:setGameState(ConstDef.GAME_STATE.PLAY)
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
    for _, node in pairs(self.blockMap_) do
        node:update(dt)
    end

    -- for _, node in pairs(self.allyMap_) do
    --     node:update(dt)
    -- end

    -- for _, node in pairs(self.enemyMap_) do
    --     node:update(dt)
    -- end
end

return FightLayer