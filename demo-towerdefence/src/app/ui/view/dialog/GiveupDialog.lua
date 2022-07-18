--[[--
    GiveupDialog.lua

    描述：认输弹窗类
]]
local GiveupDialog = class("GiveupDialog", require("app.ui.view.dialog.BaseDialog"))
local DialogManager = require("app.manager.DialogManager")
local Log = require("app.util.Log")

local RES_DIR = "img/play/giveup/"

--[[--
    描述：构造函数

    @param onConfirmCallback 类型：function，确认退出回调

    @return none
]]
function GiveupDialog:ctor(onConfirmCallback)
    GiveupDialog.super.ctor(self)

    Log.d()

    self.onConfirmCallback_ = onConfirmCallback -- 类型：function，确认退出回调
end


--[[--
    描述：节点进入

    @param none

    @return none
]]
function GiveupDialog:onEnter()
    GiveupDialog.super.onEnter(self)

    Log.d()

    -- 初始化容器
    self:initRoot(RES_DIR .. "bg.png", display.ANCHOR_POINTS[display.CENTER], display.cx, display.cy)

    local size = self.rootNode_:getContentSize()
    local cx, cy = size.width * 0.5, size.height * 0.5

    local label = display.newTTFLabel({
        text = "是否认输，放弃该场战斗？",
        size = 36 * display.scale,
        align = cc.TEXT_ALIGNMENT_CENTER,
    })
    label:setAnchorPoint(display.ANCHOR_POINTS[display.CENTER])
    label:setPosition(cx, cy)
    self.rootNode_:addChild(label)

    -- 初始化确定按钮
    local confirmBtn = ccui.Button:create(RES_DIR .. "btn_confirm.png"):addTo(self.rootNode_)
    confirmBtn:setAnchorPoint(display.ANCHOR_POINTS[display.CENTER])
    confirmBtn:setPosition(cx + 120 * display.scale, 70 * display.scale)
    confirmBtn:setScale(display.scale)
    confirmBtn:addTouchEventListener(function(sender, eventType)
        if eventType == ccui.TouchEventType.ended then
            DialogManager:hideDialog(DialogManager.DEF.ID.GIVEUP)

            if self.onConfirmCallback_ then
                self.onConfirmCallback_()
            end
        end
    end)

    -- 初始化取消按钮
    local calcelBtn = ccui.Button:create(RES_DIR .. "btn_cancel.png"):addTo(self.rootNode_)
    calcelBtn:setAnchorPoint(display.ANCHOR_POINTS[display.CENTER])
    calcelBtn:setPosition(cx - 120 * display.scale, 70 * display.scale)
    calcelBtn:setScale(display.scale)
    calcelBtn:addTouchEventListener(function(sender, eventType)
        if eventType == ccui.TouchEventType.ended then
            DialogManager:hideDialog(DialogManager.DEF.ID.GIVEUP)
        end
    end)
end

return GiveupDialog