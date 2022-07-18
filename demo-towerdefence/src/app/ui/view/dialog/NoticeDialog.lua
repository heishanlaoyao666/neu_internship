--[[--
    NoticeDialog.lua

    描述：通知弹窗
]]
local NoticeDialog = class("NoticeDialog", require("app.ui.view.dialog.BaseDialog"))
local DialogManager = require("app.manager.DialogManager")
local Log = require("app.util.Log")

-- 6种默认提示，注意，id对应资源
NoticeDialog.ID = {
    TROPHY_LACK = 1, -- 您的奖杯不足！
    GOLD_LACK = 2, -- 您的金币不足！
    DIAMOND_LACK = 3, -- 您的钻石不足！
    UPGRADE_FAIL_GOLD_LACK = 4, -- 升级失败，您的金币不足！
    UPGRADE_FAIL_CARD_LACK = 5, -- 升级失败，您的卡牌不足！
    CONFIRM_QUIT = 6, -- 是否确认退出？
}

local RES_DIR = "img/lobby/notice/"

--[[--
    描述：构造函数

    @param arg 类型：number or string，若是string显示文字；若是数字显示6种类型
    @param onConfirmCallback 类型：function，确认按钮点击回调

    @return none
]]
function NoticeDialog:ctor(arg, onConfirmCallback)
    NoticeDialog.super.ctor(self)

    Log.d()

    self.onConfirmCallback_ = onConfirmCallback -- 类型：function，确认按钮点击回调
    self.id_ = 0 -- 类型：number，arg为number时有效
    self.text_ = "" -- 类型：string，arg为string时有效
    self.isText_ = false -- 类型：boolean，true显示文字；false显示图片

    if isNumber(arg) then
        self.id_ = math.max(1, math.min(6, arg))
    else
        self.text_ = tostring(arg) or ""
        self.isText_ = true
    end
end

--[[--
    描述：节点进入

    @param none

    @return none
]]
function NoticeDialog:onEnter()
    NoticeDialog.super.onEnter(self)

    Log.d()

    -- 初始化容器
    self:initRoot(RES_DIR .. "bg.png", display.ANCHOR_POINTS[display.CENTER], display.cx, display.cy)

    local size = self.rootNode_:getContentSize()
    local cx, cy = size.width * 0.5, size.height * 0.5

    if self.isText_ then
        local label = display.newTTFLabel({
            text = self.text_,
            size = 36 * display.scale,
            align = cc.TEXT_ALIGNMENT_CENTER,
            color = cc.c3b(245, 245, 245),
        })
        label:setAnchorPoint(display.ANCHOR_POINTS[display.CENTER])
        label:setPosition(cx, cy)
        self.rootNode_:addChild(label)
    else
        local sprite = display.newSprite(string.format("%stext_%d.png", RES_DIR, self.id_))
        sprite:setAnchorPoint(display.ANCHOR_POINTS[display.CENTER])
        sprite:setPosition(cx, cy)
        sprite:setScale(display.scale)
        self.rootNode_:addChild(sprite)
    end

    -- 初始化确定按钮
    local confirmBtn = ccui.Button:create(RES_DIR .. "btn_confirm.png"):addTo(self.rootNode_)
    confirmBtn:setAnchorPoint(display.ANCHOR_POINTS[display.CENTER])
    confirmBtn:setPosition(cx, 50 * display.scale)
    confirmBtn:setScale(display.scale)
    confirmBtn:addTouchEventListener(function(sender, eventType)
        if eventType == ccui.TouchEventType.ended then
            DialogManager:hideDialog(DialogManager.DEF.ID.NOTICE)

            if self.onConfirmCallback_ then
                self.onConfirmCallback_()
            end
        end
    end)
end

return NoticeDialog