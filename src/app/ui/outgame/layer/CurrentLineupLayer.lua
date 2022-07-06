--[[--
    当前阵容层
    CurrentLineupLayer.lua
]]
local CurrentLineupLayer = class("CurrentLineupLayer", require("app.ui.outgame.layer.BaseLayer"))
local OutGameData = require("app.data.outgame.OutGameData")
local EventDef = require("app.def.EventDef")
local EventManager = require("app.manager.EventManager")
local CurrentTowerLayer = require("app.ui.outgame.layer.CurrentTowerLayer")
--[[--
    构造函数

    @param none

    @return none
]]
function CurrentLineupLayer:ctor()
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
    self.container_2 = ccui.Layout:create()
    self.container_2:setContentSize(display.width, display.height)
    self:addChild(self.container_2)
    self.container_2:setPosition(0, 0)
    --当前阵容区域底图
    local spriteC7 = display.newSprite("artcontent/lobby(ongame)/atlas_interface/current_lineup/basemap_area.png")
    self.container_2:addChild(spriteC7)
    spriteC7:setAnchorPoint(0.5, 1)
    spriteC7:setPosition(display.cx,height-140)

    --当前阵容标题底图
    local spriteC1 = display.newSprite("artcontent/lobby(ongame)/atlas_interface/current_lineup/basemap_title.png")
    self.container_2:addChild(spriteC1)
    spriteC1:setAnchorPoint(0.5, 1)
    spriteC1:setPosition(display.cx,height-70)

    --当前阵容标题文本
    local spriteC2 = display.newSprite("artcontent/lobby(ongame)/atlas_interface/current_lineup/text_currentlineup.png")
    self.container_2:addChild(spriteC2)
    spriteC2:setAnchorPoint(0.5, 1)
    spriteC2:setPosition(display.cx-110,height-100)

    --阵容连线
    tempfilename="artcontent/lobby(ongame)/atlas_interface/current_lineup/basemap_lineupconnection.png"
    local spriteC3 = display.newSprite(tempfilename)
    self.container_2:addChild(spriteC3)
    spriteC3:setAnchorPoint(0.5, 1)
    spriteC3:setPosition(display.cx+80,height-110)

    --三个阵容按钮
    local landscapeCheckBox1 = ccui.CheckBox:
    create("artcontent/lobby(ongame)/atlas_interface/current_lineup/icon_unchecked.png",
    nil, "artcontent/lobby(ongame)/atlas_interface/current_lineup/icon_checked.png", nil, nil)
    :align(display.LEFT_CENTER, -20, spriteC3:getContentSize().height/2)
    :addTo(spriteC3)
    landscapeCheckBox1:setSelected(true)

    local landscapeCheckBox2 = ccui.CheckBox:
    create("artcontent/lobby(ongame)/atlas_interface/current_lineup/icon_unchecked.png",
    nil, "artcontent/lobby(ongame)/atlas_interface/current_lineup/icon_checked.png", nil, nil)
    :align(display.LEFT_CENTER, spriteC3:getContentSize().width/2-20, spriteC3:getContentSize().height/2)
    :addTo(spriteC3)

    local landscapeCheckBox3 = ccui.CheckBox:
    create("artcontent/lobby(ongame)/atlas_interface/current_lineup/icon_unchecked.png",
    nil, "artcontent/lobby(ongame)/atlas_interface/current_lineup/icon_checked.png", nil, nil)
    :align(display.LEFT_CENTER, spriteC3:getContentSize().width-20, spriteC3:getContentSize().height/2)
    :addTo(spriteC3)

    local spriteC4 = display.newSprite("artcontent/lobby(ongame)/atlas_interface/current_lineup/number_1.png")
    landscapeCheckBox1:addChild(spriteC4)
    spriteC4:setAnchorPoint(0.5, 0.5)
    spriteC4:setPosition(landscapeCheckBox1:getContentSize().width/2,landscapeCheckBox1:getContentSize().height/2)

    local spriteC5 = display.newSprite("artcontent/lobby(ongame)/atlas_interface/current_lineup/number_2.png")
    landscapeCheckBox2:addChild(spriteC5)
    spriteC5:setAnchorPoint(0.5, 0.5)
    spriteC5:setPosition(landscapeCheckBox2:getContentSize().width/2,landscapeCheckBox2:getContentSize().height/2)

    local spriteC6 = display.newSprite("artcontent/lobby(ongame)/atlas_interface/current_lineup/number_3.png")
    landscapeCheckBox3:addChild(spriteC6)
    spriteC6:setAnchorPoint(0.5, 0.5)
    spriteC6:setPosition(landscapeCheckBox3:getContentSize().width/2,landscapeCheckBox3:getContentSize().height/2)

    --当前阵容
    id=self.id
    CurrentTowerLayer:setContentSize(spriteC7:getContentSize().width,spriteC7:getContentSize().height)
    CurrentTowerLayer:setId(id)
    CurrentTowerLayer:new():addTo(spriteC7)

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
                audio.playEffect("sounds/ui_towerbtn_click.OGG",false)
            end
	    else
            if cc.UserDefault:getInstance():getBoolForKey("音效") then
                audio.playEffect("sounds/ui_towerbtn_click.OGG",false)
            end
            cc.UserDefault:getInstance():setIntegerForKey("currentlineup",1)
            --CurrentTowerLayer:removeFromParent(true)
            CurrentTowerLayer:setContentSize(spriteC7:getContentSize().width,spriteC7:getContentSize().height)
            CurrentTowerLayer:setId(id)
            CurrentTowerLayer:new():addTo(spriteC7)
            landscapeCheckBox2:setSelected(false)
            landscapeCheckBox3:setSelected(false)
	    end
        EventManager:doEvent(EventDef.ID.BATTLE)
	end)
    landscapeCheckBox2:addEventListener(function(sender, eventType)
		-- body
		if 1==eventType then--1是没选上0是选上
            if cc.UserDefault:getInstance():getBoolForKey("音效") then
                audio.playEffect("sounds/ui_towerbtn_click.OGG",false)
            end
	    else
            if cc.UserDefault:getInstance():getBoolForKey("音效") then
                audio.playEffect("sounds/ui_towerbtn_click.OGG",false)
            end
            cc.UserDefault:getInstance():setIntegerForKey("currentlineup",2)
            CurrentTowerLayer:setContentSize(spriteC7:getContentSize().width,spriteC7:getContentSize().height)
            CurrentTowerLayer:setId(id)
            CurrentTowerLayer:new():addTo(spriteC7)
            landscapeCheckBox1:setSelected(false)
            landscapeCheckBox3:setSelected(false)
	    end
        EventManager:doEvent(EventDef.ID.BATTLE)
	end)
    landscapeCheckBox3:addEventListener(function(sender, eventType)
		-- body
		if 1==eventType then--1是没选上0是选上
            if cc.UserDefault:getInstance():getBoolForKey("音效") then
                audio.playEffect("sounds/ui_towerbtn_click.OGG",false)
            end
	    else
            if cc.UserDefault:getInstance():getBoolForKey("音效") then
                audio.playEffect("sounds/ui_towerbtn_click.OGG",false)
            end
            cc.UserDefault:getInstance():setIntegerForKey("currentlineup",3)
            CurrentTowerLayer:setContentSize(spriteC7:getContentSize().width,spriteC7:getContentSize().height)
            CurrentTowerLayer:setId(id)
            CurrentTowerLayer:new():addTo(spriteC7)
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