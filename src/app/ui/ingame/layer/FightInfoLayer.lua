--[[--
    背景层
    FightingInfoLayer.lua
]]
local FightingInfoLayer = class("BGLayer", require("app.ui.ingame.layer.BaseLayer"))

--[[--
    构造函数

    @param none

    @return none
]]
function FightingInfoLayer:ctor()
    FightingInfoLayer.super.ctor(self)

    self.latency_ = nil -- 网络延迟

    self:initView()
end

--[[--
    界面初始化

    @param none

    @return none
]]
function FightingInfoLayer:initView()
    local width, height = display.width, display.height

    local myContainer = ccui.Layout:create()
    --myContainer:setBackGroundColor(cc.c3b(200, 0, 0))
    --myContainer:setBackGroundColorType(1)
    myContainer:setContentSize(width, height)
    myContainer:setAnchorPoint(0.5, 1)
    myContainer:setPosition(display.cx, height / 2)
    myContainer:addTo(self)

    local emenyContainer = ccui.Layout:create()
    --emenyContainer:setBackGroundColor(cc.c3b(0, 200, 0))
    --:setBackGroundColorType(1)
    emenyContainer:setContentSize(width, height)
    emenyContainer:setAnchorPoint(0.5, 0)
    emenyContainer:setPosition(display.cx, height / 2)
    emenyContainer:addTo(self)

    --网络延迟
    self.latency_ = ccui.ImageView:create("artcontent/battle(ongame)/battle_interface/networkdelay/delay_high.png")
    --改变图片
    --self.latency_:loadTexture("battle(ongame)/battle_interface/networkdelay/delay_low.png")
    self.latency_:setAnchorPoint(0, 1)
    self.latency_:setPosition(20, display.cy + 80)
    self.latency_:addTo(self)

    --生命
    
end

return FightingInfoLayer