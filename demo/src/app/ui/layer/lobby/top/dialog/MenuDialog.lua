--[[
    MenuDialog.lua
    菜单弹窗
    描述：菜单弹窗
    编写：周星宇
    修订：李昊
    检查：张昊煜
]]
local MenuDialog = class("MenuDialog", require("app.ui.layer.BaseLayer"))
local SettingDialog = require("app.ui.layer.lobby.top.dialog.dialog.SettingDialog")
local DialogManager = require("app.manager.DialogManager")
local eventDispatcher = cc.Director:getInstance():getEventDispatcher()

--[[--
    构造函数

    @param none

    @return none
]]
function MenuDialog:ctor()
    MenuDialog.super.ctor(self)

    self.container_ = nil -- 全局容器

    self.listener_ = nil
    self.isListening_ = false -- 是否监听

    self:initView()
end

--[[--
    界面初始化

    @param none

    @return none
]]
function MenuDialog:initView()

    self.container_ = ccui.Layout:create()
    self.container_:setContentSize(display.width, display.height)
    self.container_:setBackGroundColor(cc.c3b(0, 0, 0))
    self.container_:setBackGroundColorType(1)
    self.container_:setCascadeOpacityEnabled(false) -- 穿透
    self.container_:setOpacity(0.8 * 255)
    self:addChild(self.container_)

    local dialogBG = ccui.ImageView:create("image/lobby/top/menu/menu_bg.png")
    dialogBG:setPosition(0.7*display.width, 0.8*display.height)
    self.container_:addChild(dialogBG)

    local width, height = dialogBG:getContentSize().width, dialogBG:getContentSize().height

    -- 公告
    local notice = ccui.Layout:create()
    notice:setPosition(1.95*width, 2.9*height)
    self.container_:addChild(notice)
    local noticeBtn = ccui.Button:create("image/lobby/top/menu/button_bg.png")
    notice:addChild(noticeBtn)
    local noticeIcon = ccui.ImageView:create("image/lobby/top/menu/notice_icon.png")
    noticeIcon:setAnchorPoint(2, 0.5)
    notice:addChild(noticeIcon)
    local noticeText = ccui.ImageView:create("image/lobby/top/menu/notice_text.png")
    noticeText:setAnchorPoint(0, 0.5)
    notice:addChild(noticeText)

    -- 邮箱
    local mail = ccui.Layout:create()
    mail:setPosition(1.95*width, 2.7*height)
    self.container_:addChild(mail)
    local mailBtn = ccui.Button:create("image/lobby/top/menu/button_bg.png")
    mail:addChild(mailBtn)
    local mailIcon = ccui.ImageView:create("image/lobby/top/menu/mail_icon.png")
    mailIcon:setAnchorPoint(1.625, 0.5)
    mail:addChild(mailIcon)
    local mailText = ccui.ImageView:create("image/lobby/top/menu/mail_text.png")
    mailText:setAnchorPoint(0, 0.5)
    mail:addChild(mailText)

    -- 对战记录
    local record = ccui.Layout:create()
    record:setPosition(1.95*width, 2.5*height)
    self.container_:addChild(record)
    local recordBtn = ccui.Button:create("image/lobby/top/menu/button_bg.png")
    record:addChild(recordBtn)
    local recordIcon = ccui.ImageView:create("image/lobby/top/menu/record_icon.png")
    recordIcon:setAnchorPoint(2, 0.5)
    record:addChild(recordIcon)
    local recordText = ccui.ImageView:create("image/lobby/top/menu/record_text.png")
    recordText:setAnchorPoint(0.3, 0.5)
    record:addChild(recordText)

    -- 设置
    local setting = ccui.Layout:create()
    setting:setPosition(1.95*width, 2.3*height)
    self.container_:addChild(setting)
    local settingBtn = ccui.Button:create("image/lobby/top/menu/button_bg.png")
    settingBtn:addClickEventListener(function()
        local settingDialog = SettingDialog.new()
        DialogManager:showDialog(settingDialog)
    end)
    setting:addChild(settingBtn)
    local settingIcon = ccui.ImageView:create("image/lobby/top/menu/setting_icon.png")
    settingIcon:setAnchorPoint(2, 0.5)
    setting:addChild(settingIcon)
    local settingText = ccui.ImageView:create("image/lobby/top/menu/setting_text.png")
    settingText:setAnchorPoint(0, 0.5)
    setting:addChild(settingText)

    -- 事件监听
    self.listener_ = cc.EventListenerTouchOneByOne:create()
    self.listener_:registerScriptHandler(function(touch, event)
        if self.isListening_ then
            local touchPosition = touch:getLocation()
            local x = dialogBG:getPositionX()
            local y = dialogBG:getPositionY()
            local nodeSize = dialogBG:getContentSize()

            local rect = cc.rect(x - nodeSize.width/2, y - nodeSize.height/2,
                    nodeSize.width, nodeSize.height)

            if not cc.rectContainsPoint(rect, touchPosition) then -- 点击黑色遮罩关闭弹窗
                self:hideView()
            end

            return true
        end
        return false
    end, cc.Handler.EVENT_TOUCH_BEGAN)

    eventDispatcher:addEventListenerWithSceneGraphPriority(self.listener_, self)

end

return MenuDialog