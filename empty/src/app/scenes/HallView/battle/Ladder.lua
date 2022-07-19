----内容：游戏外-天梯
----编写人员：郑蕾
---修订人员：郑蕾
---最后修改日期：7/15
local Ladder = {}
local KnapsackData = require("app.data.KnapsackData")
local Ladderdata = require("app.data.Ladderdata")
local TreasureChestOpenObtainView = require("app.scenes.HallView.common.TreasureChestOpenObtainView")
local GeneralView = require("app.scenes.HallView.common.GeneralView")

--[[
    函数用途：展示天梯
    --]]
function Ladder:ladderCreate(battleLayer)
    self.cups = KnapsackData:getCups()
    print("奖杯数"..self.cups)
    --层：天梯背景层
    local highLadderLayer = ccui.ImageView:create("ui/hall/battle/rank/highLadderBg.png")
    highLadderLayer:pos(display.cx, display.top-180)
    highLadderLayer:setAnchorPoint(0.5, 0.5)
    highLadderLayer:addTo(battleLayer)
    --listView翻页
    local listView = ccui.ListView:create()
    listView:setContentSize(570,350)
    listView:setPosition(55,0)
    listView:setAnchorPoint(0, 0)
    listView:setDirection(2)--水平方向
    listView:setItemsMargin(40)--间距
    listView:setBounceEnabled(true)--滑动惯性
    listView:addTo(highLadderLayer)
    --奖励
    self:awards(battleLayer,listView)
    --左右滑动按钮
    self:moveButton(highLadderLayer)

end

--[[
    函数用途：左右移动按钮
    --]]
function Ladder:moveButton(highLadderLayer)
    --按钮：左滑
    local leftButton = ccui.Button:create("ui/hall/battle/rank/slideLeft.png","ui/hall/battle/rank/slideLeft.png","ui/hall/battle/rank/slideLeft.png")
    leftButton:setPosition(cc.p(30, 160))
    leftButton:addTouchEventListener(function(sender,eventType)--按钮点击后放大缩小特效
        if eventType == ccui.TouchEventType.began then
            self:setButtonScale(1,0.9,sender)
        elseif eventType == ccui.TouchEventType.ended then
            self:setButtonScale(1,1,sender)
        elseif eventType == ccui.TouchEventType.canceled then
            self:setButtonScale(1,1,sender)
        end
    end)
    leftButton:addTo(highLadderLayer)
    --按钮：右滑
    local rightButton = ccui.Button:create("ui/hall/battle/rank/slideRight.png","ui/hall/battle/rank/slideRight.png","ui/hall/battle/rank/slideRight.png")
    rightButton:setPosition(cc.p(645, 160))
    rightButton:addTouchEventListener(function(sender,eventType)--按钮点击后放大缩小特效
        if eventType == ccui.TouchEventType.began then
            self:setButtonScale(1,0.9,sender)
        elseif eventType == ccui.TouchEventType.ended then
            self:setButtonScale(1,1,sender)
        elseif eventType == ccui.TouchEventType.canceled then
            self:setButtonScale(1,1,sender)
        end
    end)
    rightButton:addTo(highLadderLayer)
end

--[[
    函数用途：展示各个进度的奖励
    --]]
function Ladder:awards(battleLayer,listView)
    local num = math.floor(self.cups/50)--奖励进度,最多23个
    print("共可领取的奖励个数为:"..num)
    for i = 1,num do--已达成，未领取
        local bg = "ui/hall/battle/rank/availableButNotReceive.png"
        local icon = "null"
        self:itemCreate(battleLayer,i,bg,icon,listView,num)
    end
    for i = num+1,23 do--未达成未领取
        local bg = "ui/hall/battle/rank/lockedBorder.png"
        local icon = "ui/hall/battle/rank/locked.png"
        self:itemCreate(battleLayer,i,bg,icon,listView,num)
    end
end

--[[
    函数用途：天梯奖励内容
    --]]
function Ladder:itemCreate(battleLayer,i,bg,icon,listView,num)
    --获取宝箱类型
    local treasureChestType = string.sub(Ladderdata.ITEM[i].ICON,43,-5)
    --奖励层级
    local itemLayer = ccui.Layout:create()
    itemLayer:setBackGroundColorOpacity(180)--设置为透明
    --itemLayer:setBackGroundColorType(1)
    itemLayer:setAnchorPoint(0, 0)
    itemLayer:setPosition(cc.p(0,0))
    itemLayer:setContentSize(160, 160)
    --文本：进度条奖杯数
    local n = 50 * i
    local cupNum = cc.Label:createWithTTF(n,"ui/font/fzbiaozjw.ttf",25)
    cupNum:setPosition(cc.p(78,-70))
    cupNum:setColor(cc.c3b(255, 255, 255))
    cupNum:enableOutline(cc.c4b(15, 16, 59, 255),1)--字体描边
    cupNum:enableShadow(cc.c4b(17,17,60,255), cc.size(0,-2), 1)--阴影
    cupNum:addTo(itemLayer)
    --背景框
    local statusBg = ccui.ImageView:create(bg)
    statusBg:pos(80, 80)
    statusBg:setAnchorPoint(0.5, 0.5)
    statusBg:setTouchEnabled(true)
    statusBg:addTo(itemLayer)
    --根据奖励类型生成相应控件
    self:awardType(statusBg,i)

    --下方小图标
    local iconStatus = ccui.ImageView:create(icon)
    iconStatus:pos(75, 0)
    iconStatus:setAnchorPoint(0.5, 0.5)
    iconStatus:addTo(statusBg)
    if i == 1 then
        --滑动条背景
        local slidebg = ccui.ImageView:create("ui/hall/battle/rank/scale/ascale.png")
        slidebg:setScale(0.15,0.9)
        slidebg:setAnchorPoint(0, 0)
        slidebg:setPosition(9, -50)
        slidebg:addTo(itemLayer)
        if num>=1 then
            --滑动条填充
            local slide = ccui.ImageView:create("ui/hall/battle/rank/scale/rectangle1.png")
            slide:setScale(0.017,0.9)
            slide:setAnchorPoint(0, 0)
            slide:setPosition(9, -45)
            slide:addTo(itemLayer)
        end
        --滑动条截断
        self:point(itemLayer)
        --图标:钥匙
        self:key(itemLayer)
    else
        --滑动条背景
        local slidebg = ccui.ImageView:create("ui/hall/battle/rank/scale/ascale.png")
        slidebg:setScale(0.325,0.9)
        slidebg:setAnchorPoint(0, 0)
        slidebg:setPosition(-100, -50)
        slidebg:addTo(itemLayer)
        if 1< i and i<=num then--奖励进度条
            --滑动条填充
            local slide = ccui.ImageView:create("ui/hall/battle/rank/scale/rectangle1.png")
            slide:setScale(0.047,0.9)
            slide:setAnchorPoint(0, 0)
            slide:setPosition(-120, -45)
            slide:addTo(itemLayer)
        end
        --滑动条截断
        self:point(itemLayer)
    end
    statusBg:addTouchEventListener(function(sender,eventType)
        if eventType == ccui.TouchEventType.began then
            --按钮放缩
            self:setButtonScale(1,0.9,sender)
        elseif eventType == ccui.TouchEventType.ended then
            --按钮放缩
            self:setButtonScale(1,1,sender)
            if bg == "ui/hall/battle/rank/availableButNotReceive.png" then--已达成未领取
                --领取奖励
                self:drawAward(i,battleLayer,treasureChestType)
                --切换图片并禁止触摸
                statusBg:loadTexture("ui/hall/battle/rank/Available.png")
                iconStatus:loadTexture("ui/hall/battle/rank/group 130.png")
                statusBg:setTouchEnabled(false)
            elseif bg == "ui/hall/battle/rank/lockedBorder.png" then --未达成未领取
                local grayLayer = self:grayLayer(battleLayer)
                GeneralView:popUpLayer(grayLayer,"Cup")
            end
            --传输数据
            KnapsackData:sendData()
        elseif eventType == ccui.TouchEventType.canceled then
            --按钮放缩
            self:setButtonScale(1,1,sender)
        end
    end)
    listView:pushBackCustomItem(itemLayer)
end

--[[
    函数用途：灰色背景
    --]]
function Ladder:grayLayer(battleLayer)
    local width ,height = display.width,display.height
    local grayLayer = ccui.Layout:create()
    grayLayer:setBackGroundColor(cc.c4b(0,0,0,128))
    grayLayer:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)--设置颜色模式
    grayLayer:setBackGroundColorOpacity(128)--设置透明度
    grayLayer:setContentSize(width, height)
    grayLayer:pos(width/2, height/2+140)
    grayLayer:setAnchorPoint(0.5, 0.5)
    grayLayer:setTouchEnabled(true)--屏蔽一级界面
    grayLayer:addTo(battleLayer)
    return grayLayer
end

--[[
    函数用途：识别奖励类型
    --]]
function Ladder:awardType(statusBg,i)
    if Ladderdata.ITEM[i].TYPE == 1 then--宝箱
        local treasure = ccui.ImageView:create(Ladderdata.ITEM[i].ICON)
        treasure:setScale(0.8,0.8)
        treasure:pos(80, 80)
        treasure:setAnchorPoint(0.5, 0.5)
        treasure:addTo(statusBg)
    elseif Ladderdata.ITEM[i].TYPE == 2 or 3 then--钻石或者金币
        local currency = ccui.ImageView:create(Ladderdata.ITEM[i].ICON)
        currency:pos(80, 95)
        currency:setAnchorPoint(0.5, 0.5)
        currency:addTo(statusBg)
        local currencyText = ccui.Text:create(Ladderdata.ITEM[i].TEXT, "ui/font/fzbiaozjw.ttf", 30)
        currencyText:setPosition(80,45)
        currencyText:addTo(statusBg)
    elseif Ladderdata.ITEM[i].TYPE == 4 or 5  then--卡牌
        local card = ccui.ImageView:create(Ladderdata.ITEM[i].ICON)
        card:pos(80, 80)
        card:setAnchorPoint(0.5, 0.5)
        card:addTo(statusBg)
    end
end

--[[
    函数用途：添加进度条定点截断
    --]]
function Ladder:point(itemLayer)
    --滑动条截断
    local scale = ccui.ImageView:create("ui/hall/battle/rank/scale/scale.png")
    scale:setScale(1.15,1.2)
    scale:setAnchorPoint(0, 0)
    scale:setPosition(cc.p(78,-48))
    scale:addTo(itemLayer)

end

--[[
    函数用途：添加钥匙图标
    --]]
function Ladder:key(itemLayer)
    local key = ccui.ImageView:create("ui/hall/battle/rank/scale/key.png")
    key:setScale(1.2,1.2)
    key:pos(0, -50)
    key:setAnchorPoint(0, 0)
    key:addTo(itemLayer)
end
--[[
    函数用途：根据奖励类型进行相应数据的改变
    --]]
function Ladder:drawAward(i,battleLayer,treasureChestType)
    if Ladderdata.ITEM[i].TYPE == 1 then--宝箱
        --宝箱获得物品弹窗
        TreasureChestOpenObtainView:obtainFromTreasurePanel(battleLayer,treasureChestType,Ladderdata.ITEM[i].TEXT)
        --金币数量增加
        KnapsackData:setGoldCoin(Ladderdata.ITEM[i].TEXT)
    elseif Ladderdata.ITEM[i].TYPE == 2 then--金币
        --金币数量增加
        KnapsackData:setGoldCoin(Ladderdata.ITEM[i].TEXT)
    elseif Ladderdata.ITEM[i].TYPE == 3 then--钻石
        --钻石数量增加
        KnapsackData:setDiamonds(Ladderdata.ITEM[i].TEXT)
    elseif Ladderdata.ITEM[i].TYPE == 4 then--固定传奇卡
        --添加碎片
        KnapsackData:setTowerFragment_(19,1)
        --卡牌解锁
        self:towerStateChange(19)
    elseif Ladderdata.ITEM[i].TYPE == 5 then--抽取随机一张卡牌
        math.randomseed(os.time())
        local legendArray = {"05","06","13","19"}
        local legendIndex = math.random(1, #legendArray)
        local id = tonumber(legendArray[legendIndex])
        --添加碎片
        KnapsackData:setTowerFragment_(id,1)
        --卡牌解锁
        self:towerStateChange(id)
    end
end

--[[
    函数用途：对卡的锁定状态进行操作
    --]]
function Ladder:towerStateChange(id)
    --卡牌解锁
    if KnapsackData:getTowerUnlock_(id) then--卡牌已解锁
        print("卡牌已解锁")
    else--卡牌未解锁
        KnapsackData:unlockTower(id)
        print("解锁卡牌成功！")
    end
end

--[[
    函数用途：按钮放缩特效
    --]]
function Ladder:setButtonScale(X,Y,sender)
    local scale = cc.ScaleTo:create(X,Y)
    local ease_elastic = cc.EaseElasticOut:create(scale)
    sender:runAction(ease_elastic)
end

return Ladder