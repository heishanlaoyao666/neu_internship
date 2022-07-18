--[[--
    ToastNode.lua

    描述：toast提示，显示在屏幕最上方，自动消失；多个toast排队显示；
]]
local ToastNode = class("ToastNode", require("app.ui.view.common.BaseNode"))
local Log = require("app.util.Log")

local DURATION = 1 -- toast的持续时间，单位：秒

--[[--
    描述：构造函数

    @param text 类型：string，提示文字

    @return none
]]
function ToastNode:ctor(text)
    ToastNode.super.ctor(self)

    Log.d()

    self.text_ = text -- 类型：string，提示文字
end

--[[--
    描述：节点进入

    @param none

    @return none
]]
function ToastNode:onEnter()
    ToastNode.super.onEnter(self)

    Log.d()

    -- 初始化底图
    local bgSprite = display.newSprite("img/common/bg_toast.png", 0, 0)
    bgSprite:setAnchorPoint(display.ANCHOR_POINTS[display.LEFT_BOTTOM])
    bgSprite:setPosition(0, 0)
    bgSprite:setScaleX(display.scaleX)
    bgSprite:setScaleY(display.scale)
    self:addChild(bgSprite, -1)

    local size = bgSprite:getContentSize()
    local width, height = size.width * display.scaleX, size.height * display.scale
    self:setContentSize(cc.size(width, height))
    self:setAnchorPoint(display.ANCHOR_POINTS[display.CENTER])
    self:setPosition(display.cx, display.cy)

    -- 初始化文本
    local label = display.newTTFLabel({
        text = self.text_,
        size = 36 * display.scale,
        align = cc.TEXT_ALIGNMENT_CENTER,
        color = cc.c3b(245, 245, 245),
    })
    label:setAnchorPoint(display.ANCHOR_POINTS[display.CENTER])
    label:setPosition(width * 0.5, height * 0.5)
    self:addChild(label)
end

--[[--
    描述：显示

    @param onCompleteCallback 类型：function，显示完成回调

    @param none
]]
function ToastNode:show(onCompleteCallback)
    self:stop() -- 先暂停所有
    self:setScale(0)
    local action = cc.Sequence:create(
        cc.ScaleTo:create(0.1, 1),
        cc.DelayTime:create(DURATION),
        cc.ScaleTo:create(0.1, 0),
        cc.CallFunc:create(function()
            if onCompleteCallback then
                onCompleteCallback()
            end
        end)
    )
    self:runAction(action)
end

return ToastNode