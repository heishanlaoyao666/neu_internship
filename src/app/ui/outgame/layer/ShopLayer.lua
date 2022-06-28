--[[--
    信息层
    TopInfoLayer.lua
]]
local ShopLayer = class("ShopLayer", require("src\\app\\ui\\outgame\\layer\\BaseLayer.lua"))
local OutGameData = require("src\\app\\data\\outgame\\OutGameData.lua")
local EventDef = require("src\\app\\def\\outgame\\EventDef.lua")
local EventManager = require("app.manager.EventManager")
local BuyLayer = require("src\\app\\ui\\outgame\\layer\\BuyLayer.lua")
local ObtainItemLayer = require("src\\app\\ui\\outgame\\layer\\ObtainItemLayer.lua")
--[[--
    构造函数

    @param none

    @return none
]]
function ShopLayer:ctor()
    ShopLayer.super.ctor(self)
    self.packs=OutGameData:goldShop()

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

    local spriteB = display.newSprite("res\\artcontent\\lobby(ongame)\\store\\basemap_store.png")
    self.container_1:addChild(spriteB)
    spriteB:setPosition(display.cx,display.cy)

    local listViewB = ccui.ListView:create()
    listViewB:setContentSize(display.width, height)
    listViewB:setAnchorPoint(0.5, 0.5)
    listViewB:setPosition(display.cx,display.cy)
    listViewB:setDirection(1)
    listViewB:addTo(self.container_1)

    self.container_B1 = ccui.Layout:create()
    self.container_B1:setContentSize(display.width, height+70)
    self.container_B1:setAnchorPoint(0,0)
    self.container_B1:setPosition(0, 1)
    self.container_B1:addTo(listViewB)

    self.container_B2 = ccui.Layout:create()
    self.container_B2:setContentSize(display.width, height/2-300)
    self.container_B2:setAnchorPoint(0,0)
    self.container_B2:setPosition(0, 0)
    self.container_B2:addTo(listViewB)

    --金币商城
    local spriteB1 = display.newSprite("res\\artcontent\\lobby(ongame)\\store\\goldstore\\basemap_title.png")
    self.container_B1:addChild(spriteB1)
    spriteB1:setAnchorPoint(0.5, 1)
    spriteB1:setPosition(width/2,height-70)

    local spriteB2 = display.newSprite("res\\artcontent\\lobby(ongame)\\store\\goldstore\\title_goldstore.png")
    self.container_B1:addChild(spriteB2)
    spriteB2:setAnchorPoint(0.5, 1)
    spriteB2:setPosition(width/2,height-80)

    --金币商品
    --剩余刷新时间
    local spriteB3 = display.
    newSprite("res\\artcontent\\lobby(ongame)\\store\\goldstore\\basemap_remainingrefreshtime.png")
    self.container_B1:addChild(spriteB3)
    spriteB3:setAnchorPoint(0.5, 1)
    spriteB3:setPosition(width/2,height-150)
    local spriteB36 = display.
    newSprite("res\\artcontent\\lobby(ongame)\\store\\goldstore\\prompt_refreshtimeremaining.png")
    spriteB3:addChild(spriteB36)
    spriteB36:setAnchorPoint(0.5, 0.5)
    spriteB36:setPosition(spriteB3:getContentSize().width/2-100,spriteB3:getContentSize().height/2)

    --免费商品
    local spriteB4 = ccui.Button:create("res\\artcontent\\lobby(ongame)\\store\\goldstore\\basemap_freeitems.png")
    self.container_B1:addChild(spriteB4)
    spriteB4:setAnchorPoint(0.5, 1)
    spriteB4:setPosition(120,height-230)
    display.newTTFLabel({
        text = "X100",
        size = 25,
        color = display.COLOR_WHITE
    })
    :align(display.CENTER, spriteB4:getContentSize().width/2,spriteB4:getContentSize().height/2-30)
    :addTo(spriteB4)
    local spriteB24 = display.
    newSprite("res\\artcontent\\lobby(ongame)\\store\\goldstore\\itemicon_diamond.png")
    spriteB4:addChild(spriteB24)
    spriteB24:setAnchorPoint(0.5, 0.5)
    spriteB24:setPosition(spriteB4:getContentSize().width/2,spriteB4:getContentSize().height/2+30)
    local spriteB25 = display.
    newSprite("res\\artcontent\\lobby(ongame)\\store\\goldstore\\priceicon_free.png")
    spriteB4:addChild(spriteB25)
    spriteB25:setAnchorPoint(0.5, 0)
    spriteB25:setPosition(spriteB4:getContentSize().width/2,10)
    spriteB4:addTouchEventListener(
        function(sender, eventType)
            if 2 == eventType then -- touch end
                if cc.UserDefault:getInstance():getBoolForKey("音效") then
                    audio.playEffect("sounds/get_free_item.OGG",false)
                end
                OutGameData:setDiamond(100)
                EventManager:doEvent(EventDef.ID.GAMEDATA_CHANGE)
            end
        end
    )
    --五个金币商品
    local spriteB5 = ccui.Button:create("res\\artcontent\\lobby(ongame)\\store\\goldstore\\itemicon_tower\\"
    ..self.packs[1]:getTowerId()..".png")
    self.container_B1:addChild(spriteB5)
    spriteB5:setAnchorPoint(0.5, 1)
    spriteB5:setPosition(width/3+120,height-230)
    display.newTTFLabel({
        text = "360",
        size = 25,
        color = display.COLOR_WHITE
    })
    :align(display.CENTER, spriteB4:getContentSize().width/2+10,30)
    :addTo(spriteB5)
    local spriteB26 = display.
    newSprite("res\\artcontent\\lobby(ongame)\\store\\goldstore\\priceicon_gold.png")
    spriteB5:addChild(spriteB26)
    spriteB26:setAnchorPoint(0.5, 0.5)
    spriteB26:setPosition(spriteB4:getContentSize().width/2-30,30)
    local spriteB31 = display.
    newSprite("res\\artcontent\\lobby(ongame)\\store\\goldstore\\basemap_fragmentsnumber.png")
    spriteB5:addChild(spriteB31)
    spriteB31:setAnchorPoint(1, 1)
    spriteB31:setPosition(spriteB4:getContentSize().width-11,spriteB4:getContentSize().height-7)
    display.newTTFLabel({
        text = "X36",
        size = 20,
        color = display.COLOR_WHITE
    })
    :align(display.RIGHT_CENTER, spriteB31:getContentSize().width-5,spriteB31:getContentSize().height/2)
    :addTo(spriteB31)
    spriteB5:addTouchEventListener(
        function(sender, eventType)
            if 2 == eventType then -- touch end
                if cc.UserDefault:getInstance():getBoolForKey("音效") then
                    audio.playEffect("sounds/get_paid_item.OGG",false)
                end
                BuyLayer:SetBuy(36,360,self.packs[1]:getTowerId())
                BuyLayer:new():addTo(self)
            end
        end
    )

    local spriteB6 = ccui.Button:create("res\\artcontent\\lobby(ongame)\\store\\goldstore\\itemicon_tower\\"
    ..self.packs[2]:getTowerId()..".png")
    self.container_B1:addChild(spriteB6)
    spriteB6:setAnchorPoint(0.5, 1)
    spriteB6:setPosition(width*2/3+120,height-230)
    display.newTTFLabel({
        text = "360",
        size = 25,
        color = display.COLOR_WHITE
    })
    :align(display.CENTER, spriteB4:getContentSize().width/2+10,30)
    :addTo(spriteB6)
    local spriteB27 = display.
    newSprite("res\\artcontent\\lobby(ongame)\\store\\goldstore\\priceicon_gold.png")
    spriteB6:addChild(spriteB27)
    spriteB27:setAnchorPoint(0.5, 0.5)
    spriteB27:setPosition(spriteB4:getContentSize().width/2-30,30)
    local spriteB32 = display.
    newSprite("res\\artcontent\\lobby(ongame)\\store\\goldstore\\basemap_fragmentsnumber.png")
    spriteB6:addChild(spriteB32)
    spriteB32:setAnchorPoint(1, 1)
    spriteB32:setPosition(spriteB4:getContentSize().width-11,spriteB4:getContentSize().height-7)
    display.newTTFLabel({
        text = "X36",
        size = 20,
        color = display.COLOR_WHITE
    })
    :align(display.RIGHT_CENTER, spriteB31:getContentSize().width-5,spriteB31:getContentSize().height/2)
    :addTo(spriteB32)
    spriteB6:addTouchEventListener(
        function(sender, eventType)
            if 2 == eventType then -- touch end
                if cc.UserDefault:getInstance():getBoolForKey("音效") then
                    audio.playEffect("sounds/get_paid_item.OGG",false)
                end
                BuyLayer:SetBuy(36,360,self.packs[3]:getTowerId())
                BuyLayer:new():addTo(self)
            end
        end
    )

    local spriteB7 = ccui.Button:create("res\\artcontent\\lobby(ongame)\\store\\goldstore\\itemicon_tower\\"
    ..self.packs[3]:getTowerId()..".png")
    self.container_B1:addChild(spriteB7)
    spriteB7:setAnchorPoint(0.5, 1)
    spriteB7:setPosition(120,height-450)
    display.newTTFLabel({
        text = "360",
        size = 25,
        color = display.COLOR_WHITE
    })
    :align(display.CENTER, spriteB4:getContentSize().width/2+10,30)
    :addTo(spriteB7)
    local spriteB28 = display.
    newSprite("res\\artcontent\\lobby(ongame)\\store\\goldstore\\priceicon_gold.png")
    spriteB7:addChild(spriteB28)
    spriteB28:setAnchorPoint(0.5, 0.5)
    spriteB28:setPosition(spriteB4:getContentSize().width/2-30,30)
    local spriteB33 = display.
    newSprite("res\\artcontent\\lobby(ongame)\\store\\goldstore\\basemap_fragmentsnumber.png")
    spriteB7:addChild(spriteB33)
    spriteB33:setAnchorPoint(1, 1)
    spriteB33:setPosition(spriteB4:getContentSize().width-11,spriteB4:getContentSize().height-7)
    display.newTTFLabel({
        text = "X36",
        size = 20,
        color = display.COLOR_WHITE
    })
    :align(display.RIGHT_CENTER, spriteB31:getContentSize().width-5,spriteB31:getContentSize().height/2)
    :addTo(spriteB33)
    spriteB7:addTouchEventListener(
        function(sender, eventType)
            if 2 == eventType then -- touch end
                if cc.UserDefault:getInstance():getBoolForKey("音效") then
                    audio.playEffect("sounds/get_paid_item.OGG",false)
                end
                BuyLayer:SetBuy(36,360,self.packs[3]:getTowerId())
                BuyLayer:new():addTo(self)
            end
        end
    )

    local spriteB8 = ccui.Button:create("res\\artcontent\\lobby(ongame)\\store\\goldstore\\itemicon_tower\\"
    ..self.packs[4]:getTowerId()..".png")
    self.container_B1:addChild(spriteB8)
    spriteB8:setAnchorPoint(0.5, 1)
    spriteB8:setPosition(width/3+120,height-450)
    display.newTTFLabel({
        text = "600",
        size = 25,
        color = display.COLOR_WHITE
    })
    :align(display.CENTER, spriteB4:getContentSize().width/2+10,30)
    :addTo(spriteB8)
    local spriteB29 = display.
    newSprite("res\\artcontent\\lobby(ongame)\\store\\goldstore\\priceicon_gold.png")
    spriteB8:addChild(spriteB29)
    spriteB29:setAnchorPoint(0.5, 0.5)
    spriteB29:setPosition(spriteB4:getContentSize().width/2-30,30)
    local spriteB34 = display.
    newSprite("res\\artcontent\\lobby(ongame)\\store\\goldstore\\basemap_fragmentsnumber.png")
    spriteB8:addChild(spriteB34)
    spriteB34:setAnchorPoint(1, 1)
    spriteB34:setPosition(spriteB4:getContentSize().width-11,spriteB4:getContentSize().height-7)
    display.newTTFLabel({
        text = "X6",
        size = 20,
        color = display.COLOR_WHITE
    })
    :align(display.RIGHT_CENTER, spriteB31:getContentSize().width-5,spriteB31:getContentSize().height/2)
    :addTo(spriteB34)
    spriteB8:addTouchEventListener(
        function(sender, eventType)
            if 2 == eventType then -- touch end
                if cc.UserDefault:getInstance():getBoolForKey("音效") then
                    audio.playEffect("sounds/get_paid_item.OGG",false)
                end
                BuyLayer:SetBuy(6,600,self.packs[4]:getTowerId())
                BuyLayer:new():addTo(self)
            end
        end
    )

    local spriteB9 = ccui.Button:create("res\\artcontent\\lobby(ongame)\\store\\goldstore\\itemicon_tower\\"
    ..self.packs[5]:getTowerId()..".png")
    self.container_B1:addChild(spriteB9)
    spriteB9:setAnchorPoint(0.5, 1)
    spriteB9:setPosition(width*2/3+120,height-450)
    display.newTTFLabel({
        text = "1000",
        size = 25,
        color = display.COLOR_WHITE
    })
    :align(display.CENTER, spriteB4:getContentSize().width/2+10,30)
    :addTo(spriteB9)
    local spriteB30 = display.
    newSprite("res\\artcontent\\lobby(ongame)\\store\\goldstore\\priceicon_gold.png")
    spriteB9:addChild(spriteB30)
    spriteB30:setAnchorPoint(0.5, 0.5)
    spriteB30:setPosition(spriteB4:getContentSize().width/2-30,30)
    local spriteB35 = display.
    newSprite("res\\artcontent\\lobby(ongame)\\store\\goldstore\\basemap_fragmentsnumber.png")
    spriteB9:addChild(spriteB35)
    spriteB35:setAnchorPoint(1, 1)
    spriteB35:setPosition(spriteB4:getContentSize().width-11,spriteB4:getContentSize().height-7)
    display.newTTFLabel({
        text = "X1",
        size = 20,
        color = display.COLOR_WHITE
    })
    :align(display.RIGHT_CENTER, spriteB31:getContentSize().width-5,spriteB31:getContentSize().height/2)
    :addTo(spriteB35)
    spriteB9:addTouchEventListener(
        function(sender, eventType)
            if 2 == eventType then -- touch end
                if cc.UserDefault:getInstance():getBoolForKey("音效") then
                    audio.playEffect("sounds/get_paid_item.OGG",false)
                end
                BuyLayer:SetBuy(1,1000,self.packs[5]:getTowerId())
                BuyLayer:new():addTo(self)
            end
        end
    )

    --砖石商城
    local spriteB10 = display.
    newSprite("res\\artcontent\\lobby(ongame)\\store\\diamondstore\\basemap_diamondstore.png")
    self.container_B2:addChild(spriteB10)
    spriteB10:setAnchorPoint(0.5, 0)
    spriteB10:setPosition(width/2,650)

    local spriteB11 = display.
    newSprite("res\\artcontent\\lobby(ongame)\\store\\diamondstore\\title_diamondstore.png")
    self.container_B2:addChild(spriteB11)
    spriteB11:setAnchorPoint(0.5, 0)
    spriteB11:setPosition(width/2,660)

    --普通宝箱
    local spriteB12 = ccui.Button:create("res\\artcontent\\lobby(ongame)\\store\\diamondstore\\basemap_normal.png")
    self.container_B2:addChild(spriteB12)
    spriteB12:setAnchorPoint(0.5, 0)
    spriteB12:setPosition(120,350)
    spriteB12:addTouchEventListener(
        function(sender, eventType)
            if 2 == eventType then -- touch end
                if cc.UserDefault:getInstance():getBoolForKey("音效") then
                    audio.playEffect("sounds/open_box.OGG",false)
                end
                ObtainItemLayer:SetData(1,285)
                ObtainItemLayer:new():addTo(self)
            end
        end
    )

    local spriteB13 = display.
    newSprite("res\\artcontent\\lobby(ongame)\\store\\diamondstore\\chest_normal.png")
    self.container_B2:addChild(spriteB13)
    spriteB13:setAnchorPoint(0.5, 0)
    spriteB13:setPosition(120,420)


    local spriteB14 = display.
    newSprite("res\\artcontent\\lobby(ongame)\\store\\diamondstore\\titile_diamond.png")
    self.container_B2:addChild(spriteB14)
    spriteB14:setAnchorPoint(0.5, 0)
    spriteB14:setPosition(90,370)
    display.newTTFLabel({
        text = "150",
        size = 25,
        color = display.COLOR_WHITE
    })
    :align(display.CENTER, 140,390)
    :addTo(self.container_B2)


    --稀有宝箱
    local spriteB15 = ccui.Button:create("res\\artcontent\\lobby(ongame)\\store\\diamondstore\\basemap_rare.png")
    self.container_B2:addChild(spriteB15)
    spriteB15:setAnchorPoint(0.5, 0)
    spriteB15:setPosition(width/3+120,350)
    spriteB15:addTouchEventListener(
        function(sender, eventType)
            if 2 == eventType then -- touch end
                if cc.UserDefault:getInstance():getBoolForKey("音效") then
                    audio.playEffect("sounds/open_box.OGG",false)
                end
                ObtainItemLayer:SetData(2,456)
                ObtainItemLayer:new():addTo(self)
            end
        end
    )

    local spriteB16 = display.
    newSprite("res\\artcontent\\lobby(ongame)\\store\\diamondstore\\chest_rare.png")
    self.container_B2:addChild(spriteB16)
    spriteB16:setAnchorPoint(0.5, 0)
    spriteB16:setPosition(width/3+120,420)

    local spriteB17 = display.
    newSprite("res\\artcontent\\lobby(ongame)\\store\\diamondstore\\titile_diamond.png")
    self.container_B2:addChild(spriteB17)
    spriteB17:setAnchorPoint(0.5, 0)
    spriteB17:setPosition(width/3+90,370)
    display.newTTFLabel({
        text = "250",
        size = 25,
        color = display.COLOR_WHITE
    })
    :align(display.CENTER, width/3+140,390)
    :addTo(self.container_B2)

    --史诗宝箱
    local spriteB18 = ccui.Button:create("res\\artcontent\\lobby(ongame)\\store\\diamondstore\\basemap_epic.png")
    self.container_B2:addChild(spriteB18)
    spriteB18:setAnchorPoint(0.5, 0)
    spriteB18:setPosition(width*2/3+120,350)
    spriteB18:addTouchEventListener(
        function(sender, eventType)
            if 2 == eventType then -- touch end
                if cc.UserDefault:getInstance():getBoolForKey("音效") then
                    audio.playEffect("sounds/open_box.OGG",false)
                end
                ObtainItemLayer:SetData(3,1280)
                ObtainItemLayer:new():addTo(self)
            end
        end
    )

    local spriteB19 = display.
    newSprite("res\\artcontent\\lobby(ongame)\\store\\diamondstore\\chest_epic.png")
    self.container_B2:addChild(spriteB19)
    spriteB19:setAnchorPoint(0.5, 0)
    spriteB19:setPosition(width*2/3+120,420)

    local spriteB20 = display.
    newSprite("res\\artcontent\\lobby(ongame)\\store\\diamondstore\\titile_diamond.png")
    self.container_B2:addChild(spriteB20)
    spriteB20:setAnchorPoint(0.5, 0)
    spriteB20:setPosition(width*2/3+90,370)
    display.newTTFLabel({
        text = "750",
        size = 25,
        color = display.COLOR_WHITE
    })
    :align(display.CENTER, width*2/3+140,390)
    :addTo(self.container_B2)

    --传说宝箱
    local spriteB21 = ccui.Button:create("res\\artcontent\\lobby(ongame)\\store\\diamondstore\\basemap_legend.png")
    self.container_B2:addChild(spriteB21)
    spriteB21:setAnchorPoint(0.5, 0)
    spriteB21:setPosition(width/3+120,30)
    spriteB21:addTouchEventListener(
        function(sender, eventType)
            if 2 == eventType then -- touch end
                if cc.UserDefault:getInstance():getBoolForKey("音效") then
                    audio.playEffect("sounds/open_box.OGG",false)
                end
                ObtainItemLayer:SetData(4,3040)
                ObtainItemLayer:new():addTo(self)
            end
        end
    )

    local spriteB22 = display.
    newSprite("res\\artcontent\\lobby(ongame)\\store\\diamondstore\\chest_legend.png")
    self.container_B2:addChild(spriteB22)
    spriteB22:setAnchorPoint(0.5, 0)
    spriteB22:setPosition(width/3+120,100)

    local spriteB23 = display.
    newSprite("res\\artcontent\\lobby(ongame)\\store\\diamondstore\\titile_diamond.png")
    self.container_B2:addChild(spriteB23)
    spriteB23:setAnchorPoint(0.5, 0)
    spriteB23:setPosition(width/3+90,55)
    display.newTTFLabel({
        text = "2500",
        size = 25,
        color = display.COLOR_WHITE
    })
    :align(display.CENTER, width/3+140,70)
    :addTo(self.container_B2)
end

--[[--
    界面刷新

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function ShopLayer:update(dt)
    -- self.lifeLabelBmf_:setString(tostring(GameData:getLife()))
    -- self.scoreLabelBmf_:setString(tostring(GameData:getScore()))
end

return ShopLayer

