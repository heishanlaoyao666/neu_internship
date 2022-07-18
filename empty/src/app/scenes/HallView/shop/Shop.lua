----内容：商店界面
----编写人员：郑蕾
---修订人员：郑蕾
---最后修改日期：7/17
local Shop = {}
local KnapsackData = require("app.data.KnapsackData")
local GoldPurchaseView = require("app.scenes.HallView.shop.GoldPurchaseView")
local TreasureChestOpenView = require("app.scenes.HallView.common.TreasureChestOpenView")
local Shopdata = require("app.data.Shopdata")
local ShopDef = require("app.def.ShopDef")
local Music = require("app/data/Music")
local SettingMusic = require("src/app/scenes/SettingMusic")

function Shop:ctor()
    self:addNodeEventListener(cc.NODE_ENTER_FRAME_EVENT, handler(self, self.update))
    self:performWithDelay(function()
        self:scheduleUpdate()
    end,1)
end
--[[
    函数用途：商店帧循环
    --]]
function Shop:update(dt)
    --商店刷新
    self:refresh()
    --商店倒计时
    self:countDown()
end

--[[
    函数用途：定点时间刷新
    --]]
function Shop:refresh()
    local time = os.date("%X")--"%H:%M:%S"
    if time =="23:59:59" then
        --清除遮罩
        for i = 1,6 do
            KnapsackData:setSoldOutState(i,false)
        end
        self.shade1:setVisible(false)
        self.shade2:setVisible(false)
        self.shade3:setVisible(false)
        self.shade4:setVisible(false)
        self.shade5:setVisible(false)
        self.shade6:setVisible(false)
        --更新卡牌ID并加载
        KnapsackData:setITEM_ID(2,Shopdata:randomId(1))
        KnapsackData:setITEM_ID(3,Shopdata:randomId(1))
        KnapsackData:setITEM_ID(4,Shopdata:randomId(1))
        KnapsackData:setITEM_ID(5,Shopdata:randomId(2))
        KnapsackData:setITEM_ID(6,Shopdata:randomId(3))
        self.item2:loadTexture("ui/hall/shop/Goldcoin-shop/CommodityIcon-tower_fragment/"..KnapsackData:getITEM_ID(2)..".png")
        self.item3:loadTexture("ui/hall/shop/Goldcoin-shop/CommodityIcon-tower_fragment/"..KnapsackData:getITEM_ID(3)..".png")
        self.item4:loadTexture("ui/hall/shop/Goldcoin-shop/CommodityIcon-tower_fragment/"..KnapsackData:getITEM_ID(4)..".png")
        self.item5:loadTexture("ui/hall/shop/Goldcoin-shop/CommodityIcon-tower_fragment/"..KnapsackData:getITEM_ID(5)..".png")
        self.item6:loadTexture("ui/hall/shop/Goldcoin-shop/CommodityIcon-tower_fragment/"..KnapsackData:getITEM_ID(6)..".png")
        --恢复触摸状态
        self.item1:setTouchEnabled(true)
        self.item2:setTouchEnabled(true)
        self.item3:setTouchEnabled(true)
        self.item4:setTouchEnabled(true)
        self.item5:setTouchEnabled(true)
        self.item6:setTouchEnabled(true)

        KnapsackData:sendData()
    end
end

--[[
    函数用途：商店一级页面的展示
    --]]
function Shop:ShopPanelCreate()
    --层：整个商店
    local ShopLayer = ccui.Layout:create()
    --ShopLayer:setBackGroundColorOpacity(180)--设置为透明
    --ShopLayer:setBackGroundColorType(1)
    ShopLayer:setAnchorPoint(0, 0)
    ShopLayer:setPosition(cc.p(0, display.top))
    ShopLayer:setContentSize(720, 1280)
    --图片：商店背景图
    local Bg = ccui.ImageView:create("ui/hall/shop/bg-StoreInterface.png")
    Bg:setAnchorPoint(0.5, 0.5)
    Bg:setPosition(display.cx,display.cy)
    Bg:addTo(ShopLayer)

    --listView翻页
    local listView = ccui.ListView:create()
    listView:setContentSize(720,1030)
    listView:setPosition(0,display.top)
    listView:setAnchorPoint(0, 1)
    listView:setDirection(1)--垂直方向
    listView:setItemsMargin(10)--间距
    listView:setBounceEnabled(true)--滑动惯性
    listView:addTo(ShopLayer)
    --添加金币商店与钻石商店进listView
    self:GoldStore(listView,ShopLayer)
    self:diamondStore(listView,ShopLayer)
    return ShopLayer
end

--[[
    函数用途：金币商店的创建
    --]]
function Shop:GoldStore(listView,ShopLayer)
    --math.randomseed(os.time())
    --金币商店层
    local goldLayer = ccui.Layout:create()
    --goldLayer:setBackGroundColorOpacity(180)--设置为透明
    --goldLayer:setBackGroundColorType(1)
    goldLayer:setAnchorPoint(0, 1)
    goldLayer:setPosition(cc.p(0, 0))
    goldLayer:setContentSize(720, 640)
    goldLayer:addTo(listView)

    --图片：金币商店标题背景条
    local goldTitleBg = ccui.ImageView:create(ShopDef.GOLD_STORE_TITLE.BG)
    goldTitleBg:setAnchorPoint(0, 1)
    goldTitleBg:setPosition(cc.p(0, display.top-690))
    goldTitleBg:addTo(goldLayer)
    --图片：金币商店
    local goldStoreText = ccui.ImageView:create(ShopDef.GOLD_STORE_TITLE.TEXT)
    goldStoreText:setAnchorPoint(0.5, 0.5)
    goldStoreText:addTo(goldTitleBg)
    goldStoreText:setPosition(cc.p(display.cx,35))

    --图片：刷新背景条
    local refreshBg = ccui.ImageView:create(ShopDef.GOLD_STORE_TITLE.REFRESH_BG)
    refreshBg:setPosition(cc.p(display.cx, display.top-800))
    refreshBg:addTo(goldLayer)
    --图片：商店刷新剩余时间
    local refreshText = ccui.ImageView:create(ShopDef.GOLD_STORE_TITLE.REFRESH_TEXT)--文字：商店刷新剩余时间
    refreshText:setAnchorPoint(0.5, 0.5)
    refreshText:addTo(refreshBg)
    refreshText:setPosition(cc.p(display.cx-100,25))
    --文本：刷新剩余时间
    local curH = tonumber(os.date("%H"))
    local curM = tonumber(os.date("%M"))
    local h = 24-curH-1
    local m = 60-curM
    self.refreshLabel = cc.Label:createWithTTF(h..":"..m,"ui/font/fzbiaozjw.ttf",30)
    self.refreshLabel:setPosition(cc.p(display.cx+50,25))
    self.refreshLabel:setColor(cc.c3b(255, 206, 55))
    self.refreshLabel:enableOutline(cc.c4b(0, 0, 0, 255),1)--字体描边
    self.refreshLabel:addTo(refreshBg)

    --金币商店商品排列
    --免费商品
    self.item1,self.shade1 = self:freeItem(goldLayer)

    --付费商品
    local offsetX = 0
    local offsetY = 0
    self.item2,self.shade2 = self:createGoldItem(goldLayer,ShopLayer,offsetX,offsetY,2)
    offsetX = offsetX+210
    self.item3,self.shade3= self:createGoldItem(goldLayer,ShopLayer,offsetX,offsetY,3)
    offsetX = -210
    offsetY = -220
    self.item4,self.shade4 = self:createGoldItem(goldLayer,ShopLayer,offsetX,offsetY,4)
    offsetX = offsetX+210
    self.item5,self.shade5 = self:createGoldItem(goldLayer,ShopLayer,offsetX,offsetY,5)
    offsetX = offsetX+210
    self.item6,self.shade6 = self:createGoldItem(goldLayer,ShopLayer,offsetX,offsetY,6)
end

--[[
    函数用途：购买免费商品
    --]]
function Shop:freeItem(goldLayer)
    local soldOutState = ShopDef.ITEM[1].SOLD_OUT
    local freeItemButton = ccui.ImageView:create(ShopDef.FREE_ITEM.BG)
    freeItemButton:setPosition(cc.p(150, display.top-950))
    freeItemButton:addTo(goldLayer)
    if soldOutState == false then
        freeItemButton:setTouchEnabled(true)
    else
        freeItemButton:setTouchEnabled(false)
    end
    --图片：钻石
    local diamondIcon =ccui.ImageView:create(ShopDef.FREE_ITEM.ICON)
    diamondIcon:setPosition(cc.p(78, 115))
    diamondIcon:addTo(freeItemButton)
    --文本：钻石数量
    local freeItemNum = cc.Label:createWithTTF("X"..ShopDef.ITEM[1].FRAGMENT_NUM,"ui/font/fzbiaozjw.ttf",24)
    freeItemNum:setPosition(cc.p(78,65))
    freeItemNum:setColor(cc.c3b(173, 196, 255))
    freeItemNum:enableOutline(cc.c4b(0, 0, 0, 255),1)--字体描边
    freeItemNum:addTo(freeItemButton)
    --图片：免费字样
    local freeIcon =ccui.ImageView:create(ShopDef.FREE_ITEM.TITLE)
    freeIcon:setPosition(cc.p(78, 25))
    freeIcon:addTo(freeItemButton)
    --售罄遮罩
    local shade = self:ItemShade(soldOutState,freeItemButton)
    --商品点击事件
    freeItemButton:addTouchEventListener(function(sender,eventType)--按钮点击后放大缩小特效
        if eventType == ccui.TouchEventType.began then
            local scale = cc.ScaleTo:create(1,0.9)
            local ease_elastic = cc.EaseElasticOut:create(scale)
            sender:runAction(ease_elastic)

        elseif eventType == ccui.TouchEventType.ended then
            local MusicOn = SettingMusic:isMusic1()
            print(MusicOn)
            if MusicOn == true then
                local audio = require("framework.audio")
                audio.loadFile(Music.SHOP[1], function ()
                    audio.playEffect(Music.SHOP[1])
                end)
            else
                local audio = require("framework.audio")
                audio.loadFile(Music.SHOP[1], function ()
                    audio.stopEffect()
                end)
            end
            local scale = cc.ScaleTo:create(1,1)
            local ease_elastic = cc.EaseElasticOut:create(scale)
            sender:runAction(ease_elastic)
            --钻石数量增加100
            KnapsackData:setDiamonds(100)
            --添加售罄遮罩
            --售罄遮罩
            KnapsackData:setSoldOutState(1,true)
            shade:setVisible(KnapsackData:getSoldOutState(1))
            print("商品已售罄")
            --商品不可点击
            freeItemButton:setTouchEnabled(false)
            --传输数据
            KnapsackData:sendData()
        elseif eventType == ccui.TouchEventType.canceled then
            local scale = cc.ScaleTo:create(1,1)
            local ease_elastic = cc.EaseElasticOut:create(scale)
            sender:runAction(ease_elastic)
        end
    end)
    return freeItemButton,shade
end

--[[
    函数用途：金币商店商品的展示:
    --]]
function Shop:createGoldItem(goldLayer,ShopLayer,offsetX,offsetY,i)
    local index = ShopDef.ITEM[i].ID
    local fragNum = ShopDef.ITEM[i].FRAGMENT_NUM
    local price = ShopDef.ITEM[i].PRICE
    local soldOutState = ShopDef.ITEM[i].SOLD_OUT
    local path = "ui/hall/shop/Goldcoin-shop/CommodityIcon-tower_fragment/"..index..".png"

    --按钮：商品
    local ItemButton = ccui.ImageView:create(path)
    ItemButton:setPosition(cc.p(370+offsetX, display.top-950+offsetY))
    if soldOutState == false then
        ItemButton:setTouchEnabled(true)
    else
        ItemButton:setTouchEnabled(false)
    end
    ItemButton:addTo(goldLayer)

    --图片：碎片数量背景
    local fragmentBg =ccui.ImageView:create(ShopDef.GOLD_ITEM.FRAGMENT_BG)
    fragmentBg:setPosition(cc.p(110, 170))
    fragmentBg:addTo(ItemButton)
    --文本：碎片数量
    local fragmentNum = cc.Label:createWithTTF("X"..fragNum,"ui/font/fzbiaozjw.ttf",19)
    fragmentNum:setPosition(cc.p(45,15))
    fragmentNum:setColor(cc.c3b(255, 206, 55))
    fragmentNum:enableOutline(cc.c4b(0, 0, 0, 255),1)--字体描边
    fragmentNum:addTo(fragmentBg)
    --图片：金币图标
    local goldCoinIcon =ccui.ImageView:create(ShopDef.GOLD_ITEM.GOLD_COIN_ICON)
    goldCoinIcon:setPosition(cc.p(50, 30))
    goldCoinIcon:addTo(ItemButton)
    --文本：商品价格
    local priceNum = cc.Label:createWithTTF(price,"ui/font/fzbiaozjw.ttf",25)
    priceNum:setPosition(cc.p(95,30))
    priceNum:setColor(cc.c3b(255, 255, 255))
    priceNum:enableOutline(cc.c4b(0, 0, 0, 255),1)--字体描边
    priceNum:addTo(ItemButton)
    --售罄遮罩
    local shade = self:ItemShade(soldOutState,ItemButton)

    ItemButton:addTouchEventListener(function(sender,eventType)--按钮点击后放大缩小特效
        if eventType == ccui.TouchEventType.began then
            local scale = cc.ScaleTo:create(1,0.9)
            local ease_elastic = cc.EaseElasticOut:create(scale)
            sender:runAction(ease_elastic)

        elseif eventType == ccui.TouchEventType.ended then
            local MusicOn = SettingMusic:isMusic1()
            print(MusicOn)
            if MusicOn == true then
                local audio = require("framework.audio")
                audio.loadFile(Music.SHOP[2], function ()
                    audio.playEffect(Music.SHOP[2])
                end)
            else
                local audio = require("framework.audio")
                audio.loadFile(Music.SHOP[2], function ()
                    audio.stopEffect()
                end)
            end
            GoldPurchaseView:goldPurchasePanel(ShopLayer, index, fragNum, price, shade,ItemButton,i)
            --self:goldPurchasePanel(layer,path,fragNum,price,ItemButton)
            local scale = cc.ScaleTo:create(1,1)
            local ease_elastic = cc.EaseElasticOut:create(scale)
            sender:runAction(ease_elastic)

        elseif eventType == ccui.TouchEventType.canceled then
            local scale = cc.ScaleTo:create(1,1)
            local ease_elastic = cc.EaseElasticOut:create(scale)
            sender:runAction(ease_elastic)
        end
    end)
    return ItemButton,shade
end

--[[
    函数用途：钻石商店的创建
    --]]
function Shop:diamondStore(listView,ShopLayer)
    --钻石商店层
    local diamondLayer = ccui.Layout:create()
    --diamondLayer:setBackGroundColorOpacity(180)--设置为透明
    --diamondLayer:setBackGroundColorType(1)
    diamondLayer:setAnchorPoint(0, 1)
    diamondLayer:setPosition(cc.p(0, display.top))
    diamondLayer:setContentSize(720, 800)
    diamondLayer:addTo(listView)
    --图片：钻石商店标题背景条
    local diamondTitleBg = ccui.ImageView:create(ShopDef.DIAMOND_STORE_TITLE.BG)
    diamondTitleBg:setAnchorPoint(0, 1)
    diamondTitleBg:setPosition(cc.p(0, display.top-500))
    diamondTitleBg:addTo(diamondLayer)
    --图片：钻石商店
    local diamondStoreText = ccui.ImageView:create(ShopDef.DIAMOND_STORE_TITLE.TEXT)
    diamondStoreText:setAnchorPoint(0.5, 0.5)
    diamondStoreText:addTo(diamondTitleBg)
    diamondStoreText:setPosition(cc.p(display.cx,35))

    self:createDiamondItem(ShopLayer,diamondLayer,ShopDef.NORMAL_TREASURE.BG,ShopDef.NORMAL_TREASURE.ICON,ShopDef.NORMAL_TREASURE.TITLE
    , ShopDef.NORMAL_TREASURE.PRICE,0,0
    ,ShopDef.NORMAL_TREASURE.N_CARD_NUM,ShopDef.NORMAL_TREASURE.R_CARD_NUM,ShopDef.NORMAL_TREASURE.E_CARD_NUM,ShopDef.NORMAL_TREASURE.L_CARD_NUM
    ,ShopDef.NORMAL_TREASURE.COIN_NUM)

    self:createDiamondItem(ShopLayer,diamondLayer,ShopDef.RARE_TREASURE.BG,ShopDef.RARE_TREASURE.ICON,ShopDef.RARE_TREASURE.TITLE
    ,ShopDef.RARE_TREASURE.PRICE,230,0
    ,ShopDef.RARE_TREASURE.N_CARD_NUM,ShopDef.RARE_TREASURE.R_CARD_NUM,ShopDef.RARE_TREASURE.E_CARD_NUM,ShopDef.RARE_TREASURE.L_CARD_NUM
    ,ShopDef.RARE_TREASURE.COIN_NUM)

    self:createDiamondItem(ShopLayer,diamondLayer,ShopDef.EPIC_TREASURE.BG,ShopDef.EPIC_TREASURE.ICON,ShopDef.EPIC_TREASURE.TITLE
    ,ShopDef.EPIC_TREASURE.PRICE,460,0
    ,ShopDef.EPIC_TREASURE.N_CARD_NUM,ShopDef.EPIC_TREASURE.R_CARD_NUM,ShopDef.EPIC_TREASURE.E_CARD_NUM,ShopDef.EPIC_TREASURE.L_CARD_NUM
    ,ShopDef.EPIC_TREASURE.COIN_NUM)

    self:createDiamondItem(ShopLayer,diamondLayer,ShopDef.LEGEND_TREASURE.BG,ShopDef.LEGEND_TREASURE.ICON,ShopDef.LEGEND_TREASURE.TITLE
    ,ShopDef.LEGEND_TREASURE.PRICE,230,-320
    ,ShopDef.LEGEND_TREASURE.N_CARD_NUM,ShopDef.LEGEND_TREASURE.R_CARD_NUM,ShopDef.LEGEND_TREASURE.E_CARD_NUM,ShopDef.LEGEND_TREASURE.L_CARD_NUM
    ,ShopDef.LEGEND_TREASURE.COIN_NUM)

end

--[[
    函数用途：钻石商店商品的展示
    --]]
function Shop:createDiamondItem(ShopLayer,layer,bgPath,treasurePath,treasureType,price,offsetX,offsetY
,nCardNum,rCardNum,eCardNum,lCardNum,coinNum)
    --按钮：商品
    local ItemButton = ccui.Button:create(bgPath, bgPath, bgPath)
    ItemButton:setPosition(cc.p(130+offsetX, display.top-750+offsetY))
    ItemButton:addTouchEventListener(function(sender,eventType)--按钮点击后放大缩小特效
        if eventType == ccui.TouchEventType.began then
            local scale = cc.ScaleTo:create(1,0.9)
            local ease_elastic = cc.EaseElasticOut:create(scale)
            sender:runAction(ease_elastic)

        elseif eventType == ccui.TouchEventType.ended then
            local MusicOn = SettingMusic:isMusic1()
            print(MusicOn)
            if MusicOn == true then
                local audio = require("framework.audio")
                audio.loadFile(Music.SHOP[2], function ()
                    audio.playEffect(Music.SHOP[2])
                end)
            else
                local audio = require("framework.audio")
                audio.loadFile(Music.SHOP[2], function ()
                    audio.stopEffect()
                end)
            end
            TreasureChestOpenView:treasureChestOpenConfirmPanel(ShopLayer,treasurePath,treasureType
            ,nCardNum,rCardNum,eCardNum,lCardNum,coinNum,price)
            local scale = cc.ScaleTo:create(1,1)
            local ease_elastic = cc.EaseElasticOut:create(scale)
            sender:runAction(ease_elastic)

        elseif eventType == ccui.TouchEventType.canceled then
            local scale = cc.ScaleTo:create(1,1)
            local ease_elastic = cc.EaseElasticOut:create(scale)
            sender:runAction(ease_elastic)
        end
    end)
    ItemButton:addTo(layer)

    --图片：宝箱图标
    local treasureIcon =ccui.ImageView:create(treasurePath)
    treasureIcon:setPosition(cc.p(105, 140))
    treasureIcon:addTo(ItemButton)
    --图片：钻石图标
    local diamondIcon =ccui.ImageView:create("ui/hall/shop/Diamond-shop/PriceIcon-Diamond.png")
    diamondIcon:setPosition(cc.p(70, 40))
    diamondIcon:addTo(ItemButton)
    --文本：价格
    local priceNum = cc.Label:createWithTTF(price,"ui/font/fzbiaozjw.ttf",25)
    priceNum:setPosition(cc.p(120,40))
    priceNum:setColor(cc.c3b(255, 255, 255))
    priceNum:enableOutline(cc.c4b(15, 16, 59, 255),1)--字体描边
    priceNum:enableShadow(cc.c4b(17,17,60,255), cc.size(0,-2), 1)--阴影
    priceNum:addTo(ItemButton)
end

--[[
    函数用途：添加商品售罄遮罩
    --]]
function Shop:ItemShade(soldOutState,ItemButton)
    --售罄遮罩
    local shade = ccui.Layout:create()
    shade:setBackGroundColor(cc.c4b(0,0,0,128))
    shade:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)--设置颜色模式
    shade:setBackGroundColorOpacity(128)--设置透明度
    shade:setAnchorPoint(0,0)
    shade:setPosition(cc.p(0, 0))
    shade:setContentSize(156, 194)
    shade:setVisible(soldOutState)
    if soldOutState == true then--售罄
        shade:setTouchEnabled(false)--不可触摸
    elseif soldOutState == false then
        shade:setTouchEnabled(true)
    end
    shade:addTo(ItemButton)
return shade
end

--[[
    函数用途：商品倒计时
    --]]
function Shop:countDown()
    local curH = tonumber(os.date("%H"))
    local curM = tonumber(os.date("%M"))
    local h = 24-curH-1
    local m = 60-curM
    self.refreshLabel:setString(h..":"..m)
end
return Shop
