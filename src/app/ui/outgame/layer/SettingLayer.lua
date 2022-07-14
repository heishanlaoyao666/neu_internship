--[[--
    设置层
    SettingLayer.lua
]]
local SettingLayer = class("SettingLayer", require("app.ui.outgame.layer.BaseLayer"))
local EventDef = require("app.def.EventDef")
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
    local tempFilename
    local maskBtn = ccui.Button:create("artcontent/lobby(ongame)/currency/mask_popup.png")
    self:addChild(maskBtn)
    maskBtn:setAnchorPoint(0.5, 0.5)
    maskBtn:setOpacity(127)
    maskBtn:setPosition(display.cx,display.cy)

    maskBtn:addTouchEventListener(
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
    self.container_:setContentSize(sprite1:getContentSize().width, sprite1:getContentSize().height)
    self.container_:addTo(self)
    self.container_:setAnchorPoint(0.5,0.5)
    self.container_:setPosition(display.cx, display.cy)
    self.container_:addChild(sprite1)
    sprite1:setPosition(sprite1:getContentSize().width/2, sprite1:getContentSize().height/2)

    --音效
    tempFilename="artcontent/lobby(ongame)/topbar_playerinformation/setting_popup/title_musiceffects.png"
    local musiceffects = display.newSprite(tempFilename)
    self.container_:addChild(musiceffects)
    musiceffects:setAnchorPoint(0, 1)
    musiceffects:setPosition(sprite1:getContentSize().width/2-200, sprite1:getContentSize().height-130)

    local musiceffectsCheckBox = ccui.CheckBox:
    create("artcontent/lobby(ongame)/topbar_playerinformation/setting_popup/checkbox_close.png", nil,
    "artcontent/lobby(ongame)/topbar_playerinformation/setting_popup/checkbox_on.png", nil, nil)
	:align(display.LEFT_CENTER, sprite1:getContentSize().width/2, sprite1:getContentSize().height-130)
	:addTo(self.container_)

    if cc.UserDefault:getInstance():getBoolForKey("音效") then
        musiceffectsCheckBox:setSelected(true)
    else
        musiceffectsCheckBox:setSelected(false)
    end
    musiceffectsCheckBox:addEventListener(function(sender, eventType)
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

    --音乐
    tempFilename="artcontent/lobby(ongame)/topbar_playerinformation/setting_popup/title_music.png"
    local music = display.newSprite(tempFilename)
    self.container_:addChild(music)
    music:setAnchorPoint(0, 1)
    music:setPosition(sprite1:getContentSize().width/2-200, sprite1:getContentSize().height-200)

    local musicCheckBox = ccui.CheckBox:
    create("artcontent/lobby(ongame)/topbar_playerinformation/setting_popup/checkbox_close.png", nil,
    "artcontent/lobby(ongame)/topbar_playerinformation/setting_popup/checkbox_on.png", nil, nil)
	:align(display.LEFT_CENTER, sprite1:getContentSize().width/2, sprite1:getContentSize().height-200)
	:addTo(self.container_)

    if cc.UserDefault:getInstance():getBoolForKey("游戏外音乐") then
        musicCheckBox:setSelected(true)
    else
        musicCheckBox:setSelected(false)
    end
    musicCheckBox:addEventListener(function(sender, eventType)
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

    tempFilename="artcontent/lobby(ongame)/topbar_playerinformation/setting_popup/title_skillintroduction.png"
    local skillIntroduction= display.newSprite(tempFilename)
    self.container_:addChild(skillIntroduction)
    skillIntroduction:setAnchorPoint(0, 1)
    skillIntroduction:setPosition(sprite1:getContentSize().width/2-200, sprite1:getContentSize().height-270)

    local introductionCheckBox = ccui.CheckBox:
    create("artcontent/lobby(ongame)/topbar_playerinformation/setting_popup/checkbox_close.png", nil,
    "artcontent/lobby(ongame)/topbar_playerinformation/setting_popup/checkbox_on.png", nil, nil)
	:align(display.LEFT_CENTER, sprite1:getContentSize().width/2, sprite1:getContentSize().height-270)
	:addTo(self.container_)

    --退出游戏
    local exitBtn= ccui.Button:create("artcontent/lobby(ongame)/topbar_playerinformation/setting_popup/button_exit.png")
    self.container_:addChild(exitBtn)
    exitBtn:setAnchorPoint(0.5, 0.5)
    exitBtn:setPosition(sprite1:getContentSize().width/2, sprite1:getContentSize().height/2-170)
    exitBtn:addTouchEventListener(
        function(sender, eventType)
            -- ccui.TouchEventType
            if 2 == eventType then -- touch end
                EventManager:doEvent(EventDef.ID.POPUPWINDOW,6)
                self:removeFromParent(true)
                if cc.UserDefault:getInstance():getBoolForKey("音效") then
                    audio.playEffect("sounds/ui_btn_click.OGG",false)
                end
            end
        end
    )

    --X按钮
    local offBtn= ccui.Button:create("artcontent/lobby(ongame)/topbar_playerinformation/setting_popup/button_off.png")
    self.container_:addChild(offBtn)
    offBtn:setAnchorPoint(1, 1)
    offBtn:setPosition(sprite1:getContentSize().width-20, sprite1:getContentSize().height-20)
    offBtn:addTouchEventListener(
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

