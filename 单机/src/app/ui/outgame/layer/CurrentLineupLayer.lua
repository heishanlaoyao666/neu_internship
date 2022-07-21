--[[--
    当前阵容层
    CurrentLineupLayer.lua
]]
local CurrentLineupLayer = class("CurrentLineupLayer", require("app.ui.outgame.layer.BaseLayer"))
local EventDef = require("app.def.EventDef")
local EventManager = require("app.manager.EventManager")
local CurrentTowerLayer = require("app.ui.outgame.layer.CurrentTowerLayer")
--[[--
    构造函数

    @param none

    @return none
]]
function CurrentLineupLayer:ctor()
    CurrentLineupLayer.super.ctor(self)
    self.CurrentTowerLayer_=nil  --当前阵容的塔层

    self:initView()
end

--[[--
    界面初始化

    @param none

    @return none
]]
function CurrentLineupLayer:initView()
    local tempfilename
    local width, height = display.width, 1120
    self.container_ = ccui.Layout:create()
    self.container_:setContentSize(display.width, display.height)
    self:addChild(self.container_)
    self.container_:setPosition(0, 0)
    --当前阵容区域底图
    local basemapArea = display.newSprite("artcontent/lobby_ongame/atlas_interface/current_lineup/basemap_area.png")
    self.container_:addChild(basemapArea)
    basemapArea:setAnchorPoint(0.5, 1)
    basemapArea:setPosition(display.cx,height-140)

    --当前阵容标题底图
    local basemapTitle = display.newSprite("artcontent/lobby_ongame/atlas_interface/current_lineup/basemap_title.png")
    self.container_:addChild(basemapTitle)
    basemapTitle:setAnchorPoint(0.5, 1)
    basemapTitle:setPosition(display.cx,height-70)

    --当前阵容标题文本
    local text = display.newSprite("artcontent/lobby_ongame/atlas_interface/current_lineup/text_currentlineup.png")
    self.container_:addChild(text)
    text:setAnchorPoint(0.5, 1)
    text:setPosition(display.cx-110,height-100)

    --阵容连线
    tempfilename="artcontent/lobby_ongame/atlas_interface/current_lineup/basemap_lineupconnection.png"
    local basemap = display.newSprite(tempfilename)
    self.container_:addChild(basemap)
    basemap:setAnchorPoint(0.5, 1)
    basemap:setPosition(display.cx+80,height-110)

    --三个阵容按钮
    local landscapeCheckBox1 = ccui.CheckBox:
    create("artcontent/lobby_ongame/atlas_interface/current_lineup/icon_unchecked.png",
    nil, "artcontent/lobby_ongame/atlas_interface/current_lineup/icon_checked.png", nil, nil)
    :align(display.LEFT_CENTER, -20, basemap:getContentSize().height/2)
    :addTo(basemap)
    landscapeCheckBox1:setSelected(true)

    local landscapeCheckBox2 = ccui.CheckBox:
    create("artcontent/lobby_ongame/atlas_interface/current_lineup/icon_unchecked.png",
    nil, "artcontent/lobby_ongame/atlas_interface/current_lineup/icon_checked.png", nil, nil)
    :align(display.LEFT_CENTER, basemap:getContentSize().width/2-20, basemap:getContentSize().height/2)
    :addTo(basemap)

    local landscapeCheckBox3 = ccui.CheckBox:
    create("artcontent/lobby_ongame/atlas_interface/current_lineup/icon_unchecked.png",
    nil, "artcontent/lobby_ongame/atlas_interface/current_lineup/icon_checked.png", nil, nil)
    :align(display.LEFT_CENTER, basemap:getContentSize().width-20, basemap:getContentSize().height/2)
    :addTo(basemap)

    local number1 = display.newSprite("artcontent/lobby_ongame/atlas_interface/current_lineup/number_1.png")
    landscapeCheckBox1:addChild(number1)
    number1:setAnchorPoint(0.5, 0.5)
    number1:setPosition(landscapeCheckBox1:getContentSize().width/2,landscapeCheckBox1:getContentSize().height/2)

    local number2 = display.newSprite("artcontent/lobby_ongame/atlas_interface/current_lineup/number_2.png")
    landscapeCheckBox2:addChild(number2)
    number2:setAnchorPoint(0.5, 0.5)
    number2:setPosition(landscapeCheckBox2:getContentSize().width/2,landscapeCheckBox2:getContentSize().height/2)

    local number3 = display.newSprite("artcontent/lobby_ongame/atlas_interface/current_lineup/number_3.png")
    landscapeCheckBox3:addChild(number3)
    number3:setAnchorPoint(0.5, 0.5)
    number3:setPosition(landscapeCheckBox3:getContentSize().width/2,landscapeCheckBox3:getContentSize().height/2)

    --当前阵容
    id=self.id
    self.CurrentTowerLayer_=CurrentTowerLayer:new():addTo(basemapArea)
    self.CurrentTowerLayer_:setContentSize(basemapArea:getContentSize().width,basemapArea:getContentSize().height)
    self.CurrentTowerLayer_:setId(id)
    -- CurrentTowerLayer:setContentSize(basemapArea:getContentSize().width,basemapArea:getContentSize().height)
    -- CurrentTowerLayer:setId(id)
    --CurrentTowerLayer:new():addTo(basemapArea)

    if cc.UserDefault:getInstance():getIntegerForKey("currentlineup")==1 then
        landscapeCheckBox1:setSelected(true)
        landscapeCheckBox2:setSelected(false)
        landscapeCheckBox3:setSelected(false)
    elseif cc.UserDefault:getInstance():getIntegerForKey("currentlineup")==2 then
        landscapeCheckBox1:setSelected(false)
        landscapeCheckBox2:setSelected(true)
        landscapeCheckBox3:setSelected(false)
    else
        landscapeCheckBox2:setSelected(false)
        landscapeCheckBox1:setSelected(false)
        landscapeCheckBox3:setSelected(true)
    end
    landscapeCheckBox1:addEventListener(function(sender, eventType)
		-- body
		if 1==eventType then--1是没选上0是选上
            if cc.UserDefault:getInstance():getBoolForKey("音效") then
                audio.playEffect("sounds/ui_btn_click.OGG",false)
            end
	    else
            if cc.UserDefault:getInstance():getBoolForKey("音效") then
                audio.playEffect("sounds/ui_btn_click.OGG",false)
            end
            cc.UserDefault:getInstance():setIntegerForKey("currentlineup",1)
            self.CurrentTowerLayer_:removeFromParent(true)
            self.CurrentTowerLayer_=CurrentTowerLayer:new():addTo(basemapArea)
            self.CurrentTowerLayer_:setContentSize(basemapArea:getContentSize().width,basemapArea:getContentSize().height)
            self.CurrentTowerLayer_:setId(id)
            -- CurrentTowerLayer:setContentSize(basemapArea:getContentSize().width,basemapArea:getContentSize().height)
            -- CurrentTowerLayer:setId(id)
            --CurrentTowerLayer:new():addTo(basemapArea)
            landscapeCheckBox2:setSelected(false)
            landscapeCheckBox3:setSelected(false)
	    end
        EventManager:doEvent(EventDef.ID.BATTLE)
	end)
    landscapeCheckBox2:addEventListener(function(sender, eventType)
		-- body
		if 1==eventType then--1是没选上0是选上
            if cc.UserDefault:getInstance():getBoolForKey("音效") then
                audio.playEffect("sounds/ui_btn_click.OGG",false)
            end
	    else
            if cc.UserDefault:getInstance():getBoolForKey("音效") then
                audio.playEffect("sounds/ui_btn_click.OGG",false)
            end
            cc.UserDefault:getInstance():setIntegerForKey("currentlineup",2)
            self.CurrentTowerLayer_:removeFromParent(true)
            self.CurrentTowerLayer_=CurrentTowerLayer:new():addTo(basemapArea)
            self.CurrentTowerLayer_:setContentSize(basemapArea:getContentSize().width,basemapArea:getContentSize().height)
            self.CurrentTowerLayer_:setId(id)
            landscapeCheckBox1:setSelected(false)
            landscapeCheckBox3:setSelected(false)
	    end
        EventManager:doEvent(EventDef.ID.BATTLE)
	end)
    landscapeCheckBox3:addEventListener(function(sender, eventType)
		-- body
		if 1==eventType then--1是没选上0是选上
            if cc.UserDefault:getInstance():getBoolForKey("音效") then
                audio.playEffect("sounds/ui_btn_click.OGG",false)
            end
	    else
            if cc.UserDefault:getInstance():getBoolForKey("音效") then
                audio.playEffect("sounds/ui_btn_click.OGG",false)
            end
            cc.UserDefault:getInstance():setIntegerForKey("currentlineup",3)
            self.CurrentTowerLayer_:removeFromParent(true)
            self.CurrentTowerLayer_=CurrentTowerLayer:new():addTo(basemapArea)
            self.CurrentTowerLayer_:setContentSize(basemapArea:getContentSize().width,basemapArea:getContentSize().height)
            self.CurrentTowerLayer_:setId(id)
            landscapeCheckBox1:setSelected(false)
            landscapeCheckBox2:setSelected(false)
	    end
        EventManager:doEvent(EventDef.ID.BATTLE)
	end)

end

--[[--
    传入塔id

    @param id 类型：number，塔id

    @return none
]]
function CurrentLineupLayer:setId(id)
    self.id=id
end

--[[--
    帧刷新

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function CurrentLineupLayer:update(dt)
end

return CurrentLineupLayer