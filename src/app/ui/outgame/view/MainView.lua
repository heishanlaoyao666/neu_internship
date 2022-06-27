--[[--
    游戏主界面
    PlayView.lua
]]
local MainView = class("MainView", function()
    return display.newColorLayer(cc.c4b(0, 0, 0, 0))
end)
-- local BGLayer = require("app.mainui.layer.BGLayer")
local TopInfoLayer = require("src\\app\\ui\\outgame\\layer\\TopInfoLayer.lua")
local BottomInfoLayer = require("src\\app\\ui\\outgame\\layer\\BottomInfoLayer.lua")
local BattleLayer = require("src\\app\\ui\\outgame\\layer\\BattleLayer.lua")
local ShopLayer = require("src\\app\\ui\\outgame\\layer\\ShopLayer.lua")
local OutGameData = require("src\\app\\data\\outgame\\OutGameData.lua")
local ConstDef = require("src\\app\\def\\outgame\\ConstDef.lua")
local EventDef = require("src\\app\\def\\outgame\\EventDef.lua")
local EventManager = require("app.manager.EventManager")
local BuyLayer = require("src\\app\\ui\\outgame\\layer\\BuyLayer.lua")
local ObtainItemLayer = require("src\\app\\ui\\outgame\\layer\\ObtainItemLayer.lua")

--[[--
    构造函数

    @param none

    @return none
]]
function MainView:ctor()
    self.TopInfoLayer_ = nil -- 类型：TopInfoLayer，顶部信息层
    self.BottomInfoLayer_ = nil -- 类型：BottomInfoLayer，底部信息层
    OutGameData:initTower()
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
function MainView:initView()

    local page = ccui.PageView:create()
    local width, height = display.width, 1120

    do
        --战斗界面（游戏外）
        self.container_ = ccui.Layout:create()
        self.container_:setContentSize(display.width, height)
        self.container_:setPosition(0, 0)

        --底图
        local sprite = display.newSprite("res\\artcontent\\lobby(ongame)\\battle_interface\\basemap_interfaces.png")
        self.container_:addChild(sprite)
        sprite:setPosition(display.cx,display.cy)

        --对战模式按钮
        local button = ccui.Button:create("res\\artcontent\\lobby(ongame)\\battle_interface\\button_battlemode.png")
        self.container_:addChild(button)
        button:setAnchorPoint(0.5, 0.5)
        button:setPosition(width/2, height/2-30)
        button:addTouchEventListener(function(sender, eventType)
            -- ccui.TouchEventType
            if 2 == eventType then -- touch end
                -- body
                -- local AnotherScene=require("src\\app\\ui\\outgame\\layer\\ShopLayer.lua"):new()
                -- display.replaceScene(AnotherScene, "moveInL", 0.5)
                print("进入战斗")
            end
        end)
        --已选队伍底图
        local sprite1 = display.newSprite("res\\artcontent\\lobby(ongame)\\battle_interface\\basemap_selectedteams.png")
        self.container_:addChild(sprite1)
        sprite1:setPosition(display.cx,200)

        --天梯背景和ListView创建
        local sprite2 = display.newSprite("res\\artcontent\\lobby(ongame)\\battle_interface\\rank\\basemap_rank.png")
        self.container_:addChild(sprite2)
        sprite2:setPosition(display.cx,display.cy+300)
        local listView = ccui.ListView:create()
        listView:setContentSize(sprite2:getContentSize().width, sprite2:getContentSize().height)
        listView:setAnchorPoint(0.5, 0.5)
        listView:setPosition(display.cx,display.cy+300)
        listView:setDirection(2)
        listView:addTo(self.container_)
        for i=1,8 do
            local img = ccui.ImageView:
            create("res\\artcontent\\lobby(ongame)\\battle_interface\\rank\\locked_blueborder.png")
            listView:pushBackCustomItem(img)
        end

    end
    do
        --商店界面
        self.container_1 = ccui.Layout:create()
        self.container_1:setContentSize(display.width, height)
        self.container_1:setPosition(0, 0)

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

    do
        self.collected1,self.collected2,self.collected3,self.collected4=OutGameData:getCollected()
        self.uncollected1,self.uncollected2,self.uncollected3,self.uncollected4=OutGameData:getUnCollected()
        local num1 = #self.collected1+#self.collected2+#self.collected3+#self.collected4
        local num2 = #self.uncollected1+#self.uncollected2+#self.uncollected3+#self.uncollected4
        local num3={}
        local num4={}
        for i=1,#self.collected1 do
            num3[#num3+1]=self.collected1[i]
        end
        for i=1,#self.collected2 do
            num3[#num3+1]=self.collected2[i]
        end
        for i=1,#self.collected3 do
            num3[#num3+1]=self.collected3[i]
        end
        for i=1,#self.collected4 do
            num3[#num3+1]=self.collected4[i]
        end
        for i=1,#self.uncollected1 do
            num4[#num4+1]=self.uncollected1[i]
        end
        for i=1,#self.uncollected2 do
            num4[#num4+1]=self.uncollected2[i]
        end
        for i=1,#self.uncollected3 do
            num4[#num4+1]=self.uncollected3[i]
        end
        for i=1,#self.uncollected4 do
            num4[#num4+1]=self.uncollected4[i]
        end
        num1=9
        --num2=10
        --图鉴界面
        self.container_2 = ccui.Layout:create()
        self.container_2:setContentSize(display.width, height)
        --page:addPage(self.container_2)
        self.container_2:setPosition(0, 0)

        --底图
        local spriteC = display.newSprite("res\\artcontent\\lobby(ongame)\\atlas_interface\\basemap_guide.png")
        self.container_2:addChild(spriteC)
        spriteC:setAnchorPoint(0.5, 0.5)
        spriteC:setPosition(display.cx,display.cy)

        --当前阵容
        local spriteC7 = display.
        newSprite("res\\artcontent\\lobby(ongame)\\atlas_interface\\current_lineup\\basemap_area.png")
        self.container_2:addChild(spriteC7)
        spriteC7:setAnchorPoint(0.5, 1)
        spriteC7:setPosition(display.cx,height-150)

        local spriteC1 = display.
        newSprite("res\\artcontent\\lobby(ongame)\\atlas_interface\\current_lineup\\basemap_title.png")
        self.container_2:addChild(spriteC1)
        spriteC1:setAnchorPoint(0.5, 1)
        spriteC1:setPosition(display.cx,height-80)

        local spriteC2 = display.
        newSprite("res\\artcontent\\lobby(ongame)\\atlas_interface\\current_lineup\\text_currentlineup.png")
        self.container_2:addChild(spriteC2)
        spriteC2:setAnchorPoint(0.5, 1)
        spriteC2:setPosition(display.cx-110,height-100)

        local spriteC3 = display.
        newSprite("res\\artcontent\\lobby(ongame)\\atlas_interface\\current_lineup\\basemap_lineupconnection.png")
        self.container_2:addChild(spriteC3)
        spriteC3:setAnchorPoint(0.5, 1)
        spriteC3:setPosition(display.cx+80,height-110)

        local landscapeCheckBox1 = ccui.CheckBox:
        create("res\\artcontent\\lobby(ongame)\\atlas_interface\\current_lineup\\icon_unchecked.png",
        nil, "res\\artcontent\\lobby(ongame)\\atlas_interface\\current_lineup\\icon_checked.png", nil, nil)
	    :align(display.LEFT_CENTER, -20, spriteC3:getContentSize().height/2)
	    :addTo(spriteC3)

        local landscapeCheckBox2 = ccui.CheckBox:
        create("res\\artcontent\\lobby(ongame)\\atlas_interface\\current_lineup\\icon_unchecked.png",
        nil, "res\\artcontent\\lobby(ongame)\\atlas_interface\\current_lineup\\icon_checked.png", nil, nil)
	    :align(display.LEFT_CENTER, spriteC3:getContentSize().width/2-20, spriteC3:getContentSize().height/2)
	    :addTo(spriteC3)

        local landscapeCheckBox3 = ccui.CheckBox:
        create("res\\artcontent\\lobby(ongame)\\atlas_interface\\current_lineup\\icon_unchecked.png",
        nil, "res\\artcontent\\lobby(ongame)\\atlas_interface\\current_lineup\\icon_checked.png", nil, nil)
	    :align(display.LEFT_CENTER, spriteC3:getContentSize().width-20, spriteC3:getContentSize().height/2)
	    :addTo(spriteC3)

        local spriteC4 = display.
        newSprite("res\\artcontent\\lobby(ongame)\\atlas_interface\\current_lineup\\number_1.png")
        landscapeCheckBox1:addChild(spriteC4)
        spriteC4:setAnchorPoint(0.5, 0.5)
        spriteC4:setPosition(landscapeCheckBox1:getContentSize().width/2,landscapeCheckBox1:getContentSize().height/2)

        local spriteC5 = display.
        newSprite("res\\artcontent\\lobby(ongame)\\atlas_interface\\current_lineup\\number_2.png")
        landscapeCheckBox2:addChild(spriteC5)
        spriteC5:setAnchorPoint(0.5, 0.5)
        spriteC5:setPosition(landscapeCheckBox2:getContentSize().width/2,landscapeCheckBox2:getContentSize().height/2)

        local spriteC6 = display.
        newSprite("res\\artcontent\\lobby(ongame)\\atlas_interface\\current_lineup\\number_3.png")
        landscapeCheckBox3:addChild(spriteC6)
        spriteC6:setAnchorPoint(0.5, 0.5)
        spriteC6:setPosition(landscapeCheckBox3:getContentSize().width/2,landscapeCheckBox3:getContentSize().height/2)

        -- self.container_C1 = ccui.Layout:create()
        -- self.container_C1:setContentSize(spriteC7:getContentSize().width, spriteC7:getContentSize().height)
        -- self.container_C1:setAnchorPoint(0.5,0.5)
        -- self.container_C1:setPosition(spriteC7:getContentSize().width/2, spriteC7:getContentSize().height/2)
        -- self.container_C1:addTo(self.container_2)

        -- local spriteC8 = display.
        -- newSprite("res\\artcontent\\lobby(ongame)\\atlas_interface\\current_lineup\\number_3.png")
        -- self.container_C1:addChild(spriteC8)
        -- spriteC8:setAnchorPoint(0.5, 0.5)
        -- spriteC8:setPosition(landscapeCheckBox3:getContentSize().width/2,landscapeCheckBox3:getContentSize().height/2)

        --建立listview
        local listViewC = ccui.ListView:create()
        listViewC:setContentSize(display.width, height)
        listViewC:setAnchorPoint(0.5, 1)
        listViewC:setPosition(display.cx,height-353)
        listViewC:setDirection(1)
        listViewC:addTo(self.container_2)

        --创建三个容器，分别装提示信息，已收集和未收集
        self.container_C1 = ccui.Layout:create()
        -- self.container_C1:setBackGroundColor(cc.c3b(200, 0, 0))
        -- self.container_C1:setBackGroundColorType(1)
        self.container_C1:setContentSize(width, 150)
        self.container_C1:setAnchorPoint(0.5,0.5)
        self.container_C1:setPosition(display.cx, display.cy)
        self.container_C1:addTo(listViewC)

        self.container_C2 = ccui.Layout:create()
        -- self.container_C2:setBackGroundColor(cc.c3b(200, 0, 0))
        -- self.container_C2:setBackGroundColorType(1)
        self.container_C2:setContentSize(width, 200+math.ceil(num1/4)*250)
        self.container_C2:setAnchorPoint(0.5,0.5)
        self.container_C2:setPosition(display.cx, display.cy)
        self.container_C2:addTo(listViewC)
        -- if #num3==0 then
        --     self.container_C2:setContentSize(width, 200+250)
        -- end

        self.container_C3 = ccui.Layout:create()
        -- self.container_C3:setBackGroundColor(cc.c3b(200, 0, 0))
        -- self.container_C3:setBackGroundColorType(1)
        self.container_C3:setContentSize(width, 450+math.ceil(#num4/4)*250)
        self.container_C3:setAnchorPoint(0.5,0.5)
        self.container_C3:setPosition(display.cx, display.cy)
        self.container_C3:addTo(listViewC)
        if #num4==0 then
            self.container_C3:setContentSize(width, 200+250)
        end

        --提示信息
        local spriteC8 = display.
        newSprite("res\\artcontent\\lobby(ongame)\\atlas_interface\\prompt_information\\basemap_tips.png")
        self.container_C1:addChild(spriteC8)
        spriteC8:setAnchorPoint(0.5, 0)
        spriteC8:setPosition(display.cx,30)

        local spriteC10 = display.
        newSprite("res\\artcontent\\lobby(ongame)\\atlas_interface\\prompt_information\\text_2.png")
        spriteC8:addChild(spriteC10)
        spriteC10:setAnchorPoint(0.5, 0.5)
        spriteC10:setPosition(spriteC8:getContentSize().width/2-50,spriteC8:getContentSize().height/2+20)

        local spriteC11 = display.
        newSprite("res\\artcontent\\lobby(ongame)\\atlas_interface\\prompt_information\\text_1.png")
        spriteC8:addChild(spriteC11)
        spriteC11:setAnchorPoint(0.5, 0.5)
        spriteC11:setPosition(spriteC8:getContentSize().width/2,spriteC8:getContentSize().height/2-20)

        --已收集,一行占250
        -- if #num3==0 then
        -- else
        --     for i=1,#num3 do
        --         local spriteC17 = display.
        --         newSprite("res\\artcontent\\lobby(ongame)\\atlas_interface\\tower_list\\basemap_towernomal.png")
        --         self.container_C3:addChild(spriteC17)
        --         spriteC17:setAnchorPoint(0.5, 0)
        --         if i%4==0 then
        --             spriteC17:setPosition(100+width*3/4,math.ceil(i/4)*250+200)
        --         else
        --             spriteC17:setPosition(100+width*(i%4-1)/4,math.ceil(i/4)*250+200)
        --         end
        --         local spriteD6 = display.
        --         newSprite(string.format("res\\artcontent\\lobby(ongame)\\currency\\icon_tower\\%02d.png",
        --         num4[i]:getTowerId()))
        --         spriteC17:addChild(spriteD6)
        --         spriteD6:setAnchorPoint(0.5, 0.5)
        --         spriteD6:setPosition(spriteC17:getContentSize().width/2,spriteC17:getContentSize().height/2+30)
        --         local spriteD7 = display.
        --         newSprite("res\\artcontent\\lobby(ongame)\\atlas_interface\\tower_list\\grade\\Lv.1.png")
        --         spriteC17:addChild(spriteD7)
        --         spriteD7:setAnchorPoint(0.5, 0.5)
        --         spriteD7:setPosition(spriteC17:getContentSize().width/2,spriteC17:getContentSize().height/2-40)
        --         local spriteD8 = display.
        --         newSprite("res\\artcontent\\lobby(ongame)\\atlas_interface\\tower_list\\progressbar_basemap_fragmentsnumber.png")
        --         spriteC17:addChild(spriteD8)
        --         spriteD8:setAnchorPoint(0.5, 0.5)
        --         spriteD8:setPosition(spriteC17:getContentSize().width/2,spriteC17:getContentSize().height/2-80)
        --         local spriteD9= display.
        --         newSprite("res\\artcontent\\lobby(ongame)\\atlas_interface\\tower_list\\progress_progress_fragmentsnumber.png")
        --         spriteD8:addChild(spriteD9)
        --         spriteD9:setAnchorPoint(0.5, 0.5)
        --         spriteD9:setPosition(spriteD3:getContentSize().width/2,spriteD3:getContentSize().height/2)
        --         local spriteD10 = display.
        --         newSprite("res\\artcontent\\lobby(ongame)\\atlas_interface\\tower_list\\towertype_control.png")
        --         spriteC17:addChild(spriteD10)
        --         spriteD10:setAnchorPoint(1, 1)
        --         spriteD10:setPosition(spriteC17:getContentSize().width-10,spriteC17:getContentSize().height)
        --     end
        -- end
        local spriteC9 = display.
        newSprite("res\\artcontent\\lobby(ongame)\\atlas_interface\\tower_list\\split_collected.png")
        self.container_C2:addChild(spriteC9)
        spriteC9:setAnchorPoint(0.5, 0)
        spriteC9:setPosition(display.cx,100+math.ceil(num1/4)*250)--math.ceil()向正无穷取整
        local spriteC13 = display.
        newSprite("res\\artcontent\\lobby(ongame)\\atlas_interface\\tower_list\\basemap_towernomal.png")
        self.container_C2:addChild(spriteC13)
        spriteC13:setAnchorPoint(0.5, 0)
        spriteC13:setPosition(100,350)

        local spriteC14 = display.
        newSprite("res\\artcontent\\lobby(ongame)\\atlas_interface\\tower_list\\basemap_towernomal.png")
        self.container_C2:addChild(spriteC14)
        spriteC14:setAnchorPoint(0.5, 0)
        spriteC14:setPosition(width/4+100,350)

        local spriteC15 = display.
        newSprite("res\\artcontent\\lobby(ongame)\\atlas_interface\\tower_list\\basemap_towernomal.png")
        self.container_C2:addChild(spriteC15)
        spriteC15:setAnchorPoint(0.5, 0)
        spriteC15:setPosition(100,100)

        --未收集
        for i=1,#num4 do
            local spriteC16 = display.
            newSprite("res\\artcontent\\lobby(ongame)\\atlas_interface\\tower_list\\basemap_towernomal.png")
            self.container_C3:addChild(spriteC16)
            spriteC16:setAnchorPoint(0.5, 0)
            if i%4==0 then
                spriteC16:setPosition(100+width*3/4,math.ceil(i/4)*250+200)
            else
                spriteC16:setPosition(100+width*(i%4-1)/4,math.ceil(i/4)*250+200)
            end
            local spriteD1 = display.
            newSprite(string.format("res\\artcontent\\lobby(ongame)\\currency\\icon_tower\\%02d.png",
            num4[i]:getTowerId()))
            spriteC16:addChild(spriteD1)
            spriteD1:setAnchorPoint(0.5, 0.5)
            spriteD1:setPosition(spriteC16:getContentSize().width/2,spriteC16:getContentSize().height/2+30)
            local spriteD2 = display.
            newSprite("res\\artcontent\\lobby(ongame)\\atlas_interface\\tower_list\\grade\\Lv.1.png")
            spriteC16:addChild(spriteD2)
            spriteD2:setAnchorPoint(0.5, 0.5)
            spriteD2:setPosition(spriteC16:getContentSize().width/2,spriteC16:getContentSize().height/2-40)
            local spriteD3 = display.
            newSprite("res\\artcontent\\lobby(ongame)\\atlas_interface\\tower_list\\progressbar_basemap_fragmentsnumber.png")
            spriteC16:addChild(spriteD3)
            spriteD3:setAnchorPoint(0.5, 0.5)
            spriteD3:setPosition(spriteC16:getContentSize().width/2,spriteC16:getContentSize().height/2-80)
            local spriteD4 = display.
            newSprite("res\\artcontent\\lobby(ongame)\\atlas_interface\\tower_list\\progress_progress_fragmentsnumber.png")
            spriteD3:addChild(spriteD4)
            spriteD4:setAnchorPoint(0.5, 0.5)
            spriteD4:setPosition(spriteD3:getContentSize().width/2,spriteD3:getContentSize().height/2)
            local spriteD5 = display.
            newSprite("res\\artcontent\\lobby(ongame)\\atlas_interface\\tower_list\\towertype_control.png")
            spriteC16:addChild(spriteD5)
            spriteD5:setAnchorPoint(1, 1)
            spriteD5:setPosition(spriteC16:getContentSize().width-10,spriteC16:getContentSize().height)
        end
        local spriteC12 = display.
        newSprite("res\\artcontent\\lobby(ongame)\\atlas_interface\\tower_list\\split_notcollected.png")
        self.container_C3:addChild(spriteC12)
        spriteC12:setAnchorPoint(0.5, 0)
        spriteC12:setPosition(display.cx,450+math.ceil(num2/4)*250)

        -- local spriteC16 = display.
        -- newSprite("res\\artcontent\\lobby(ongame)\\atlas_interface\\tower_list\\basemap_towernomal.png")
        -- self.container_C3:addChild(spriteC16)
        -- spriteC16:setAnchorPoint(0.5, 0)
        -- spriteC16:setPosition(100,450)

    end

    page:addPage(self.container_1)
    page:addPage(self.container_)
    page:addPage(self.container_2)
    self:addChild(page)
    page:setContentSize(720,1200)
    page:setTouchEnabled(true)
    page:setAnchorPoint(cc.p(0.5,0.5))
    page:setPosition(display.cx,display.cy)
    page:scrollToPage(1)

    cc.UserDefault:getInstance():setIntegerForKey("bottom",1)
    self.BottomInfoLayer_1 = BottomInfoLayer.new()
    self:addChild(self.BottomInfoLayer_1)
    self.BottomInfoLayer_1:setVisible(false)
    cc.UserDefault:getInstance():setIntegerForKey("bottom",2)
    self.BottomInfoLayer_2 = BottomInfoLayer.new()
    self:addChild(self.BottomInfoLayer_2)
    self.BottomInfoLayer_2:setVisible(false)
    cc.UserDefault:getInstance():setIntegerForKey("bottom",3)
    self.BottomInfoLayer_3 = BottomInfoLayer.new()
    self:addChild(self.BottomInfoLayer_3)
    self.BottomInfoLayer_3:setVisible(false)

    page:addEventListener(function(sender,event)
        if event==ccui.PageViewEventType.turning then
            self:setName(page:getCurPageIndex())
            --print("当前页码是"..page:getCurPageIndex())
            if page:getCurPageIndex()==0 then
                self.BottomInfoLayer_1:setVisible(true)
                self.BottomInfoLayer_2:setVisible(false)
                self.BottomInfoLayer_3:setVisible(false)
            elseif page:getCurPageIndex()==1 then
                self.BottomInfoLayer_1:setVisible(false)
                self.BottomInfoLayer_2:setVisible(true)
                self.BottomInfoLayer_3:setVisible(false)
            elseif page:getCurPageIndex()==2 then
                self.BottomInfoLayer_1:setVisible(false)
                self.BottomInfoLayer_2:setVisible(false)
                self.BottomInfoLayer_3:setVisible(true)
            end
        end
    end)

    self.TopInfoLayer_ = TopInfoLayer.new()
    self:addChild(self.TopInfoLayer_)
    --self.TopInfoLayer_:setSprite1("res\\artcontent\\lobby(ongame)\\currency\\icon_tower\\03.png")
    --print(...)
end

--[[--
    修改头像

    @param none

    @return none
]]
-- function MainView:setSprite(filename)
--     self.TopInfoLayer_ = TopInfoLayer.new()
--     self.TopInfoLayer_:setSprite1(filename)
--     self:addChild(self.TopInfoLayer_)
-- end

--[[--
    节点进入

    @param none

    @return none
]]
function MainView:onEnter()
    EventManager:regListener(EventDef.ID.PORTRAIT_CHANGE, self, function(filename)
        self.TopInfoLayer_:setSprite1(filename)
    end)
    EventManager:regListener(EventDef.ID.GAMEDATA_CHANGE, self, function()
        self.TopInfoLayer_:setData()
    end)
end

--[[--
    节点退出

    @param none

    @return none
]]
function MainView:onExit()
    EventManager:unRegListener(EventDef.ID.GAMESTATE_CHANGE, self)
    EventManager:unRegListener(EventDef.ID.GAMEDATA_CHANGE, self)
end

--[[--
    帧刷新

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function MainView:update(dt)
    -- self.bgLayer_:update(dt)
    -- self.fightLayer_:update(dt)
    -- self.TopInfoLayer_:update(dt)
end

return MainView