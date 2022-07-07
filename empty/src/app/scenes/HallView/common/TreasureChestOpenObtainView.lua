local TreasureChestOpenObtainView = {}
local KnapsackData = require("app.data.KnapsackData")
--[[
    函数用途：二级界面-宝箱开启获得物品弹窗
    参数：层，普通卡数量，稀有卡数量，史诗卡数量，传奇卡数量，可获得的金币数量
    --]]
function TreasureChestOpenObtainView:obtainFromTreasurePanel(layer,TreasureChestType,coinNum)
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
    if TreasureChestType == "normal"then
        self:normalObtained(obtainBg)
    elseif TreasureChestType == "RARE"then
        self:rareObtained(obtainBg)
    elseif TreasureChestType == "Epic"then
        self:epicObtained(obtainBg)
    elseif TreasureChestType == "Legend"then
        self:legendObtained(obtainBg)
    end
    KnapsackData:sendData()
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
    函数用途：对卡的锁定状态进行操作
    --]]
function TreasureChestOpenObtainView:towerStateChange(id)
    --卡牌解锁
    if KnapsackData:getTowerUnlock_(id) then--卡牌已解锁
        print("卡牌已解锁")
    else--卡牌未解锁
        KnapsackData:unlockTower(id)
        print("解锁卡牌成功！")
    end
end

--[[
    函数用途：展示开启普通宝箱所获得的碎片
    参数：弹窗背景层
--]]
function TreasureChestOpenObtainView:normalObtained(obtainBg)
    math.randomseed(os.time())
    local nCardNum = 38--两张普通卡
    local rCardNum = 7--一张稀有卡
    local eCardNum = 1--一张史诗卡
    local originX = 140
    local originY = 200
    local cNum = math.random(10, 20)
    --两张普通卡
    local normalArray = {"01","04","07","09","18","20"}
    for i = 1,2 do
        local normalIndex = math.random(1, #normalArray)
        --print(normalIndex)
        self:diaplayFragment(obtainBg,normalArray[normalIndex],cNum,"普通",originX,originY)

        --增加卡牌碎片数量
        local id = tonumber(normalArray[normalIndex])
        KnapsackData:setTowerFragment_(id,cNum)
        print("购买后卡牌ID为"..id.."的碎片数量为"..KnapsackData:getTowerFragment_(id))

        --卡牌状态改变
        self:towerStateChange(id)

        cNum = nCardNum-cNum
        originX = originX+140
    end
    --一张稀有卡
    local rareArray = {"03","10","14","15"}
    local rareIndex = math.random(1, #rareArray)
    --print(rareIndex)
    self:diaplayFragment(obtainBg,rareArray[rareIndex],rCardNum,"稀有",originX,originY)

    --增加卡牌碎片数量
    local id = tonumber(rareArray[rareIndex])
    KnapsackData:setTowerFragment_(id,rCardNum)
    print("购买后卡牌ID为"..id.."的碎片数量为"..KnapsackData:getTowerFragment_(id))
    --卡牌状态改变
    self:towerStateChange(id)

    originX = originX+140
    --一张史诗卡
    local epicArray = {"02","08","11","12","16","17"}
    local epicIndex = math.random(1, #epicArray)
    --print(epicIndex)
    self:diaplayFragment(obtainBg,epicArray[epicIndex],eCardNum,"史诗",originX,originY)

    --增加卡牌碎片数量
    local id = tonumber(epicArray[epicIndex])
    KnapsackData:setTowerFragment_(id,eCardNum)
    print("购买后卡牌ID为"..id.."的碎片数量为"..KnapsackData:getTowerFragment_(id))
    --卡牌状态改变
    self:towerStateChange(id)

end

--[[
    函数用途：展示开启稀有宝箱所获得的碎片
    参数：弹窗背景层
--]]
function TreasureChestOpenObtainView:rareObtained(obtainBg)
    local nCardNum = 74--两张普通卡
    local rCardNum = 14--一张稀有卡
    local eCardNum = 2--一张史诗卡
    local originX = 140
    local originY = 200
    --金币商店商品排列
    math.randomseed(os.time())
    local cNum = math.random(20, 40)
    --两张普通卡
    local normalArray = {"01","04","07","09","18","20"}
    for i = 1,2 do
        local normalIndex = math.random(1, #normalArray)
        --print(normalIndex)
        self:diaplayFragment(obtainBg,normalArray[normalIndex],cNum,"普通",originX,originY)

        --增加卡牌碎片数量
        local id = tonumber(normalArray[normalIndex])
        KnapsackData:setTowerFragment_(id,cNum)
        print("购买后卡牌ID为"..id.."的碎片数量为"..KnapsackData:getTowerFragment_(id))
        --卡牌状态改变
        self:towerStateChange(id)

        cNum = nCardNum-cNum
        originX = originX+140
    end
    --一张稀有卡
    local rareArray = {"03","10","14","15"}
    local rareIndex = math.random(1, #rareArray)
    --print(rareIndex)
    self:diaplayFragment(obtainBg,rareArray[rareIndex],rCardNum,"稀有",originX,originY)
    --增加卡牌碎片数量
    local id = tonumber(rareArray[rareIndex])
    KnapsackData:setTowerFragment_(id,rCardNum)
    print("购买后卡牌ID为"..id.."的碎片数量为"..KnapsackData:getTowerFragment_(id))
    --卡牌状态改变
    self:towerStateChange(id)

    originX = originX+140
    --一张史诗卡
    local epicArray = {"02","08","11","12","16","17"}
    local epicIndex = math.random(1, #epicArray)
    --print(epicIndex)
    self:diaplayFragment(obtainBg,epicArray[epicIndex],eCardNum,"史诗",originX,originY)
    --增加卡牌碎片数量
    local id = tonumber(epicArray[epicIndex])
    KnapsackData:setTowerFragment_(id,eCardNum)
    print("购买后卡牌ID为"..id.."的碎片数量为"..KnapsackData:getTowerFragment_(id))
    --卡牌状态改变
    self:towerStateChange(id)

end

--[[
    函数用途：展示开启史诗宝箱所获得的碎片
    参数：弹窗背景层
--]]
function TreasureChestOpenObtainView:epicObtained(obtainBg)
    math.randomseed(os.time())
    local nCardNum = 139--四张普通卡
    local rCardNum = 36--两张稀有卡
    local eCardNum = 7--一张史诗卡
    local lCardNum = math.random(0, 1)

    local originX = 140
    local originY = 280
    local cNum = 0
    --四张普通卡
    local normalArray = {"01","04","07","09","18","20"}
    for i = 1,4 do
        local normalIndex = math.random(1, #normalArray)
        --print(normalIndex)
        if i<4 then
            cNum = math.random(25, 32)
            nCardNum = nCardNum-cNum
        else
            cNum = nCardNum
        end
        self:diaplayFragment(obtainBg,normalArray[normalIndex],cNum,"普通",originX,originY)
        --增加卡牌碎片数量
        local id = tonumber(normalArray[normalIndex])
        KnapsackData:setTowerFragment_(id,cNum)
        print("购买后卡牌ID为"..id.."的碎片数量为"..KnapsackData:getTowerFragment_(id))
        --卡牌状态改变
        self:towerStateChange(id)

        originX = originX+140
    end

    originX = 140
    originY = originY - 150

    --两张稀有卡
    local rareArray = {"03","10","14","15"}
    local rNum = math.random(1, 35)
    for i = 1,2 do
        local rareIndex = math.random(1, #rareArray)
        --print(rareIndex)
        self:diaplayFragment(obtainBg,rareArray[rareIndex],rNum,"稀有",originX,originY)
        --增加卡牌碎片数量
        local id = tonumber(rareArray[rareIndex])
        KnapsackData:setTowerFragment_(id,rNum)
        print("购买后卡牌ID为"..id.."的碎片数量为"..KnapsackData:getTowerFragment_(id))
        --卡牌状态改变
        self:towerStateChange(id)

        rNum = rCardNum-rNum
        originX = originX+140
    end

    --一张史诗卡
    local epicArray = {"02","08","11","12","16","17"}
    local epicIndex = math.random(1, #epicArray)
    --print(epicIndex)
    self:diaplayFragment(obtainBg,epicArray[epicIndex],eCardNum,"史诗",originX,originY)
    --增加卡牌碎片数量
    local id = tonumber(epicArray[epicIndex])
    KnapsackData:setTowerFragment_(id,eCardNum)
    print("购买后卡牌ID为"..id.."的碎片数量为"..KnapsackData:getTowerFragment_(id))
    --卡牌状态改变
    self:towerStateChange(id)

    originX = originX+140

    --传说卡
    if lCardNum == 1 then
        local legendArray = {"05","06","13","19"}
        local legendIndex = math.random(1, #legendArray)
        --print(legendIndex)
        self:diaplayFragment(obtainBg,legendArray[legendIndex],lCardNum,"传说",originX,originY)
        --增加卡牌碎片数量
        local id = tonumber(legendArray[legendIndex])
        KnapsackData:setTowerFragment_(id,lCardNum)
        print("购买后卡牌ID为"..id.."的碎片数量为"..KnapsackData:getTowerFragment_(id))
        --卡牌状态改变
        self:towerStateChange(id)

    end
end

--[[
    函数用途：展示开启传说宝箱所获得的碎片
    参数：弹窗背景层
--]]
function TreasureChestOpenObtainView:legendObtained(obtainBg)
    math.randomseed(os.time())
    local nCardNum = 187--四张普通卡
    local rCardNum = 51--两张稀有卡
    local eCardNum = 21--一张史诗卡
    local lCardNum = 1--一张传说卡

    local originX = 140
    local originY = 280
    local cNum = 0
    --四张普通卡
    local normalArray = {"01","04","07","09","18","20"}
    for i = 1,4 do
        local normalIndex = math.random(1, #normalArray)
        --print(normalIndex)
        if i<4 then
            cNum = math.random(25, 32)
            nCardNum = nCardNum-cNum
        else
            cNum = nCardNum
        end
        self:diaplayFragment(obtainBg,normalArray[normalIndex],cNum,"普通",originX,originY)
        --增加卡牌碎片数量
        local id = tonumber(normalArray[normalIndex])
        KnapsackData:setTowerFragment_(id,cNum)
        print("购买后卡牌ID为"..id.."的碎片数量为"..KnapsackData:getTowerFragment_(id))
        --卡牌状态改变
        self:towerStateChange(id)

        originX = originX+140
    end

    originX = 140
    originY = originY - 150

    --两张稀有卡
    local rareArray = {"03","10","14","15"}
    local rNum = math.random(1, 35)
    for i = 1,2 do
        local rareIndex = math.random(1, #rareArray)
        --print(rareIndex)
        self:diaplayFragment(obtainBg,rareArray[rareIndex],rNum,"稀有",originX,originY)
        --增加卡牌碎片数量
        local id = tonumber(rareArray[rareIndex])
        KnapsackData:setTowerFragment_(id,rNum)
        print("购买后卡牌ID为"..id.."的碎片数量为"..KnapsackData:getTowerFragment_(id))
        --卡牌状态改变
        self:towerStateChange(id)

        rNum = rCardNum-rNum
        originX = originX+140
    end

    --一张史诗卡
    local epicArray = {"02","08","11","12","16","17"}
    local epicIndex = math.random(1, #epicArray)
    --print(epicIndex)
    self:diaplayFragment(obtainBg,epicArray[epicIndex],eCardNum,"史诗",originX,originY)
    --增加卡牌碎片数量
    local id = tonumber(epicArray[epicIndex])
    KnapsackData:setTowerFragment_(id,eCardNum)
    print("购买后卡牌ID为"..id.."的碎片数量为"..KnapsackData:getTowerFragment_(id))
    --卡牌状态改变
    self:towerStateChange(id)

    originX = originX+140

    --传说卡
    local legendArray = {"05","06","13","19"}
    local legendIndex = math.random(1, #legendArray)
    --print(legendIndex)
    self:diaplayFragment(obtainBg,legendArray[legendIndex],lCardNum,"传说",originX,originY)
    --增加卡牌碎片数量
    local id = tonumber(legendArray[legendIndex])
    KnapsackData:setTowerFragment_(id,lCardNum)
    print("购买后卡牌ID为"..id.."的碎片数量为"..KnapsackData:getTowerFragment_(id))
    --卡牌状态改变
    self:towerStateChange(id)

end

--[[
    函数用途：添加碎片展示
    --]]
function TreasureChestOpenObtainView:diaplayFragment(obtainBg,string,fragNum,fragType,originX,originY)
    local ItemObtained =ccui.ImageView:create("ui/hall/common/SecondaryInterface-Open the treasure chest to obtain the item pop-up window/Icon - tower/"..string..".png")
    ItemObtained:setScale(0.8,0.8)
    ItemObtained:setPosition(cc.p(originX, originY))
    ItemObtained:addTo(obtainBg)
    --文本：碎片数量
    local fragmentNum = cc.Label:createWithTTF("X"..fragNum,"ui/font/fzbiaozjw.ttf",21)
    fragmentNum:setPosition(cc.p(originX+40, originY+40))
    fragmentNum:setColor(cc.c3b(255, 255, 255))
    fragmentNum:enableOutline(cc.c4b(0, 0, 0, 255),1)--字体描边
    fragmentNum:addTo(obtainBg)
    --文本：稀有度
    local fragmentType= cc.Label:createWithTTF(fragType,"ui/font/fzbiaozjw.ttf",22)
    fragmentType:setPosition(cc.p(originX, originY-70))
    fragmentType:setColor(cc.c3b(255, 255, 255))
    fragmentType:enableOutline(cc.c4b(0, 0, 0, 255),1)--字体描边
    fragmentType:addTo(obtainBg)
end

return TreasureChestOpenObtainView