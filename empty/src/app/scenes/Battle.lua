local Battle = class("Battle")

local function touchEvent(sender,eventType,bg)--按钮点击事件
    if eventType == ccui.TouchEventType.began then
        if bg == "ui/hall/battle/rank/lockedBorder.png" then--未达成未领取

        elseif bg == "ui/hall/battle/rank/availableButNotReceive.png" then--已达成未领取

        elseif bg == "ui/hall/battle/rank/Available.png" then--已达成已领取

        end

        local scale = cc.ScaleTo:create(0.8,0.7)
        local ease_elastic = cc.EaseElasticOut:create(scale)
        sender:runAction(ease_elastic)

    elseif eventType == ccui.TouchEventType.ended then
        local scale = cc.ScaleTo:create(0.8,0.8)
        local ease_elastic = cc.EaseElasticOut:create(scale)
        sender:runAction(ease_elastic)

    elseif eventType == ccui.TouchEventType.canceled then
        local scale = cc.ScaleTo:create(0.8,0.8)
        local ease_elastic = cc.EaseElasticOut:create(scale)
        sender:runAction(ease_elastic)
    end
end
function Battle:ctor()

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
    listView:setContentSize(570,285)
    listView:setPosition(50,0)
    listView:setAnchorPoint(0, 0)
    listView:setDirection(1)
    listView:addTo(highLadderLayer)
    --滑动层
    local slideLayer = ccui.Layout:create()
    slideLayer:setBackGroundColorOpacity(180)--设置为透明
    --slideLayer:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid) --设置颜色
    --slideLayer:setBackGroundColorOpacity(128)--设置透明度
    slideLayer:setContentSize(676, 285)
    slideLayer:setPosition(0,0)
    slideLayer:setAnchorPoint(0,1)
    listView:addChild(slideLayer)

    --进度条
    self:slideCreate(slideLayer,score)
    --奖励
    self:awardPanel(slideLayer,"true","false",score)
    --图标:钥匙
    local key = ccui.ImageView:create("ui/hall/battle/rank/scale/key.png")
    key:setScale(0.9,0.9)
    key:pos(10, 70)
    key:setAnchorPoint(0.5, 0.5)
    key:addTo(slideLayer)

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
function Battle:awardPanel(layer,reachStatus,receiveStatus,score)
    local num = score/50--奖励进度
    print("共可领取的奖励个数为:"..num)
    --默认状态为未达成未领取
    local bg = "ui/hall/battle/rank/lockedBorder.png"
    local icon = "ui/hall/battle/rank/locked.png"
    local bgOriginX = 110
    for i = 1,num do
        if reachStatus == "true" then--已达成
            if receiveStatus == "false" then--未领取
                bg = "ui/hall/battle/rank/availableButNotReceive.png"
                icon = "null"
            elseif receiveStatus == "true" then --已领取
                bg = "ui/hall/battle/rank/Available.png"
                icon = "ui/hall/battle/rank/group 130.png"
            end
        end
        --背景状态框
        local statusBg = ccui.ImageView:create(bg)
        --statusBg:setScale(1.1,1.1)
        statusBg:pos(bgOriginX, 180)
        statusBg:setAnchorPoint(0.5, 0.5)
        statusBg:addTo(layer)
        bgOriginX = bgOriginX+177
        --下方小图标
        if icon~="null" then
            local iconStatus = ccui.ImageView:create(icon)
            --iconStatus:setScale(0.9,0.9)
            iconStatus:pos(75, 0)
            iconStatus:setAnchorPoint(0.5, 0.5)
            iconStatus:addTo(statusBg)
        end
    end
    for i = num+1,23 do
        local bg = "ui/hall/battle/rank/lockedBorder.png"
        local icon = "ui/hall/battle/rank/locked.png"
        --背景状态框
        local statusBg = ccui.ImageView:create(bg)
        --statusBg:setScale(0.9,0.9)
        statusBg:pos(bgOriginX, 180)
        statusBg:setAnchorPoint(0.5, 0.5)
        statusBg:addTo(layer)
        bgOriginX = bgOriginX+177
        --下方小图标
        if icon~="null" then
            local iconStatus = ccui.ImageView:create(icon)
            --iconStatus:setScale(0.9,0.9)
            iconStatus:pos(75, 0)
            iconStatus:setAnchorPoint(0.5, 0.5)
            iconStatus:addTo(statusBg)
        end
    end

    local awardOriginX = 110


    --奖励图标
    local firstAward = ccui.Button:create("ui/hall/shop/Diamond-shop/TreasureChest - RARE.png")
    firstAward:setScale(0.8,0.8)
    firstAward:pos(awardOriginX, 180)
    firstAward:setAnchorPoint(0.5, 0.5)
    firstAward:addTo(layer)
    firstAward:addTouchEventListener(touchEvent)
    awardOriginX = awardOriginX+177
    local secondAward =  ccui.Button:create("ui/hall/battle/rank/coin.png")
    secondAward:setScale(0.8,0.8)
    secondAward:pos(awardOriginX, 180)
    secondAward:setAnchorPoint(0.5, 0.5)
    secondAward:addTo(layer)
    secondAward:addTouchEventListener(touchEvent)
    awardOriginX = awardOriginX+177
    local thirdAward = ccui.Button:create("ui/hall/shop/Diamond-shop/TreasureChest - normal.png")
    thirdAward:setScale(0.8,0.8)
    thirdAward:pos(awardOriginX, 180)
    thirdAward:setAnchorPoint(0.5, 0.5)
    thirdAward:addTo(layer)
    thirdAward:addTouchEventListener(touchEvent)
    awardOriginX = awardOriginX+177
    for i = 1,9 do--200~1000分之间，每100分奖励一个稀有宝箱
        local rareAward = ccui.Button:create("ui/hall/shop/Diamond-shop/TreasureChest - Epic.png")
        rareAward:setScale(0.8,0.8)
        rareAward:pos(awardOriginX, 180)
        rareAward:setAnchorPoint(0.5, 0.5)
        rareAward:addTo(layer)
        rareAward:addTouchEventListener(touchEvent)
        awardOriginX = awardOriginX+177
    end
    --第1000分固定传奇卡一张
    local OnekAward = ccui.Button:create("ui/hall/battle/rank/highLadderLegendCard/group 914.png")
    OnekAward:setScale(0.8,0.8)
    OnekAward:pos(awardOriginX, 180)
    OnekAward:setAnchorPoint(0.5, 0.5)
    OnekAward:addTo(layer)
    OnekAward:addTouchEventListener(touchEvent)
    awardOriginX = awardOriginX+177

    --普通宝箱、钻石、金币轮换出现
    for i = 1,3 do--200~1000分之间，每100分奖励一个稀有宝箱
        local treasureAward = ccui.Button:create("ui/hall/shop/Diamond-shop/TreasureChest - normal.png")
        treasureAward:setScale(0.8,0.8)
        treasureAward:pos(awardOriginX, 180)
        treasureAward:setAnchorPoint(0.5, 0.5)
        treasureAward:addTo(layer)
        treasureAward:addTouchEventListener(touchEvent)
        awardOriginX = awardOriginX+177

        local diamondAward = ccui.Button:create("ui/hall/battle/rank/diamond.png")
        diamondAward:setScale(0.8,0.8)
        diamondAward:pos(awardOriginX, 180)
        diamondAward:setAnchorPoint(0.5, 0.5)
        diamondAward:addTo(layer)
        diamondAward:addTouchEventListener(touchEvent)
        awardOriginX = awardOriginX+177

        local coinAward = ccui.Button:create("ui/hall/battle/rank/coin.png")
        coinAward:setScale(0.8,0.8)
        coinAward:pos(awardOriginX, 180)
        coinAward:setAnchorPoint(0.5, 0.5)
        coinAward:addTo(layer)
        coinAward:addTouchEventListener(touchEvent)
        awardOriginX = awardOriginX+177
    end

    --第2000分随机传奇卡一张
    local twokAward = ccui.Button:create("ui/hall/battle/rank/group92.png")
    twokAward:setScale(0.8,0.8)
    twokAward:pos(awardOriginX, 180)
    twokAward:setAnchorPoint(0.5, 0.5)
    twokAward:addTo(layer)
    twokAward:addTouchEventListener(touchEvent)
    awardOriginX = awardOriginX+197
end
--[[
    函数用途：填充进度条背景
    --]]
function Battle:slideCreate(layer,score)
    local distance = 550
    local originX = 60-55
    local originY = 50
    local scaleOriginX = -15-55
    local scaleDistance = 177
    local num = score/50--得出达到了第几个奖励
    --进度条背景
    for i = 1,7 do
        local slidebg = ccui.ImageView:create("ui/hall/battle/rank/scale/ascale.png")
        slidebg:setScale(1.13,0.9)
        slidebg:setAnchorPoint(0, 0)
        slidebg:setPosition(originX, originY)
        slidebg:addTo(layer)
        local scale = ccui.ImageView:create("ui/hall/battle/rank/scale/scale.png")
        scale:setScale(1,1)
        scale:setAnchorPoint(0, 0)
        scale:setPosition(cc.p(scaleOriginX, originY+5))
        scale:addTo(layer)
        originX =originX+distance
        scaleOriginX = scaleOriginX+scaleDistance
    end

    local barPro = cc.ProgressTimer:create(cc.Sprite:create("ui/hall/battle/rank/scale/rectangle1.png"))--进度条组件
    barPro:setScale(0.931,0.9)
    barPro:setAnchorPoint(0, 0)
    barPro:setPosition(5, originY+4)
    barPro:setType(cc.PROGRESS_TIMER_TYPE_BAR)
    barPro:setMidpoint(cc.p(0, 0))--进度条起点位置
    barPro:setBarChangeRate(cc.p(1, 0))--进度方向为水平方向
    barPro:addTo(layer)
    barPro:setPercentage(0)--起始进度为0

    local offset = 4.4
    local process = 0
    if num ~= 0 then
        process = (num-1)*offset
    end
    local actionToFirst = cc.ProgressFromTo:create(0,0,2.6+process)--动作：0秒内从0到2.6+process
    local callFuncAction = cc.CallFunc:create(function()--动作执行完毕回调函数

    end)
    local delayTimeAction = cc.DelayTime:create(0.5)--延时0.5s
    local sequenceAction = cc.Sequence:create(actionToFirst,delayTimeAction,callFuncAction)
    barPro:runAction(sequenceAction)

end









--[[
    函数用途：滑动事件
    --]]
function Battle:slide(layer)
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
        local x1 = location["x"] or 0
        local location2 = touch:getLocationInView()
        local x2 = location2["x"] or 0
        if x1<x2 then
            str = "right"
        elseif x1>x2 then
            str = "left"
        end
    end
    local function onTouchEnded(touch, event)
        if str == "right" then
            self:slideShop(layer,570)
            print(str)
        elseif str == "left" then
            self:slideShop(layer,-570)
            print(str)
        end
    end

    listener:registerScriptHandler(onTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN )
    listener:registerScriptHandler(onTouchMoved,cc.Handler.EVENT_TOUCH_MOVED )
    listener:registerScriptHandler(onTouchEnded,cc.Handler.EVENT_TOUCH_ENDED )
    cc.Director:getInstance():getEventDispatcher():addEventListenerWithSceneGraphPriority(listener, layer)
end

--[[
    函数用途：页面的滑动
    --]]
function Battle:slideShop(layer,distance)
    local moveAction = cc.MoveBy:create(0.5,cc.p(distance,0))
    layer:runAction(moveAction)
end


return Battle