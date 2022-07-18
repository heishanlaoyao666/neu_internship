--[[--
    LoadingBar.lua

    描述：加载进度条，样式定制，仅在底部显示。
          进度条包含3部分：底图、进度、头部
]]
local LoadingBar = class("LoadingBar", require("app.ui.view.common.BaseNode"))
local Log = require("app.util.Log")

local MAX_PROGRESS = 100

local RES_DIR = "img/loading/"

--[[--
    描述：构造函数

    @param width 类型：number，进度条宽度，注意，是设计宽度

    @return none
]]
function LoadingBar:ctor(width)
    LoadingBar.super.ctor(self)

    self.barSprite_ = nil -- 类型：CCSprite，进度精灵
    self.headSprite_ = nil -- 类型：CCSprite，头部精灵
    self.width_ = width -- 类型：number，进度条宽度
    self.progress_ = 0 -- 类型：number，进度，整数，范围0~100
end

--[[--
    描述：视图进入

    @param none

    @return none
]]
function LoadingBar:onEnter()
    LoadingBar.super.onEnter(self)

    -- 初始化底图精灵
    local bgSprite = display.newSprite(RES_DIR .. "bar_bg.png", 0, 0)
    bgSprite:setAnchorPoint(display.ANCHOR_POINTS[display.LEFT_BOTTOM])
    self:addChild(bgSprite, -1)

    -- 重置当前节点尺寸，高度同底图
    self:setContentSize(cc.size(self.width_, bgSprite:getContentSize().height))
    self:setAnchorPoint(display.ANCHOR_POINTS[display.LEFT_BOTTOM])

    -- 初始化进度条精灵
    self.barSprite_ = display.newSprite(RES_DIR .. "bar_body.png", 0, 0)
    self.barSprite_:setAnchorPoint(display.ANCHOR_POINTS[display.LEFT_BOTTOM])
    self:addChild(self.barSprite_)

    -- 初始化头部精灵
    self.headSprite_ = display.newSprite(RES_DIR .. "bar_head.png", 0, 0)
    self.headSprite_:setAnchorPoint(display.ANCHOR_POINTS[display.LEFT_BOTTOM])
    self:addChild(self.headSprite_)
end

--[[--
    描述：设置进度

    @param progress 类型：number，进度，整数，范围0~100

    @return none
]]
function LoadingBar:setProgress(progress)
    if not isNumber(progress) then
        Log.e("unexpecet param, progress=", progress)
        return
    end

    if progress == self.progress_ then return end

    self.progress_ = math.max(0, math.min(MAX_PROGRESS, progress))

    -- 计算百分比
    local percent = self.progress_ / MAX_PROGRESS
    local progressWidth = self.width_ * percent

    -- 设置头部的位置
    self.headSprite_:setPosition(progressWidth, self.headSprite_:getPositionY())

    -- 设置进度缩放
    local barWidth = self.barSprite_:getContentSize().width
    local scaleX = progressWidth / barWidth
    self.barSprite_:setScaleX(scaleX)
end

--[[--
    描述：获取当前进度

    @param none

    @return number
]]
function LoadingBar:getProgress()
    return self.progress_
end

return LoadingBar