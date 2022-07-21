--[[--
    提示信息层
    TipsLayer.lua
]]
local TipsLayer = class("TipsLayer", require("app.ui.outgame.layer.BaseLayer"))
local OutGameData = require("app.data.outgame.OutGameData")
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
    local basemap = display.newSprite("artcontent/lobby_ongame/atlas_interface/prompt_information/basemap_tips.png")
    self.container_2:addChild(basemap)
    basemap:setAnchorPoint(0.5, 0)
    basemap:setPosition(display.cx,30)

    local textTips2 = display.newSprite("artcontent/lobby_ongame/atlas_interface/prompt_information/text_2.png")
    basemap:addChild(textTips2)
    textTips2:setAnchorPoint(0.5, 0.5)
    textTips2:setPosition(basemap:getContentSize().width/2-50,basemap:getContentSize().height/2+20)

    local textTips1 = display.newSprite("artcontent/lobby_ongame/atlas_interface/prompt_information/text_1.png")
    basemap:addChild(textTips1)
    textTips1:setAnchorPoint(0.5, 0.5)
    textTips1:setPosition(basemap:getContentSize().width/2,basemap:getContentSize().height/2-20)
    self.ratio=display.newTTFLabel({
        text = "200%",
        size = 25,
        color = cc.c3b(255, 215, 0)
    })
    :align(display.LEFT_CENTER, basemap:getContentSize().width/2+40,basemap:getContentSize().height/2+20)
    :addTo(basemap)
    self.ratio:setString(OutGameData:getRatio().."%")
end

--[[--
    帧刷新

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function TipsLayer:update(dt)
end

return TipsLayer