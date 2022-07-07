local GoldPurchaseView = {}
local KnapsackData = require("app.data.KnapsackData")
local TopPanel = require("app.scenes.TopPanel")
--[[
    函数用途：二级界面-金币商店购买确认弹窗
    参数：层，图片路径，碎片数量，金额，所属商品
--]]
function GoldPurchaseView:goldPurchasePanel(layer,path,fragNum,price,ItemButton)
    --灰色背景
    local grayLayer = self:grayLayer(layer)

    --图片：弹窗背景
    local popLayer = ccui.ImageView:create("ui/hall/shop/SecondaryInterface-Goldcoin_store_purchase_confirmation_pop-up/bg-pop-up.png")
    popLayer:pos(display.cx, display.cy)
    popLayer:setAnchorPoint(0.5, 0.5)
    popLayer:addTo(grayLayer)
    --图片：商品图
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
    --print(id)

    --确认按钮
    self:confirmButton(layer,grayLayer,popLayer,price,ItemButton,fragNum,id)
    --关闭按钮
    self:closeButton(layer,grayLayer,popLayer)
end
--[[
    函数用途：添加商品售罄遮罩
    参数：层，商品坐标x,y
    --]]
function GoldPurchaseView:ItemShade(layer,x,y)
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
    函数用途：创建灰色背景
    参数：层
    --]]
function GoldPurchaseView:grayLayer(layer)--参数：层
    local width ,height = display.width,display.height
    local grayLayer = ccui.Layout:create()
    grayLayer:setBackGroundColor(cc.c4b(0,0,0,128))
    grayLayer:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)--设置颜色模式
    grayLayer:setBackGroundColorOpacity(128)--设置透明度
    grayLayer:setContentSize(width, height)
    --随着滑动的位置而改变
    if layer:getPositionY() == 0 then
        grayLayer:pos(width/2, height/2+140)
    else
        grayLayer:pos(width/2, height/2-370+140)
    end
    grayLayer:setAnchorPoint(0.5, 0.5)
    grayLayer:addTo(layer)
    grayLayer:setTouchEnabled(true)--屏蔽一级界面
    return grayLayer
end

--[[
    函数用途：确认按钮
    参数：层，灰色背景，弹窗背景层，金额，所属商品,碎片数量,卡牌ID
    --]]
function GoldPurchaseView:confirmButton(layer,grayLayer,popLayer,price,ItemButton,fragNum,id)
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
                --更新顶部信息栏的金币数量
                TopPanel:setCoinString(KnapsackData:getGoldCoin())
                print("购买后金币数量为"..KnapsackData:getGoldCoin())

                --添加碎片
                KnapsackData:setTowerFragment_(id,fragNum)
                print("购买后卡牌ID为"..id.."的碎片数量为"..KnapsackData:getTowerFragment_(id))

                --售罄遮罩
                self:ItemShade(layer,ItemButton:getPositionX(),ItemButton:getPositionY())
            end
            KnapsackData:sendData()
            grayLayer:setVisible(false)
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
function GoldPurchaseView:closeButton(layer,grayLayer,popLayer)
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
            layer:setTouchEnabled(true)
        elseif eventType == ccui.TouchEventType.canceled then
            local scale = cc.ScaleTo:create(1,1)
            local ease_elastic = cc.EaseElasticOut:create(scale)
            sender:runAction(ease_elastic)
        end
    end)
    closeButton:addTo(popLayer)
end

return GoldPurchaseView