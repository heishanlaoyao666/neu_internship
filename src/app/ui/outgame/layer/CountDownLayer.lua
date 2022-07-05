--[[--
    倒计时层
    CountDownLayer.lua
]]
local CountDownLayer = class("CountDownLayer", require("app.ui.outgame.layer.BaseLayer"))
--[[--
    构造函数

    @param none

    @return none
]]
function CountDownLayer:ctor()
    CountDownLayer.super.ctor(self)

    self:initView()
end

--[[--
    界面初始化

    @param none

    @return none
]]
function CountDownLayer:initView()
    --cc.UserDefault:getInstance():setIntegerForKey("bottom",2)
    local width, height = display.width, 80
    self.container_ = ccui.Layout:create()
    --self.container_:setBackGroundColor(cc.c3b(200, 0, 0))
    --self.container_:setBackGroundColorType(1)
    self.container_:setContentSize(display.width, height)
    self.container_:addTo(self)
    self.container_:setAnchorPoint(0.5, 0)
    self.container_:setPosition(display.cx, 0)

    local sprite = ccui.ImageView:create("artcontent/lobby(ongame)/bottombar_tabbutton/tab_unchecked_left.png")
    self.container_:addChild(sprite)
    sprite:setScale9Enabled(true)
    sprite:setContentSize(cc.size(width/3, 120))
    sprite:setAnchorPoint(0, 0)
    sprite:setScale(1)
    sprite:setPosition(0, 0)

    local sprite1 = ccui.ImageView:create("artcontent/lobby(ongame)/bottombar_tabbutton/tab_unchecked_medium.png")
    self.container_:addChild(sprite1)
    sprite1:setScale9Enabled(true)
    sprite1:setContentSize(cc.size(width/3, 120))
    sprite1:setAnchorPoint(0, 0)
    sprite1:setScale(1)
    sprite1:setPosition(width/3, 0)

end

--[[--
    界面刷新

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function CountDownLayer:update(dt)

end

return CountDownLayer

