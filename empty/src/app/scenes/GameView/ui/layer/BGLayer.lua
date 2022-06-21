--[[--
    背景层
    BGLayer.lua
]]
local BGLayer = class("BGLayer", require("app/scenes/GameView/ui/layer/BaseLayer.lua"))
local SpriteTool = require("app/tool/SpriteTool.lua")

--[[--
    构造函数

    @param none

    @return none
]]
function BGLayer:ctor()
    BGLayer.super.ctor(self)
    self.bgScaleFactor_ = 1 -- 类型：number，背景缩放系数

    self:initView()
end

--[[--
    界面初始化
    
    @param none

    @return none
]]
function BGLayer:initView()
    -- 背景图960 * 1480
    -- 设计尺寸 480 * 720
    --判断横屏竖屏调整比例

    self.bgScaleFactor_ = SpriteTool:getScaleInBg(720,1480)
    local offsetY = display.bottom
    --底下背景
    local sprite_down = display.newSprite("res/ui/battle/Battle interface/bg-down.png")
    self:addChild(sprite_down)
    sprite_down:setScale(self.bgScaleFactor_)
    sprite_down:setAnchorPoint(0.5, 0.5)
    sprite_down:setPosition(display.cx, display.cy)
    --底上背景
    local sprite_up = display.newSprite("res/ui/battle/Battle interface/bg-up.png")
    self:addChild(sprite_up)
    sprite_up:setScale(self.bgScaleFactor_)
    sprite_up:setAnchorPoint(0.5, 0.5)
    sprite_up:setPosition(display.cx, display.cy)
    
end

--[[--
    界面刷新

    @param dt 类型：number，帧间隔

    @return none
]]
function BGLayer:update(dt)
   
end

return BGLayer