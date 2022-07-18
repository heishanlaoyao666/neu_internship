--[[--
    RankmapNode.lua

    描述：天梯模块节点类
]]
local RankmapNode = class("RankmapNode", require("app.ui.view.common.BaseNode"))
local Log = require("app.util.Log")

local RES_DIR = "img/lobby/fight/rankmap/"

--[[--
    描述：构造函数

    @param none

    @return none
]]
function RankmapNode:ctor()
    RankmapNode.super.ctor(self)

    Log.d()
end

--[[--
    描述：节点进入

    @param none

    @return none
]]
function RankmapNode:onEnter()
    RankmapNode.super.onEnter(self)

    Log.d()

    -- 初始化底图
    local bgSprite = display.newSprite(RES_DIR .. "bg.png", 0, 0)
    bgSprite:setAnchorPoint(display.ANCHOR_POINTS[display.LEFT_BOTTOM])
    bgSprite:setScaleX(display.scaleX)
    bgSprite:setScaleY(display.scale)
    self:addChild(bgSprite, -1)

    local size = bgSprite:getContentSize()
    self:setContentSize(cc.size(size.width * display.scaleX, size.height * display.scale))
    self:setAnchorPoint(display.ANCHOR_POINTS[display.CENTER])
    self:setPosition(display.cx, display.top - 320 * display.scale)

    -- TODO 其它功能
end

return RankmapNode