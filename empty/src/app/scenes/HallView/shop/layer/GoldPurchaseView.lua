----内容：二级界面 - 金币商店购买确认弹窗
----编写人员：郑蕾
---修订人员：郑蕾
---最后修改日期：7/13
local GoldPurchaseView = {}
local KnapsackData = require("app.data.KnapsackData")
local GeneralView = require("app.scenes.HallView.common.GeneralView")
--[[
    函数用途：二级界面-金币商店购买确认弹窗
    参数：层，图片路径，碎片数量，金额，所属商品
--]]
function GoldPurchaseView:goldPurchasePanel(ShopLayer,index,fragNum,price,shade,ItemButton,i)
    --灰色背景
    local grayLayer = self:grayLayer(ShopLayer)

    --图片：弹窗背景
    local popLayer = ccui.ImageView:create("ui/hall/shop/SecondaryInterface-Goldcoin_store_purchase_confirmation_pop-up/bg-pop-up.png")
    popLayer:pos(display.cx, display.cy)
    popLayer:setAnchorPoint(0.5, 0.5)
    popLayer:addTo(grayLayer)
    --图片：商品图
    local path = "ui/hall/shop/Goldcoin-shop/CommodityIcon-tower_fragment/"..index..".png"
    local ItemBg =ccui.ImageView:create(path)
    ItemBg:setScale(0.8,0.8)
    ItemBg:setPosition(cc.p(display.cx-90, 185))
    ItemBg:addTo(popLayer)
    --文本：碎片数量
    local fragmentNum = cc.Label:createWithTTF("X"..fragNum,"ui/font/fzbiaozjw.ttf",25)
    fragmentNum:setPosition(cc.p(80,30))
    fragmentNum:setColor(cc.c3b(255, 206, 55))
    fragmentNum:enableOutline(cc.c4b(0, 0, 0, 255),1)--字体描边
    fragmentNum:addTo(ItemBg)

    --获取卡牌ID
    local id = tonumber(string.sub(path,57,-5))

    --确认按钮
    self:confirmButton(grayLayer,popLayer,price,shade,fragNum,id,ItemButton,i)
    --关闭按钮
    self:closeButton(ShopLayer,grayLayer,popLayer)
end

--[[
    函数用途：创建灰色背景
    参数：层
    --]]
function GoldPurchaseView:grayLayer(ShopLayer)--参数：层
    local width ,height = display.width,display.height
    local grayLayer = ccui.Layout:create()
    grayLayer:setBackGroundColor(cc.c4b(0,0,0,128))
    grayLayer:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)--设置颜色模式
    grayLayer:setBackGroundColorOpacity(128)--设置透明度
    grayLayer:setContentSize(width, height)
    grayLayer:pos(width/2, height/2+140)
    grayLayer:setAnchorPoint(0.5, 0.5)
    grayLayer:addTo(ShopLayer)
    grayLayer:setTouchEnabled(true)--屏蔽一级界面
    return grayLayer
end

--[[
    函数用途：确认按钮
    参数：层，灰色背景，弹窗背景层，金额，所属商品,碎片数量,卡牌ID
    --]]
function GoldPurchaseView:confirmButton(grayLayer,popLayer,price,shade,fragNum,id,ItemButton,i)
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
            if KnapsackData:setGoldCoin(-price) then--如果金币充足
                print("购买后金币数量为"..KnapsackData:getGoldCoin())

                --添加碎片
                KnapsackData:setTowerFragment_(id,fragNum)
                print("购买后卡牌ID为"..id.."的碎片数量为"..KnapsackData:getTowerFragment_(id))

                --售罄遮罩
                KnapsackData:setSoldOutState(i,true)
                shade:setVisible(KnapsackData:getSoldOutState(i))


                ItemButton:setTouchEnabled(false)
                --卡牌解锁
                if KnapsackData:getTowerUnlock_(id) then--卡牌已解锁
                    print("卡牌已解锁")
                else--卡牌未解锁
                    KnapsackData:unlockTower(id)
                    print("解锁卡牌成功！")
                end

                grayLayer:setVisible(false)
            else--金币不足
                popLayer:setVisible(false)
                GeneralView:popUpLayer(grayLayer,"Gold")
            end
            KnapsackData:sendData()
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
end

--[[
    函数用途：关闭弹窗按钮
    参数：层，灰色背景，弹窗背景层
    --]]
function GoldPurchaseView:closeButton(ShopLayer,grayLayer,popLayer)
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
            grayLayer:setVisible(false)--隐藏二级弹窗
            ShopLayer:setTouchEnabled(true)
        elseif eventType == ccui.TouchEventType.canceled then
            local scale = cc.ScaleTo:create(1,1)
            local ease_elastic = cc.EaseElasticOut:create(scale)
            sender:runAction(ease_elastic)
        end
    end)
    closeButton:addTo(popLayer)
end

return GoldPurchaseView