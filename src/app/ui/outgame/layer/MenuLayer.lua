--[[--
    菜单层
    MenuLayer.lua
]]
local MenuLayer = class("MenuLayer", require("app.ui.outgame.layer.BaseLayer"))
local EventDef = require("app.def..EventDef")
local EventManager = require("app.manager.EventManager")

--[[--
    构造函数

    @param none

    @return none
]]
function MenuLayer:ctor()
    --PortraitSelectionLayer.super.ctor(self)
    self:initView()
end

--[[--
    界面初始化

    @param none

    @return none
]]
function MenuLayer:initView()
    local tempfilename
    --遮罩
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

    local basemap = display.newSprite("artcontent/lobby(ongame)/topbar_playerinformation/menu_bar/basemap_menu.png")
    basemap:setAnchorPoint(0.5, 0.5)

    self.container_ = ccui.Layout:create()
    -- self.container_:setBackGroundColor(cc.c3b(200, 0, 0))
    -- self.container_:setBackGroundColorType(1)
    self.container_:setContentSize(basemap:getContentSize().width, basemap:getContentSize().height)
    self.container_:addTo(self)
    self.container_:setAnchorPoint(1,1)
    self.container_:setPosition(display.width-100, display.height-50)
    self.container_:addChild(basemap)
    basemap:setPosition(basemap:getContentSize().width/2, basemap:getContentSize().height/2)

    --四个按钮，从下往上
    tempfilename="artcontent/lobby(ongame)/topbar_playerinformation/menu_bar/basemap_button.png"
    local basemapBtn1 = ccui.Button:create(tempfilename)
    self.container_:addChild(basemapBtn1)
    basemapBtn1:setAnchorPoint(0.5, 0)
    basemapBtn1:setPosition(basemap:getContentSize().width/2,20)

    basemapBtn1:addTouchEventListener(
        function(sender, eventType)
            -- ccui.TouchEventType
            if 2 == eventType then -- touch end
                EventManager:doEvent(EventDef.ID.SETTING)
                self:removeFromParent(true)
                if cc.UserDefault:getInstance():getBoolForKey("音效") then
                    audio.playEffect("sounds/ui_btn_click.OGG",false)
                end
            end
        end
    )

    local basemapBtn2 = ccui.Button:create(tempfilename)
    self.container_:addChild(basemapBtn2)
    basemapBtn2:setAnchorPoint(0.5, 0)
    basemapBtn2:setPosition(basemap:getContentSize().width/2,basemap:getContentSize().height/4+20)

    basemapBtn2:addTouchEventListener(
        function(sender, eventType)
            -- ccui.TouchEventType
            if 2 == eventType then -- touch end
                self:removeFromParent(true)
                if cc.UserDefault:getInstance():getBoolForKey("音效") then
                    audio.playEffect("sounds/ui_btn_click.OGG",false)
                end
            end
        end
    )

    local basemapBtn3 = ccui.Button:create(tempfilename)
    self.container_:addChild(basemapBtn3)
    basemapBtn3:setAnchorPoint(0.5, 0)
    basemapBtn3:setPosition(basemap:getContentSize().width/2,basemap:getContentSize().height*2/4+20)

    basemapBtn3:addTouchEventListener(
        function(sender, eventType)
            -- ccui.TouchEventType
            if 2 == eventType then -- touch end
                self:removeFromParent(true)
                if cc.UserDefault:getInstance():getBoolForKey("音效") then
                    audio.playEffect("sounds/ui_btn_click.OGG",false)
                end
            end
        end
    )

    local basemapBtn4 = ccui.Button:create(tempfilename)
    self.container_:addChild(basemapBtn4)
    basemapBtn4:setAnchorPoint(0.5, 0)
    basemapBtn4:setPosition(basemap:getContentSize().width/2,basemap:getContentSize().height*3/4+20)

    basemapBtn4:addTouchEventListener(
        function(sender, eventType)
            -- ccui.TouchEventType
            if 2 == eventType then -- touch end
                self:removeFromParent(true)
                if cc.UserDefault:getInstance():getBoolForKey("音效") then
                    audio.playEffect("sounds/ui_btn_click.OGG",false)
                end
            end
        end
    )

    --设置
    local setSprite = display.newSprite("artcontent/lobby(ongame)/topbar_playerinformation/menu_bar/icon_sett.png")
    basemapBtn1:addChild(setSprite)
    setSprite:setAnchorPoint(0.5,0.5)
    setSprite:setPosition(basemapBtn1:getContentSize().width/2-70, basemapBtn1:getContentSize().height/2)

    local fontSet = display.newSprite("artcontent/lobby(ongame)/topbar_playerinformation/menu_bar/font_settings.png")
    basemapBtn1:addChild(fontSet)
    fontSet:setAnchorPoint(0.5,0.5)
    fontSet:setPosition(basemapBtn1:getContentSize().width/2+20, basemapBtn1:getContentSize().height/2)

    --对战记录
    tempfilename="artcontent/lobby(ongame)/topbar_playerinformation/menu_bar/icon_battlerecord.png"
    local battlerecord = display.newSprite(tempfilename)
    basemapBtn2:addChild(battlerecord)
    battlerecord:setAnchorPoint(0.5,0.5)
    battlerecord:setPosition(basemapBtn1:getContentSize().width/2-70, basemapBtn1:getContentSize().height/2)

    tempfilename="artcontent/lobby(ongame)/topbar_playerinformation/menu_bar/text_battlerecord.png"
    local textBattlerecord = display.newSprite(tempfilename)
    basemapBtn2:addChild(textBattlerecord)
    textBattlerecord:setAnchorPoint(0.5,0.5)
    textBattlerecord:setPosition(basemapBtn1:getContentSize().width/2+20, basemapBtn1:getContentSize().height/2)

    --邮箱
    local mailbox = display. newSprite("artcontent/lobby(ongame)/topbar_playerinformation/menu_bar/icon_mailbox.png")
    basemapBtn3:addChild(mailbox)
    mailbox:setAnchorPoint(0.5,0.5)
    mailbox:setPosition(basemapBtn1:getContentSize().width/2-70, basemapBtn1:getContentSize().height/2)

    local textMailbox= display.newSprite("artcontent/lobby(ongame)/topbar_playerinformation/menu_bar/text_mailbox.png")
    basemapBtn3:addChild(textMailbox)
    textMailbox:setAnchorPoint(0.5,0.5)
    textMailbox:setPosition(basemapBtn1:getContentSize().width/2+20, basemapBtn1:getContentSize().height/2)

    --公告
    tempfilename="artcontent/lobby(ongame)/topbar_playerinformation/menu_bar/icon_announcement.png"
    local announcement = display.newSprite(tempfilename)
    basemapBtn4:addChild(announcement)
    announcement:setAnchorPoint(0.5,0.5)
    announcement:setPosition(basemapBtn1:getContentSize().width/2-70, basemapBtn1:getContentSize().height/2)

    tempfilename="artcontent/lobby(ongame)/topbar_playerinformation/menu_bar/font_announcements.png"
    local fontAnnouncements = display.newSprite(tempfilename)
    basemapBtn4:addChild(fontAnnouncements)
    fontAnnouncements:setAnchorPoint(0.5,0.5)
    fontAnnouncements:setPosition(basemapBtn1:getContentSize().width/2+20, basemapBtn1:getContentSize().height/2)
end

--[[--
    界面刷新

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function MenuLayer:update(dt)
end

return MenuLayer

