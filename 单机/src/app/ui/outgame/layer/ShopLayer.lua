--[[--
    商店层
    ShopLayer.lua
]]
local ShopLayer = class("ShopLayer", require("app.ui.outgame.layer.BaseLayer"))
local GoldShopLayer = require("app.ui.outgame.layer.GoldShopLayer")
local DiamondShopLayer = require("app.ui.outgame.layer.DiamondShopLayer")
local EventDef = require("app.def.EventDef")
local EventManager = require("app.manager.EventManager")
--[[--
    构造函数

    @param none

    @return none
]]
function ShopLayer:ctor()
    ShopLayer.super.ctor(self)
    self.GoldShopLayer_=nil -- 类型：Layout，金币商店界面
    self.DiamondShopLayer_=nil -- 类型：Layout，钻石商店界面

    self:initView()
end

--[[--
    界面初始化

    @param none

    @return none
]]
function ShopLayer:initView()
    local width, height = display.width, 1120
    --商店界面
    self.container_1 = ccui.Layout:create()
    self.container_1:setContentSize(display.width, height)
    self.container_1:setPosition(0, 0)
    self.container_1:addTo(self)

    local basemapSprite = display.newSprite("artcontent/lobby_ongame/store/basemap_store.png")
    self.container_1:addChild(basemapSprite)
    basemapSprite:setPosition(display.cx,display.cy)

    local listViewB = ccui.ListView:create()
    listViewB:setContentSize(display.width, height)
    listViewB:setAnchorPoint(0.5, 0.5)
    listViewB:setPosition(display.cx,display.cy)
    listViewB:setDirection(1)
    listViewB:addTo(self.container_1)

    --金币商店
    self.container_B1 = ccui.Layout:create()
    self.container_B1:setContentSize(display.width, height+70)
    self.container_B1:setAnchorPoint(0,0)
    self.container_B1:setPosition(0, 1)
    self.container_B1:addTo(listViewB)

    self.GoldShopLayer_=GoldShopLayer.new()
    self.GoldShopLayer_:addTo(self.container_B1)

    --钻石商店
    self.container_B2 = ccui.Layout:create()
    self.container_B2:setContentSize(display.width, height/2-300)
    self.container_B2:setAnchorPoint(0,0)
    self.container_B2:setPosition(0, 0)
    self.container_B2:addTo(listViewB)

    self.DiamondShopLayer_=DiamondShopLayer.new()
    self.DiamondShopLayer_:addTo(self.container_B2)
end
--[[--
    节点进入

    @param none

    @return none
]]
function ShopLayer:onEnter()
    EventManager:regListener(EventDef.ID.GOLDSHOP_CHANGE, self, function()
        self.GoldShopLayer_:removeFromParent(true)
        self.GoldShopLayer_=GoldShopLayer.new()
        self.GoldShopLayer_:addTo(self.container_B1)
    end)
end

--[[--
    节点退出

    @param none

    @return none
]]
function ShopLayer:onExit()
    EventManager:unRegListener(EventDef.ID.GOLDSHOP_CHANGE, self)
end
--[[--
    界面刷新

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function ShopLayer:update(dt)
end

return ShopLayer

