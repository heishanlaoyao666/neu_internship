--[[
    RegisterSucceedDialog.lua
    描述：注册成功弹窗
]]
local RegisterSucceedDialog = class("RegisterSucceedDialog", require("app.ui.layer.BaseUILayout"))
local MsgManager = require("app.manager.MsgManager")
local eventDispatcher = cc.Director:getInstance():getEventDispatcher()

--[[--
    构造函数

    @param txt string 要显示的信息

    @return none
]]
function RegisterSucceedDialog:ctor(text)
    RegisterSucceedDialog.super.ctor(self)


    self.container_ = nil -- 全局容器

    self.text_ = text


    self:initView()
    self:hideView()
end

--[[--
    界面初始化

    @param none

    @return none
]]
function RegisterSucceedDialog:initView()
    print("init dialog")

    self.container_ = ccui.Layout:create()
    self.container_:setContentSize(display.width, display.height)
    self.container_:setAnchorPoint(0.5, 0.5)
    self.container_:setPosition(display.width/2, display.height/2)
    self.container_:setBackGroundColor(cc.c3b(0, 0, 0))
    self.container_:setBackGroundColorType(1)
    self.container_:setCascadeOpacityEnabled(false) -- 穿透
    self.container_:setOpacity(0.8 * 255)
    self:addChild(self.container_)

    -- 弹窗背景
    local dialog = ccui.Layout:create()
    dialog:setBackGroundImage("image/lobby/general/inform/dialog_bg.png")
    local dialogWidth, dialogHeight = dialog:getBackGroundImageTextureSize().width, dialog:getBackGroundImageTextureSize().height
    dialog:setContentSize(dialogWidth, dialogHeight)
    dialog:setAnchorPoint(0.5, 0.5)
    dialog:setPosition(display.width/2, display.height/2)
    self.container_:addChild(dialog)

    -- 关闭按钮
    local closeBtn = ccui.Button:create("image/lobby/store/gold/dialog/close_btn.png")
    closeBtn:setPosition(1.1*dialogWidth, 2.31*dialogHeight)
    closeBtn:addClickEventListener(function()
        self:hideView()
    end)
    self.container_:addChild(closeBtn)

    -- 确定按钮
    local confirmBtn = ccui.Button:create("image/lobby/general/inform/confirm_btn.png")
    confirmBtn:setPosition(0.7*dialogWidth, 1.6*dialogHeight)
    confirmBtn:addClickEventListener(function()
        self:hideView()
        display.replaceScene(require("app.scenes.LobbyScene"):new())
        MsgManager:recStoreData()
        MsgManager:recPlayerData() -- 联网更新
    end)
    self.container_:addChild(confirmBtn)


    -- 显示文字
    local label = cc.Label:createWithTTF(self.text_,"font/fzhz.ttf", 48)
    label:setPosition(0.7*dialogWidth, 2*dialogHeight)
    label:setTextColor(cc.c4b(248,191,42,255))
    self.container_:addChild(label)

    -- 事件监听(空白处关闭)
    self.listener_ = cc.EventListenerTouchOneByOne:create()
    self.listener_:registerScriptHandler(function(touch, event)
        if self.isListening_ then
            local touchPosition = touch:getLocation()
            local x = dialog:getPositionX()
            local y = dialog:getPositionY()
            local nodeSize = dialog:getContentSize()

            local rect = cc.rect(x - nodeSize.width/2, y - nodeSize.height/2,
                    nodeSize.width, nodeSize.height)

            if not cc.rectContainsPoint(rect, touchPosition) then -- 点击黑色遮罩关闭弹窗并跳转到Lobby场景
                self:hideView()
                display.replaceScene(require("app.scenes.LobbyScene"):new())
            end

            return true
        end
        return false
    end, cc.Handler.EVENT_TOUCH_BEGAN)

    eventDispatcher:addEventListenerWithSceneGraphPriority(self.listener_, self)

end

return RegisterSucceedDialog