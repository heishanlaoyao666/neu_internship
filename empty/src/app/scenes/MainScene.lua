
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)
score = 200
local TopPanel = require("app.scenes.TopPanel")
local Shop = require("app.scenes.Shop")
local Atlas = require("app.scenes.Atlas")
local Battle = require("app.scenes.Battle")
function MainScene:ctor()
    local shop = Shop.new()
    local atlas = Atlas.new()
    local battle = Battle.new()
    local layer1 = shop:ShopPanel()
    local layer2 = battle:battlePanel()
    local layer3 = atlas:createCollectionPanel()
    self:createBg()--创建主界面背景图

    local pageView = self:sliderView(layer1,layer2,layer3)--将商店、战斗、图鉴界面加入到翻页中
    self:createMiddleBottomPanel(pageView)--底部按钮导航栏

    local layer = ccui.Layout:create()
    layer:setBackGroundColorOpacity(180)--设置为透明
    --layer:setBackGroundColorType(1)
    layer:setAnchorPoint(0.5, 0.5)
    layer:setPosition(cc.p(display.cx, display.cy))
    layer:setContentSize(720, 1280)
    layer:addTo(self)
    TopPanel:createMiddleTopPanel(layer)--顶部信息栏
    --TopPanel:init(layer)


end

--[[
    函数用途：实现左右翻页
    --]]
function MainScene:sliderView(layer1,layer2,layer3)
    -- PageView
    local pageView = ccui.PageView:create()
    -- 设置PageView容器尺寸
    pageView:setContentSize(720, 1280)
    pageView:setTouchEnabled(true)    -- 设置可触摸 若设置为false 则不能响应触摸事件
    pageView:setAnchorPoint(0.5, 0.5)
    pageView:setPosition(display.cx, display.cy-140)
    pageView:addPage(layer1)
    pageView:addPage(layer2)
    pageView:addPage(layer3)
    -- 触摸回调
    local function PageViewCallBack(sender,event)
        -- 翻页时
        if event==ccui.PageViewEventType.turning then
            -- getCurrentPageIndex() 获取当前翻到的页码 打印
            print("当前页码是"..pageView:getCurPageIndex() + 1)
        end
    end
    pageView:addEventListener(PageViewCallBack)
    pageView:scrollToPage(1)
    self:addChild(pageView, 0)
    return pageView
end

function MainScene:createBg()
    local width ,height  =display.width,display.top
    local bgLayer = ccui.Layout:create()
    bgLayer:setBackGroundImage("ui/hall/battle/bg-battle_interface.png")
    bgLayer:setContentSize(width,height)
    bgLayer:setAnchorPoint(0.5,0.5)
    bgLayer:setPosition(width*0.5,height*0.5)
    bgLayer:addTo(self)

end

function MainScene:createMiddleBottomPanel(pageView)
    local width,height = display.width,display.top
    local menuLayer = ccui.Layout:create()
    menuLayer:setContentSize(width,height)
    menuLayer:setAnchorPoint(0,0)
    menuLayer:setPosition(0,0)
    menuLayer:addTo(self)
    --按钮：商店
    local shopBtn = ccui.Button:create(
            "ui/hall/bottom-tab/tab-unselected-left.png",
            "ui/hall/bottom-tab/tab-selected.png",
            "ui/hall/bottom-tab/tab-unselected-left.png"
    )
    shopBtn:setAnchorPoint(0,0)
    shopBtn:setScale(240/230,1.2)
    shopBtn:pos(0,0)
    shopBtn:addTo(menuLayer)
    --商店按钮图标
    local shopImage = ccui.ImageView:create("ui/hall/bottom-tab/chart-shop.png")
    shopImage:setScale(0.9,0.9)
    shopImage:setAnchorPoint(0, 0)
    shopImage:setPosition(cc.p(33, 20))
    shopImage:addTo(shopBtn)
    --商店标题
    local shopName = ccui.ImageView:create("ui/hall/bottom-tab/title-shop.png")
    shopName:setScale(0.9,0.9)
    shopName:setAnchorPoint(0, 0)
    shopName:setPosition(cc.p(95, 5))
    shopName:addTo(shopBtn)
    shopName:setVisible(false)

    shopBtn:addTouchEventListener(function(sender, eventType)
        if eventType == ccui.TouchEventType.began then
            local scale = cc.ScaleTo:create(1,1)
            local ease_elastic = cc.EaseElasticOut:create(scale)
            shopImage:runAction(ease_elastic)
            shopName:setVisible(true)
        elseif eventType == ccui.TouchEventType.ended then
            local scale = cc.ScaleTo:create(0.9,0.9)
            local ease_elastic = cc.EaseElasticOut:create(scale)
            shopImage:runAction(ease_elastic)
            shopName:setVisible(false)
            pageView:scrollToPage(0)

        elseif eventType == ccui.TouchEventType.canceled then
            local scale = cc.ScaleTo:create(0.9,0.9)
            local ease_elastic = cc.EaseElasticOut:create(scale)
            shopImage:runAction(ease_elastic)
            shopName:setVisible(false)
        end
    end)


    --按钮：图鉴
    local atlasBtn = ccui.Button:create(
            "ui/hall/bottom-tab/tab-unselected-right.png",
            "ui/hall/bottom-tab/tab-selected.png",
            "ui/hall/bottom-tab/tab-unselected-right.png"
    )
    atlasBtn:setAnchorPoint(0,0)
    atlasBtn:setScale(240/230,1.2)
    atlasBtn:pos(0+230*240/230+230*240/230,0)
    atlasBtn:addTo(menuLayer)
    --图鉴按钮图标
    local atlasImage = ccui.ImageView:create("ui/hall/bottom-tab/chart-Atlas.png")
    atlasImage:setScale(0.9,0.9)
    atlasImage:setAnchorPoint(0, 0)
    atlasImage:setPosition(cc.p(33, 20))
    atlasImage:addTo(atlasBtn)
    --图鉴标题
    local atlasName = ccui.ImageView:create("ui/hall/bottom-tab/title-Atlas.png")
    atlasName:setScale(0.9,0.9)
    atlasName:setAnchorPoint(0, 0)
    atlasName:setPosition(cc.p(95, 5))
    atlasName:addTo(atlasBtn)
    atlasName:setVisible(false)
    atlasBtn:addTouchEventListener(function(sender, eventType)
        if eventType == ccui.TouchEventType.began then
            local scale = cc.ScaleTo:create(1,1)
            local ease_elastic = cc.EaseElasticOut:create(scale)
            atlasImage:runAction(ease_elastic)
            atlasName:setVisible(true)
        elseif eventType == ccui.TouchEventType.ended then
            local scale = cc.ScaleTo:create(0.9,0.9)
            local ease_elastic = cc.EaseElasticOut:create(scale)
            atlasImage:runAction(ease_elastic)
            atlasName:setVisible(false)
            pageView:scrollToPage(2)

        elseif eventType == ccui.TouchEventType.canceled then
            local scale = cc.ScaleTo:create(0.9,0.9)
            local ease_elastic = cc.EaseElasticOut:create(scale)
            atlasImage:runAction(ease_elastic)
            atlasName:setVisible(false)
        end
    end)

    --按钮：对战
    local battleBtn = ccui.Button:create(
            "ui/hall/bottom-tab/tab-unselected-middle.png",
            "ui/hall/bottom-tab/tab-selected.png",
            "ui/hall/bottom-tab/tab-unselected-middle.png"
    )
    battleBtn:setAnchorPoint(0,0)
    battleBtn:setScale(240/230,1.2)
    battleBtn:pos(0+230*240/230,0)
    battleBtn:addTo(menuLayer)
    --战斗按钮图标
    local battleImage = ccui.ImageView:create("ui/hall/bottom-tab/chart-battle.png")
    battleImage:setScale(0.9,0.9)
    battleImage:setAnchorPoint(0, 0)
    battleImage:setPosition(cc.p(33, 20))
    battleImage:addTo(battleBtn)
    --战斗标题
    local battleName = ccui.ImageView:create("ui/hall/bottom-tab/title-battle.png")
    battleName:setScale(0.9,0.9)
    battleName:setAnchorPoint(0, 0)
    battleName:setPosition(cc.p(95, 5))
    battleName:addTo(battleBtn)
    battleName:setVisible(false)
    battleBtn:addTouchEventListener(function(sender, eventType)
        if eventType == ccui.TouchEventType.began then
            local scale = cc.ScaleTo:create(1,1)
            local ease_elastic = cc.EaseElasticOut:create(scale)
            battleImage:runAction(ease_elastic)
            battleName:setVisible(true)
        elseif eventType == ccui.TouchEventType.ended then
            local scale = cc.ScaleTo:create(0.9,0.9)
            local ease_elastic = cc.EaseElasticOut:create(scale)
            battleImage:runAction(ease_elastic)
            battleName:setVisible(false)
            pageView:scrollToPage(1)

        elseif eventType == ccui.TouchEventType.canceled then
            local scale = cc.ScaleTo:create(0.9,0.9)
            local ease_elastic = cc.EaseElasticOut:create(scale)
            shopImage:runAction(ease_elastic)
            shopName:setVisible(false)
        end
    end)
    
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

return MainScene
