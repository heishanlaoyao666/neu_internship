
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)
score = 200
function MainScene:ctor()

    self:createMiddleMiddlePanel()
    self:highLadder()
    --开始游戏按钮
    local images = {
        normal = "ui/hall/battle/Button-Battle_Mode.png",
        pressed = "",
        disabled = "ui/hall/battle/Button-Battle_Mode.png"
    }

    local NewGameBtn = ccui.Button:create(images["normal"], images["pressed"], images["disabled"])
    NewGameBtn:setAnchorPoint(cc.p(0.5 ,0.5))
    -- 居中
    NewGameBtn:setPosition(cc.p(display.cx, display.cy))
    -- 设置缩放程度
    NewGameBtn:setScale(0.5, 0.5)
    -- 设置是否禁用(false为禁用)
    NewGameBtn:setEnabled(true)
    -- registerBtn:addClickEventListener(function()
    --     print("lalala")
    -- end)

    NewGameBtn:addTouchEventListener(function(sender, eventType)
	 	if eventType == ccui.TouchEventType.ended then
	 		local ABtn = import("app.scenes.GameView.GameScene"):new()
            display.replaceScene(ABtn,"turnOffTiles",0.5)
	 	end
	end)

    self:addChild(NewGameBtn, 4)

    self:createMiddleBottomPanel()
    self:createMiddleTopPanel()


end


--[[
    函数用途：展示天梯
    --]]
function MainScene:highLadder()
    --层：天梯背景
    local highLadderLayer = ccui.ImageView:create("ui/hall/battle/rank/highLadderBg.png")
    highLadderLayer:pos(display.cx, display.top-320)
    highLadderLayer:setAnchorPoint(0.5, 0.5)
    highLadderLayer:addTo(self)
    --滑动层
    local slideLayer = ccui.Layout:create()
    slideLayer:setBackGroundColorOpacity(180)--设置为透明
    --slideLayer:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid) --设置颜色
    --slideLayer:setBackGroundColorOpacity(128)--设置透明度
    --slideLayer:setBackGroundColor(cc.c3b(51, 51, 51))
    slideLayer:setContentSize(10000, 285)
    slideLayer:setPosition(0, 283)
    slideLayer:setAnchorPoint(0,1)
    slideLayer:addTo(highLadderLayer)
    self:slide(slideLayer)
    --进度条
    self:slideCreate(slideLayer,score)
    --奖励
    self:awardPanel(slideLayer,"true","false",score)
    --图标:钥匙
    local key = ccui.ImageView:create("ui/hall/battle/rank/scale/key.png")
    key:setScale(0.9,0.9)
    key:pos(60, 70)
    key:setAnchorPoint(0.5, 0.5)
    key:addTo(slideLayer)

    --左侧遮罩
    --[[local leftLayer = ccui.Layout:create()
    leftLayer:setBackGroundColorOpacity(180)--设置为透明
    leftLayer:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid) --设置颜色
    leftLayer:setBackGroundColorOpacity(128)--设置透明度
    leftLayer:setBackGroundColor(cc.c3b(51, 51, 51))
    leftLayer:setContentSize(100, 285)
    leftLayer:setPosition(-50, 0)
    leftLayer:setAnchorPoint(0,0)
    leftLayer:addTo(highLadderLayer)
    --]]
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
            self:slideShop(slideLayer,570)
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
            self:slideShop(slideLayer,-570)
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
    函数用途：展示各个进度的奖励
    --]]
function MainScene:awardPanel(layer,reachStatus,receiveStatus,score)
    local num = score/50--奖励进度
    print("共可领取的奖励个数为:"..num)
    --默认状态为未达成未领取
    local bg = "ui/hall/battle/rank/lockedBorder.png"
    local icon = "ui/hall/battle/rank/locked.png"
    local bgOriginX = 165
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
        statusBg:setScale(0.9,0.9)
        statusBg:pos(bgOriginX, 180)
        statusBg:setAnchorPoint(0.5, 0.5)
        statusBg:addTo(layer)
        bgOriginX = bgOriginX+177
        --下方小图标
        if icon~="null" then
            local iconStatus = ccui.ImageView:create(icon)
            iconStatus:setScale(0.9,0.9)
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
        statusBg:setScale(0.9,0.9)
        statusBg:pos(bgOriginX, 180)
        statusBg:setAnchorPoint(0.5, 0.5)
        statusBg:addTo(layer)
        bgOriginX = bgOriginX+177
        --下方小图标
        if icon~="null" then
            local iconStatus = ccui.ImageView:create(icon)
            iconStatus:setScale(0.9,0.9)
            iconStatus:pos(75, 0)
            iconStatus:setAnchorPoint(0.5, 0.5)
            iconStatus:addTo(statusBg)
        end
    end

    local awardOriginX = 165
    --奖励图标
    local firstAward = ccui.ImageView:create("ui/hall/shop/Diamond-shop/TreasureChest - RARE.png")
    firstAward:setScale(0.7,0.7)
    firstAward:pos(awardOriginX, 180)
    firstAward:setAnchorPoint(0.5, 0.5)
    firstAward:addTo(layer)
    awardOriginX = awardOriginX+177
    local secondAward =  ccui.ImageView:create("ui/hall/battle/rank/coin.png")
    secondAward:pos(awardOriginX, 180)
    secondAward:setAnchorPoint(0.5, 0.5)
    secondAward:addTo(layer)
    awardOriginX = awardOriginX+177
    local thirdAward = ccui.ImageView:create("ui/hall/shop/Diamond-shop/TreasureChest - normal.png")
    thirdAward:setScale(0.7,0.7)
    thirdAward:pos(awardOriginX, 180)
    thirdAward:setAnchorPoint(0.5, 0.5)
    thirdAward:addTo(layer)
    awardOriginX = awardOriginX+177
    for i = 1,9 do--200~1000分之间，每100分奖励一个稀有宝箱
        local rareAward = ccui.ImageView:create("ui/hall/shop/Diamond-shop/TreasureChest - Epic.png")
        rareAward:setScale(0.7,0.7)
        rareAward:pos(awardOriginX, 180)
        rareAward:setAnchorPoint(0.5, 0.5)
        rareAward:addTo(layer)
        awardOriginX = awardOriginX+177
    end
    --第1000分固定传奇卡一张
    local OnekAward = ccui.ImageView:create("ui/hall/battle/rank/highLadderLegendCard/group 914.png")
    --OnekAward:setScale(0.7,0.7)
    OnekAward:pos(awardOriginX, 180)
    OnekAward:setAnchorPoint(0.5, 0.5)
    OnekAward:addTo(layer)
    awardOriginX = awardOriginX+177

    --普通宝箱、钻石、金币轮换出现
    for i = 1,3 do--200~1000分之间，每100分奖励一个稀有宝箱
        local treasureAward = ccui.ImageView:create("ui/hall/shop/Diamond-shop/TreasureChest - normal.png")
        treasureAward:setScale(0.7,0.7)
        treasureAward:pos(awardOriginX, 180)
        treasureAward:setAnchorPoint(0.5, 0.5)
        treasureAward:addTo(layer)
        awardOriginX = awardOriginX+177

        local diamondAward = ccui.ImageView:create("ui/hall/battle/rank/diamond.png")
        --diamondAward:setScale(0.7,0.7)
        diamondAward:pos(awardOriginX, 180)
        diamondAward:setAnchorPoint(0.5, 0.5)
        diamondAward:addTo(layer)
        awardOriginX = awardOriginX+177

        local coinAward = ccui.ImageView:create("ui/hall/battle/rank/coin.png")
        --coinAward:setScale(0.7,0.7)
        coinAward:pos(awardOriginX, 180)
        coinAward:setAnchorPoint(0.5, 0.5)
        coinAward:addTo(layer)
        awardOriginX = awardOriginX+177
    end

    --第2000分随机传奇卡一张
    local OnekAward = ccui.ImageView:create("ui/hall/battle/rank/group92.png")
    OnekAward:pos(awardOriginX, 180)
    OnekAward:setAnchorPoint(0.5, 0.5)
    OnekAward:addTo(layer)
    awardOriginX = awardOriginX+197
end
--[[
    函数用途：填充进度条背景
    --]]
function MainScene:slideCreate(layer,score)
    local distance = 550
    local originX = 60
    local originY = 50
    local scaleOriginX = -15
    local scaleDistance = 177
    local num = score/50--得出达到了第几个奖励
    print(num)
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
    barPro:setPosition(60, originY+4)
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
    local actionToFirst = cc.ProgressFromTo:create(0,0,2.6+process)--动作：5秒内从0到100
    local callFuncAction = cc.CallFunc:create(function()--动作执行完毕回调函数

    end)
    local delayTimeAction = cc.DelayTime:create(0.5)--延时0.5s
    local sequenceAction = cc.Sequence:create(actionToFirst,delayTimeAction,callFuncAction)
    barPro:runAction(sequenceAction)

end

--[[
    函数用途：滑动商店触摸事件
    --]]
function MainScene:slide(layer)
    str = "null"
    local listener = cc.EventListenerTouchOneByOne:create()--单点触摸
    local function onTouchBegan(touch, event)
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
    函数用途：商店页面的滑动
    --]]
function MainScene:slideShop(layer,distance)
    local moveAction = cc.MoveBy:create(0.5,cc.p(distance,0))
    layer:runAction(moveAction)
end




--[[
    函数用途：实现左右翻页
    --]]
function MainScene:sliderView(layer)
    -- PageView
    local pageView = ccui.PageView:create()
    -- 设置PageView容器尺寸
    pageView:setBackGroundColor(cc.c3b(200,200,255))
    pageView:setBackGroundColorType(1)
    pageView:setContentSize(720, 1280)
    pageView:setTouchEnabled(true)    -- 设置可触摸 若设置为false 则不能响应触摸事件
    pageView:setAnchorPoint(0.5, 0.5)
    pageView:setPosition(display.cx, display.cy)
    pageView:addPage(layer)
    for i = 1,3 do
        local layer = ccui.Layout:create()
        layer:setAnchorPoint(0, 0)
        layer:setPosition(0, 0)
        layer:setContentSize(720, 1280)
        local image = ccui.ImageView:create("TreasureChest - Epic.png")
        image:setPosition(display.cx, display.cy)
        image:addTo(layer)
        pageView:addPage(layer)
    end

    -- 触摸回调
    local function PageViewCallBack(sender,event)
        -- 翻页时
        if event==ccui.PageViewEventType.turning then
            -- getCurrentPageIndex() 获取当前翻到的页码 打印
            print("当前页码是"..pageView:getCurPageIndex() + 1)
        end
    end
    pageView:addEventListener(PageViewCallBack)
    self:addChild(pageView, 0)

end

--bg-battle_interface.png
function MainScene:createMiddleMiddlePanel()
    local width ,height  =display.width,display.top
    local settingLayer = ccui.Layout:create()
    settingLayer:setBackGroundImage("ui/hall/battle/bg-battle_interface.png")
    settingLayer:setContentSize(width,height)
    settingLayer:setAnchorPoint(0.5,0.5)
    settingLayer:setPosition(width*0.5,height*0.5)
    
    settingLayer:addTo(self)

end

function MainScene:createMiddleBottomPanel()
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

    AtlasBtn:addTouchEventListener(function(sender, eventType)
		if 2 == eventType then
			local atlasScene=import("app/scenes/AtlasScene"):new()
            display.replaceScene(atlasScene)
		end
	end)
    
end
--顶部
function MainScene:createMiddleTopPanel()
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
			-- local newScene=import("app/scenes/HeadScene"):new()
            -- display.replaceScene(newScene)
            cc.Director:getInstance():pushScene(require("app.scenes.HeadScene").new())
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
            cc.Director:getInstance():pushScene(require("app.scenes.SettingScene").new())
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

--[[
    函数用途：实现左右翻页
    --]]
function MainScene:sliderView(layer)
    -- PageView
    local pageView = ccui.PageView:create()
    -- 设置PageView容器尺寸
    pageView:setBackGroundColor(cc.c3b(200,200,255))
    pageView:setBackGroundColorType(1)
    pageView:setContentSize(720, 1280)
    pageView:setTouchEnabled(true)    -- 设置可触摸 若设置为false 则不能响应触摸事件
    pageView:setAnchorPoint(0.5, 0.5)
    pageView:setPosition(display.cx, display.cy)
    pageView:addPage(layer)
    for i = 1,3 do
        local layer = ccui.Layout:create()
        layer:setAnchorPoint(0, 0)
        layer:setPosition(0, 0)
        layer:setContentSize(720, 1280)
        local image = ccui.ImageView:create("TreasureChest - Epic.png")
        image:setPosition(display.cx, display.cy)
        image:addTo(layer)
        pageView:addPage(layer)
    end

    -- 触摸回调
    local function PageViewCallBack(sender,event)
        -- 翻页时
        if event==ccui.PageViewEventType.turning then
            -- getCurrentPageIndex() 获取当前翻到的页码 打印
            print("当前页码是"..pageView:getCurPageIndex() + 1)
        end
    end
    pageView:addEventListener(PageViewCallBack)
    self:addChild(pageView, 0)

end

--[[
    函数用途：加载界面，加载完毕后切换至游戏大厅
    --]]
function MainScene:loadingPanel()
    local loadPanel = ccui.Layout:create()--加载页面层级
    loadPanel:setContentSize(720, 1280)
    loadPanel:setAnchorPoint(0, 0)
    loadPanel:setPosition(0,0)
    loadPanel:addTo(self)

    display.newSprite("ui/loading/bottomchart.jpg")--加载页面_背景图
           :pos(display.cx,display.cy)
           :addTo(loadPanel)

    local tips = cc.Label:createWithTTF("大厅预加载，进行中...","ui/font/fzhz.ttf",20)--文本：大厅预加载
    tips:setPosition(360,30)
    tips:setColor(cc.c3b(255,255,255))
    tips:addTo(loadPanel)

    local progressNum = 0--文本：加载进度
    local progress = cc.Label:createWithTTF(progressNum,"ui/font/fzhz.ttf",20)
    progress:setPosition(650,30)
    progress:setColor(cc.c3b(255,239,117))
    progress:addTo(loadPanel)

    --[[ cc.Director:getInstance():getScheduler():scheduleScriptFunc(
             function()
                 progressNum = progressNum+1
                 progress:setString(progressNum)
             end,0.1,false)--]]



    local barProBg = cc.Sprite:create("ui/loading/processbar_bottomchart.png")--进度条背景
    barProBg:setAnchorPoint(0,0)
    barProBg:setScale(48,1)
    barProBg:setPosition(0, 0)
    barProBg:addTo(loadPanel)

    local barPro = cc.ProgressTimer:create(cc.Sprite:create("ui/loading/processbar_stretch_full.png"))--进度条组件
    barPro:setAnchorPoint(0,0)
    barPro:setPosition(cc.p(0, 0))
    barPro:setType(cc.PROGRESS_TIMER_TYPE_BAR)
    barPro:setMidpoint(cc.p(0, 0))--进度条起点位置
    barPro:setBarChangeRate(cc.p(1, 0))--进度方向为水平方向
    barPro:addTo(loadPanel)
    barPro:setPercentage(0)--起始进度为0

    local loadAction = cc.ProgressFromTo:create(5,0,100)--动作：5秒内从0到100
    local callFuncAction = cc.CallFunc:create(function()--动作执行完毕回调函数
        loadPanel:setVisible(false)
    end)
    local delayTimeAction = cc.DelayTime:create(0.5)--延时0.5s
    local sequenceAction = cc.Sequence:create(loadAction,delayTimeAction,callFuncAction)
    barPro:runAction(sequenceAction)

end



function MainScene:onEnter()
end

function MainScene:onExit()
end

return MainScene
