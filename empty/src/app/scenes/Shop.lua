local Shop = class("Shop")
local KnapsackData = require("app.data.KnapsackData")
local TopPanel = require("app.scenes.TopPanel")
--[[
local function buttonEvent(sender,eventType)--按钮点击后放大缩小特效
    if eventType == ccui.TouchEventType.began then
        local scale = cc.ScaleTo:create(1,0.9)
        local ease_elastic = cc.EaseElasticOut:create(scale)
         sender:runAction(ease_elastic)

    elseif eventType == ccui.TouchEventType.ended then
        local scale = cc.ScaleTo:create(1,1)
        local ease_elastic = cc.EaseElasticOut:create(scale)
        sender:runAction(ease_elastic)

    elseif eventType == ccui.TouchEventType.canceled then
        local scale = cc.ScaleTo:create(1,1)
        local ease_elastic = cc.EaseElasticOut:create(scale)
        sender:runAction(ease_elastic)
    end
end--]]
function Shop:ctor()
    KnapsackData:init()
end


--[[
    函数用途：滑动商店触摸事件
    --]]
function Shop:slide(layer)
    local listener = cc.EventListenerTouchOneByOne:create()--单点触摸
    local function onTouchBegan(touch, event)
        str = "null"
        local target = event:getCurrentTarget()
        local size = target:getContentSize()
        local rect = cc.rect(0, 0, size.width, size.height)
        local p = touch:getLocation()
        p = target:convertTouchToNodeSpace(touch)
        if cc.rectContainsPoint(rect, p) then
            return true
        end
        return false
    end

    local function onTouchMoved(touch, event)
        local location = touch:getStartLocationInView()
        local y1 = location["y"] or 0
        local location2 = touch:getLocationInView()
        local y2 = location2["y"] or 0
        if y2-y1>50 then
            --print(layer:getPositionY())
            if layer:getPositionY() ~= 0 then--边缘内滑动
                str = "down"
            end
        elseif y1-y2>50 then
            if layer:getPositionY() ~=370 then--边缘内滑动
                str = "up"
            end
        end
    end
    local function onTouchEnded(touch, event)
        if str == "down" then
            self:slideShop(layer,-370)
            print(str)
        elseif str == "up" then
            self:slideShop(layer,370)
            print(str)
        end
    end

    listener:registerScriptHandler(onTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN )
    listener:registerScriptHandler(onTouchMoved,cc.Handler.EVENT_TOUCH_MOVED )
    listener:registerScriptHandler(onTouchEnded,cc.Handler.EVENT_TOUCH_ENDED )
    cc.Director:getInstance():getEventDispatcher():addEventListenerWithSceneGraphPriority(listener, layer)
end

--[[
    函数用途：商店页面的滑动
    --]]
function Shop:slideShop(layer,distance)
    local moveAction = cc.MoveBy:create(0.5,cc.p(0,distance))
    layer:runAction(moveAction)
end

--[[
    函数用途：商店一级页面的展示
    --]]
function Shop:ShopPanel()
    --层：整个商店
    local ShopLayer = ccui.Layout:create()
    ShopLayer:setBackGroundColorOpacity(180)--设置为透明
    --ShopLayer:setBackGroundColorType(1)
    ShopLayer:setAnchorPoint(0, 0)
    ShopLayer:setPosition(cc.p(0, display.top))
    ShopLayer:setContentSize(720, 1280)
    self:slide(ShopLayer)

    --图片：商店背景图
    local Bg = ccui.ImageView:create("ui/hall/shop/bg-StoreInterface.png")
    Bg:setAnchorPoint(0.5, 0.5)
    Bg:setPosition(display.cx,display.cy)
    Bg:addTo(ShopLayer)
    --图片：标题背景条
    local goldTitleBg = ccui.ImageView:create("ui/hall/shop/Goldcoin-shop/bg-title_block.png")
    goldTitleBg:setAnchorPoint(0, 1)
    goldTitleBg:setPosition(cc.p(0, display.top-50))
    goldTitleBg:addTo(ShopLayer)
    --图片：金币商店
    local goldStoreText = ccui.ImageView:create("ui/hall/shop/Goldcoin-shop/Title - gold_coin_store.png")
    goldStoreText:setAnchorPoint(0.5, 0.5)
    goldStoreText:addTo(goldTitleBg)
    goldStoreText:setPosition(cc.p(display.cx,35))

    --图片：刷新背景条
    local refreshBg = ccui.ImageView:create("ui/hall/shop/Goldcoin-shop/bg-remaining_refresh_time.png")
    refreshBg:setPosition(cc.p(display.cx, display.top-160))
    refreshBg:addTo(ShopLayer)
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


    --按钮：免费商品
    local freeItemButton = ccui.Button:create(
            "ui/hall/shop/Goldcoin-shop/bg-free_items.png",
            "ui/hall/shop/Goldcoin-shop/bg-free_items.png",
            "ui/hall/shop/Goldcoin-shop/bg-free_items.png"
    )
    freeItemButton:setPosition(cc.p(150, display.top-310))
    freeItemButton:addTouchEventListener(function(sender,eventType)--按钮点击后放大缩小特效
        if eventType == ccui.TouchEventType.began then
            local scale = cc.ScaleTo:create(1,0.9)
            local ease_elastic = cc.EaseElasticOut:create(scale)
            sender:runAction(ease_elastic)

        elseif eventType == ccui.TouchEventType.ended then
            local scale = cc.ScaleTo:create(1,1)
            local ease_elastic = cc.EaseElasticOut:create(scale)
            sender:runAction(ease_elastic)
            KnapsackData:setDiamonds(100)
            TopPanel:setDiamondsString(KnapsackData:getDiamonds())
            --print(KnapsackData:getDiamonds())
            --售罄遮罩
            self:ItemShade(ShopLayer,freeItemButton:getPositionX(),freeItemButton:getPositionY())
        elseif eventType == ccui.TouchEventType.canceled then
            local scale = cc.ScaleTo:create(1,1)
            local ease_elastic = cc.EaseElasticOut:create(scale)
            sender:runAction(ease_elastic)
        end
    end)
    freeItemButton:addTo(ShopLayer)
    --图片：钻石
    local diamondIcon =ccui.ImageView:create("ui/hall/shop/Goldcoin-shop/ItemIcon-Diamond.png")
    diamondIcon:setPosition(cc.p(78, 115))
    diamondIcon:addTo(freeItemButton)
    --文本：钻石数量
    local freeItemNum = cc.Label:createWithTTF("X100","ui/font/fzbiaozjw.ttf",24)
    freeItemNum:setPosition(cc.p(78,65))
    freeItemNum:setColor(cc.c3b(173, 196, 255))
    freeItemNum:enableOutline(cc.c4b(0, 0, 0, 255),1)--字体描边
    freeItemNum:addTo(freeItemButton)
    --图片：免费字样
    local freeIcon =ccui.ImageView:create("ui/hall/shop/Goldcoin-shop/PriceIcon-free.png")
    freeIcon:setPosition(cc.p(78, 25))
    freeIcon:addTo(freeItemButton)

    self:createGoldItem(ShopLayer,"ui/hall/shop/Goldcoin-shop/CommodityIcon-tower_fragment/1.png"
    ,"X36",360,0,0)
    self:createGoldItem(ShopLayer,"ui/hall/shop/Goldcoin-shop/CommodityIcon-tower_fragment/4.png"
    ,"X36",360,210,0)
    self:createGoldItem(ShopLayer,"ui/hall/shop/Goldcoin-shop/CommodityIcon-tower_fragment/9.png"
    ,"X36",360,-220,-220)
    self:createGoldItem(ShopLayer,"ui/hall/shop/Goldcoin-shop/CommodityIcon-tower_fragment/10.png"
    ,"X6",600,0,-220)
    self:createGoldItem(ShopLayer,"ui/hall/shop/Goldcoin-shop/CommodityIcon-tower_fragment/12.png"
    ,"X1",1000,210,-220)

    --***************************钻石商店****************************************
    --图片：钻石商店标题背景条
    local diamondTitleBg = ccui.ImageView:create("ui/hall/shop/Diamond-shop/bg-title.png")
    diamondTitleBg:setAnchorPoint(0, 1)
    diamondTitleBg:setPosition(cc.p(0, display.top-660))
    diamondTitleBg:addTo(ShopLayer)
    --图片：钻石商店
    local diamondStoreText = ccui.ImageView:create("ui/hall/shop/Diamond-shop/Title-diamond_store.png")
    diamondStoreText:setAnchorPoint(0.5, 0.5)
    diamondStoreText:addTo(diamondTitleBg)
    diamondStoreText:setPosition(cc.p(display.cx,35))

    self:createDiamondItem(ShopLayer,"ui/hall/shop/Diamond-shop/bg-normal.png","ui/hall/shop/Diamond-shop/TreasureChest - normal.png"
    ,"ui/hall/common/SecondaryInterface-Treasure chest opening confirmation pop-up window/Title - common treasure chest.png",
            "150",0,0,"X38","X7","X1","X0","+285")
    self:createDiamondItem(ShopLayer,"ui/hall/shop/Diamond-shop/bg-rare.png","ui/hall/shop/Diamond-shop/TreasureChest - RARE.png"
    ,"ui/hall/common/SecondaryInterface-Treasure chest opening confirmation pop-up window/Title - rare treasure chest.png",
            "250",230,0,"X74","X14","X2","X0","+456")
    self:createDiamondItem(ShopLayer,"ui/hall/shop/Diamond-shop/bg-epic.png","ui/hall/shop/Diamond-shop/TreasureChest - Epic.png"
    ,"ui/hall/common/SecondaryInterface-Treasure chest opening confirmation pop-up window/Title - Epic chest.png",
            "750",460,0,"X139","X36","X7","X0~1","+1280")
    self:createDiamondItem(ShopLayer,"ui/hall/shop/Diamond-shop/bg-legend.png","ui/hall/shop/Diamond-shop/TreasureChest - Legend.png"
    ,"ui/hall/common/SecondaryInterface-Treasure chest opening confirmation pop-up window/Title - legendary treasure chest.png",
            "2500",230,-320,"X187","X51","X21","X1","+3040")

    return ShopLayer
end

--[[
    函数用途：商品售罄遮罩
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
--[[
    函数用途：金币商店商品的展示:serveTo ShopPanel
    --]]
function Shop:createGoldItem(layer,path,fragNum,price,offsetX,offsetY)--层级、图片路径、碎片数量、价格、偏移量

    --按钮：商品
    local ItemButton = ccui.Button:create(path, path, path)
    ItemButton:setPosition(cc.p(370+offsetX, display.top-310+offsetY))
    ItemButton:addTouchEventListener(function(sender,eventType)--按钮点击后放大缩小特效
        if eventType == ccui.TouchEventType.began then
            local scale = cc.ScaleTo:create(1,0.9)
            local ease_elastic = cc.EaseElasticOut:create(scale)
            sender:runAction(ease_elastic)

        elseif eventType == ccui.TouchEventType.ended then
            self:goldPurchasePanel(layer,path,fragNum,price,ItemButton)
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

    --图片：碎片数量背景
    local fragmentBg =ccui.ImageView:create("ui/hall/shop/Goldcoin-shop/bg-fragment_number.png")
    fragmentBg:setPosition(cc.p(110, 170))
    fragmentBg:addTo(ItemButton)
    --文本：碎片数量
    local fragmentNum = cc.Label:createWithTTF(fragNum,"ui/font/fzbiaozjw.ttf",19)
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


end

--[[
    函数用途：钻石商店商品的展示:serveTo ShopPanel
    --]]
function Shop:createDiamondItem(layer,bgPath,treasurePath,treasureType,price,offsetX,offsetY,nCardNum,rCardNum,eCardNum,lCardNum,coinNum)--层级、背景图路径、宝箱图路径、价格、偏移量
    --按钮：商品
    local ItemButton = ccui.Button:create(bgPath, bgPath, bgPath)
    ItemButton:setPosition(cc.p(130+offsetX, display.top-900+offsetY))
    ItemButton:addTouchEventListener(function(sender,eventType)--按钮点击后放大缩小特效
        if eventType == ccui.TouchEventType.began then
            local scale = cc.ScaleTo:create(1,0.9)
            local ease_elastic = cc.EaseElasticOut:create(scale)
            sender:runAction(ease_elastic)

        elseif eventType == ccui.TouchEventType.ended then
            self:diamondPurchasePanel(layer,treasurePath,treasureType,nCardNum,rCardNum,eCardNum,lCardNum,coinNum,price)
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
    函数用途：二级弹窗-金币商店购买确认弹窗
    --]]
function Shop:goldPurchasePanel(layer,path,fragNum,price,ItemButton)--图片路径，碎片数量，金额
    local width ,height = display.width,display.height
    --层：灰色背景
    local purchaseLayer = ccui.Layout:create()
    purchaseLayer:setBackGroundColor(cc.c4b(0,0,0,128))
    purchaseLayer:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)--设置颜色模式
    purchaseLayer:setBackGroundColorOpacity(128)--设置透明度
    purchaseLayer:setContentSize(width, height)
    if layer:getPositionY() == 0 then
        purchaseLayer:pos(width/2, height/2+140)
    else
        purchaseLayer:pos(width/2, height/2-370+140)
    end
    purchaseLayer:setAnchorPoint(0.5, 0.5)
    purchaseLayer:addTo(layer)
    purchaseLayer:setTouchEnabled(true)--屏蔽一级界面

    --图片：弹窗背景
    local popLayer = ccui.ImageView:create("ui/hall/shop/SecondaryInterface-Goldcoin_store_purchase_confirmation_pop-up/bg-pop-up.png")
    popLayer:pos(display.cx, display.cy)
    popLayer:setAnchorPoint(0.5, 0.5)
    popLayer:addTo(purchaseLayer)

    --图片：商品图
    local ItemBg =ccui.ImageView:create(path)
    ItemBg:setScale(0.8,0.8)
    ItemBg:setPosition(cc.p(display.cx-90, 185))
    ItemBg:addTo(popLayer)
    --文本：碎片数量
    local fragmentNum = cc.Label:createWithTTF(fragNum,"ui/font/fzbiaozjw.ttf",25)
    fragmentNum:setPosition(cc.p(80,30))
    fragmentNum:setColor(cc.c3b(255, 206, 55))
    fragmentNum:enableOutline(cc.c4b(0, 0, 0, 255),1)--字体描边
    fragmentNum:addTo(ItemBg)

    --按钮：确认按钮
    local confirmButton = ccui.Button:create(
            "ui/hall/shop/SecondaryInterface-Goldcoin_store_purchase_confirmation_pop-up/Button-purchase.png",
            "ui/hall/shop/SecondaryInterface-Goldcoin_store_purchase_confirmation_pop-up/Button-purchase.png",
            "ui/hall/shop/SecondaryInterface-Goldcoin_store_purchase_confirmation_pop-up/Button-purchase.png")
    confirmButton:setPosition(cc.p(display.cx-90, 50))
    confirmButton:addTouchEventListener(function(sender,eventType)--按钮点击后放大缩小特效
        if eventType == ccui.TouchEventType.began then
            local scale = cc.ScaleTo:create(1,0.9)
            local ease_elastic = cc.EaseElasticOut:create(scale)
            sender:runAction(ease_elastic)
        elseif eventType == ccui.TouchEventType.ended then
            local scale = cc.ScaleTo:create(1,1)
            local ease_elastic = cc.EaseElasticOut:create(scale)
            sender:runAction(ease_elastic)
            if KnapsackData:setGoldCoin(-price) then
                TopPanel:setCoinString(KnapsackData:getGoldCoin())
                --售罄遮罩
                self:ItemShade(layer,ItemButton:getPositionX(),ItemButton:getPositionY())
            end
            purchaseLayer:setVisible(false)
        elseif eventType == ccui.TouchEventType.canceled then
            local scale = cc.ScaleTo:create(1,1)
            local ease_elastic = cc.EaseElasticOut:create(scale)
            sender:runAction(ease_elastic)
        end
    end)
    confirmButton:addTo(popLayer)
    --图片：确认按钮的金币图标
    local coin =ccui.ImageView:create("ui/hall/shop/SecondaryInterface-Goldcoin_store_purchase_confirmation_pop-up/Icon-gold_coin.png")
    coin:setPosition(cc.p(60, 40))
    coin:addTo(confirmButton)
    --文本：确认按钮的金额文本
    local priceNum = cc.Label:createWithTTF(price,"ui/font/fzbiaozjw.ttf",30)
    priceNum:setPosition(cc.p(120,40))
    priceNum:setColor(cc.c3b(255, 255, 255))
    priceNum:enableOutline(cc.c4b(0, 0, 0, 255),1)--字体描边
    priceNum:addTo(confirmButton)

    --按钮：关闭窗口
    local closeButton = ccui.Button:create(
            "ui/hall/shop/SecondaryInterface-Goldcoin_store_purchase_confirmation_pop-up/Button-off.png",
            "ui/hall/shop/SecondaryInterface-Goldcoin_store_purchase_confirmation_pop-up/Button-off.png",
            "ui/hall/shop/SecondaryInterface-Goldcoin_store_purchase_confirmation_pop-up/Button-off.png")
    closeButton:setPosition(cc.p(490, 330))
    closeButton:addTouchEventListener(function(sender,eventType)--按钮点击后放大缩小特效
        if eventType == ccui.TouchEventType.began then
            local scale = cc.ScaleTo:create(1,0.9)
            local ease_elastic = cc.EaseElasticOut:create(scale)
            sender:runAction(ease_elastic)
        elseif eventType == ccui.TouchEventType.ended then
            local scale = cc.ScaleTo:create(1,1)
            local ease_elastic = cc.EaseElasticOut:create(scale)
            sender:runAction(ease_elastic)
            purchaseLayer:setVisible(false)--隐藏二级弹窗
            layer:setTouchEnabled(true)
        elseif eventType == ccui.TouchEventType.canceled then
            local scale = cc.ScaleTo:create(1,1)
            local ease_elastic = cc.EaseElasticOut:create(scale)
            sender:runAction(ease_elastic)
        end
    end)
    closeButton:addTo(popLayer)
end

--[[
    函数用途：二级弹窗-宝箱开启确认弹窗
    --]]
function Shop:diamondPurchasePanel(layer,treasurePath,treasureType,nCardNum,rCardNum,eCardNum,lCardNum,coinNum,price)--层，宝箱图路径，宝箱类型,金币数量
    local width ,height = display.width,display.height
    --层：灰色背景
    local purchaseLayer = ccui.Layout:create()
    purchaseLayer:setBackGroundColor(cc.c4b(0,0,0,128))
    purchaseLayer:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)--设置颜色模式
    purchaseLayer:setBackGroundColorOpacity(128)--设置透明度
    purchaseLayer:setContentSize(width, height)
    if layer:getPositionY() == 0 then
        purchaseLayer:pos(width/2, height/2+140)
    else
        purchaseLayer:pos(width/2, height/2-370+140)
    end
    purchaseLayer:setAnchorPoint(0.5, 0.5)
    purchaseLayer:addTo(layer)
    purchaseLayer:setTouchEnabled(true)--屏蔽一级界面

    --图片：弹窗背景
    local popLayer = ccui.ImageView:create("ui/hall/common/SecondaryInterface-Treasure chest opening confirmation pop-up window/bg-pop-up.png")
    popLayer:pos(display.cx, display.cy)
    popLayer:setAnchorPoint(0.5, 0.5)
    popLayer:addTo(purchaseLayer)

    --图片：宝箱图标
    local treasureIcon =ccui.ImageView:create(treasurePath)
    treasureIcon:setScale(1.4,1.4)
    treasureIcon:setPosition(cc.p(300, display.cy-190))
    treasureIcon:addTo(popLayer)
    --图片：宝箱类型图标
    local type =ccui.ImageView:create(treasureType)
    type:setPosition(cc.p(300, display.cy-310))
    type:addTo(popLayer)

    --图片：金币背景
    local coinBg =ccui.ImageView:create("ui/hall/common/SecondaryInterface-Treasure chest opening confirmation pop-up window/bg-gold coin.png")
    coinBg:setPosition(cc.p(120, 180))
    coinBg:addTo(popLayer)
    --图片：金币
    local coin =ccui.ImageView:create("ui/hall/common/SecondaryInterface-Treasure chest opening confirmation pop-up window/Icon - gold coin.png")
    coin:setPosition(cc.p(65, 100))
    coin:addTo(coinBg)
    --文本：金币数量
    local cNum = cc.Label:createWithTTF(coinNum,"ui/font/fzbiaozjw.ttf",24)
    cNum:setPosition(cc.p(60,40))
    cNum:setColor(cc.c3b(165, 237, 255))
    cNum:enableOutline(cc.c4b(0, 0, 0, 255),1)--字体描边
    cNum:addTo(coinBg)
    self:ItemInTreasure(popLayer,nCardNum,rCardNum,eCardNum,lCardNum)--展示宝箱开启可能获得的物品信息
    --按钮：开启按钮
    local openButton = ccui.Button:create(
            "ui/hall/common/SecondaryInterface-Treasure chest opening confirmation pop-up window/Button - on.png",
            "ui/hall/common/SecondaryInterface-Treasure chest opening confirmation pop-up window/Button - on.png",
            "ui/hall/common/SecondaryInterface-Treasure chest opening confirmation pop-up window/Button - on.png")
    openButton:setPosition(cc.p(300, 0))
    openButton:addTouchEventListener(function(sender,eventType)--按钮点击后放大缩小特效
        if eventType == ccui.TouchEventType.began then
            local scale = cc.ScaleTo:create(1,0.9)
            local ease_elastic = cc.EaseElasticOut:create(scale)
            sender:runAction(ease_elastic)
        elseif eventType == ccui.TouchEventType.ended then
            local scale = cc.ScaleTo:create(1,1)
            local ease_elastic = cc.EaseElasticOut:create(scale)
            sender:runAction(ease_elastic)
            --获得金币，扣除钻石
            if KnapsackData:setDiamonds(-price) then
                TopPanel:setDiamondsString(KnapsackData:getDiamonds())
                --print(KnapsackData:getDiamonds())
                KnapsackData:setGoldCoin(coinNum)
                TopPanel:setCoinString(KnapsackData:getGoldCoin())
                --print(KnapsackData:getGoldCoin())
                self:obtainFromTreasure(layer,nCardNum,rCardNum,eCardNum,lCardNum,coinNum,price)
            end
            purchaseLayer:setVisible(false)--隐藏二级弹窗
        elseif eventType == ccui.TouchEventType.canceled then
            local scale = cc.ScaleTo:create(1,1)
            local ease_elastic = cc.EaseElasticOut:create(scale)
            sender:runAction(ease_elastic)
        end
    end)
    openButton:addTo(popLayer)



    --按钮：关闭窗口
    local closeButton = ccui.Button:create(
            "ui/hall/common/SecondaryInterface-Treasure chest opening confirmation pop-up window/Button - off.png",
            "ui/hall/common/SecondaryInterface-Treasure chest opening confirmation pop-up window/Button - off.png",
            "ui/hall/common/SecondaryInterface-Treasure chest opening confirmation pop-up window/Button - off.png")
    closeButton:setPosition(cc.p(570, 330))
    closeButton:addTouchEventListener(function(sender,eventType)--按钮点击后放大缩小特效
        if eventType == ccui.TouchEventType.began then
            local scale = cc.ScaleTo:create(1,0.9)
            local ease_elastic = cc.EaseElasticOut:create(scale)
            sender:runAction(ease_elastic)
        elseif eventType == ccui.TouchEventType.ended then
            local scale = cc.ScaleTo:create(1,1)
            local ease_elastic = cc.EaseElasticOut:create(scale)
            sender:runAction(ease_elastic)
            purchaseLayer:setVisible(false)--隐藏二级弹窗
            layer:setTouchEnabled(true)
        elseif eventType == ccui.TouchEventType.canceled then
            local scale = cc.ScaleTo:create(1,1)
            local ease_elastic = cc.EaseElasticOut:create(scale)
            sender:runAction(ease_elastic)
        end
    end)
    closeButton:addTo(popLayer)
end

--[[
    函数用途：二级界面-宝箱开启获得物品弹窗serveTo diamondPurchasePanel
    --]]
function Shop:obtainFromTreasure(layer,nCardNum,rCardNum,eCardNum,lCardNum,coinNum,price)
    local width ,height = display.width,display.height
    --层：灰色背景
    local grayLayer = ccui.Layout:create()
    grayLayer:setBackGroundColor(cc.c4b(0,0,0,128))
    grayLayer:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)--设置颜色模式
    grayLayer:setBackGroundColorOpacity(128)--设置透明度
    grayLayer:setContentSize(width, height)
    if layer:getPositionY() == 0 then
        grayLayer:pos(width/2, height/2+140)
    else
        grayLayer:pos(width/2, height/2-370+140)
    end
    grayLayer:setAnchorPoint(0.5, 0.5)
    grayLayer:addTo(layer)
    grayLayer:setTouchEnabled(true)--屏蔽一级界面
    --图片：弹窗背景
    local obtainBg =ccui.ImageView:create("ui/hall/common/SecondaryInterface-Open the treasure chest to obtain the item pop-up window/bg-pop-up.png")
    obtainBg:setPosition(cc.p(display.cx, display.cy))
    obtainBg:addTo(grayLayer)
    obtainBg:setTouchEnabled(true)--屏蔽一级界面
    --碎片展示
    self:obtained(obtainBg,nCardNum,rCardNum,eCardNum,lCardNum,coinNum)
    --金币获得
    local coinObtained =ccui.ImageView:create("ui/hall/common/SecondaryInterface-Open the treasure chest to obtain the item pop-up window/Icon - gold coin.png")
    coinObtained:setPosition(cc.p(300, -40))
    coinObtained:addTo(obtainBg)
    --文本：金币数量
    local cNum = cc.Label:createWithTTF(coinNum,"ui/font/fzbiaozjw.ttf",30)
    cNum:setPosition(cc.p(380,-40))
    cNum:setColor(cc.c3b(255, 255, 255))
    cNum:enableOutline(cc.c4b(20, 20, 66, 255),2)--字体描边
    cNum:addTo(obtainBg)
    --按钮：开启按钮
    local confirmButton = ccui.Button:create(
            "ui/hall/common/SecondaryInterface-Open the treasure chest to obtain the item pop-up window/Button - confirm.png",
            "ui/hall/common/SecondaryInterface-Open the treasure chest to obtain the item pop-up window/Button - confirm.png",
            "ui/hall/common/SecondaryInterface-Open the treasure chest to obtain the item pop-up window/Button - confirm.png")
    confirmButton:setAnchorPoint(0.5,0.5)
    confirmButton:setPosition(cc.p(display.cx, -130))
    confirmButton:addTouchEventListener(function(sender,eventType)--按钮点击后放大缩小特效
        if eventType == ccui.TouchEventType.began then
            local scale = cc.ScaleTo:create(1,0.9)
            local ease_elastic = cc.EaseElasticOut:create(scale)
            sender:runAction(ease_elastic)
        elseif eventType == ccui.TouchEventType.ended then
            local scale = cc.ScaleTo:create(1,1)
            local ease_elastic = cc.EaseElasticOut:create(scale)
            sender:runAction(ease_elastic)
            grayLayer:setVisible(false)--隐藏二级弹窗
        elseif eventType == ccui.TouchEventType.canceled then
            local scale = cc.ScaleTo:create(1,1)
            local ease_elastic = cc.EaseElasticOut:create(scale)
            sender:runAction(ease_elastic)
        end
    end)
    confirmButton:addTo(obtainBg)
end
--[[
    函数用途：展示宝箱开启后所能获得的物品serveTo diamondPurchasePanel
    --]]
function Shop:ItemInTreasure(layer,nCardNum,rCardNum,eCardNum,lCardNum)
    --普通
    local nIcon =ccui.ImageView:create("ui/hall/common/SecondaryInterface-Treasure chest opening confirmation pop-up window/Icon - normal.png")
    nIcon:setPosition(cc.p(240, 220))
    nIcon:addTo(layer)
    local nBg = ccui.ImageView:create("ui/hall/common/SecondaryInterface-Treasure chest opening confirmation pop-up window/bg-text.png")
    nBg:setPosition(cc.p(320, 240))
    nBg:addTo(layer)
    local nBg1 = ccui.ImageView:create("ui/hall/common/SecondaryInterface-Treasure chest opening confirmation pop-up window/bg-text.png")
    nBg1:setPosition(cc.p(320, 210))
    nBg1:addTo(layer)
    local normalText= cc.Label:createWithTTF("普通","ui/font/fzbiaozjw.ttf",20)
    normalText:setPosition(cc.p(320,240))
    normalText:setColor(cc.c3b(214, 214, 231))
    normalText:enableOutline(cc.c4b(0, 0, 0, 255),2)--字体描边
    normalText:addTo(layer)
    local normalNum= cc.Label:createWithTTF(nCardNum,"ui/font/fzbiaozjw.ttf",20)
    normalNum:setPosition(cc.p(320,210))
    normalNum:setColor(cc.c3b(214, 214, 231))
    normalNum:enableOutline(cc.c4b(0, 0, 0, 255),1)--字体描边
    normalNum:addTo(layer)

    --稀有
    local rIcon =ccui.ImageView:create("ui/hall/common/SecondaryInterface-Treasure chest opening confirmation pop-up window/Icon - RARE.png")
    rIcon:setPosition(cc.p(410, 220))
    rIcon:addTo(layer)
    local rBg = ccui.ImageView:create("ui/hall/common/SecondaryInterface-Treasure chest opening confirmation pop-up window/bg-text.png")
    rBg:setPosition(cc.p(490, 240))
    rBg:addTo(layer)
    local rBg1 = ccui.ImageView:create("ui/hall/common/SecondaryInterface-Treasure chest opening confirmation pop-up window/bg-text.png")
    rBg1:setPosition(cc.p(490, 210))
    rBg1:addTo(layer)
    local rareText= cc.Label:createWithTTF("稀有","ui/font/fzbiaozjw.ttf",20)
    rareText:setPosition(cc.p(490,240))
    rareText:setColor(cc.c3b(79, 187, 245))
    rareText:enableOutline(cc.c4b(0, 0, 0, 255),2)--字体描边
    rareText:addTo(layer)
    local rareNum= cc.Label:createWithTTF(rCardNum,"ui/font/fzbiaozjw.ttf",20)
    rareNum:setPosition(cc.p(490,210))
    rareNum:setColor(cc.c3b(79, 187, 245))
    rareNum:enableOutline(cc.c4b(0, 0, 0, 255),1)--字体描边
    rareNum:addTo(layer)
    --史诗
    local eIcon =ccui.ImageView:create("ui/hall/common/SecondaryInterface-Treasure chest opening confirmation pop-up window/Icon - Epic.png")
    eIcon:setPosition(cc.p(240, 130))
    eIcon:addTo(layer)
    local eBg = ccui.ImageView:create("ui/hall/common/SecondaryInterface-Treasure chest opening confirmation pop-up window/bg-text.png")
    eBg:setPosition(cc.p(320, 150))
    eBg:addTo(layer)
    local eBg1 = ccui.ImageView:create("ui/hall/common/SecondaryInterface-Treasure chest opening confirmation pop-up window/bg-text.png")
    eBg1:setPosition(cc.p(320, 120))
    eBg1:addTo(layer)
    local epicText= cc.Label:createWithTTF("史诗","ui/font/fzbiaozjw.ttf",20)
    epicText:setPosition(cc.p(320,150))
    epicText:setColor(cc.c3b(210, 102, 249))
    epicText:enableOutline(cc.c4b(0, 0, 0, 255),2)--字体描边
    epicText:addTo(layer)
    local epicNum= cc.Label:createWithTTF(eCardNum,"ui/font/fzbiaozjw.ttf",20)
    epicNum:setPosition(cc.p(320,120))
    epicNum:setColor(cc.c3b(210, 102, 249))
    epicNum:enableOutline(cc.c4b(0, 0, 0, 255),1)--字体描边
    epicNum:addTo(layer)
    --传说
    if lCardNum ~="X0" then
        local lIcon =ccui.ImageView:create("ui/hall/common/SecondaryInterface-Treasure chest opening confirmation pop-up window/Icon-legend.png")
        lIcon:setPosition(cc.p(410, 130))
        lIcon:addTo(layer)
        local lBg = ccui.ImageView:create("ui/hall/common/SecondaryInterface-Treasure chest opening confirmation pop-up window/bg-text.png")
        lBg:setPosition(cc.p(490, 150))
        lBg:addTo(layer)
        local lBg1 = ccui.ImageView:create("ui/hall/common/SecondaryInterface-Treasure chest opening confirmation pop-up window/bg-text.png")
        lBg1:setPosition(cc.p(490, 120))
        lBg1:addTo(layer)
        local legendText= cc.Label:createWithTTF("传说","ui/font/fzbiaozjw.ttf",20)
        legendText:setPosition(cc.p(490,150))
        legendText:setColor(cc.c3b(250, 198, 17))
        legendText:enableOutline(cc.c4b(0, 0, 0, 255),2)--字体描边
        legendText:addTo(layer)
        local legendNum= cc.Label:createWithTTF(lCardNum,"ui/font/fzbiaozjw.ttf",20)
        legendNum:setPosition(cc.p(490,120))
        legendNum:setColor(cc.c3b(250, 198, 17))
        legendNum:enableOutline(cc.c4b(0, 0, 0, 255),1)--字体描边
        legendNum:addTo(layer)
    end
end
--[[
    函数用途：serveToobtainFromTreasure
--]]
function Shop:obtained(layer,nCardNum,rCardNum,eCardNum,lCardNum)
    local originX = 140
    local originY = 260
    for i = 1,4 do
        local ItemObtained =ccui.ImageView:create("ui/hall/common/SecondaryInterface-Open the treasure chest to obtain the item pop-up window/Icon - tower/01.png")
        ItemObtained:setScale(0.9,0.9)
        ItemObtained:setPosition(cc.p(originX, originY))
        ItemObtained:addTo(layer)
        --文本：碎片数量
        local fragmentNum = cc.Label:createWithTTF("X42","ui/font/fzbiaozjw.ttf",21)
        fragmentNum:setPosition(cc.p(originX+45, originY+45))
        fragmentNum:setColor(cc.c3b(255, 255, 255))
        fragmentNum:enableOutline(cc.c4b(0, 0, 0, 255),1)--字体描边
        fragmentNum:addTo(layer)
        originX = originX+150
    end
    originY = originY-150
    originX = 140
    for i = 1,4 do
        local ItemObtained =ccui.ImageView:create("ui/hall/common/SecondaryInterface-Open the treasure chest to obtain the item pop-up window/Icon - tower/01.png")
        ItemObtained:setScale(0.9,0.9)
        ItemObtained:setPosition(cc.p(originX, originY))
        ItemObtained:addTo(layer)
        --文本：碎片数量
        local fragmentNum = cc.Label:createWithTTF("X42","ui/font/fzbiaozjw.ttf",21)
        fragmentNum:setPosition(cc.p(originX+45, originY+45))
        fragmentNum:setColor(cc.c3b(255, 255, 255))
        fragmentNum:enableOutline(cc.c4b(0, 0, 0, 255),1)--字体描边
        fragmentNum:addTo(layer)
        originX = originX+150
    end
end


return Shop