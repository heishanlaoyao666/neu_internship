--[[--
    背景层
    BGLayer.lua
]]
local BGLayer = class("BGLayer", require("app.ui.layer.BaseLayer"))
local ConstDef = require("app.def.ConstDef")

--[[--
    构造函数

    @param none

    @return none
]]
function BGLayer:ctor(gameData)
    BGLayer.super.ctor(self)
    self.bgScaleFactor_ = 1 -- 类型：number，背景缩放系数
    self.bgSprites_ = {} -- 类型：Sprite数组

    self.gameData_ = gameData

    self:initView()
end

--[[--
    界面初始化
    
    @param none

    @return none
]]
function BGLayer:initView()
    local bg = cc.Sprite:create(ConstDef.GAME_BACKGROUND) -- 背景图片
    bg:setAnchorPoint(0.5, 0.5)
    bg:setPosition(cc.p(display.width/2, display.height/2))
    bg:setScale(self.bgScaleFactor_)
    self:addChild(bg)

    local masking = ccui.Layout:create() -- 蒙版
    masking:setBackGroundColor(cc.c3b(255, 255, 255))
    masking:setBackGroundColorType(1)
    masking:setContentSize(display.width, display.height)
    masking:setPosition(cc.p(display.cx, 0))
    masking:setAnchorPoint(0.5, 0)
    masking:setCascadeOpacityEnabled(true)
    masking:setOpacity(0.2 * 255)
    self:addChild(masking)
end


return BGLayer