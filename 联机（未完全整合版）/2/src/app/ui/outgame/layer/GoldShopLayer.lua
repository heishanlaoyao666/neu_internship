--[[--
    商店层
    GoldShopLayer.lua
]]
local GoldShopLayer = class("GoldShopLayer", require("app.ui.outgame.layer.BaseLayer"))
local OutGameData = require("app.data.outgame.OutGameData")
local EventDef = require("app.def.EventDef")
local EventManager = require("app.manager.EventManager")
local BuyLayer = require("app.ui.outgame.layer.BuyLayer")
local scheduler = require("framework.scheduler")
local socket = require "socket"
--[[--
    构造函数

    @param none

    @return none
]]
function GoldShopLayer:ctor()
    GoldShopLayer.super.ctor(self)

    self:initView()
end

--[[--
    界面初始化

    @param none

    @return none
]]
function GoldShopLayer:initView()
    local width, height = display.width, 1120
    local now=socket.gettime()
    --商店界面
    self.container_1 = ccui.Layout:create()
    self.container_1:setContentSize(display.width, height)
    self.container_1:setPosition(0, 0)
    self.container_1:addTo(self)

    --金币商城
    local basemapTitleSprite = display.newSprite("artcontent/lobby_ongame/store/goldstore/basemap_title.png")
    self.container_1:addChild(basemapTitleSprite)
    basemapTitleSprite:setAnchorPoint(0.5, 1)
    basemapTitleSprite:setPosition(width/2,height-70)

    local titleSprite = display.newSprite("artcontent/lobby_ongame/store/goldstore/title_goldstore.png")
    self.container_1:addChild(titleSprite)
    titleSprite:setAnchorPoint(0.5, 1)
    titleSprite:setPosition(width/2,height-80)

    --金币商品
    --剩余刷新时间
    local basemapTime= display.newSprite("artcontent/lobby_ongame/store/goldstore/basemap_remainingrefreshtime.png")
    self.container_1:addChild(basemapTime)
    basemapTime:setAnchorPoint(0.5, 1)
    basemapTime:setPosition(width/2,height-150)
    local promptSprite = display.newSprite("artcontent/lobby_ongame/store/goldstore/prompt_refreshtimeremaining.png")
    basemapTime:addChild(promptSprite)
    promptSprite:setAnchorPoint(0.5, 0.5)
    promptSprite:setPosition(basemapTime:getContentSize().width/2-50,basemapTime:getContentSize().height/2)
    self.countDown=15--*60
    self.m=math.floor(self.countDown/60)
    self.s=math.floor(self.countDown%60)
    self.time=display.newTTFLabel({
        text = "14:00",
        size = 25,
         color = cc.c3b(255, 215, 0)
    })
    :align(display.CENTER, basemapTime:getContentSize().width/2+90,basemapTime:getContentSize().height/2)
    :addTo(basemapTime)
    self.time:setString(self.m..":"..string.format("%02d",self.s))

    --免费商品
    local basemapFree = ccui.Button:create("artcontent/lobby_ongame/store/goldstore/basemap_freeitems.png")
    self.container_1:addChild(basemapFree)
    basemapFree:setAnchorPoint(0.5, 1)
    basemapFree:setPosition(120,height-230)
    display.newTTFLabel({
        text = "X100",
        size = 25,
         color = display.COLOR_WHITE
    })
    :align(display.CENTER, basemapFree:getContentSize().width/2,basemapFree:getContentSize().height/2-30)
    :addTo(basemapFree)
    local diamondSprite = display.newSprite("artcontent/lobby_ongame/store/goldstore/itemicon_diamond.png")
    basemapFree:addChild(diamondSprite)
    diamondSprite:setAnchorPoint(0.5, 0.5)
    diamondSprite:setPosition(basemapFree:getContentSize().width/2,basemapFree:getContentSize().height/2+30)

    local priceiconFree = display.newSprite("artcontent/lobby_ongame/store/goldstore/priceicon_free.png")
    basemapFree:addChild(priceiconFree)
    priceiconFree:setAnchorPoint(0.5, 0)
    priceiconFree:setPosition(basemapFree:getContentSize().width/2,10)
    basemapFree:addTouchEventListener(
        function(sender, eventType)
            if 2 == eventType then -- touch end
                if cc.UserDefault:getInstance():getBoolForKey("音效") then
                    audio.playEffect("sounds/get_free_item.OGG",false)
                end
                EventManager:doEvent(EventDef.ID.FREE)
                OutGameData:setDiamond(100)
                EventManager:doEvent(EventDef.ID.GAMEDATA_CHANGE)
                basemapFree:setBright(false);
                basemapFree:setTouchEnabled(false);
                cc.UserDefault:getInstance():setIntegerForKey("itemicon1",2)
            end
        end
    )

    local oldtime=cc.UserDefault:getInstance():getIntegerForKey("countDown")
    local ctime=now-cc.UserDefault:getInstance():getIntegerForKey("now")
    if ctime>=oldtime then
        self.countDown=15
        cc.UserDefault:getInstance():setIntegerForKey("itemicon1",1)
        cc.UserDefault:getInstance():setIntegerForKey("itemicon2",1)
        cc.UserDefault:getInstance():setIntegerForKey("itemicon3",1)
        cc.UserDefault:getInstance():setIntegerForKey("itemicon4",1)
        cc.UserDefault:getInstance():setIntegerForKey("itemicon5",1)
        cc.UserDefault:getInstance():setIntegerForKey("itemicon6",1)
        self.packs=OutGameData:goldShop()
    else
        self.countDown=oldtime-ctime
        self.packs=OutGameData:oldGoldShop()
    end

    --五个金币商品
    local itemicon="artcontent/lobby_ongame/store/goldstore/itemicon_tower/"
    self.itemicon1Sprite = ccui.Button:create(itemicon..self.packs[1]:getTowerId()..".png")
    self.container_1:addChild(self.itemicon1Sprite)
    self.itemicon1Sprite:setAnchorPoint(0.5, 1)
    self.itemicon1Sprite:setPosition(width/3+120,height-230)
    display.newTTFLabel({
        text = "360",
        size = 25,
         color = display.COLOR_WHITE
    })
    :align(display.CENTER, basemapFree:getContentSize().width/2+10,30)
    :addTo(self.itemicon1Sprite)
    local priceicon1Sprite = display.newSprite("artcontent/lobby_ongame/store/goldstore/priceicon_gold.png")
    self.itemicon1Sprite:addChild(priceicon1Sprite)
    priceicon1Sprite:setAnchorPoint(0.5, 0.5)
    priceicon1Sprite:setPosition(basemapFree:getContentSize().width/2-30,30)
    local basemapSprite1 = display.newSprite("artcontent/lobby_ongame/store/goldstore/basemap_fragmentsnumber.png")
    self.itemicon1Sprite:addChild(basemapSprite1)
    basemapSprite1:setAnchorPoint(1, 1)
    basemapSprite1:setPosition(basemapFree:getContentSize().width-11,basemapFree:getContentSize().height-7)
    display.newTTFLabel({
        text = "X36",
        size = 20,
         color = cc.c3b(255, 215, 0)
    })
    :align(display.RIGHT_CENTER, basemapSprite1:getContentSize().width-5,basemapSprite1:getContentSize().height/2)
    :addTo(basemapSprite1)
    self.itemicon1Sprite:addTouchEventListener(
        function(sender, eventType)
            if 2 == eventType then -- touch end
                if cc.UserDefault:getInstance():getBoolForKey("音效") then
                    audio.playEffect("sounds/get_paid_item.OGG",false)
                end
                BuyLayer:SetBuy(2,36,360,self.packs[1])
                EventManager:doEvent(EventDef.ID.BUY)
            end
        end
    )

    self.itemicon2Sprite = ccui.Button:create(itemicon..self.packs[2]:getTowerId()..".png")
    self.container_1:addChild(self.itemicon2Sprite)
    self.itemicon2Sprite:setAnchorPoint(0.5, 1)
    self.itemicon2Sprite:setPosition(width*2/3+120,height-230)
    display.newTTFLabel({
        text = "360",
        size = 25,
         color = display.COLOR_WHITE
    })
    :align(display.CENTER, basemapFree:getContentSize().width/2+10,30)
    :addTo(self.itemicon2Sprite)
    local priceicon2Sprite  = display.newSprite("artcontent/lobby_ongame/store/goldstore/priceicon_gold.png")
    self.itemicon2Sprite:addChild(priceicon2Sprite)
    priceicon2Sprite:setAnchorPoint(0.5, 0.5)
    priceicon2Sprite:setPosition(basemapFree:getContentSize().width/2-30,30)
    local basemapSprite2 = display.newSprite("artcontent/lobby_ongame/store/goldstore/basemap_fragmentsnumber.png")
    self.itemicon2Sprite:addChild(basemapSprite2)
    basemapSprite2:setAnchorPoint(1, 1)
    basemapSprite2:setPosition(basemapFree:getContentSize().width-11,basemapFree:getContentSize().height-7)
    display.newTTFLabel({
        text = "X36",
        size = 20,
         color = cc.c3b(255, 215, 0)
    })
    :align(display.RIGHT_CENTER, basemapSprite1:getContentSize().width-5,basemapSprite1:getContentSize().height/2)
    :addTo(basemapSprite2)
    self.itemicon2Sprite:addTouchEventListener(
        function(sender, eventType)
            if 2 == eventType then -- touch end
                if cc.UserDefault:getInstance():getBoolForKey("音效") then
                    audio.playEffect("sounds/get_paid_item.OGG",false)
                end
                BuyLayer:SetBuy(3,36,360,self.packs[2])
                EventManager:doEvent(EventDef.ID.BUY)
            end
        end
    )

    self.itemicon3Sprite = ccui.Button:create(itemicon..self.packs[3]:getTowerId()..".png")
    self.container_1:addChild(self.itemicon3Sprite)
    self.itemicon3Sprite:setAnchorPoint(0.5, 1)
    self.itemicon3Sprite:setPosition(120,height-450)
    display.newTTFLabel({
        text = "360",
        size = 25,
         color = display.COLOR_WHITE
    })
    :align(display.CENTER, basemapFree:getContentSize().width/2+10,30)
    :addTo(self.itemicon3Sprite)
    local priceicon3Sprite = display.newSprite("artcontent/lobby_ongame/store/goldstore/priceicon_gold.png")
    self.itemicon3Sprite:addChild(priceicon3Sprite)
    priceicon3Sprite:setAnchorPoint(0.5, 0.5)
    priceicon3Sprite:setPosition(basemapFree:getContentSize().width/2-30,30)
    local basemapSprite3 = display.newSprite("artcontent/lobby_ongame/store/goldstore/basemap_fragmentsnumber.png")
    self.itemicon3Sprite:addChild(basemapSprite3)
    basemapSprite3:setAnchorPoint(1, 1)
    basemapSprite3:setPosition(basemapFree:getContentSize().width-11,basemapFree:getContentSize().height-7)
    display.newTTFLabel({
        text = "X36",
        size = 20,
         color = cc.c3b(255, 215, 0)
    })
    :align(display.RIGHT_CENTER, basemapSprite1:getContentSize().width-5,basemapSprite1:getContentSize().height/2)
    :addTo(basemapSprite3)
    self.itemicon3Sprite:addTouchEventListener(
        function(sender, eventType)
            if 2 == eventType then -- touch end
                if cc.UserDefault:getInstance():getBoolForKey("音效") then
                    audio.playEffect("sounds/get_paid_item.OGG",false)
                end
                BuyLayer:SetBuy(4,36,360,self.packs[3])
                EventManager:doEvent(EventDef.ID.BUY)
            end
        end
    )

    self.itemicon4Sprite = ccui.Button:create(itemicon..self.packs[4]:getTowerId()..".png")
    self.container_1:addChild(self.itemicon4Sprite)
    self.itemicon4Sprite:setAnchorPoint(0.5, 1)
    self.itemicon4Sprite:setPosition(width/3+120,height-450)
    display.newTTFLabel({
        text = "600",
        size = 25,
         color = display.COLOR_WHITE
    })
    :align(display.CENTER, basemapFree:getContentSize().width/2+10,30)
    :addTo(self.itemicon4Sprite)
    local priceicon4Sprite = display.newSprite("artcontent/lobby_ongame/store/goldstore/priceicon_gold.png")
    self.itemicon4Sprite:addChild(priceicon4Sprite)
    priceicon4Sprite:setAnchorPoint(0.5, 0.5)
    priceicon4Sprite:setPosition(basemapFree:getContentSize().width/2-30,30)
    local basemapSprite4 = display.newSprite("artcontent/lobby_ongame/store/goldstore/basemap_fragmentsnumber.png")
    self.itemicon4Sprite:addChild(basemapSprite4)
    basemapSprite4:setAnchorPoint(1, 1)
    basemapSprite4:setPosition(basemapFree:getContentSize().width-11,basemapFree:getContentSize().height-7)
    display.newTTFLabel({
        text = "X6",
        size = 20,
         color = cc.c3b(255, 215, 0)
    })
    :align(display.RIGHT_CENTER, basemapSprite1:getContentSize().width-5,basemapSprite1:getContentSize().height/2)
    :addTo(basemapSprite4)
    self.itemicon4Sprite:addTouchEventListener(
        function(sender, eventType)
            if 2 == eventType then -- touch end
                if cc.UserDefault:getInstance():getBoolForKey("音效") then
                    audio.playEffect("sounds/get_paid_item.OGG",false)
                end
                BuyLayer:SetBuy(5,6,600,self.packs[4])
                EventManager:doEvent(EventDef.ID.BUY)
            end
        end
    )

    self.itemicon5Sprite = ccui.Button:create(itemicon..self.packs[5]:getTowerId()..".png")
    self.container_1:addChild(self.itemicon5Sprite)
    self.itemicon5Sprite:setAnchorPoint(0.5, 1)
    self.itemicon5Sprite:setPosition(width*2/3+120,height-450)
    display.newTTFLabel({
        text = "1000",
        size = 25,
        color = display.COLOR_WHITE
    })
    :align(display.CENTER, basemapFree:getContentSize().width/2+10,30)
    :addTo(self.itemicon5Sprite)
    local priceicon5Sprite = display.newSprite("artcontent/lobby_ongame/store/goldstore/priceicon_gold.png")
    self.itemicon5Sprite:addChild(priceicon5Sprite)
    priceicon5Sprite:setAnchorPoint(0.5, 0.5)
    priceicon5Sprite:setPosition(basemapFree:getContentSize().width/2-30,30)
    local basemapSprite5 = display.newSprite("artcontent/lobby_ongame/store/goldstore/basemap_fragmentsnumber.png")
    self.itemicon5Sprite:addChild(basemapSprite5)
    basemapSprite5:setAnchorPoint(1, 1)
    basemapSprite5:setPosition(basemapFree:getContentSize().width-11,basemapFree:getContentSize().height-7)
    display.newTTFLabel({
        text = "X1",
        size = 20,
        color = cc.c3b(255, 215, 0)
    })
    :align(display.RIGHT_CENTER, basemapSprite1:getContentSize().width-5,basemapSprite1:getContentSize().height/2)
    :addTo(basemapSprite5)
    self.itemicon5Sprite:addTouchEventListener(
        function(sender, eventType)
            if 2 == eventType then -- touch end
                if cc.UserDefault:getInstance():getBoolForKey("音效") then
                    audio.playEffect("sounds/get_paid_item.OGG",false)
                end
                BuyLayer:SetBuy(6,1,1000,self.packs[5])
                EventManager:doEvent(EventDef.ID.BUY)
            end
        end
    )
    local function setCountDown()
        self.countDown=self.countDown-1
        self.m=math.floor(self.countDown/60)
        self.s=math.floor(self.countDown%60)
        self.time:setString(self.m..":"..string.format("%02d",self.s))
        if self.countDown<=0 then
            scheduler.unscheduleGlobal(scheduler1)
            EventManager:doEvent(EventDef.ID.GOLDSHOP_CHANGE)
        end
    end
    local item={basemapFree,self.itemicon1Sprite,self.itemicon2Sprite,self.itemicon3Sprite,
    self.itemicon4Sprite,self.itemicon5Sprite}
    if ctime>=oldtime then
    else
        for i=1,6 do
            if cc.UserDefault:getInstance():getIntegerForKey("itemicon"..i)==2 then
                item[i]:setBright(false);
                item[i]:setTouchEnabled(false);
            end
        end
    end

    scheduler1=scheduler.scheduleGlobal(setCountDown, 1)
end
--[[--
    节点进入

    @param none

    @return none
]]
function GoldShopLayer:onEnter()
    EventManager:regListener(EventDef.ID.GOODS_CHANGE, self, function(i)
        print(i)
        if i==2 then
            self.itemicon1Sprite:setBright(false);
            self.itemicon1Sprite:setTouchEnabled(false);
            cc.UserDefault:getInstance():setIntegerForKey("itemicon2",2)
        elseif i==3 then
            self.itemicon2Sprite:setBright(false);
            self.itemicon2Sprite:setTouchEnabled(false);
            cc.UserDefault:getInstance():setIntegerForKey("itemicon3",2)
        elseif i==4 then
            self.itemicon3Sprite:setBright(false);
            self.itemicon3Sprite:setTouchEnabled(false);
            cc.UserDefault:getInstance():setIntegerForKey("itemicon4",2)
        elseif i==5 then
            self.itemicon4Sprite:setBright(false);
            self.itemicon4Sprite:setTouchEnabled(false);
            cc.UserDefault:getInstance():setIntegerForKey("itemicon5",2)
        else
            self.itemicon5Sprite:setBright(false);
            self.itemicon5Sprite:setTouchEnabled(false);
            cc.UserDefault:getInstance():setIntegerForKey("itemicon6",2)
        end
    end)
end

--[[--
    节点退出

    @param none

    @return none
]]
function GoldShopLayer:onExit()
    local now=socket.gettime()
    cc.UserDefault:getInstance():setIntegerForKey("now",now)
    EventManager:unRegListener(EventDef.ID.GOODS_CHANGE, self)
    cc.UserDefault:getInstance():setIntegerForKey("countDown",self.countDown)
end

--[[--
    界面刷新

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function GoldShopLayer:update(dt)
end

return GoldShopLayer

