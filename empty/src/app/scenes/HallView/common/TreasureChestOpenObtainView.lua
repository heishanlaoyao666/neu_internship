local TreasureChestOpenObtainView = {}
--[[
    函数用途：二级界面-宝箱开启获得物品弹窗
    参数：层，普通卡数量，稀有卡数量，史诗卡数量，传奇卡数量，可获得的金币数量
    --]]
function TreasureChestOpenObtainView:obtainFromTreasurePanel(layer,nCardNum,rCardNum,eCardNum,lCardNum,coinNum)
    --灰色背景
    local grayLayer = self:grayLayer(layer)
    --图片：弹窗背景
    local obtainBg =ccui.ImageView:create("ui/hall/common/SecondaryInterface-Open the treasure chest to obtain the item pop-up window/bg-pop-up.png")
    obtainBg:setPosition(cc.p(display.cx, display.cy))
    obtainBg:addTo(grayLayer)
    obtainBg:setTouchEnabled(true)--屏蔽一级界面
    --金币展示
    self:goldCoinDisplay(obtainBg,coinNum)
    --碎片展示
    self:obtained(obtainBg,nCardNum,rCardNum,eCardNum,lCardNum,coinNum)
    --确认按钮
    self:confirmButton(grayLayer,obtainBg)
end

--[[
    函数用途：创建灰色背景
    参数：层
    --]]
function TreasureChestOpenObtainView:grayLayer(layer)--参数：层
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
    函数用途：金币的展示
    参数：弹窗层，金币数量
    --]]
function TreasureChestOpenObtainView:goldCoinDisplay(obtainBg,coinNum)
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
end
--[[
    函数用途：确认按钮
    参数：灰色背景层，弹窗背景层
    --]]
function TreasureChestOpenObtainView:confirmButton(grayLayer,obtainBg)
    --按钮：确认按钮
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
    函数用途：展示所获得的碎片
    参数：层，普通卡数量，稀有卡数量，史诗卡数量，传奇卡数量
--]]
function TreasureChestOpenObtainView:obtained(layer,nCardNum,rCardNum,eCardNum,lCardNum)
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

return TreasureChestOpenObtainView