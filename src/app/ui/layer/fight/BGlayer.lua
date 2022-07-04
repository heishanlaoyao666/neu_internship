--[[--
    背景层
    BGLayer.lua
    编写：李昊
]]
local BGLayer = class("BGLayer", require("app.ui.layer.BaseLayer"))
local FightImgDef = require("src.app.def.FightImgDef")
local FightConstDef = require("src.app.def.FightConstDef")
--[[--
    构造函数

    @param none

    @return none
]]
function BGLayer:ctor()
    BGLayer.super.ctor(self)
    self.bgScaleFactor_  = 1 -- 类型：number，背景缩放系数
    self.bgMapUp_ = nil --背景图片上层
    self.bgMapDown_ = nil --背景图片下层

    self:initView()
end

--[[--
    界面初始化
    
    @param none

    @return none
]]
function BGLayer:initView()
    -- 背景图down 960 * 1480 
    -- 设计尺寸 720 * 1280
    self.bgScaleFactorY_ = display.top/1280
    self.bgScaleFactorX_ = display.right/720


    self.bgMapDown_ = display.newSprite(FightImgDef.BG_DOWN.DEFAULT)
    self:addChild(self.bgMapDown_)
    self.bgMapDown_:setScaleX(self.bgScaleFactorX_ )
    self.bgMapDown_:setScaleY(self.bgScaleFactorY_ )
    self.bgMapDown_:setAnchorPoint(0.5, 0.5)
    self.bgMapDown_:setPosition(display.cx, display.cy)


    -- 背景图up 960 * 1480 
    -- 设计尺寸 720 * 1280
    self.bgMapUp_ = display.newSprite(FightImgDef.BG_UP.DEFAULT)
    self:addChild(self.bgMapUp_)
    self.bgMapUp_:setScaleX(self.bgScaleFactorX_ )
    self.bgMapUp_:setScaleY(self.bgScaleFactorX_ )
    self.bgMapUp_:setAnchorPoint(0.5, 0.5)
    self.bgMapUp_:setPosition(display.cx, display.cy)

end

--[[--
    界面刷新

    @param dt 类型：number，帧间隔

    @return none
]]
function BGLayer:update(dt)
end

return BGLayer