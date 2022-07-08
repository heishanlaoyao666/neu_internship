local Battle = class("Battle")
local KnapsackData = require("app.data.KnapsackData")
local LadderDef = require("app.def.LadderDef")
local TreasureChestOpenObtainView = require("app.scenes.HallView.common.TreasureChestOpenObtainView")
function Battle:ctor()
    self.cups = KnapsackData:getCups()
end

function Battle:battlePanel()
    local battleLayer = ccui.Layout:create()
    battleLayer:setBackGroundColorOpacity(180)--设置为透明
    --battleLayer:setBackGroundColorType(1)
    battleLayer:setAnchorPoint(0, 0)
    battleLayer:setPosition(0, display.top)
    battleLayer:setContentSize(720, 1280)
    --图片：背景图
    local Bg = ccui.ImageView:create("ui/hall/battle/bg-battle_interface.png")
    Bg:setAnchorPoint(0.5, 0.5)
    Bg:setPosition(display.cx,display.cy)
    Bg:addTo(battleLayer)

    self:highLadder(battleLayer)
    --开始游戏按钮
    local images = {
        normal = "ui/hall/battle/Button-Battle_Mode.png",
        pressed = "",
        disabled = "ui/hall/battle/Button-Battle_Mode.png"
    }
    local NewGameBtn = ccui.Button:create(images["normal"], images["pressed"], images["disabled"])
    NewGameBtn:setAnchorPoint(cc.p(0.5 ,0.5))
    NewGameBtn:setPosition(cc.p(display.cx, display.cy))
    NewGameBtn:setScale(0.5, 0.5)
    NewGameBtn:setEnabled(true)
    NewGameBtn:addTouchEventListener(function(sender, eventType)
        if eventType == ccui.TouchEventType.ended then
            local ABtn = import("app.scenes.GameView.GameScene"):new()
            display.replaceScene(ABtn,"turnOffTiles",0.5)
        end
    end)
    NewGameBtn:addTo(battleLayer)

    return battleLayer
end


--[[
    函数用途：展示天梯
    --]]
function Battle:highLadder(layer)

    --层：天梯背景
    local highLadderLayer = ccui.ImageView:create("ui/hall/battle/rank/highLadderBg.png")
    highLadderLayer:pos(display.cx, display.top-180)
    highLadderLayer:setAnchorPoint(0.5, 0.5)
    highLadderLayer:addTo(layer)
    --listView翻页
    local listView = ccui.ListView:create()
    listView:setContentSize(570,300)
    listView:setPosition(65,30)
    listView:setAnchorPoint(0, 0)
    listView:setDirection(2)
    listView:setItemsMargin(40)
    listView:addTo(highLadderLayer)
    --滑动层
    local slideLayer = ccui.Layout:create()
    slideLayer:setBackGroundColorOpacity(180)--设置为透明
    --slideLayer:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid) --设置颜色
    --slideLayer:setBackGroundColorOpacity(128)--设置透明度
    slideLayer:setContentSize(676, 285)
    slideLayer:setPosition(0,0)
    slideLayer:setAnchorPoint(0,1)
    --slideLayer:addTo(highLadderLayer)
    --listView:addChild(slideLayer)

    --奖励
    self:awardPanel(layer,listView)
    --图标:钥匙
    local key = ccui.ImageView:create("ui/hall/battle/rank/scale/key.png")
    key:setScale(0.9,0.9)
    key:pos(10, 70)
    key:setAnchorPoint(0.5, 0.5)
    key:addTo(slideLayer)
    --进度条
    self:slideCreate(listView)
    --按钮：左滑
    local leftButton = ccui.Button:create(
            "ui/hall/battle/rank/slideLeft.png",
            "ui/hall/battle/rank/slideLeft.png",
            "ui/hall/battle/rank/slideLeft.png")
    leftButton:setPosition(cc.p(30, 160))
    leftButton:addTouchEventListener(function(sender,eventType)--按钮点击后放大缩小特效
        if eventType == ccui.TouchEventType.began then
            local scale = cc.ScaleTo:create(1,0.9)
            local ease_elastic = cc.EaseElasticOut:create(scale)
            sender:runAction(ease_elastic)
            print(slideLayer:getPositionX())
            if slideLayer:getPositionX()>0 then
                slideLayer:setPositionX(0)
            end
            if slideLayer:getPositionX()~=0 then
                self:slideShop(slideLayer,570)
            end

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
    leftButton:addTo(highLadderLayer)
    --按钮：右滑
    local rightButton = ccui.Button:create(
            "ui/hall/battle/rank/slideRight.png",
            "ui/hall/battle/rank/slideRight.png",
            "ui/hall/battle/rank/slideRight.png")
    rightButton:setPosition(cc.p(645, 160))
    rightButton:addTouchEventListener(function(sender,eventType)--按钮点击后放大缩小特效
        if eventType == ccui.TouchEventType.began then
            local scale = cc.ScaleTo:create(1,0.9)
            local ease_elastic = cc.EaseElasticOut:create(scale)
            sender:runAction(ease_elastic)
            if slideLayer:getPositionX()>-3420 then
                self:slideShop(slideLayer,-570)
            end
            --print(slideLayer:getPositionX())
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
    rightButton:addTo(highLadderLayer)

end


--[[
    函数用途：天梯滑动
    --]]
function Battle:ladderListView()

end



--[[
    函数用途：展示各个进度的奖励
    --]]
function Battle:awardPanel(layer,listView)
    local num = 200/50--奖励进度,最多23个
    print("共可领取的奖励个数为:"..num)
    for i = 1,num do--已达成，未领取
        local bg = "ui/hall/battle/rank/availableButNotReceive.png"
        local icon = "null"
        self:itemCreate(layer,i,bg,icon,listView)
    end
    for i = num+1,23 do
        local bg = "ui/hall/battle/rank/lockedBorder.png"
        local icon = "ui/hall/battle/rank/locked.png"
        self:itemCreate(layer,i,bg,icon,listView)
    end
    --进度条
    --self:slideCreate(listView)

end
--[[
    函数用途：填充进度条背景
    --]]
function Battle:slideCreate(listView)
    local num = 2--得出达到了第几个奖励
    local barPro = cc.ProgressTimer:create(cc.Sprite:create("ui/hall/battle/rank/scale/rectangle1.png"))--进度条组件
    barPro:setScale(0.931,0.9)
    barPro:setAnchorPoint(0, 0)
    barPro:setPosition(0, 25)
    barPro:setType(cc.PROGRESS_TIMER_TYPE_BAR)
    barPro:setMidpoint(cc.p(0, 0))--进度条起点位置
    barPro:setBarChangeRate(cc.p(1, 0))--进度方向为水平方向
    barPro:addTo(listView)
    barPro:setPercentage(0)--起始进度为0

    local offset = 4.9
    local process = 0
    if num > 1 then
        process = (num-1)*offset+1.85
    elseif num == 1 then
        process = 1.85
    end
    local actionToFirst = cc.ProgressFromTo:create(0,0,process)--动作：0秒内从0到2.6+process
    local callFuncAction = cc.CallFunc:create(function()--动作执行完毕回调函数

    end)
    local delayTimeAction = cc.DelayTime:create(0.5)--延时0.5s
    local sequenceAction = cc.Sequence:create(actionToFirst,delayTimeAction,callFuncAction)
    barPro:runAction(sequenceAction)

end


--[[
    函数用途：天梯奖励内容
    --]]
function Battle:itemCreate(layer,i,bg,icon,listView)
    local treasureChestType = string.sub(LadderDef[i].ICON,43,-5)
    --单个奖励层级
    local itemLayer = ccui.Layout:create()
    itemLayer:setBackGroundColorOpacity(180)--设置为透明
    --itemLayer:setBackGroundColorType(1)
    itemLayer:setAnchorPoint(0, 0)
    itemLayer:setPosition(cc.p(0,0))
    itemLayer:setContentSize(160, 160)
    --背景框
    local statusBg = ccui.ImageView:create(bg)
    statusBg:pos(80, 80)
    statusBg:setAnchorPoint(0.5, 0.5)
    if LadderDef[i].TYPE == 1 then--宝箱类型
        local treasure = ccui.ImageView:create(LadderDef[i].ICON)
        treasure:setScale(0.8,0.8)
        treasure:pos(80, 80)
        treasure:setAnchorPoint(0.5, 0.5)
        treasure:addTo(statusBg)
    elseif LadderDef[i].TYPE == 2 then--钻石或者金币
        local currency = ccui.ImageView:create(LadderDef[i].ICON)
        currency:pos(80, 95)
        currency:setAnchorPoint(0.5, 0.5)
        currency:addTo(statusBg)
        local currencyText = ccui.Text:create(LadderDef[i].TEXT, "ui/font/fzbiaozjw.ttf", 30)
        currencyText:setPosition(80,45)
        currencyText:addTo(statusBg)
    elseif LadderDef[i].TYPE == 3 then--卡牌
        local card = ccui.ImageView:create(LadderDef[i].ICON)
        card:pos(80, 80)
        card:setAnchorPoint(0.5, 0.5)
        card:addTo(statusBg)
    end
    --下方小图标
    local iconStatus = ccui.ImageView:create(icon)
    iconStatus:pos(75, 0)
    iconStatus:setAnchorPoint(0.5, 0.5)
    iconStatus:addTo(statusBg)
    --滑动条背景
    local slidebg = ccui.ImageView:create("ui/hall/battle/rank/scale/ascale.png")
    slidebg:setScale(0.328,0.9)
    slidebg:setAnchorPoint(0, 0)
    slidebg:setPosition(0, -50)
    slidebg:addTo(itemLayer)
    --滑动条截断
    local scale = ccui.ImageView:create("ui/hall/battle/rank/scale/scale.png")
    scale:setScale(1.1,1.1)
    scale:setAnchorPoint(0, 0)
    scale:setPosition(cc.p(230,5))
    scale:addTo(slidebg)

    statusBg:addTouchEventListener(function(sender,eventType)
        if eventType == ccui.TouchEventType.began then
            local scale = cc.ScaleTo:create(1,0.9)
            local ease_elastic = cc.EaseElasticOut:create(scale)
            sender:runAction(ease_elastic)

        elseif eventType == ccui.TouchEventType.ended then
            local scale = cc.ScaleTo:create(1,1)
            local ease_elastic = cc.EaseElasticOut:create(scale)
            sender:runAction(ease_elastic)

            if bg == "ui/hall/battle/rank/availableButNotReceive.png" then--已达成未领取
                if LadderDef[i].TYPE == 1 then--宝箱
                    TreasureChestOpenObtainView:obtainFromTreasurePanel(layer,treasureChestType,LadderDef[i].TEXT)--宝箱获得物品弹窗
                    KnapsackData:setGoldCoin(LadderDef[i].TEXT)--金币数量增加
                elseif LadderDef[i].TYPE == 2 then

                end
                statusBg:loadTexture("ui/hall/battle/rank/Available.png")
                iconStatus:loadTexture("ui/hall/battle/rank/group 130.png")
                statusBg:setTouchEnabled(false)
            end
            KnapsackData:sendData()
        elseif eventType == ccui.TouchEventType.canceled then
            local scale = cc.ScaleTo:create(1,1)
            local ease_elastic = cc.EaseElasticOut:create(scale)
            sender:runAction(ease_elastic)
        end
    end)
    statusBg:setTouchEnabled(true)
    statusBg:addTo(itemLayer)
    listView:pushBackCustomItem(itemLayer)
end


return Battle