--[[--
    设置层
    SettingLayer.lua
]]
local SettingLayer = class("SettingLayer", function()
    return display.newLayer()
end)
local EventDef = require("app.def.outgame.EventDef")
local EventManager = require("app.manager.EventManager")
--[[--
    构造函数

    @param none

    @return none
]]
function SettingLayer:ctor()
    self:initView()
end

--[[--
    界面初始化

    @param none

    @return none
]]
function SettingLayer:initView()

    local sprite0 = ccui.Button:
    create("artcontent/lobby(ongame)/currency/mask_popup.png")
    self:addChild(sprite0)
    sprite0:setAnchorPoint(0.5, 0.5)
    sprite0:setOpacity(127)
    sprite0:setPosition(display.cx,display.cy)

    sprite0:addTouchEventListener(
        function(sender, eventType)
            -- ccui.TouchEventType
            if 2 == eventType then -- touch end
                self:removeFromParent(true)
            end
        end
    )

    local width, height = display.width, 1120

    --底图
    local sprite1 = display.
    newSprite("artcontent/lobby(ongame)/topbar_playerinformation/setting_popup/basemap_popup.png")
    sprite1:setAnchorPoint(0.5, 0.5)

    self.container_ = ccui.Layout:create()
    -- self.container_:setBackGroundColor(cc.c3b(200, 0, 0))
    -- self.container_:setBackGroundColorType(1)
    self.container_:setContentSize(sprite1:getContentSize().width, sprite1:getContentSize().height)
    self.container_:addTo(self)
    self.container_:setAnchorPoint(0.5,0.5)
    self.container_:setPosition(display.cx, display.cy)
    self.container_:addChild(sprite1)
    sprite1:setPosition(sprite1:getContentSize().width/2, sprite1:getContentSize().height/2)

    local sprite2 = display.
    newSprite("artcontent/lobby(ongame)/topbar_playerinformation/setting_popup/title_musiceffects.png")
    self.container_:addChild(sprite2)
    sprite2:setAnchorPoint(0, 1)
    sprite2:setPosition(sprite1:getContentSize().width/2-200, sprite1:getContentSize().height-130)

    local landscapeCheckBox1 = ccui.CheckBox:
    create("artcontent/lobby(ongame)/topbar_playerinformation/setting_popup/checkbox_close.png", nil,
    "artcontent/lobby(ongame)/topbar_playerinformation/setting_popup/checkbox_on.png", nil, nil)
	:align(display.LEFT_CENTER, sprite1:getContentSize().width/2, sprite1:getContentSize().height-130)
	:addTo(self.container_)

    if cc.UserDefault:getInstance():getBoolForKey("音效") then
        landscapeCheckBox1:setSelected(true)
    else
        landscapeCheckBox1:setSelected(false)
    end
    landscapeCheckBox1:addEventListener(function(sender, eventType)
		-- body
		if 1==eventType then--1是没选上0是选上
            if cc.UserDefault:getInstance():getBoolForKey("音效") then
                audio.playEffect("sounds/ui_btn_click.OGG",false)
            end
            cc.UserDefault:getInstance():setBoolForKey("音效",false)
	    else
            if cc.UserDefault:getInstance():getBoolForKey("音效") then
                audio.playEffect("sounds/ui_btn_click.OGG",false)
            end
            cc.UserDefault:getInstance():setBoolForKey("音效",true)
	    end
	end)

    local sprite3 = display.
    newSprite("artcontent/lobby(ongame)/topbar_playerinformation/setting_popup/title_music.png")
    self.container_:addChild(sprite3)
    sprite3:setAnchorPoint(0, 1)
    sprite3:setPosition(sprite1:getContentSize().width/2-200, sprite1:getContentSize().height-200)

    local landscapeCheckBox2 = ccui.CheckBox:
    create("artcontent/lobby(ongame)/topbar_playerinformation/setting_popup/checkbox_close.png", nil,
    "artcontent/lobby(ongame)/topbar_playerinformation/setting_popup/checkbox_on.png", nil, nil)
	:align(display.LEFT_CENTER, sprite1:getContentSize().width/2, sprite1:getContentSize().height-200)
	:addTo(self.container_)

    if cc.UserDefault:getInstance():getBoolForKey("游戏外音乐") then
        landscapeCheckBox2:setSelected(true)
    else
        landscapeCheckBox2:setSelected(false)
    end
    landscapeCheckBox2:addEventListener(function(sender, eventType)
		-- body
        if cc.UserDefault:getInstance():getBoolForKey("音效") then
            audio.playEffect("sounds/ui_btn_click.OGG",false)
        end
		if 1==eventType then--1是没选上0是选上
            audio.stopBGM("ssounds/lobby_bgm_120bpm.OGG")
            cc.UserDefault:getInstance():setBoolForKey("游戏外音乐",false)
	    else
            audio.playBGM("sounds/lobby_bgm_120bpm.OGG", true)
            cc.UserDefault:getInstance():setBoolForKey("游戏外音乐",true)
	    end
	end)

    local sprite4= display.
    newSprite("artcontent/lobby(ongame)/topbar_playerinformation/setting_popup/title_skillintroduction.png")
    self.container_:addChild(sprite4)
    sprite4:setAnchorPoint(0, 1)
    sprite4:setPosition(sprite1:getContentSize().width/2-200, sprite1:getContentSize().height-270)

    local landscapeCheckBox3 = ccui.CheckBox:
    create("artcontent/lobby(ongame)/topbar_playerinformation/setting_popup/checkbox_close.png", nil,
    "artcontent/lobby(ongame)/topbar_playerinformation/setting_popup/checkbox_on.png", nil, nil)
	:align(display.LEFT_CENTER, sprite1:getContentSize().width/2, sprite1:getContentSize().height-270)
	:addTo(self.container_)

    --退出游戏
    local sprite5= ccui.Button:
    create("artcontent/lobby(ongame)/topbar_playerinformation/setting_popup/button_exit.png")
    self.container_:addChild(sprite5)
    sprite5:setAnchorPoint(0.5, 0.5)
    sprite5:setPosition(sprite1:getContentSize().width/2, sprite1:getContentSize().height/2-170)
    sprite5:addTouchEventListener(
        function(sender, eventType)
            -- ccui.TouchEventType
            if 2 == eventType then -- touch end
                EventManager:doEvent(EventDef.ID.COMFIRMEDEXIT)
                self:removeFromParent(true)
                if cc.UserDefault:getInstance():getBoolForKey("音效") then
                    audio.playEffect("sounds/ui_btn_click.OGG",false)
                end
            end
        end
    )

    --X按钮
    local sprite6= ccui.Button:
    create("artcontent/lobby(ongame)/topbar_playerinformation/setting_popup/button_off.png")
    self.container_:addChild(sprite6)
    sprite6:setAnchorPoint(1, 1)
    sprite6:setPosition(sprite1:getContentSize().width-20, sprite1:getContentSize().height-20)
    sprite6:addTouchEventListener(
        function(sender, eventType)
            -- ccui.TouchEventType
            if 2 == eventType then -- touch end
                self:removeFromParent(true)
                if cc.UserDefault:getInstance():getBoolForKey("音效") then
                    audio.playEffect("sounds/ui_btn_close.OGG",false)
                end
            end
        end
    )

end

--[[--
    界面刷新

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function SettingLayer:update(dt)
end

return SettingLayer

