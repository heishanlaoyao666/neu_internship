--[[--
    背景层
    BGLayer.lua
]]
local BGLayer = class("BGLayer", require("app.ui.layer.BaseLayer"))

--[[--
    构造函数

    @param none

    @return none
]]
function BGLayer:ctor()
    BGLayer.super.ctor(self)
    self.bgScaleFactor_ = 1 -- 类型：number，背景缩放系数
    self.bgSprites_ = {} -- 类型：Sprite数组

    self:initView()
end

--[[--
    界面初始化
    
    @param none

    @return none
]]
function BGLayer:initView()
    -- 背景图1447*2046 
    -- 设计尺寸 1000*2000
    local sprite = display.newSprite("texture/blackgroung.jpeg")
    self.bgSprites_[#self.bgSprites_+1] = sprite
    sprite:setScale(self.bgScaleFactor_)
    sprite:setAnchorPoint(0.5, 0)
    sprite:setPosition(display.cx, display.top)
end

return BGLayer