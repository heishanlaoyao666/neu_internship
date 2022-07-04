--[[--
    提示信息层
    TipsLayer.lua
]]
local TipsLayer = class("TipsLayer", require("app.ui.outgame.layer.BaseLayer"))
local OutGameData = require("app.data.outgame.OutGameData")
local EventDef = require("app.def.EventDef")
local EventManager = require("app.manager.EventManager")
--[[--
    构造函数

    @param none

    @return none
]]
function TipsLayer:ctor()
    self:initView()
end

--[[--
    界面初始化

    @param none

    @return none
]]
function TipsLayer:initView()
    local tempfilename
    local width, height = display.width, 1120
    self.container_2 = ccui.Layout:create()
    self.container_2:setContentSize(display.width, display.height)
    self:addChild(self.container_2)
    self.container_2:setPosition(0, 0)

    -- self.container_C1 = ccui.Layout:create()
    -- -- self.container_C1:setBackGroundColor(cc.c3b(200, 0, 0))
    -- -- self.container_C1:setBackGroundColorType(1)
    -- self.container_C1:setContentSize(width, 150)
    -- self.container_C1:setAnchorPoint(0.5,0.5)
    -- self.container_C1:setPosition(display.cx, display.cy)
    -- self.container_C1:addTo(listViewC)
    --提示信息
    local spriteC8 = display.newSprite("artcontent/lobby(ongame)/atlas_interface/prompt_information/basemap_tips.png")
    self.container_2:addChild(spriteC8)
    spriteC8:setAnchorPoint(0.5, 0)
    spriteC8:setPosition(display.cx,30)

    local spriteC10 = display.newSprite("artcontent/lobby(ongame)/atlas_interface/prompt_information/text_2.png")
    spriteC8:addChild(spriteC10)
    spriteC10:setAnchorPoint(0.5, 0.5)
    spriteC10:setPosition(spriteC8:getContentSize().width/2-50,spriteC8:getContentSize().height/2+20)

    local spriteC11 = display.newSprite("artcontent/lobby(ongame)/atlas_interface/prompt_information/text_1.png")
    spriteC8:addChild(spriteC11)
    spriteC11:setAnchorPoint(0.5, 0.5)
    spriteC11:setPosition(spriteC8:getContentSize().width/2,spriteC8:getContentSize().height/2-20)

end

--[[--
    帧刷新

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function TipsLayer:update(dt)
end

return TipsLayer