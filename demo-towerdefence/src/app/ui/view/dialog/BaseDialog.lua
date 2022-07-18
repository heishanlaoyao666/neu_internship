--[[--
    BaseDialog.lua

    描述：弹窗基类
]]
local BaseNode = require("app.ui.view.common.BaseNode")
local BaseDialog = class("BaseDialog", BaseNode)
local DialogManager = require("app.manager.DialogManager")
local Log = require("app.util.Log")

--[[--
    描述：构造函数

    @param ...

    @return none
]]
function BaseDialog:ctor()
    BaseDialog.super.ctor(self)

    Log.d()

    self.maskNode_ = nil -- 类型：BaseNode，遮罩节点（屏蔽点击）
    self.rootNode_ = nil -- 类型：Node，容器节点（弹窗主体）

    self.rootWidth_ = 0 -- 类型：number，容器宽度
    self.rootHeight_ = 0 -- 类型：number，容器高度
end

--[[--
    描述：节点进入

    @param none

    @return none
]]
function BaseDialog:onEnter()
    BaseDialog.super.onEnter(self)

    Log.d()

    -- 初始化遮罩
    self.maskNode_ = BaseNode.new()
    self.maskNode_:setContentSize(cc.size(display.width, display.height))
    self.maskNode_:setAnchorPoint(display.ANCHOR_POINTS[display.LEFT_BOTTOM])
    self.maskNode_:setPosition(0, 0)
    self.maskNode_:setClickEnable(true)
    self.maskNode_:setOnClickListener(function() DialogManager:hideTopDialog() end)
    self:addChild(self.maskNode_, -1)

    -- 初始化半透明
    local colorLayer = display.newColorLayer(cc.c4b(0, 0, 0, 120))
    colorLayer:setContentSize(cc.size(display.width, display.height))
    colorLayer:setAnchorPoint(display.ANCHOR_POINTS[display.LEFT_BOTTOM])
    colorLayer:setPosition(0, 0)
    self.maskNode_:addChild(colorLayer)

    -- 初始化容器
    self.rootNode_ = BaseNode.new()
    self.rootNode_:setClickEnable(true)
    self:addChild(self.rootNode_)
end

--[[--
    描述：节点退出

    @param none

    @return none
]]
function BaseDialog:onExit()
    BaseDialog.super.onExit(self)

    Log.d()
end

--[[--
    描述：初始化容器

    @param bgPath 类型：string，底图路径
    @param anchor 类型：number，锚点
    @param x 类型：number，坐标x
    @param y 类型：number，坐标y

    @return none
]]
function BaseDialog:initRoot(bgPath, anchor, x, y)
    -- 初始化底图
    local bgSprite = display.newSprite(bgPath, 0, 0)
    bgSprite:setAnchorPoint(display.ANCHOR_POINTS[display.LEFT_BOTTOM])
    bgSprite:setScale(display.scale)
    self.rootNode_:addChild(bgSprite, -1)

    local size = bgSprite:getContentSize()
    self.rootWidth_ = size.width * display.scale
    self.rootHeight_ = size.height * display.scale
    self.rootNode_:setContentSize(cc.size(self.rootWidth_, self.rootHeight_))
    self.rootNode_:setAnchorPoint(anchor)
    self.rootNode_:setPosition(x, y)
    self.rootNode_:setScale(0)
end

--[[--
    描述：显示

    @param onCompleteCallback 类型：function，显示完成回调

    @param none
]]
function BaseDialog:show(onCompleteCallback)
    self.rootNode_:stop() -- 先暂停所有
    self.rootNode_:setScale(0)
    local action = cc.Sequence:create(
        cc.EaseExponentialOut:create(cc.ScaleTo:create(0.3, 1)),
        cc.CallFunc:create(function()
            if onCompleteCallback then
                onCompleteCallback()
            end
        end)
    )
    self.rootNode_:runAction(action)
end

--[[--
    描述：隐藏

    @param onCompleteCallback 类型：function，隐藏完成回调

    @return none
]]
function BaseDialog:hide(onCompleteCallback)
    self.rootNode_:stop() -- 先暂停所有
    local action = cc.Sequence:create(
        cc.EaseExponentialIn:create(cc.ScaleTo:create(0.2, 0)),
        cc.CallFunc:create(function()
            if onCompleteCallback then
                onCompleteCallback()
            end
        end)
    )
    self.rootNode_:runAction(action)
end

return BaseDialog