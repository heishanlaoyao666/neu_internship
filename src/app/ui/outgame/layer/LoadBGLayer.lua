--[[--
    背景层
    LoadBGLayer.lua
]]
local LoadBGLayer = class("BGLayer", require("app.ui.outgame.layer.BaseLayer"))

--[[--
    构造函数

    @param none

    @return none
]]
function LoadBGLayer:ctor()
    LoadBGLayer.super.ctor(self)
    self.bgScaleFactor_ = 1 -- 类型：number，背景缩放系数

    self:initView()
end

--[[--
    界面初始化

    @param none

    @return none
]]
function LoadBGLayer:initView()
    -- 背景图720 * 1280
    -- 设计尺寸 720 * 1280
    local sprite = display.newSprite("load/scene_bg.jpg")
    sprite:setAnchorPoint(0.5,0.5)
    sprite:pos(display.cx, display.cy)
    self:addChild(sprite)
end

return LoadBGLayer