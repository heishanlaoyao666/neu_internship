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
    local sprite0 = ccui.Button:create("artcontent/lobby(ongame)/currency/mask_popup.png")
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

    local sprite1 = display.newSprite("artcontent/lobby(ongame)/topbar_playerinformation/menu_bar/basemap_menu.png")
    sprite1:setAnchorPoint(0.5, 0.5)

    self.container_ = ccui.Layout:create()
    -- self.container_:setBackGroundColor(cc.c3b(200, 0, 0))
    -- self.container_:setBackGroundColorType(1)
    self.container_:setContentSize(sprite1:getContentSize().width, sprite1:getContentSize().height)
    self.container_:addTo(self)
    self.container_:setAnchorPoint(1,1)
    self.container_:setPosition(display.width-100, display.height-50)
    self.container_:addChild(sprite1)
    sprite1:setPosition(sprite1:getContentSize().width/2, sprite1:getContentSize().height/2)

    --四个按钮，从下往上
    tempfilename="artcontent/lobby(ongame)/topbar_playerinformation/menu_bar/basemap_button.png"
    local sprite2 = ccui.Button:create(tempfilename)
    self.container_:addChild(sprite2)
    sprite2:setAnchorPoint(0.5, 0)
    sprite2:setPosition(sprite1:getContentSize().width/2,20)

    sprite2:addTouchEventListener(
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

    local sprite3 = ccui.Button:create(tempfilename)
    self.container_:addChild(sprite3)
    sprite3:setAnchorPoint(0.5, 0)
    sprite3:setPosition(sprite1:getContentSize().width/2,sprite1:getContentSize().height/4+20)

    sprite3:addTouchEventListener(
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

    local sprite4 = ccui.Button:create(tempfilename)
    self.container_:addChild(sprite4)
    sprite4:setAnchorPoint(0.5, 0)
    sprite4:setPosition(sprite1:getContentSize().width/2,sprite1:getContentSize().height*2/4+20)

    sprite4:addTouchEventListener(
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

    local sprite5 = ccui.Button:create(tempfilename)
    self.container_:addChild(sprite5)
    sprite5:setAnchorPoint(0.5, 0)
    sprite5:setPosition(sprite1:getContentSize().width/2,sprite1:getContentSize().height*3/4+20)

    sprite5:addTouchEventListener(
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
    local sprite6 = display.newSprite("artcontent/lobby(ongame)/topbar_playerinformation/menu_bar/icon_sett.png")
    sprite2:addChild(sprite6)
    sprite6:setAnchorPoint(0.5,0.5)
    sprite6:setPosition(sprite2:getContentSize().width/2-70, sprite2:getContentSize().height/2)

    local sprite7 = display.newSprite("artcontent/lobby(ongame)/topbar_playerinformation/menu_bar/font_settings.png")
    sprite2:addChild(sprite7)
    sprite7:setAnchorPoint(0.5,0.5)
    sprite7:setPosition(sprite2:getContentSize().width/2+20, sprite2:getContentSize().height/2)

    --对战记录
    tempfilename="artcontent/lobby(ongame)/topbar_playerinformation/menu_bar/icon_battlerecord.png"
    local sprite8 = display.newSprite(tempfilename)
    sprite3:addChild(sprite8)
    sprite8:setAnchorPoint(0.5,0.5)
    sprite8:setPosition(sprite2:getContentSize().width/2-70, sprite2:getContentSize().height/2)

    tempfilename="artcontent/lobby(ongame)/topbar_playerinformation/menu_bar/text_battlerecord.png"
    local sprite9 = display.newSprite(tempfilename)
    sprite3:addChild(sprite9)
    sprite9:setAnchorPoint(0.5,0.5)
    sprite9:setPosition(sprite2:getContentSize().width/2+20, sprite2:getContentSize().height/2)

    --邮箱
    local sprite10 = display. newSprite("artcontent/lobby(ongame)/topbar_playerinformation/menu_bar/icon_mailbox.png")
    sprite4:addChild(sprite10)
    sprite10:setAnchorPoint(0.5,0.5)
    sprite10:setPosition(sprite2:getContentSize().width/2-70, sprite2:getContentSize().height/2)

    local sprite11= display.newSprite("artcontent/lobby(ongame)/topbar_playerinformation/menu_bar/text_mailbox.png")
    sprite4:addChild(sprite11)
    sprite11:setAnchorPoint(0.5,0.5)
    sprite11:setPosition(sprite2:getContentSize().width/2+20, sprite2:getContentSize().height/2)

    --公告
    tempfilename="artcontent/lobby(ongame)/topbar_playerinformation/menu_bar/icon_announcement.png"
    local sprite12 = display.newSprite(tempfilename)
    sprite5:addChild(sprite12)
    sprite12:setAnchorPoint(0.5,0.5)
    sprite12:setPosition(sprite2:getContentSize().width/2-70, sprite2:getContentSize().height/2)

    tempfilename="artcontent/lobby(ongame)/topbar_playerinformation/menu_bar/font_announcements.png"
    local sprite13 = display.newSprite(tempfilename)
    sprite5:addChild(sprite13)
    sprite13:setAnchorPoint(0.5,0.5)
    sprite13:setPosition(sprite2:getContentSize().width/2+20, sprite2:getContentSize().height/2)
end

--[[--
    界面刷新

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function MenuLayer:update(dt)
end

return MenuLayer

