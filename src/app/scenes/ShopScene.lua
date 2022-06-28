--[[--
    ShopScene.lua

    描述：商店场景
]]
local StoreList = require"app.StoreList"

local ShopScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

local shopLayer_
local _buttonCoinClik
local _buttonCoinClikGrey
local _checkBuy

--[[--
    描述：初始化函数

    @param layer

    @return none
]]
function ShopScene:ctor(layer, num)
    local shopLayer = self:createShopLayer()
    shopLayer:addTo(layer, num)
end

--[[--
    描述：音乐音效加载

    @param none

    @return none
]]
local audio_ = require"framework.audio"
function ShopScene:loadMusic()
    audio_.loadFile("sound_ogg/get_free_item.ogg",function (dt) end)
    audio_.loadFile("sound_ogg/get_paid_item.ogg",function (dt) end)
    audio_.loadFile("sound_ogg/open_box.ogg",function (dt) end)
    audio_.loadFile("sound_ogg/buy_paid_item.ogg",function (dt) end)
end

--[[--
    描述：金币商城按钮点击事件(点击后弹出二级界面)

    @param layer

    @return none
]]
function _buttonCoinClik(layer, itemWidth, itemHeight)
    print("clik")
    layer:scale(1)
    _checkBuy(layer, itemWidth, itemHeight)
end

--[[--
    描述：金币商城按钮点击事件(点击后置灰)

    @param layer

    @return none
]]
function _buttonCoinClikGrey(layer, itemWidth, itemHeight)
    -- 遮罩
    local shadeSprite = cc.Sprite:create(
        "home/shop/coins_shop/base_shade.png")
    shadeSprite:setPosition(itemWidth*2/3, itemHeight/2)
    shadeSprite:setAnchorPoint(0.5, 0.5)
    shadeSprite:setOpacity(120)
    shadeSprite:addTo(layer)
end

--[[--
    描述：二级界面确认购买信息获取模拟
]]
function _checkBuy(layer, itemWidth, itemHeight)
    -- 弹出二级界面确认
    local checkButton = ccui.Button:create("home/shop/second_purchase_confirmation_popup/button_buy.png")
    checkButton:setAnchorPoint(0.5, 0.5)
    checkButton:setPosition(itemWidth*2/3, itemHeight/2)
    checkButton:scale(0.25)
    checkButton:addTo(layer)
    checkButton:addTouchEventListener(function (sender, eventType)
        --checkButton:setTouchEnabled(false)
        checkButton:removeFromParent()
        _buttonCoinClikGrey(layer, itemWidth, itemHeight)
        audio_.playEffect("sound_ogg/buy_paid_item.ogg", false)
    end)

    local checkLayer = ccui.Layout:create()
    checkLayer:setBackGroundColor(cc.c4b(0,0,0,100))
    checkLayer:setBackGroundColorType(1)
    checkLayer:opacity(200)
    checkLayer:setAnchorPoint(0.5, 0.5)
    checkLayer:setPosition(display.cx, display.cy)
    checkLayer:setContentSize(display.width, display.height)
    checkLayer:addTo(layer:getParent():getParent():getParent(), 5)
    -- 设置层可触摸屏蔽下方按键
    checkLayer:setTouchEnabled(true)
    checkLayer:addTouchEventListener(function (sender, eventType)
        if 2 == eventType then
            audio_.playEffect("sound_ogg/ui_btn_click.ogg")
            checkLayer:removeFromParent()
        end
    end)

--[[
    local checkBase = cc.Sprite:create("home/top_player_info/second_setting/base_popup.png")
    checkBase:setAnchorPoint(0.5, 0.5)
    checkBase:setPosition(display.cx, display.cy)
    checkBase:addTo(checkLayer)
    local sizeSetBase = checkBase:getContentSize()

    local checkClose = ccui.Button:create("home/top_player_info/second_setting/button_close.png")
    checkClose:setAnchorPoint(0.5, 0.5)
    checkClose:setPosition(display.cx + sizeSetBase.width/2 - sizeSetBase.width/17, display.cy + sizeSetBase.height/2 - sizeSetBase.height/10)
    checkClose:addTo(checkLayer)
    checkClose:addTouchEventListener(function (sender, eventType)
        if 2 == eventType then
            audio_.playEffect("sound_ogg/ui_btn_click.ogg")
            checkLayer:removeFromParent()
        end
    end)

    -- 遮罩，屏蔽点击退出触摸事件
    local baseMaskLayer = ccui.Layout:create()
    baseMaskLayer:setAnchorPoint(0.5, 0.5)
    baseMaskLayer:setPosition(display.cx, display.cy)
    baseMaskLayer:setContentSize(sizeSetBase.width, sizeSetBase.height)
    baseMaskLayer:setTouchEnabled(true)
    baseMaskLayer:addTo(checkLayer, -1)
]]
end

--[[--
    描述：商店场景创建

    @param none

    @return layer
]]
function ShopScene:createShopLayer()
    self:loadMusic()

    shopLayer_ = ccui.Layout:create()
    shopLayer_:setBackGroundImage("home/shop/background_shop.png")
    shopLayer_:setPosition(display.width/2, display.height/2)
    shopLayer_:setAnchorPoint(0.5, 0.5)
    shopLayer_:setContentSize(display.width, display.height)

    -- 滑动区域
    local itemWidth, itemHeight = display.width/5, display.height/6
    local listView = ccui.ListView:create()
    listView:setContentSize(display.width, display.height*7/8)      -- 滑动区域大小
    listView:setAnchorPoint(0.5, 0.5)
    listView:setPosition(display.cx, display.cy)
    listView:setDirection(1)        -- 垂直
    listView:addTo(shopLayer_)

    local dragonNum = 0

    for i = 1, 8 do
        -- 层存放每列数据
        local colLayer = ccui.Layout:create()
        colLayer:addTo(listView)

        if i == 1 then
            colLayer:setContentSize(display.width, itemHeight*3/4)
            -- 金币商店
            local coinTitleBase = cc.Sprite:create("home/shop/coins_shop/base_title.png")
            coinTitleBase:setPosition(display.cx, itemHeight/8)
            coinTitleBase:setAnchorPoint(0.5, 0.5)
            --coinTitleBase:scale(display.width / 720)
            coinTitleBase:addTo(colLayer)

            local coinTitle = cc.Sprite:create("home/shop/coins_shop/title_coin_store.png")
            coinTitle:setPosition(display.cx, itemHeight/8)
            coinTitle:setAnchorPoint(0.5, 0.5)
            --coinTitle:scale(display.width / 720)
            coinTitle:addTo(colLayer)

        elseif i == 2 then
            colLayer:setContentSize(display.width, itemHeight*5/12)
            -- 商品刷新提示
            local refreshBase = cc.Sprite:create("home/shop/coins_shop/base_remaining_refresh_time.png")
            refreshBase:setPosition(display.cx, itemHeight/5)
            refreshBase:setAnchorPoint(0.5, 0.5)
            --refreshBase:scale(display.width / 720)
            refreshBase:addTo(colLayer)

            local refreshTitle = cc.Sprite:create("home/shop/coins_shop/tips_remaining_refresh_time.png")
            refreshTitle:setPosition(display.cx *8/7, itemHeight/5)
            refreshTitle:setAnchorPoint(1, 0.5)
            --refreshTitle:scale(display.width / 720)
            refreshTitle:addTo(colLayer)

            local refreshText = display.newTTFLabel({
                text = "03:13",
                font = "font/fzbiaozjw.ttf",
                size = 30,
            })
            refreshText:setAnchorPoint(0, 0.5)
            refreshText:setPosition(display.cx *11/9, itemHeight/5)
            refreshText:setColor(cc.c3b(255, 206, 55))
            refreshText:enableOutline(cc.c4b(0,0,0,255),1)
            refreshText:addTo(colLayer)

        elseif i>2 and i<5 then
            colLayer:setContentSize(display.width, itemHeight)
            -- 滑动区域
            local rowViewDragon = ccui.ListView:create()
            rowViewDragon:setContentSize(itemWidth*13/3, itemHeight+20)      -- 滑动区域大小
            rowViewDragon:setAnchorPoint(0.5, 0.5)
            rowViewDragon:setPosition(display.cx, itemHeight/2)
            rowViewDragon:setDirection(2)        -- 水平
            rowViewDragon:addTo(colLayer)
            for j = 1, 3 do
                -- 层存放每行数据
                local rowLayer = ccui.Layout:create()
                rowLayer:setAnchorPoint(0.5, 0.5)
                rowLayer:setContentSize(itemWidth*13/9, itemHeight)
                rowLayer:addTo(rowViewDragon)
                if dragonNum == 0 then
                    ---------------------------------------------------------------------
                    -- 免费钻石
                    local freeButton = ccui.Button:create(
                        "home/shop/coins_shop/base_free_merchandise.png")
                    dragonNum = dragonNum + 1
                    freeButton:setPosition(itemWidth*2/3, itemHeight/2)
                    freeButton:setAnchorPoint(0.5, 0.5)
                    local size = freeButton:getContentSize()
                    --freeButton:scale(itemHeight/size.height)
                    freeButton:addTo(rowLayer)

                    local freeTitle = cc.Sprite:create(
                        "home/shop/coins_shop/icon_free.png")
                    freeTitle:setPosition(itemWidth*2/3, itemHeight/6)
                    freeTitle:setAnchorPoint(0.5, 0.5)
                    local size = freeTitle:getContentSize()
                    --freeTitle:scale(itemHeight / size.height /6)
                    freeTitle:addTo(rowLayer)

                    local diaIcon = cc.Sprite:create(
                        "home/shop/coins_shop/commodity_icon_diamond.png")
                    diaIcon:setPosition(itemWidth*2/3, itemHeight/5*3)
                    diaIcon:setAnchorPoint(0.5, 0.5)
                    local size = diaIcon:getContentSize()
                    --diaIcon:scale(itemHeight / size.height /3 - 0.1)
                    diaIcon:addTo(rowLayer)

                    local diaNum = display.newTTFLabel({
                        text = "x100",
                        font = "font/fzbiaozjw.ttf",
                        size = 24
                    })
                    diaNum:align(display.CENTER, itemWidth*2/3, itemHeight/3)
                    diaNum:setColor(cc.c3b(173, 196, 255))
                    diaNum:enableOutline(cc.c4b(0,0,0,255),1)
                    diaNum:addTo(rowLayer)

                    -- 点击事件
                    freeButton:addTouchEventListener(function (sender, eventType)
                        if 0 == eventType then
                            print("0")
                            rowLayer:scale(0.8)
                        end
                        if 2 == eventType then
                            print("2")
                            audio_.playEffect("sound_ogg/get_free_item.ogg")
                            --freeButton:setTouchEnabled(false)
                            rowLayer:scale(1)
                        end
                    end)
                else
                    ---------------------------------------------------------------------
                    -- 商品塔
                    local dragon = StoreList.DRAGON_LIST[dragonNum]
                    if dragon == nil then
                        print("dragonNum", dragonNum)
                        print("dragon", StoreList.DRAGON_LIST[dragonNum])
                    else
                        print(dragon["id"], dragon.type)
                        local dragonButton = ccui.Button:create(
                            "home/shop/coins_shop/commodity_icon_tower_fragment/"
                            ..dragon["id"]..".png")
                        dragonNum = dragonNum + 1
                        dragonButton:setPosition(itemWidth*2/3, itemHeight/2)
                        dragonButton:setAnchorPoint(0.5, 0.5)
                        local size = dragonButton:getContentSize()
                        --dragonButton:scale(itemHeight/size.height)
                        dragonButton:addTo(rowLayer)

                        -- 金币图标
                        local coinIcon = cc.Sprite:create(
                            "home/shop/coins_shop/icon_coin.png")
                        if dragon.type == "epic" then
                            coinIcon:setPosition(itemWidth*2/3 - 30, itemHeight/6)
                        else
                            coinIcon:setPosition(itemWidth*2/3 - 23, itemHeight/6)
                        end
                        coinIcon:setAnchorPoint(0.5, 0.5)
                        local sizeCoin = coinIcon:getContentSize()
                        --coinIcon:scale(itemHeight / sizeCoin.height /6)
                        coinIcon:addTo(rowLayer)

                        -- 价格
                        local dragonPrice = display.newTTFLabel({
                            text = StoreList.TYPE_PRICE[dragon.type],
                            font = "font/fzbiaozjw.ttf",
                            size = 25
                        })
                        dragonPrice:align(display.CENTER, itemWidth*4/5, itemHeight/6)
                        dragonPrice:setColor(cc.c3b(255,255,255))
                        dragonPrice:enableOutline(cc.c4b(0,0,0,255),1)
                        dragonPrice:addTo(rowLayer)

                        --碎片底图
                        local fragmentBase = cc.Sprite:create(
                            "home/shop/coins_shop/base_fragments_number.png")
                        fragmentBase:setPosition(size.width*20/19, itemHeight*5/6)
                        fragmentBase:setAnchorPoint(1, 0.5)
                        local size = fragmentBase:getContentSize()
                        --fragmentBase:scale(itemHeight / size.height /6)
                        fragmentBase:addTo(rowLayer)

                        -- 碎片数量
                        local fragmentNum = display.newTTFLabel({
                            text = "x"..dragon.number,
                            font = "font/fzzchjw.ttf",
                            size = 19
                        })
                        fragmentNum:align(display.CENTER, size.width*2, itemHeight*5/6)
                        fragmentNum:setColor(cc.c3b(255,206,55))
                        fragmentNum:enableOutline(cc.c4b(0,0,0,255),1)
                        fragmentNum:addTo(rowLayer)

                        -- 点击事件
                        dragonButton:addTouchEventListener(function (sender, eventType)
                            if 0 == eventType then
                                rowLayer:scale(0.8)
                            end
                            if 2 == eventType then
                                dragonButton:setTouchEnabled(false)
                                audio_.playEffect("sound_ogg/get_paid_item.ogg")
                                _buttonCoinClik(rowLayer, itemWidth, itemHeight)
                            end
                        end)
                    end
                end
            end

        elseif i == 5 then
            colLayer:setContentSize(display.width, itemHeight*2/3)
            -- 钻石商店
            local diaTitleBase = cc.Sprite:create("home/shop/diamond_shop/base_title.png")
            diaTitleBase:setPosition(display.cx, itemHeight*5/12)
            diaTitleBase:setAnchorPoint(0.5, 0.5)
            --diaTitleBase:scale(display.width / 720)
            diaTitleBase:addTo(colLayer)

            local diaTitle = cc.Sprite:create("home/shop/diamond_shop/title_diamond_store.png")
            diaTitle:setPosition(display.cx, itemHeight*5/12)
            diaTitle:setAnchorPoint(0.5, 0.5)
            --diaTitle:scale(display.width / 720)
            diaTitle:addTo(colLayer)

        else
            --商品宝箱
            local rowLayer = ccui.Layout:create()
            rowLayer:setAnchorPoint(0.5, 0.5)
            rowLayer:setContentSize(itemWidth*9/2, itemHeight*3/2)
            rowLayer:pos(display.cx, itemHeight/2)
            rowLayer:addTo(colLayer)

            if i == 6 then
                ---------------------------------------------------------------------
                --稀有宝箱层
                local rowRareLayer = ccui.Layout:create()
                rowRareLayer:setAnchorPoint(0.5, 0.5)
                rowRareLayer:setContentSize(itemWidth*9/2, itemHeight*3/2)
                rowRareLayer:pos(display.cx, itemHeight/2)
                rowRareLayer:addTo(colLayer)

                colLayer:setContentSize(display.width, itemHeight)

                -- 稀有宝箱
                local boxRareButton = ccui.Button:create(
                    "home/shop/diamond_shop/base_rare.png")
                boxRareButton:setPosition(itemWidth*9/4, itemHeight*3/4)
                boxRareButton:setAnchorPoint(0.5, 0.5)
                boxRareButton:addTo(rowRareLayer)

                local boxRare = cc.Sprite:create(
                    "home/shop/diamond_shop/box_rare.png")
                boxRare:setPosition(itemWidth*9/4, itemHeight*3/4)
                boxRare:setAnchorPoint(0.5, 0.5)
                boxRare:addTo(rowRareLayer)

                local boxRareDia = cc.Sprite:create(
                    "home/shop/diamond_shop/commodity_icon_diamond.png")
                boxRareDia:setPosition(itemWidth*9/4 - itemHeight/20, itemHeight/4)
                boxRareDia:setAnchorPoint(1, 0.5)
                boxRareDia:addTo(rowRareLayer)

                local boxRarePrice = display.newTTFLabel({
                    text = "250",
                    font = "font/fzbiaozjw.ttf",
                    size = 25
                })
                boxRarePrice:align(display.LEFT_CENTER, itemWidth*9/4, itemHeight/4)
                boxRarePrice:setColor(cc.c3b(255,255,255))
                boxRarePrice:enableOutline(cc.c4b(15,16,59,255),1)
                boxRarePrice:enableShadow(cc.c4b(17,17,60,255), cc.size(0,-2), 1)
                boxRarePrice:addTo(rowRareLayer)

                -- 点击事件
                boxRareButton:addTouchEventListener(function (sender, eventType)
                    if 0 == eventType then
                        rowRareLayer:scale(0.8)
                    end
                    if 2 == eventType then
                        --boxRareButton:setTouchEnabled(false)
                        audio_.playEffect("sound_ogg/open_box.ogg")
                        rowRareLayer:scale(1)
                    end
                end)
                ---------------------------------------------------------------------
                --普通宝箱层
                local rowNormalLayer = ccui.Layout:create()
                rowNormalLayer:setAnchorPoint(0.5, 0.5)
                rowNormalLayer:setContentSize(itemWidth*9/2, itemHeight*3/2)
                rowNormalLayer:pos(display.cx/2, itemHeight/2)
                rowNormalLayer:addTo(colLayer)

                colLayer:setContentSize(display.width, itemHeight)

                -- 普通宝箱
                local boxNormalButton = ccui.Button:create(
                    "home/shop/diamond_shop/base_normal.png")
                boxNormalButton:setPosition(itemWidth*21/11, itemHeight*3/4)
                boxNormalButton:setAnchorPoint(0.5, 0.5)
                boxNormalButton:addTo(rowNormalLayer)

                local boxNormal = cc.Sprite:create(
                    "home/shop/diamond_shop/box_nomal.png")
                boxNormal:setPosition(itemWidth*21/11, itemHeight*3/4)
                boxNormal:setAnchorPoint(0.5, 0.5)
                boxNormal:addTo(rowNormalLayer)

                local boxNormalDia = cc.Sprite:create(
                    "home/shop/diamond_shop/commodity_icon_diamond.png")
                boxNormalDia:setPosition(itemWidth*21/11 - itemHeight/20, itemHeight/4)
                boxNormalDia:setAnchorPoint(1, 0.5)
                boxNormalDia:addTo(rowNormalLayer)

                local boxNormalPrice = display.newTTFLabel({
                    text = "150",
                    font = "font/fzbiaozjw.ttf",
                    size = 25
                })
                boxNormalPrice:align(display.LEFT_CENTER, itemWidth*21/11, itemHeight/4)
                boxNormalPrice:setColor(cc.c3b(255,255,255))
                boxNormalPrice:enableOutline(cc.c4b(15,16,59,255),1)
                boxNormalPrice:enableShadow(cc.c4b(17,17,60,255), cc.size(0,-2), 1)
                boxNormalPrice:addTo(rowNormalLayer)

                -- 点击事件
                boxNormalButton:addTouchEventListener(function (sender, eventType)
                    if 0 == eventType then
                        rowNormalLayer:scale(0.8)
                    end
                    if 2 == eventType then
                        --boxNormalButton:setTouchEnabled(false)
                        audio_.playEffect("sound_ogg/open_box.ogg")
                        rowNormalLayer:scale(1)
                    end
                end)

                ---------------------------------------------------------------------
                --史诗宝箱层
                local rowEpicLayer = ccui.Layout:create()
                rowEpicLayer:setAnchorPoint(0.5, 0.5)
                rowEpicLayer:setContentSize(itemWidth*9/2, itemHeight*3/2)
                rowEpicLayer:pos(display.cx/2*3, itemHeight/2)
                rowEpicLayer:addTo(colLayer)

                colLayer:setContentSize(display.width, itemHeight)

                -- 史诗宝箱
                local boxEpicButton = ccui.Button:create(
                    "home/shop/diamond_shop/base_epic.png")
                boxEpicButton:setPosition(itemWidth*13/5 , itemHeight*3/4)
                boxEpicButton:setAnchorPoint(0.5, 0.5)
                boxEpicButton:addTo(rowEpicLayer)

                local boxEpic = cc.Sprite:create(
                    "home/shop/diamond_shop/box_epic.png")
                boxEpic:setPosition(itemWidth*13/5, itemHeight*3/4)
                boxEpic:setAnchorPoint(0.5, 0.5)
                boxEpic:addTo(rowEpicLayer)

                local boxEpicDia = cc.Sprite:create(
                    "home/shop/diamond_shop/commodity_icon_diamond.png")
                boxEpicDia:setPosition(itemWidth*13/5 - itemHeight/20, itemHeight/4)
                boxEpicDia:setAnchorPoint(1, 0.5)
                boxEpicDia:addTo(rowEpicLayer)

                local boxEpicPrice = display.newTTFLabel({
                    text = "750",
                    font = "font/fzbiaozjw.ttf",
                    size = 25
                })
                boxEpicPrice:align(display.LEFT_CENTER, itemWidth*13/5, itemHeight/4)
                boxEpicPrice:setColor(cc.c3b(255,255,255))
                boxEpicPrice:enableOutline(cc.c4b(15,16,59,255),1)
                boxEpicPrice:enableShadow(cc.c4b(17,17,60,255), cc.size(0,-2), 1)
                boxEpicPrice:addTo(rowEpicLayer)

                -- 点击事件
                boxEpicButton:addTouchEventListener(function (sender, eventType)
                    if 0 == eventType then
                        rowEpicLayer:scale(0.8)
                    end
                    if 2 == eventType then
                        --boxEpicButton:setTouchEnabled(false)
                        audio_.playEffect("sound_ogg/open_box.ogg")
                        rowEpicLayer:scale(1)
                    end
                end)

            elseif i == 7 then
                ---------------------------------------------------------------------
                --传说宝箱层
                local rowLegendLayer = ccui.Layout:create()
                rowLegendLayer:setAnchorPoint(0.5, 0.5)
                rowLegendLayer:setContentSize(itemWidth*9/2, itemHeight*7/4)
                rowLegendLayer:pos(display.cx, itemHeight/2)
                rowLegendLayer:addTo(colLayer)

                colLayer:setContentSize(display.width, itemHeight)

                --传说宝箱
                colLayer:setContentSize(display.width, itemHeight+80)
                local boxLengendButton = ccui.Button:create(
                    "home/shop/diamond_shop/base_legend.png")
                boxLengendButton:setPosition(itemWidth*9/4, itemHeight*3/4)
                boxLengendButton:setAnchorPoint(0.5, 0.5)
                boxLengendButton:addTo(rowLegendLayer)

                local boxLengend = cc.Sprite:create(
                    "home/shop/diamond_shop/box_legend.png")
                boxLengend:setPosition(itemWidth*9/4, itemHeight*3/4)
                boxLengend:setAnchorPoint(0.5, 0.5)
                boxLengend:addTo(rowLegendLayer)

                local boxLengendDia = cc.Sprite:create(
                    "home/shop/diamond_shop/commodity_icon_diamond.png")
                boxLengendDia:setPosition(itemWidth*9/4-30 - itemHeight/20, itemHeight/5)
                boxLengendDia:setAnchorPoint(0.5, 0.5)
                boxLengendDia:addTo(rowLegendLayer)

                local boxLegendPrice = display.newTTFLabel({
                    text = "2500",
                    font = "font/fzbiaozjw.ttf",
                    size = 25
                })
                boxLegendPrice:align(display.CENTER, itemWidth*9/4 + 20, itemHeight/5)
                boxLegendPrice:setColor(cc.c3b(255,255,255))
                boxLegendPrice:enableOutline(cc.c4b(15,16,59,255),1)
                boxLegendPrice:enableShadow(cc.c4b(17,17,60,255), cc.size(0,-2), 1)
                boxLegendPrice:addTo(rowLegendLayer)

                -- 点击事件
                boxLengendButton:addTouchEventListener(function (sender, eventType)
                    if 0 == eventType then
                        rowLegendLayer:scale(0.8)
                    end
                    if 2 == eventType then
                        --boxLengendButton:setTouchEnabled(false)
                        audio_.playEffect("sound_ogg/open_box.ogg")
                        rowLegendLayer:scale(1)
                    end
                end)
            else
                colLayer:setContentSize(display.width, itemHeight)
            end
        end
    end


    return shopLayer_
end

return ShopScene