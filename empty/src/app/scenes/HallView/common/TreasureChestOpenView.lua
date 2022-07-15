----内容：宝箱开启确认弹窗
----编写人员：郑蕾
---修订人员：郑蕾
---最后修改日期：7/15
local TreasureChestOpenView = {}
local KnapsackData = require("app.data.KnapsackData")
local TreasureChestOpenObtainView = require("app.scenes.HallView.common.TreasureChestOpenObtainView")
local GeneralView = require("app.scenes.HallView.common.GeneralView")

--[[
    函数用途：二级弹窗-宝箱开启确认弹窗
    --]]
function TreasureChestOpenView:treasureChestOpenConfirmPanel(ShopLayer,treasurePath,treasureType
,nCardNum,rCardNum,eCardNum,lCardNum,coinNum,price)
    --创建灰色背景
    local grayLayer = self:grayLayer(ShopLayer)

    --图片：弹窗背景
    local popLayer = ccui.ImageView:create("ui/hall/common/SecondaryInterface-Treasure chest opening confirmation pop-up window/bg-pop-up.png")
    popLayer:pos(display.cx, display.cy)
    popLayer:setAnchorPoint(0.5, 0.5)
    popLayer:addTo(grayLayer)
    --图片：顶部宝箱图标
    local treasureIcon =ccui.ImageView:create(treasurePath)
    treasureIcon:setScale(1.4,1.4)
    treasureIcon:setPosition(cc.p(300, display.cy-190))
    treasureIcon:addTo(popLayer)
    --图片：宝箱类型图标
    local type =ccui.ImageView:create(treasureType)
    type:setPosition(cc.p(300, display.cy-310))
    type:addTo(popLayer)

    --获取宝箱类型
    local treasureChestType = string.sub(treasurePath,43,-5)
    --print(treasureChestType)

    --展示金币信息
    self:goldCoinDisplay(popLayer,coinNum)

    --展示宝箱开启可能获得的物品信息
    self:fragmentInTreasure(popLayer,nCardNum,rCardNum,eCardNum,lCardNum)

    --宝箱开启按钮
    self:openButton(ShopLayer,grayLayer,popLayer,coinNum,price,treasureChestType)

    --弹窗关闭按钮
    self:closeButton(ShopLayer,grayLayer,popLayer)

end

--[[
    函数用途：创建灰色背景
    --]]
function TreasureChestOpenView:grayLayer(ShopLayer)--参数：层
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
    函数用途：金币的展示
    --]]
function TreasureChestOpenView:goldCoinDisplay(popLayer,coinNum)
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
end

--[[
    函数用途：宝箱开启按钮
    --]]
function TreasureChestOpenView:openButton(ShopLayer,grayLayer,popLayer,coinNum,price,treasureChestType)
    local openButton = ccui.Button:create(
            "ui/hall/common/SecondaryInterface-Treasure chest opening confirmation pop-up window/Button - on.png",
            "ui/hall/common/SecondaryInterface-Treasure chest opening confirmation pop-up window/Button - on.png",
            "ui/hall/common/SecondaryInterface-Treasure chest opening confirmation pop-up window/Button - on.png")
    openButton:setPosition(cc.p(300, 0))
    openButton:addTouchEventListener(function(sender,eventType)--按钮点击后放大缩小特效
        if eventType == ccui.TouchEventType.began then
            --按钮放缩
            self:setButtonScale(1,0.9,sender)
        elseif eventType == ccui.TouchEventType.ended then
            --按钮放缩
            self:setButtonScale(1,1,sender)
            --条件允许情况下：获得金币，扣除钻石
            if KnapsackData:setDiamonds(-price) then--钻石充足时
                --金币数量增加
                KnapsackData:setGoldCoin(coinNum)
                --宝箱获得物品弹窗
                TreasureChestOpenObtainView:obtainFromTreasurePanel(ShopLayer,treasureChestType,coinNum)
                grayLayer:setVisible(false)
            else--钻石不够
                popLayer:setVisible(false)
                GeneralView:popUpLayer(grayLayer,"Diamond")
            end
            KnapsackData:sendData()
        elseif eventType == ccui.TouchEventType.canceled then
            --按钮放缩
            self:setButtonScale(1,1,sender)
        end
    end)
    openButton:addTo(popLayer)
end

--[[
    函数用途：关闭窗口按钮
    --]]
function TreasureChestOpenView:closeButton(ShopLayer,grayLayer,popLayer)
    local closeButton = ccui.Button:create(
            "ui/hall/common/SecondaryInterface-Treasure chest opening confirmation pop-up window/Button - off.png",
            "ui/hall/common/SecondaryInterface-Treasure chest opening confirmation pop-up window/Button - off.png",
            "ui/hall/common/SecondaryInterface-Treasure chest opening confirmation pop-up window/Button - off.png")
    closeButton:setPosition(cc.p(570, 330))
    closeButton:addTouchEventListener(function(sender,eventType)--按钮点击后放大缩小特效
        if eventType == ccui.TouchEventType.began then
            --按钮放缩
            self:setButtonScale(1,0.9,sender)
        elseif eventType == ccui.TouchEventType.ended then
            --按钮放缩
            self:setButtonScale(1,1,sender)
            --隐藏二级弹窗
            grayLayer:setVisible(false)
            ShopLayer:setTouchEnabled(true)
        elseif eventType == ccui.TouchEventType.canceled then
            --按钮放缩
            self:setButtonScale(1,1,sender)
        end
    end)
    closeButton:addTo(popLayer)
end

--[[
    函数用途：展示宝箱开启后可能获得的物品
    --]]
function TreasureChestOpenView:fragmentInTreasure(layer,nCardNum,rCardNum,eCardNum,lCardNum)
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
    函数用途：按钮放缩特效
    --]]
function TreasureChestOpenView:setButtonScale(X,Y,sender)
    local scale = cc.ScaleTo:create(X,Y)
    local ease_elastic = cc.EaseElasticOut:create(scale)
    sender:runAction(ease_elastic)
end

return TreasureChestOpenView