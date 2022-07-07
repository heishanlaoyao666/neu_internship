--[[--
    商店层
    ShopLayer.lua
]]
local ShopView = class("ShopView", function()
    return display.newColorLayer(cc.c4b(0, 0, 0, 0))
end)
local OutGameData = require("app.data.outgame.OutGameData")
local GoldShopLayer = require("app.ui.outgame.layer.GoldShopLayer")
local DiamondShopLayer = require("app.ui.outgame.layer.DiamondShopLayer")
local EventDef = require("app.def.EventDef")
local EventManager = require("app.manager.EventManager")
--[[--
    构造函数

    @param none

    @return none
]]
function ShopView:ctor()
    self.GoldShopLayer_=nil
    self.DiamondShopLayer_=nil
    self.packs=OutGameData:goldShop()

    self:initView()
    self:registerScriptHandler(function(event)
        if event == "enter" then
            self:onEnter()
        elseif event == "exit" then
            self:onExit()
        end
    end)
end

--[[--
    界面初始化

    @param none

    @return none
]]
function ShopView:initView()
    local width, height = display.width, 1120
    --商店界面
    self.container_1 = ccui.Layout:create()
    self.container_1:setContentSize(display.width, height)
    self.container_1:setPosition(0, 0)
    self.container_1:addTo(self)

    local spriteB = display.newSprite("artcontent/lobby(ongame)/store/basemap_store.png")
    self.container_1:addChild(spriteB)
    spriteB:setPosition(display.cx,display.cy)

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
function ShopView:onEnter()
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
function ShopView:onExit()
    EventManager:unRegListener(EventDef.ID.GOLDSHOP_CHANGE, self)
end
--[[--
    界面刷新

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function ShopView:update(dt)
end

return ShopView

