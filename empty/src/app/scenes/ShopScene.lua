
local ShopScene = class("ShopScene", function()
    return display.newScene("ShopScene")
end)

function ShopScene:ctor()
    self:createMiddleMiddlePanel()
    local layer = self:ShopPanel()
    self:createMiddleBottomPanel()
    self:createMiddleTopPanel()

    str = "null"
    local listener = cc.EventListenerTouchOneByOne:create()--单点触摸
    local function onTouchBegan(touch, event)
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
        if y1<y2 then
            str = "up"
        elseif y1>y2 then
            str = "down"
        end
    end
    local function onTouchEnded(touch, event)
        if str == "up" then
            self:slideShop(layer,-350)
            print(str)
        elseif str == "down" then
            self:slideShop(layer,350)
            print(str)
        end
    end

    listener:registerScriptHandler(onTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN )
    listener:registerScriptHandler(onTouchMoved,cc.Handler.EVENT_TOUCH_MOVED )
    listener:registerScriptHandler(onTouchEnded,cc.Handler.EVENT_TOUCH_ENDED )
    cc.Director:getInstance():getEventDispatcher():addEventListenerWithSceneGraphPriority(listener, layer)

end
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

--[[
    函数用途：商店页面的滑动
    --]]
function ShopScene:slideShop(layer,distance)
    local moveAction = cc.MoveBy:create(0.5,cc.p(0,distance))
    layer:runAction(moveAction)
end


--[[
    函数用途：商店一级页面的展示
    --]]
function ShopScene:ShopPanel()
    local width,height = display.width,display.top
    local ShopLayer = ccui.Layout:create()
    ShopLayer:setBackGroundColorOpacity(180)--设置为半透明
    --ShopLayer:setBackGroundColorType(1)
    ShopLayer:setContentSize(width, height/2)--占满全屏
    ShopLayer:setPosition(0, display.top-150)--左上角
    ShopLayer:setAnchorPoint(0, 1)
    ShopLayer:addTo(self)

    --标题背景条
    local goldTitleBg = ccui.ImageView:create("ui/hall/shop/Goldcoin-shop/bg-title_block.png")
    goldTitleBg:setAnchorPoint(0, 1)
    goldTitleBg:setPosition(cc.p(0, (display.top-50)/2))
    goldTitleBg:addTo(ShopLayer)
    --文字：金币商店
    local goldStoreText = ccui.ImageView:create("ui/hall/shop/Goldcoin-shop/Title - gold_coin_store.png")
    goldStoreText:setAnchorPoint(0.5, 0.5)
    goldStoreText:addTo(goldTitleBg)
    goldStoreText:setPosition(cc.p(display.cx,35))

    --刷新背景条
    local refreshBg = ccui.ImageView:create("ui/hall/shop/Goldcoin-shop/bg-remaining_refresh_time.png")
    refreshBg:setPosition(cc.p(display.cx, (display.top-270)/2))
    refreshBg:addTo(ShopLayer)
    --文字：商店刷新剩余时间
    local refreshText = ccui.ImageView:create("ui/hall/shop/Goldcoin-shop/Prompt-refresh_time_remaining.png")--文字：商店刷新剩余时间
    refreshText:setAnchorPoint(0.5, 0.5)
    refreshText:addTo(refreshBg)
    refreshText:setPosition(cc.p(display.cx-100,25))
    --文本：商品刷新剩余时间
    local time = "03:13"
    local refreshLabel = cc.Label:createWithTTF(time,"ui/font/fzbiaozjw.ttf",30)
    refreshLabel:setPosition(cc.p(display.cx+50,25))
    refreshLabel:setColor(cc.c3b(255, 206, 55))
    --refreshLabel:enableShadow(cc.c3b(0,0,0), cc.size(2,-2), 100)--字体描边有待学习
    refreshLabel:addTo(refreshBg)

    --按钮：免费商品
    local freeItemButton = ccui.Button:create(
            "ui/hall/shop/Goldcoin-shop/bg-free_items.png",
            "ui/hall/shop/Goldcoin-shop/bg-free_items.png",
            "ui/hall/shop/Goldcoin-shop/bg-free_items.png"
    )
    freeItemButton:setPosition(cc.p(150, display.top-920))
    freeItemButton:addTouchEventListener(function(sender,eventType)--按钮点击后放大缩小特效
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
    end)
    freeItemButton:addTo(ShopLayer)
    --图标：钻石
    local diamondIcon =ccui.ImageView:create("ui/hall/shop/Goldcoin-shop/ItemIcon-Diamond.png")
    diamondIcon:setPosition(cc.p(78, 115))
    diamondIcon:addTo(freeItemButton)
    --文本：钻石数量
    local freeItemNum = cc.Label:createWithTTF("X100","ui/font/fzbiaozjw.ttf",24)
    freeItemNum:setPosition(cc.p(78,65))
    freeItemNum:setColor(cc.c3b(173, 196, 255))
    --freeItemNum:enableShadow(cc.c3b(0,0,0), cc.size(2,-2), 100)--字体描边有待学习
    freeItemNum:addTo(freeItemButton)
    --图标：免费字样
    local freeIcon =ccui.ImageView:create("ui/hall/shop/Goldcoin-shop/PriceIcon-free.png")
    freeIcon:setPosition(cc.p(78, 25))
    freeIcon:addTo(freeItemButton)

    self:createGoldItem(ShopLayer,"ui/hall/shop/Goldcoin-shop/CommodityIcon-tower_fragment/1.png"
    ,"X36","360",0,0)
    self:createGoldItem(ShopLayer,"ui/hall/shop/Goldcoin-shop/CommodityIcon-tower_fragment/4.png"
    ,"X36","360",210,0)
    self:createGoldItem(ShopLayer,"ui/hall/shop/Goldcoin-shop/CommodityIcon-tower_fragment/9.png"
    ,"X36","360",-220,-220)
    self:createGoldItem(ShopLayer,"ui/hall/shop/Goldcoin-shop/CommodityIcon-tower_fragment/10.png"
    ,"X6","600",0,-220)
    self:createGoldItem(ShopLayer,"ui/hall/shop/Goldcoin-shop/CommodityIcon-tower_fragment/12.png"
    ,"X1","1000",210,-220)

    --***************************钻石商店****************************************
    --标题背景条
    local diamondTitleBg = ccui.ImageView:create("ui/hall/shop/Diamond-shop/bg-title.png")
    diamondTitleBg:setAnchorPoint(0, 1)
    diamondTitleBg:setPosition(cc.p(0, (display.top-1250)/2))
    diamondTitleBg:addTo(ShopLayer)
    --文字：钻石商店
    local diamondStoreText = ccui.ImageView:create("ui/hall/shop/Diamond-shop/Title-diamond_store.png")
    diamondStoreText:setAnchorPoint(0.5, 0.5)
    diamondStoreText:addTo(diamondTitleBg)
    diamondStoreText:setPosition(cc.p(display.cx,35))

    self:createDiamondItem(ShopLayer,"ui/hall/shop/Diamond-shop/bg-normal.png","ui/hall/shop/Diamond-shop/TreasureChest - normal.png"
    ,"150",0,0)
    self:createDiamondItem(ShopLayer,"ui/hall/shop/Diamond-shop/bg-rare.png","ui/hall/shop/Diamond-shop/TreasureChest - RARE.png"
    ,"250",230,0)
    self:createDiamondItem(ShopLayer,"ui/hall/shop/Diamond-shop/bg-epic.png","ui/hall/shop/Diamond-shop/TreasureChest - Epic.png"
    ,"750",460,0)
    self:createDiamondItem(ShopLayer,"ui/hall/shop/Diamond-shop/bg-legend.png","ui/hall/shop/Diamond-shop/TreasureChest - Legend.png"
    ,"2500",230,-320)

    return ShopLayer
end


--[[
    函数用途：金币商店商品的展示
    --]]
function ShopScene:createGoldItem(layer,path,fragNum,price,offsetX,offsetY)--层级、图片路径、碎片数量、价格、偏移量

    --按钮：商品1
    local ItemButton = ccui.Button:create(path, path, path)
    ItemButton:setPosition(cc.p(370+offsetX, display.top-920+offsetY))
    ItemButton:addTouchEventListener(function(sender,eventType)--按钮点击后放大缩小特效
        if eventType == ccui.TouchEventType.began then
            local scale = cc.ScaleTo:create(1,0.9)
            local ease_elastic = cc.EaseElasticOut:create(scale)
            sender:runAction(ease_elastic)

        elseif eventType == ccui.TouchEventType.ended then
            self:goldPurchasePanel(layer,path,fragNum,price)
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

    --图标：碎片数量背景
    local fragmentBg =ccui.ImageView:create("ui/hall/shop/Goldcoin-shop/bg-fragment_number.png")
    fragmentBg:setPosition(cc.p(110, 170))
    fragmentBg:addTo(ItemButton)
    --文本：碎片数量
    local fragmentNum = cc.Label:createWithTTF(fragNum,"ui/font/fzbiaozjw.ttf",19)
    fragmentNum:setPosition(cc.p(45,15))
    fragmentNum:setColor(cc.c3b(255, 206, 55))
    --fragmentNum:enableShadow(cc.c3b(0,0,0), cc.size(2,-2), 100)--字体描边有待学习
    fragmentNum:addTo(fragmentBg)
    --图标：金币图标
    local goldCoinIcon =ccui.ImageView:create("ui/hall/shop/Goldcoin-shop/PriceIcon-gold_coins.png")
    goldCoinIcon:setPosition(cc.p(50, 30))
    goldCoinIcon:addTo(ItemButton)
    --文本：价格
    local priceNum = cc.Label:createWithTTF(price,"ui/font/fzbiaozjw.ttf",25)
    priceNum:setPosition(cc.p(95,30))
    priceNum:setColor(cc.c3b(255, 255, 255))
    --priceNum:enableShadow(cc.c3b(0,0,0), cc.size(2,-2), 100)--字体描边有待学习
    priceNum:addTo(ItemButton)


end


--[[
    函数用途：钻石商店商品的展示
    --]]
function ShopScene:createDiamondItem(layer,bgPath,treasurePath,price,offsetX,offsetY)--层级、背景图路径、宝箱图路径、价格、偏移量
    --按钮：商品
    local ItemButton = ccui.Button:create(bgPath, bgPath, bgPath)
    ItemButton:setPosition(cc.p(130+offsetX, display.top-1500+offsetY))
    ItemButton:addTouchEventListener(function(sender,eventType)--按钮点击后放大缩小特效
        if eventType == ccui.TouchEventType.began then
            local scale = cc.ScaleTo:create(1,0.9)
            local ease_elastic = cc.EaseElasticOut:create(scale)
            sender:runAction(ease_elastic)

        elseif eventType == ccui.TouchEventType.ended then
            self:purchasePanel()
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

    --图标：宝箱图标
    local treasureIcon =ccui.ImageView:create(treasurePath)
    treasureIcon:setPosition(cc.p(105, 140))
    treasureIcon:addTo(ItemButton)
    --图标：钻石图标
    local diamondIcon =ccui.ImageView:create("ui/hall/shop/Diamond-shop/PriceIcon-Diamond.png")
    diamondIcon:setPosition(cc.p(70, 40))
    diamondIcon:addTo(ItemButton)
    --文本：价格
    local priceNum = cc.Label:createWithTTF(price,"ui/font/fzbiaozjw.ttf",25)
    priceNum:setPosition(cc.p(120,40))
    priceNum:setColor(cc.c3b(255, 255, 255))
    --priceNum:enableShadow(cc.c3b(0,0,0), cc.size(2,-2), 100)--字体描边有待学习
    priceNum:addTo(ItemButton)
end

--[[
    函数用途：二级弹窗-金币商店购买页面
    --]]
function ShopScene:goldPurchasePanel(layer,path,fragNum,price)--图片路径，碎片数量，金额
    local width ,height = display.width,display.height
    --层：灰色背景
    local purchaseLayer = ccui.Layout:create()
    purchaseLayer:setBackGroundColor(cc.c4b(0,0,0,128))
    purchaseLayer:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)--设置颜色模式
    purchaseLayer:setBackGroundColorOpacity(128)--设置透明度
    purchaseLayer:setContentSize(width, height)
    purchaseLayer:pos(width*0.5, height *0.5)
    purchaseLayer:setAnchorPoint(0.5, 0.5)
    purchaseLayer:addTo(self)
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
    --fragmentNum:enableShadow(cc.c3b(0,0,0), cc.size(2,-2), 100)--字体描边有待学习
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
    --priceNum:enableShadow(cc.c3b(0,0,0), cc.size(2,-2), 100)--字体描边有待学习
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




function ShopScene:createMiddleMiddlePanel()
    local width ,height  =display.width,display.top
    local settingLayer = ccui.Layout:create()
    settingLayer:setBackGroundImage("ui/hall/shop/bg-StoreInterface.png")
    settingLayer:setContentSize(width,height)
    settingLayer:setAnchorPoint(0.5,0.5)
    settingLayer:setPosition(width*0.5,height*0.5)

    settingLayer:addTo(self)

end

function ShopScene:createMiddleBottomPanel()
    local width,height = display.width,display.top
    local menuLayer = ccui.Layout:create()
    menuLayer:setContentSize(width,height)
    menuLayer:setAnchorPoint(0,0)
    menuLayer:setPosition(0,0)

    menuLayer:addTo(self)
    --商店
    local shopBtn = ccui.Button:create(
            "ui/hall/bottom-tab/tab-unselected-left.png",
            "ui/hall/bottom-tab/tab-selected.png",
            "ui/hall/bottom-tab/tab-unselected-left.png"
    )
    shopBtn:setAnchorPoint(0,0)
    shopBtn:setScale(240/230)
    shopBtn:pos(0,0)
    shopBtn:addTo(menuLayer)

    shopBtn:addTouchEventListener(function(sender, eventType)
        if 2 == eventType then
            local shopScene=import("app/scenes/ShopScene"):new()
            display.replaceScene(shopScene)
        end
    end)
    --对战
    local battleBtn = ccui.Button:create(
            "ui/hall/bottom-tab/tab-unselected-middle.png",
            "ui/hall/bottom-tab/tab-selected.png",
            "ui/hall/bottom-tab/tab-unselected-middle.png"
    )
    battleBtn:setAnchorPoint(0,0)
    battleBtn:setScale(240/230)
    battleBtn:pos(0+230*240/230,0)
    battleBtn:addTo(menuLayer)
    --图鉴
    local AtlasBtn = ccui.Button:create(
            "ui/hall/bottom-tab/tab-unselected-right.png",
            "ui/hall/bottom-tab/tab-selected.png",
            "ui/hall/bottom-tab/tab-unselected-right.png"
    )
    AtlasBtn:setAnchorPoint(0,0)
    AtlasBtn:setScale(240/230)
    AtlasBtn:pos(0+230*240/230+230*240/230,0)
    AtlasBtn:addTo(menuLayer)

end
--顶部
function ShopScene:createMiddleTopPanel()
    local width,height = display.width,display.top
    local infoLayer = ccui.Layout:create()
    --infoLayer:setBackGroundImage("ui/hall/Prompt text/bg-topPanel.png")
    infoLayer:setContentSize(width,height)
    infoLayer:setAnchorPoint(0,0)
    infoLayer:setPosition(0,0)

    infoLayer:addTo(self)
    --小背景
    local bgicon=ccui.ImageView:create("ui/hall/Prompt text/bg-topPanel.png")
    bgicon:setScale(1)
    bgicon:setAnchorPoint(0,1)
    bgicon:pos(0,height)
    bgicon:addTo(infoLayer)
    --头像
    local headicon=ccui.ImageView:create("ui/hall/Prompt text/bg-name.png")
    headicon:setScale(1)
    headicon:setAnchorPoint(0,1)
    headicon:pos(0+100,height-20)
    headicon:addTo(infoLayer)
    --第二背景（黑色）
    local bg2icon=ccui.ImageView:create("ui/hall/Prompt text/Default_Avatar.png")
    bg2icon:setScale(1)
    bg2icon:setAnchorPoint(0,1)
    bg2icon:pos(0+10,height-10)
    bg2icon:addTo(infoLayer)
    --名字
    local namelabel=cc.Label:createWithTTF("黑山老妖04","ui/font/fzbiaozjw.ttf",30)
    namelabel:setScale(1)
    namelabel:setAnchorPoint(0,1)
    namelabel:pos(0+150,height-25)
    namelabel:addTo(infoLayer)
    --小奖杯 res\ui\hall\Prompt text\trophy.png
    local trophyicon=ccui.ImageView:create("ui/hall/Prompt text/trophy.png")
    trophyicon:setScale(1)
    trophyicon:setAnchorPoint(0,1)
    trophyicon:pos(0+150,height-70)
    trophyicon:addTo(infoLayer)

    --奖杯数
    local trophylabel=cc.Label:createWithTTF("100","ui/font/fzbiaozjw.ttf",30)
    trophylabel:setScale(1)
    trophylabel:setColor(cc.c3b(255,128,0))
    trophylabel:setAnchorPoint(0,1)
    trophylabel:pos(0+200,height-70)
    trophylabel:addTo(infoLayer)

    --两个小背景
    local bg3icon=ccui.ImageView:create("ui/hall/Prompt text/bg-Base-diamonds &amp; gold coins.png")
    bg3icon:setScale(1)
    bg3icon:setAnchorPoint(0,1)
    bg3icon:pos(0+450,height-25)
    bg3icon:addTo(infoLayer)

    local bg4icon=ccui.ImageView:create("ui/hall/Prompt text/bg-Base-diamonds &amp; gold coins.png")
    bg4icon:setScale(1)
    bg4icon:setAnchorPoint(0,1)
    bg4icon:pos(0+450,height-75)
    bg4icon:addTo(infoLayer)

    --金币
    local coinicon=ccui.ImageView:create("ui/hall/Prompt text/Gold-coin.png")
    coinicon:setScale(1)
    coinicon:setAnchorPoint(0,1)
    coinicon:pos(0+430,height-20)
    coinicon:addTo(infoLayer)

    --钻石
    local diamondicon=ccui.ImageView:create("ui/hall/Prompt text/Diamonds.png")
    diamondicon:setScale(1)
    diamondicon:setAnchorPoint(0,1)
    diamondicon:pos(0+430,height-70)
    diamondicon:addTo(infoLayer)




    -- local shopBtn = ccui.Button:create(
    --     "ui/hall/bottom-tab/tab-unselected-left.png",
    --     "ui/hall/bottom-tab/tab-selected.png",
    --     "ui/hall/bottom-tab/tab-unselected-left.png"
    -- )
    -- shopBtn:setAnchorPoint(0,0)
    -- shopBtn:setScale(240/230)
    -- shopBtn:pos(0,0)
    -- shopBtn:addTo(menuLayer)



end


return ShopScene