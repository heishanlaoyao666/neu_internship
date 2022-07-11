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
--[[--
    构造函数

    @param none

    @return none
]]
function GoldShopLayer:ctor()
    GoldShopLayer.super.ctor(self)
    self.packs=OutGameData:goldShop()

    self:initView()
end

--[[--
    界面初始化

    @param none

    @return none
]]
function GoldShopLayer:initView()
    local width, height = display.width, 1120
    --商店界面
    self.container_1 = ccui.Layout:create()
    self.container_1:setContentSize(display.width, height)
    self.container_1:setPosition(0, 0)
    self.container_1:addTo(self)

    --金币商城
    local spriteB1 = display.newSprite("artcontent/lobby(ongame)/store/goldstore/basemap_title.png")
    self.container_1:addChild(spriteB1)
    spriteB1:setAnchorPoint(0.5, 1)
    spriteB1:setPosition(width/2,height-70)

    local spriteB2 = display.newSprite("artcontent/lobby(ongame)/store/goldstore/title_goldstore.png")
    self.container_1:addChild(spriteB2)
    spriteB2:setAnchorPoint(0.5, 1)
    spriteB2:setPosition(width/2,height-80)

    --金币商品
    --剩余刷新时间
    local spriteB3 = display.newSprite("artcontent/lobby(ongame)/store/goldstore/basemap_remainingrefreshtime.png")
    self.container_1:addChild(spriteB3)
    spriteB3:setAnchorPoint(0.5, 1)
    spriteB3:setPosition(width/2,height-150)
    local spriteB36 = display.newSprite("artcontent/lobby(ongame)/store/goldstore/prompt_refreshtimeremaining.png")
    spriteB3:addChild(spriteB36)
    spriteB36:setAnchorPoint(0.5, 0.5)
    spriteB36:setPosition(spriteB3:getContentSize().width/2-50,spriteB3:getContentSize().height/2)
    self.countdown=10
    self.m=math.floor(self.countdown/60)
    self.s=math.floor(self.countdown%60)
    self.time=display.newTTFLabel({
        text = "14:00",
        size = 25,
        color = display.COLOR_WHITE
    })
    :align(display.CENTER, spriteB3:getContentSize().width/2+90,spriteB3:getContentSize().height/2)
    :addTo(spriteB3)
    self.time:setString(self.m..":"..string.format("%02d",self.s))

    local function setCountDown()
        self.countdown=self.countdown-1
        self.m=math.floor(self.countdown/60)
        self.s=math.floor(self.countdown%60)
        self.time:setString(self.m..":"..string.format("%02d",self.s))
        if self.countdown<=0 then
            scheduler.unscheduleGlobal(scheduler1)
            EventManager:doEvent(EventDef.ID.GOLDSHOP_CHANGE)
        end
    end
    scheduler1=scheduler.scheduleGlobal(setCountDown, 1)
    --免费商品
    local spriteB4 = ccui.Button:create("artcontent/lobby(ongame)/store/goldstore/basemap_freeitems.png")
    self.container_1:addChild(spriteB4)
    spriteB4:setAnchorPoint(0.5, 1)
    spriteB4:setPosition(120,height-230)
    display.newTTFLabel({
        text = "X100",
        size = 25,
        color = display.COLOR_WHITE
    })
    :align(display.CENTER, spriteB4:getContentSize().width/2,spriteB4:getContentSize().height/2-30)
    :addTo(spriteB4)
    local spriteB24 = display.newSprite("artcontent/lobby(ongame)/store/goldstore/itemicon_diamond.png")
    spriteB4:addChild(spriteB24)
    spriteB24:setAnchorPoint(0.5, 0.5)
    spriteB24:setPosition(spriteB4:getContentSize().width/2,spriteB4:getContentSize().height/2+30)
    local spriteB25 = display.
    newSprite("artcontent/lobby(ongame)/store/goldstore/priceicon_free.png")
    spriteB4:addChild(spriteB25)
    spriteB25:setAnchorPoint(0.5, 0)
    spriteB25:setPosition(spriteB4:getContentSize().width/2,10)
    spriteB4:addTouchEventListener(
        function(sender, eventType)
            if 2 == eventType then -- touch end
                if cc.UserDefault:getInstance():getBoolForKey("音效") then
                    audio.playEffect("sounds/get_free_item.OGG",false)
                end
                EventManager:doEvent(EventDef.ID.FREE)
                OutGameData:setDiamond(100)
                EventManager:doEvent(EventDef.ID.GAMEDATA_CHANGE)
                spriteB4:setBright(false);
                spriteB4:setTouchEnabled(false);
            end
        end
    )
    --五个金币商品
    local itemicon="artcontent/lobby(ongame)/store/goldstore/itemicon_tower/"
    self.spriteB5 = ccui.Button:create(itemicon..self.packs[1]:getTowerId()..".png")
    self.container_1:addChild(self.spriteB5)
    self.spriteB5:setAnchorPoint(0.5, 1)
    self.spriteB5:setPosition(width/3+120,height-230)
    display.newTTFLabel({
        text = "360",
        size = 25,
        color = display.COLOR_WHITE
    })
    :align(display.CENTER, spriteB4:getContentSize().width/2+10,30)
    :addTo(self.spriteB5)
    local spriteB26 = display.newSprite("artcontent/lobby(ongame)/store/goldstore/priceicon_gold.png")
    self.spriteB5:addChild(spriteB26)
    spriteB26:setAnchorPoint(0.5, 0.5)
    spriteB26:setPosition(spriteB4:getContentSize().width/2-30,30)
    local spriteB31 = display.newSprite("artcontent/lobby(ongame)/store/goldstore/basemap_fragmentsnumber.png")
    self.spriteB5:addChild(spriteB31)
    spriteB31:setAnchorPoint(1, 1)
    spriteB31:setPosition(spriteB4:getContentSize().width-11,spriteB4:getContentSize().height-7)
    display.newTTFLabel({
        text = "X36",
        size = 20,
        color = display.COLOR_WHITE
    })
    :align(display.RIGHT_CENTER, spriteB31:getContentSize().width-5,spriteB31:getContentSize().height/2)
    :addTo(spriteB31)
    self.spriteB5:addTouchEventListener(
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

    self.spriteB6 = ccui.Button:create(itemicon..self.packs[2]:getTowerId()..".png")
    self.container_1:addChild(self.spriteB6)
    self.spriteB6:setAnchorPoint(0.5, 1)
    self.spriteB6:setPosition(width*2/3+120,height-230)
    display.newTTFLabel({
        text = "360",
        size = 25,
        color = display.COLOR_WHITE
    })
    :align(display.CENTER, spriteB4:getContentSize().width/2+10,30)
    :addTo(self.spriteB6)
    local spriteB27 = display.newSprite("artcontent/lobby(ongame)/store/goldstore/priceicon_gold.png")
    self.spriteB6:addChild(spriteB27)
    spriteB27:setAnchorPoint(0.5, 0.5)
    spriteB27:setPosition(spriteB4:getContentSize().width/2-30,30)
    local spriteB32 = display.newSprite("artcontent/lobby(ongame)/store/goldstore/basemap_fragmentsnumber.png")
    self.spriteB6:addChild(spriteB32)
    spriteB32:setAnchorPoint(1, 1)
    spriteB32:setPosition(spriteB4:getContentSize().width-11,spriteB4:getContentSize().height-7)
    display.newTTFLabel({
        text = "X36",
        size = 20,
        color = display.COLOR_WHITE
    })
    :align(display.RIGHT_CENTER, spriteB31:getContentSize().width-5,spriteB31:getContentSize().height/2)
    :addTo(spriteB32)
    self.spriteB6:addTouchEventListener(
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

    self.spriteB7 = ccui.Button:create(itemicon..self.packs[3]:getTowerId()..".png")
    self.container_1:addChild(self.spriteB7)
    self.spriteB7:setAnchorPoint(0.5, 1)
    self.spriteB7:setPosition(120,height-450)
    display.newTTFLabel({
        text = "360",
        size = 25,
        color = display.COLOR_WHITE
    })
    :align(display.CENTER, spriteB4:getContentSize().width/2+10,30)
    :addTo(self.spriteB7)
    local spriteB28 = display.newSprite("artcontent/lobby(ongame)/store/goldstore/priceicon_gold.png")
    self.spriteB7:addChild(spriteB28)
    spriteB28:setAnchorPoint(0.5, 0.5)
    spriteB28:setPosition(spriteB4:getContentSize().width/2-30,30)
    local spriteB33 = display.newSprite("artcontent/lobby(ongame)/store/goldstore/basemap_fragmentsnumber.png")
    self.spriteB7:addChild(spriteB33)
    spriteB33:setAnchorPoint(1, 1)
    spriteB33:setPosition(spriteB4:getContentSize().width-11,spriteB4:getContentSize().height-7)
    display.newTTFLabel({
        text = "X36",
        size = 20,
        color = display.COLOR_WHITE
    })
    :align(display.RIGHT_CENTER, spriteB31:getContentSize().width-5,spriteB31:getContentSize().height/2)
    :addTo(spriteB33)
    self.spriteB7:addTouchEventListener(
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

    self.spriteB8 = ccui.Button:create(itemicon..self.packs[4]:getTowerId()..".png")
    self.container_1:addChild(self.spriteB8)
    self.spriteB8:setAnchorPoint(0.5, 1)
    self.spriteB8:setPosition(width/3+120,height-450)
    display.newTTFLabel({
        text = "600",
        size = 25,
        color = display.COLOR_WHITE
    })
    :align(display.CENTER, spriteB4:getContentSize().width/2+10,30)
    :addTo(self.spriteB8)
    local spriteB29 = display.newSprite("artcontent/lobby(ongame)/store/goldstore/priceicon_gold.png")
    self.spriteB8:addChild(spriteB29)
    spriteB29:setAnchorPoint(0.5, 0.5)
    spriteB29:setPosition(spriteB4:getContentSize().width/2-30,30)
    local spriteB34 = display.newSprite("artcontent/lobby(ongame)/store/goldstore/basemap_fragmentsnumber.png")
    self.spriteB8:addChild(spriteB34)
    spriteB34:setAnchorPoint(1, 1)
    spriteB34:setPosition(spriteB4:getContentSize().width-11,spriteB4:getContentSize().height-7)
    display.newTTFLabel({
        text = "X6",
        size = 20,
        color = display.COLOR_WHITE
    })
    :align(display.RIGHT_CENTER, spriteB31:getContentSize().width-5,spriteB31:getContentSize().height/2)
    :addTo(spriteB34)
    self.spriteB8:addTouchEventListener(
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

    self.spriteB9 = ccui.Button:create(itemicon..self.packs[5]:getTowerId()..".png")
    self.container_1:addChild(self.spriteB9)
    self.spriteB9:setAnchorPoint(0.5, 1)
    self.spriteB9:setPosition(width*2/3+120,height-450)
    display.newTTFLabel({
        text = "1000",
        size = 25,
        color = display.COLOR_WHITE
    })
    :align(display.CENTER, spriteB4:getContentSize().width/2+10,30)
    :addTo(self.spriteB9)
    local spriteB30 = display.newSprite("artcontent/lobby(ongame)/store/goldstore/priceicon_gold.png")
    self.spriteB9:addChild(spriteB30)
    spriteB30:setAnchorPoint(0.5, 0.5)
    spriteB30:setPosition(spriteB4:getContentSize().width/2-30,30)
    local spriteB35 = display.newSprite("artcontent/lobby(ongame)/store/goldstore/basemap_fragmentsnumber.png")
    self.spriteB9:addChild(spriteB35)
    spriteB35:setAnchorPoint(1, 1)
    spriteB35:setPosition(spriteB4:getContentSize().width-11,spriteB4:getContentSize().height-7)
    display.newTTFLabel({
        text = "X1",
        size = 20,
        color = display.COLOR_WHITE
    })
    :align(display.RIGHT_CENTER, spriteB31:getContentSize().width-5,spriteB31:getContentSize().height/2)
    :addTo(spriteB35)
    self.spriteB9:addTouchEventListener(
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
            self.spriteB5:setBright(false);
            self.spriteB5:setTouchEnabled(false);
        elseif i==3 then
            self.spriteB6:setBright(false);
            self.spriteB6:setTouchEnabled(false);
        elseif i==4 then
            self.spriteB7:setBright(false);
            self.spriteB7:setTouchEnabled(false);
        elseif i==5 then
            self.spriteB8:setBright(false);
            self.spriteB8:setTouchEnabled(false);
        else
            self.spriteB9:setBright(false);
            self.spriteB9:setTouchEnabled(false);
        end
    end)
end

--[[--
    节点退出

    @param none

    @return none
]]
function GoldShopLayer:onExit()
    EventManager:unRegListener(EventDef.ID.GOODS_CHANGE, self)
end

--[[--
    界面刷新

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function GoldShopLayer:update(dt)
end

return GoldShopLayer

