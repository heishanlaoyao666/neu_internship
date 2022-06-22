
local ShopScene = class("ShopScene", function()
    return display.newScene("ShopScene")
end)

local M = require("app.scenes.MainScene")
function ShopScene:ctor()
    --self.func = M.new()
    --print("sucess")
    self:createMiddleMiddlePanel()
    self:createMiddleBottomPanel()
    self:createMiddleTopPanel()
    self:goldCoinShop(ShopLayer)
end

--[[
    函数用途：显示金币商店区域
    --]]
function ShopScene:goldCoinShop()
    local width,height = display.width,display.top
    local ShopLayer = ccui.Layout:create()
    --ShopLayer:setBackGroundColorOpacity(180)--设置为半透明
    --ShopLayer:setBackGroundColorType(1)
    ShopLayer:setContentSize(width, height)--占满全屏
    ShopLayer:setPosition(0, display.top-150)--左上角
    ShopLayer:setAnchorPoint(0, 1)
    ShopLayer:addTo(self)
    --标题背景条
    local goldTitleBg = ccui.ImageView:create("ui/hall/shop/Goldcoin-shop/bg-title_block.png")
    goldTitleBg:setAnchorPoint(0, 1)
    goldTitleBg:setPosition(cc.p(0, display.top-50))
    goldTitleBg:addTo(ShopLayer)
    --文字：金币商店
    local goldStoreText = ccui.ImageView:create("ui/hall/shop/Goldcoin-shop/Title - gold_coin_store.png")
    goldStoreText:setAnchorPoint(0.5, 0.5)
    goldStoreText:addTo(goldTitleBg)
    goldStoreText:setPosition(cc.p(display.cx,35))

    --刷新背景条
    local refreshBg = ccui.ImageView:create("ui/hall/shop/Goldcoin-shop/bg-remaining_refresh_time.png")
    refreshBg:setPosition(cc.p(display.cx, display.top-160))
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
    freeItemButton:setPosition(cc.p(150, display.top-310))
    freeItemButton:addTouchEventListener(function(sender,eventType)
        if eventType == ccui.TouchEventType.ended then
            print("buy")
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

    self:createItem(ShopLayer,"ui/hall/shop/Goldcoin-shop/CommodityIcon-tower_fragment/1.png"
    ,"X36","360",0,0)
    self:createItem(ShopLayer,"ui/hall/shop/Goldcoin-shop/CommodityIcon-tower_fragment/4.png"
    ,"X36","360",210,0)
    self:createItem(ShopLayer,"ui/hall/shop/Goldcoin-shop/CommodityIcon-tower_fragment/9.png"
    ,"X36","360",-220,-220)
    self:createItem(ShopLayer,"ui/hall/shop/Goldcoin-shop/CommodityIcon-tower_fragment/10.png"
    ,"X6","600",0,-220)
    self:createItem(ShopLayer,"ui/hall/shop/Goldcoin-shop/CommodityIcon-tower_fragment/12.png"
    ,"X1","1000",210,-220)
end


--[[
    函数用途：商品的展示
    --]]
function ShopScene:createItem(layer,path,fragNum,price,offsetX,offsetY)--层级、图片路径、碎片数量、价格、偏移量
    --按钮：商品1
    local ItemButton = ccui.Button:create(path, path, path)
    ItemButton:setPosition(cc.p(370+offsetX, display.top-310+offsetY))
    ItemButton:addTouchEventListener(function(sender,eventType)--点击事件
        if eventType == ccui.TouchEventType.ended then
            print("buy")
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
--bg-battle_interface.png
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

    --第二背景（黑色）
    local bg2icon=ccui.ImageView:create("ui/hall/Prompt text/bg-name.png")
    bg2icon:setScale(1)
    bg2icon:setAnchorPoint(0,1)
    bg2icon:pos(0+100,height-20)
    bg2icon:addTo(infoLayer)

    --头像

    local headBtn=ccui.Button:create(
            "ui/hall/Prompt text/Default_Avatar.png",
            "",
            "ui/hall/Prompt text/Default_Avatar.png"
    )
    headBtn:setScale(1)
    headBtn:setAnchorPoint(0,1)
    headBtn:pos(0+10,height-10)
    headBtn:addTo(infoLayer)

    headBtn:addTouchEventListener(function(sender, eventType)
        if 2 == eventType then
            local newScene=import("app/scenes/HeadScene"):new()
            display.replaceScene(newScene)
        end
    end)

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
    --金币数
    local coinlabel=cc.Label:createWithTTF("100000","ui/font/fzbiaozjw.ttf",30)
    coinlabel:setScale(1)
    coinlabel:setAnchorPoint(0,1)
    coinlabel:pos(0+480,height-25)
    coinlabel:addTo(infoLayer)

    --钻石数
    local diamondlabel=cc.Label:createWithTTF("1000","ui/font/fzbiaozjw.ttf",30)
    diamondlabel:setScale(1)
    diamondlabel:setAnchorPoint(0,1)
    diamondlabel:pos(0+480,height-75)
    diamondlabel:addTo(infoLayer)

    --设置

    local settingBtn = ccui.Button:create(
            "ui/hall/Prompt text/button-menu.png",
            "",
            "ui/hall/Prompt text/button-menu.png"
    )
    settingBtn:setScale(1)
    settingBtn:setAnchorPoint(0,1)
    settingBtn:pos(0+630,height-35)
    settingBtn:addTo(infoLayer)

    settingBtn:addTouchEventListener(function(sender, eventType)
        if 2 == eventType then
            local newScene=import("app/scenes/??Scene"):new()
            display.replaceScene(newScene)
        end
    end)



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