--[[--
    DiamondShopNode.lua

    描述：金币模块节点
]]
local DiamondShopNode = class("DiamondShopNode", require("app.ui.view.common.BaseNode"))
local Log = require("app.util.Log")

local RES_DIR = "img/lobby/shop/diamondshop/"

---------------------------------------------------------------------------
-- 私有函数定义
---------------------------------------------------------------------------
local _initGoods

--[[--
    描述：构造函数

    @param none

    @return none
]]
function DiamondShopNode:ctor()
    DiamondShopNode.super.ctor(self)

    Log.d()
end

--[[--
    描述：节点进入

    @param none

    @return none
]]
function DiamondShopNode:onEnter()
    DiamondShopNode.super.onEnter(self)

    Log.d()

    local width = display.width
    local height = 620 * display.scale
    local cx = width * 0.5

    self:setContentSize(cc.size(width, height))
    self:setAnchorPoint(display.ANCHOR_POINTS[display.LEFT_BOTTOM])

--    self:initTestBg(cc.c4b(0, 0, 255, 255))

    -- 初始化标题底图
    local bgTitleSprite = display.newSprite(RES_DIR .. "bg_title.png", cx, height)
    bgTitleSprite:setAnchorPoint(display.ANCHOR_POINTS[display.CENTER_TOP])
    bgTitleSprite:setScaleX(display.scaleX)
    bgTitleSprite:setScale(display.scale)
    self:addChild(bgTitleSprite)

    -- 初始标题
    local titleSprite = display.newSprite(RES_DIR .. "title.png", cx, height - 32 * display.scale)
    titleSprite:setAnchorPoint(display.ANCHOR_POINTS[display.CENTER])
    titleSprite:setScale(display.scale)
    self:addChild(titleSprite)
end

---------------------------------------------------------------------------
-- 私有函数实现
---------------------------------------------------------------------------

--[[--
    描述：初始化商品

    @param self 类型：GoldShopNode，当前节点

    @return none
]]
function _initGoods(self)
    -- TODO
end

return DiamondShopNode