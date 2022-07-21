--[[--
    AnimLayer.lua
    动画效果层
]]
local AnimLayer = class("AnimLayer", require("app.ui.outgame.layer.BaseLayer"))
local EventDef = require("app.def.EventDef")
local EventManager = require("app.manager.EventManager")

--display.addSpriteFrames("animation/explosion.plist", "animation/explosion.png")

--[[
    节点进入

    @param none

    @return none
]]
function AnimLayer:onEnter()
    print("Ani")
    -- EventManager:regListener(EventDef.ID.BULLET_BOMB, self, function(bullet)
    --     audio.playEffect("sounds/explodeEffect.ogg", false)

    --     -- 播放动画
    --     local sprite = display.newSprite("#explosion_01.png")
    --     local frames = display.newFrames("explosion_%02d.png", 1, 35)
    --     local animation = display.newAnimation(frames, 0.5 / 15) -- 0.5 秒播放 8 桢
    --     local animate = cc.Animate:create(animation)
    --     sprite:runAction(cc.Sequence:create(
    --         animate, cc.CallFunc:create(function() 
    --                     sprite:removeFromParent(true)
    --     end)))
    --     self:addChild(sprite)
    --     sprite:setPosition(bullet:getX(), bullet:getY())
    -- end)

    -- EventManager:regListener(EventDef.ID.FREE, self, function()
    --     print("free")
    --     --audio.playEffect("sounds/shipDestroyEffect.ogg", false)
    --     local spine = sp.SkeletonAnimation:createWithJsonFile("artcontent/animation/outgame/free/free.json",
    --                 "artcontent/animation/outgame/free/free.atlas")
    --     spine:setAnimation(0, "free", false)
    --     spine:performWithDelay(function()
    --         spine:removeFromParent()
    --     end, 1)
    --     self:addChild(spine)
    --     spine:setPosition(display.cx, display.cy)
    -- end)
end

--[[--
    节点退出

    @param none

    @return none
]]
function AnimLayer:onExit()
    --EventManager:unRegListener(EventDef.ID.BULLET_BOMB, self)
    EventManager:unRegListener(EventDef.ID.FREE, self)
end

return AnimLayer