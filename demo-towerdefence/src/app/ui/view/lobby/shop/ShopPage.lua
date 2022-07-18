--[[--
    ShopPage.lua

    描述：商城界面
]]
local ShopPage = class("ShopPage", require("app.ui.view.common.BasePage"))
local GoldShopNode = require("app.ui.view.lobby.shop.GoldShopNode")
local DiamondShopNode = require("app.ui.view.lobby.shop.DiamondShopNode")
local Log = require("app.util.Log")

local RES_DIR = "img/lobby/shop/"

--[[--
    描述：构造函数

    @param none

    @return none
]]
function ShopPage:ctor()
    ShopPage.super.ctor(self)

    Log.d()
end

--[[--
    描述：节点进入

    @param none

    @return none
]]
function ShopPage:onEnter()
    ShopPage.super.onEnter(self)

    Log.d()

    self:setContentSize(cc.size(display.width, display.height))
    self:setAnchorPoint(display.ANCHOR_POINTS[display.LEFT_BOTTOM])
    self:setPosition(0, 0)

    -- 初始化底图
    local bgSprite = display.newSprite(RES_DIR .. "bg.png", 0, 0)
    bgSprite:setAnchorPoint(display.ANCHOR_POINTS[display.LEFT_BOTTOM])
    bgSprite:setScaleX(display.scaleX)
    bgSprite:setScaleY(display.scaleY)
    self:addChild(bgSprite, -1)

    -- 初始化滑动区域
    local scrollView = ccui.ScrollView:create():addTo(self)
    scrollView:setContentSize(cc.size(display.width, display.height - (165 + 140) * display.scale))
    scrollView:setAnchorPoint(display.ANCHOR_POINTS[display.CENTER])
    scrollView:setPosition(display.cx, display.cy)

    -- 初始化金币商店
    local goldShopNode = GoldShopNode.new()
    scrollView:addChild(goldShopNode)

    -- 初始化钻石商店
    local diamondShopNode = DiamondShopNode.new()
    scrollView:addChild(diamondShopNode)

    local goldHeight = goldShopNode:getContentSize().height
    local diamondHeight = diamondShopNode:getContentSize().height
    goldShopNode:setPosition(0, diamondHeight)
    diamondShopNode:setPosition(0, 0)
    scrollView:setInnerContainerSize(cc.size(display.width, goldHeight + diamondHeight))
end

return ShopPage