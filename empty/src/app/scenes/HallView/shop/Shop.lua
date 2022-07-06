local Shop = class("Shop")
local KnapsackData = require("app.data.KnapsackData")
local TopPanel = require("app.scenes.TopPanel")
local GoldPurchaseView = require("app.scenes.HallView.shop.layer.GoldPurchaseView")
local TreasureChestOpenView = require("app.scenes.HallView.common.TreasureChestOpenView")
function Shop:ctor()

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
    --添加滑动事件
    self:slide(ShopLayer)

    --图片：商店背景图
    local Bg = ccui.ImageView:create("ui/hall/shop/bg-StoreInterface.png")
    Bg:setAnchorPoint(0.5, 0.5)
    Bg:setPosition(display.cx,display.cy)
    Bg:addTo(ShopLayer)

    --图片：金币商店标题背景条
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

    --免费商品
    self:freeItem(ShopLayer)

    --金币商店商品排列
    math.randomseed(os.time())
    --银色框360
    local silverArray = {"01","04","07","09","18","20"}
    local offsetX = 0
    for i = 1,2 do
        local index = math.random(1, #silverArray)
        print(index)
        self:createGoldItem(ShopLayer,"ui/hall/shop/Goldcoin-shop/CommodityIcon-tower_fragment/"..silverArray[index]..".png"
        ,36,360,offsetX,0)
        offsetX = offsetX+210
    end

    local silverIndex = math.random(1, #silverArray)
    print(silverIndex)
    self:createGoldItem(ShopLayer,"ui/hall/shop/Goldcoin-shop/CommodityIcon-tower_fragment/"..silverArray[silverIndex]..".png"
    ,36,360,-220,-220)

    --蓝色框600
    local blueArray = {"03","10","14","15"}
    local blueIndex = math.random(1, #blueArray)
    print(blueIndex)
    self:createGoldItem(ShopLayer,"ui/hall/shop/Goldcoin-shop/CommodityIcon-tower_fragment/"..blueArray[blueIndex]..".png"
    ,6,600,0,-220)

    --紫色框1000
    local purpleArray = {"02","08","11","12","16","17"}
    local purpleIndex = math.random(1, #purpleArray)
    print(purpleIndex)
    self:createGoldItem(ShopLayer,"ui/hall/shop/Goldcoin-shop/CommodityIcon-tower_fragment/"..purpleArray[purpleIndex]..".png"
    ,1,1000,210,-220)

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
    , "150",0,0,"X38","X7","X1","X0","+285")
    self:createDiamondItem(ShopLayer,"ui/hall/shop/Diamond-shop/bg-rare.png","ui/hall/shop/Diamond-shop/TreasureChest - RARE.png"
    ,"250",230,0,"X74","X14","X2","X0","+456")
    self:createDiamondItem(ShopLayer,"ui/hall/shop/Diamond-shop/bg-epic.png","ui/hall/shop/Diamond-shop/TreasureChest - Epic.png"
    ,"750",460,0,"X139","X36","X7","X0~1","+1280")
    self:createDiamondItem(ShopLayer,"ui/hall/shop/Diamond-shop/bg-legend.png","ui/hall/shop/Diamond-shop/TreasureChest - Legend.png"
    ,"2500",230,-320,"X187","X51","X21","X1","+3040")

    return ShopLayer
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
end
--[[
    函数用途：滑动商店触摸事件
    参数：层
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
    函数用途：滑动动作
    参数：层，移动距离
    --]]
function Shop:slideShop(layer,distance)
    local moveAction = cc.MoveBy:create(0.5,cc.p(0,distance))
    layer:runAction(moveAction)
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

--[[
    函数用途：金币商店商品的展示:
    参数：层，商品图片路径，碎片数量，商品价格，位置偏移的X,Y
    --]]
function Shop:createGoldItem(layer,path,fragNum,price,offsetX,offsetY)
    --按钮：商品
    local ItemButton = ccui.Button:create(path, path, path)
    ItemButton:setPosition(cc.p(370+offsetX, display.top-310+offsetY))
    ItemButton:addTouchEventListener(function(sender,eventType)--按钮点击后放大缩小特效
        if eventType == ccui.TouchEventType.began then
            local scale = cc.ScaleTo:create(1,0.9)
            local ease_elastic = cc.EaseElasticOut:create(scale)
            sender:runAction(ease_elastic)

        elseif eventType == ccui.TouchEventType.ended then
            GoldPurchaseView:goldPurchasePanel(layer,path,fragNum,price,ItemButton)
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
    ItemButton:addTo(layer)

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
end

--[[
    函数用途：钻石商店商品的展示:
    参数：层，宝箱背景图路径，宝箱图标路径，宝箱类型路径，宝箱价格，位置的偏移X,Y
    ，普通卡数量，稀有卡数量，史诗卡数量，传说卡数量，可获得金币数量
    --]]
function Shop:createDiamondItem(layer,bgPath,treasurePath,price,offsetX,offsetY
,nCardNum,rCardNum,eCardNum,lCardNum,coinNum)
    --按钮：商品
    local ItemButton = ccui.Button:create(bgPath, bgPath, bgPath)
    ItemButton:setPosition(cc.p(130+offsetX, display.top-900+offsetY))
    ItemButton:addTouchEventListener(function(sender,eventType)--按钮点击后放大缩小特效
        if eventType == ccui.TouchEventType.began then
            local scale = cc.ScaleTo:create(1,0.9)
            local ease_elastic = cc.EaseElasticOut:create(scale)
            sender:runAction(ease_elastic)

        elseif eventType == ccui.TouchEventType.ended then
            TreasureChestOpenView:treasureChestOpenConfirmPanel(layer,treasurePath,treasureType
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



return Shop