---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by Asus.
--- DateTime: 2022/5/31 14:17
---
local BaseLayer = class("BaseLayer", function()
    return ccui.Layout:create()
end)

---properties
BaseLayer.backGroundLocation = {"res/ui/main/bg_menu.jpg"}
BaseLayer.backButtonLocation = {"res/ui/back_peek0.png", "res/ui/back_peek1.png"}
BaseLayer.sound = {
    music = "res/sounds/mainMainMusic.ogg",
    buttonEffect = "res/sounds/buttonEffet.ogg"
}
function BaseLayer:ctor()


    --data
    local width, height = display.width, display.height
    --basic layer
    self:setContentSize(cc.size(display.width, display.height))
    self:setTouchEnabled(false)
    --self:setBackGroundColor(cc.c4b(0,0,0,0))
    self:setBackGroundColorType(3)

    --Background
    local sprite = display.newScale9Sprite(self.backGroundLocation[1],0,0,cc.size(width, height))
    sprite:setContentSize(width, height)
    sprite:setAnchorPoint(0, 0)
    sprite:setPosition(0, 0)
    self:addChild(sprite)
    --return button
    local button = ccui.Button:create(self.backButtonLocation[1], self.backButtonLocation[2])
    button:setAnchorPoint(0, 1)
    button:pos(0, height - 10)
    button:setContentSize(130, 40)
    button:addTouchEventListener(function(sender, eventType)
        audio.playEffectSync(self.sound.buttonEffect, false)
        if 2 == eventType then
            self:removeSelf()
        end
    end)
    self:addChild(button)
end
return BaseLayer
