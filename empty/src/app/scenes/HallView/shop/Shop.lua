----内容：商店界面
----编写人员：郑蕾
---修订人员：郑蕾
---最后修改日期：7/13
local Shop = class("Shop")
local KnapsackData = require("app.data.KnapsackData")
local GoldPurchaseView = require("app.scenes.HallView.shop.layer.GoldPurchaseView")
local TreasureChestOpenView = require("app.scenes.HallView.common.TreasureChestOpenView")
local Shopdata = require("app.data.Shopdata")
function Shop:ctor()
    Shopdata:initID()--初始化商店碎片
end

--[[
    函数用途：定点时间刷新
    --]]
function Shop:refresh()
    local time = os.date("%X")--"%H:%M:%S"
    if time =="00:00:00" then
        --清除遮罩
        for i = 1,6 do
            Shopdata.ITEM[i].SOLD_OUT = false
        end
        --更新卡牌
        Shopdata.ITEM[2].ID = Shopdata:randomId(1)
        item2:loadTexture("ui/hall/shop/Goldcoin-shop/CommodityIcon-tower_fragment/"..Shopdata.ITEM[2].ID..".png")
        print(Shopdata.ITEM[2].ID)

        Shopdata.ITEM[3].ID = Shopdata:randomId(1)
        item3:loadTexture("ui/hall/shop/Goldcoin-shop/CommodityIcon-tower_fragment/"..Shopdata.ITEM[3].ID..".png")
        print(Shopdata.ITEM[3].ID)

        Shopdata.ITEM[4].ID = Shopdata:randomId(1)
        item4:loadTexture("ui/hall/shop/Goldcoin-shop/CommodityIcon-tower_fragment/"..Shopdata.ITEM[4].ID..".png")
        print(Shopdata.ITEM[4].ID)

        Shopdata.ITEM[5].ID = Shopdata:randomId(2)
        item5:loadTexture("ui/hall/shop/Goldcoin-shop/CommodityIcon-tower_fragment/"..Shopdata.ITEM[5].ID..".png")
        print(Shopdata.ITEM[5].ID)

        Shopdata.ITEM[6].ID = Shopdata:randomId(3)
        print(Shopdata.ITEM[6].ID)
        item6:loadTexture("ui/hall/shop/Goldcoin-shop/CommodityIcon-tower_fragment/"..Shopdata.ITEM[6].ID..".png")

    end
end

--[[
    函数用途：商店一级页面的展示
    --]]
function Shop:ShopPanel()
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
    local goldTitleBg = ccui.ImageView:create("ui/hall/shop/Goldcoin-shop/bg-title_block.png")
    goldTitleBg:setAnchorPoint(0, 1)
    goldTitleBg:setPosition(cc.p(0, display.top-690))
    goldTitleBg:addTo(goldLayer)
    --图片：金币商店
    local goldStoreText = ccui.ImageView:create("ui/hall/shop/Goldcoin-shop/Title - gold_coin_store.png")
    goldStoreText:setAnchorPoint(0.5, 0.5)
    goldStoreText:addTo(goldTitleBg)
    goldStoreText:setPosition(cc.p(display.cx,35))

    --图片：刷新背景条
    local refreshBg = ccui.ImageView:create("ui/hall/shop/Goldcoin-shop/bg-remaining_refresh_time.png")
    refreshBg:setPosition(cc.p(display.cx, display.top-800))
    refreshBg:addTo(goldLayer)
    --图片：商店刷新剩余时间
    local refreshText = ccui.ImageView:create("ui/hall/shop/Goldcoin-shop/Prompt-refresh_time_remaining.png")--文字：商店刷新剩余时间
    refreshText:setAnchorPoint(0.5, 0.5)
    refreshText:addTo(refreshBg)
    refreshText:setPosition(cc.p(display.cx-100,25))
    --文本：刷新剩余时间
    local time = os.date("%H:%M")
    local refreshLabel = cc.Label:createWithTTF(time,"ui/font/fzbiaozjw.ttf",30)
    refreshLabel:setPosition(cc.p(display.cx+50,25))
    refreshLabel:setColor(cc.c3b(255, 206, 55))
    refreshLabel:enableOutline(cc.c4b(0, 0, 0, 255),1)--字体描边
    refreshLabel:addTo(refreshBg)

    --免费商品
    item1 = self:freeItem(goldLayer)
    --金币商店商品排列
    local offsetX = 0
    item2 = self:createGoldItem(goldLayer,ShopLayer,Shopdata.ITEM[2].ID,Shopdata.ITEM[2].FRAGMENT_NUM,Shopdata.ITEM[2].PRICE,Shopdata.ITEM[2].SOLD_OUT,
            offsetX,0,2)
    offsetX = offsetX+210
    item3 = self:createGoldItem(goldLayer,ShopLayer,Shopdata.ITEM[3].ID,Shopdata.ITEM[3].FRAGMENT_NUM,Shopdata.ITEM[3].PRICE,Shopdata.ITEM[3].SOLD_OUT,
            offsetX,0,3)
    offsetX = -210
    item4 = self:createGoldItem(goldLayer,ShopLayer,Shopdata.ITEM[4].ID,Shopdata.ITEM[4].FRAGMENT_NUM,Shopdata.ITEM[4].PRICE,Shopdata.ITEM[4].SOLD_OUT,
            offsetX,-220,4)
    offsetX = offsetX+210
    item5 = self:createGoldItem(goldLayer,ShopLayer,Shopdata.ITEM[5].ID,Shopdata.ITEM[5].FRAGMENT_NUM,Shopdata.ITEM[5].PRICE,Shopdata.ITEM[5].SOLD_OUT,
            offsetX,-220,5)
    offsetX = offsetX+210
    item6 = self:createGoldItem(goldLayer,ShopLayer,Shopdata.ITEM[6].ID,Shopdata.ITEM[6].FRAGMENT_NUM,Shopdata.ITEM[6].PRICE,Shopdata.ITEM[6].SOLD_OUT,
            offsetX,-220,6)
end

--[[
    函数用途：购买免费商品
    --]]
function Shop:freeItem(ShopLayer)
    local freeItemButton = ccui.Button:create(
            "ui/hall/shop/Goldcoin-shop/bg-free_items.png",
            "ui/hall/shop/Goldcoin-shop/bg-free_items.png",
            "ui/hall/shop/Goldcoin-shop/bg-free_items.png"
    )
    freeItemButton:setPosition(cc.p(150, display.top-950))
    freeItemButton:addTo(ShopLayer)
    --图片：钻石
    local diamondIcon =ccui.ImageView:create(Shopdata.ITEM[1].ICON)
    diamondIcon:setPosition(cc.p(78, 115))
    diamondIcon:addTo(freeItemButton)
    --文本：钻石数量
    local freeItemNum = cc.Label:createWithTTF("X"..Shopdata.ITEM[1].FRAGMENT_NUM,"ui/font/fzbiaozjw.ttf",24)
    freeItemNum:setPosition(cc.p(78,65))
    freeItemNum:setColor(cc.c3b(173, 196, 255))
    freeItemNum:enableOutline(cc.c4b(0, 0, 0, 255),1)--字体描边
    freeItemNum:addTo(freeItemButton)
    --图片：免费字样
    local freeIcon =ccui.ImageView:create("ui/hall/shop/Goldcoin-shop/PriceIcon-free.png")
    freeIcon:setPosition(cc.p(78, 25))
    freeIcon:addTo(freeItemButton)
    --售罄遮罩
    local shade = ccui.Layout:create()
    shade:setBackGroundColor(cc.c4b(0,0,0,128))
    shade:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)--设置颜色模式
    shade:setBackGroundColorOpacity(128)--设置透明度
    shade:setAnchorPoint(0,0)
    shade:setPosition(cc.p(0, 0))
    shade:setContentSize(156, 194)
    shade:setVisible(Shopdata.ITEM[1].SOLD_OUT)
    --售罄则不可点击
    if Shopdata.ITEM[1].SOLD_OUT == true then
        freeItemButton:setTouchEnabled(false)
    end
    shade:addTo(freeItemButton)
    --商品点击事件
    freeItemButton:addTouchEventListener(function(sender,eventType)--按钮点击后放大缩小特效
        if eventType == ccui.TouchEventType.began then
            local scale = cc.ScaleTo:create(1,0.9)
            local ease_elastic = cc.EaseElasticOut:create(scale)
            sender:runAction(ease_elastic)

        elseif eventType == ccui.TouchEventType.ended then
            local scale = cc.ScaleTo:create(1,1)
            local ease_elastic = cc.EaseElasticOut:create(scale)
            sender:runAction(ease_elastic)
            --钻石数量增加100
            KnapsackData:setDiamonds(100)
            --添加售罄遮罩
            shade:setVisible(true)
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
end

--[[
    函数用途：金币商店商品的展示:
    参数：层，商品图片路径，碎片数量，商品价格，位置偏移的X,Y
    --]]
function Shop:createGoldItem(goldLayer,ShopLayer,index,fragNum,price,soldOutState,offsetX,offsetY,i)
    local path = "ui/hall/shop/Goldcoin-shop/CommodityIcon-tower_fragment/"..index..".png"
    --按钮：商品
    local ItemButton = ccui.ImageView:create(path)
    ItemButton:setPosition(cc.p(370+offsetX, display.top-950+offsetY))
    ItemButton:setTouchEnabled(true)
    ItemButton:addTo(goldLayer)

    --图片：碎片数量背景
    local fragmentBg =ccui.ImageView:create("ui/hall/shop/Goldcoin-shop/bg-fragment_number.png")
    fragmentBg:setPosition(cc.p(110, 170))
    fragmentBg:addTo(ItemButton)
    --文本：碎片数量
    local fragmentNum = cc.Label:createWithTTF("X"..fragNum,"ui/font/fzbiaozjw.ttf",19)
    fragmentNum:setPosition(cc.p(45,15))
    fragmentNum:setColor(cc.c3b(255, 206, 55))
    fragmentNum:enableOutline(cc.c4b(0, 0, 0, 255),1)--字体描边
    fragmentNum:addTo(fragmentBg)
    --图片：金币图标
    local goldCoinIcon =ccui.ImageView:create("ui/hall/shop/Goldcoin-shop/PriceIcon-gold_coins.png")
    goldCoinIcon:setPosition(cc.p(50, 30))
    goldCoinIcon:addTo(ItemButton)
    --文本：商品价格
    local priceNum = cc.Label:createWithTTF(price,"ui/font/fzbiaozjw.ttf",25)
    priceNum:setPosition(cc.p(95,30))
    priceNum:setColor(cc.c3b(255, 255, 255))
    priceNum:enableOutline(cc.c4b(0, 0, 0, 255),1)--字体描边
    priceNum:addTo(ItemButton)
    --售罄遮罩
    local shade = ccui.Layout:create()
    shade:setBackGroundColor(cc.c4b(0,0,0,128))
    shade:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)--设置颜色模式
    shade:setBackGroundColorOpacity(128)--设置透明度
    shade:setAnchorPoint(0,0)
    shade:setPosition(cc.p(0, 0))
    shade:setContentSize(156, 194)
    shade:setVisible(soldOutState)
    shade:setTouchEnabled(false)
    shade:addTo(ItemButton)

    ItemButton:addTouchEventListener(function(sender,eventType)--按钮点击后放大缩小特效
        if eventType == ccui.TouchEventType.began then
            local scale = cc.ScaleTo:create(1,0.9)
            local ease_elastic = cc.EaseElasticOut:create(scale)
            sender:runAction(ease_elastic)

        elseif eventType == ccui.TouchEventType.ended then
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
    return ItemButton
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
    local diamondTitleBg = ccui.ImageView:create("ui/hall/shop/Diamond-shop/bg-title.png")
    diamondTitleBg:setAnchorPoint(0, 1)
    diamondTitleBg:setPosition(cc.p(0, display.top-500))
    diamondTitleBg:addTo(diamondLayer)
    --图片：钻石商店
    local diamondStoreText = ccui.ImageView:create("ui/hall/shop/Diamond-shop/Title-diamond_store.png")
    diamondStoreText:setAnchorPoint(0.5, 0.5)
    diamondStoreText:addTo(diamondTitleBg)
    diamondStoreText:setPosition(cc.p(display.cx,35))

    self:createDiamondItem(ShopLayer,diamondLayer,"ui/hall/shop/Diamond-shop/bg-normal.png","ui/hall/shop/Diamond-shop/TreasureChest - normal.png"
    , "ui/hall/common/SecondaryInterface-Treasure chest opening confirmation pop-up window/Title - common treasure chest.png"
    , "150",0,0,"X38","X7","X1","X0","+285")

    self:createDiamondItem(ShopLayer,diamondLayer,"ui/hall/shop/Diamond-shop/bg-rare.png","ui/hall/shop/Diamond-shop/TreasureChest - RARE.png"
    , "ui/hall/common/SecondaryInterface-Treasure chest opening confirmation pop-up window/Title - rare treasure chest.png"
    ,"250",230,0,"X74","X14","X2","X0","+456")

    self:createDiamondItem(ShopLayer,diamondLayer,"ui/hall/shop/Diamond-shop/bg-epic.png","ui/hall/shop/Diamond-shop/TreasureChest - Epic.png"
    , "ui/hall/common/SecondaryInterface-Treasure chest opening confirmation pop-up window/Title - Epic chest.png"
    ,"750",460,0,"X139","X36","X7","X0~1","+1280")

    self:createDiamondItem(ShopLayer,diamondLayer,"ui/hall/shop/Diamond-shop/bg-legend.png","ui/hall/shop/Diamond-shop/TreasureChest - Legend.png"
    , "ui/hall/common/SecondaryInterface-Treasure chest opening confirmation pop-up window/Title - legendary treasure chest.png"
    ,"2500",230,-320,"X187","X51","X21","X1","+3040")

end

--[[
    函数用途：钻石商店商品的展示:
    参数：层，宝箱背景图路径，宝箱图标路径，宝箱类型路径，宝箱价格，位置的偏移X,Y
    ，普通卡数量，稀有卡数量，史诗卡数量，传说卡数量，可获得金币数量
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
    参数：层，商品坐标x,y
    --]]
function Shop:ItemShade(layer,x,y)
    local shade = ccui.Layout:create()
    shade:setBackGroundColor(cc.c4b(0,0,0,128))
    shade:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)--设置颜色模式
    shade:setBackGroundColorOpacity(128)--设置透明度
    shade:setAnchorPoint(0.5,0.5)
    shade:setPosition(cc.p(x, y))
    shade:setContentSize(156, 194)
    shade:setTouchEnabled(true)
    shade:addTo(layer)

end


return Shop