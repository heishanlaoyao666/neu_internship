local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

local TopTab = require("app.scenes.HallView.topTab.TopPanel")
local BottomTab = require("app.scenes.HallView.bottomTab.BottomTab")
local Shop = require("app.scenes.HallView.shop.Shop")
local Battle = require("app.scenes.HallView.battle.Battle")
local Atlas = require("app.scenes..HallView.atlas.Atlas")

local Music = require("app/data/Music")
local SettingMusic = require("src/app/scenes/SettingMusic")

local KnapsackData = require("app.data.KnapsackData")
local EventManager = require("app/manager/EventManager.lua")
local EventDef = require("app/def/EventDef.lua")

function MainScene:ctor()
    self:loadingPanel()--没播放完就被替换掉了，为啥
    KnapsackData:init()
    self:addNodeEventListener(cc.NODE_ENTER_FRAME_EVENT, handler(self, self.update))
    self:performWithDelay(function() 
        self:scheduleUpdate()
    end, 0.1)
    EventManager:regListener(EventDef.ID.KNAPSACK_LOGIN,self,function ()
        self:createBg()--创建主界面背景图

        local shopLayer = Shop:ShopPanelCreate()
        local battleLayer = Battle:battlePanelCreate()
        local atlasLayer = Atlas:createCollectionPanel()
        local pageView = self:sliderView(shopLayer,battleLayer,atlasLayer)--将商店、战斗、图鉴界面加入到翻页中

        local layer = ccui.Layout:create()
        layer:setBackGroundColorOpacity(180)--设置为透明
        --layer:setBackGroundColorType(1)
        layer:setAnchorPoint(0.5, 0.5)
        layer:setPosition(cc.p(display.cx, display.cy))
        layer:setContentSize(720, 1280)
        layer:addTo(self)
        self:bottomTab(layer,pageView)--底部按钮导航栏
        TopTab:createMiddleTopPanel(layer)--顶部信息栏

        local MusicOn = SettingMusic:isMusic2()
        print(MusicOn)
        if MusicOn == true then
            local audio = require("framework.audio")
            audio.loadFile(Music.MUSIC[1], function ()
                audio.playEffect(Music.MUSIC[1])
            end)
        else
            local audio = require("framework.audio")
            audio.loadFile(Music.MUSIC[1], function ()
                audio.stopEffect()
            end)
        end
    end)

    KnapsackData:Login()
end

--[[
    函数用途：实现左右翻页
    --]]
function MainScene:sliderView(shopLayer,battleLayer,atlasLayer)
    -- PageView
    local pageView = ccui.PageView:create()
    -- 设置PageView容器尺寸
    pageView:setContentSize(720, 1280)
    pageView:setTouchEnabled(true)
    pageView:setAnchorPoint(0.5, 0.5)
    pageView:setPosition(display.cx, display.cy-140)
    pageView:addPage(shopLayer)
    pageView:addPage(battleLayer)
    pageView:addPage(atlasLayer)
    pageView:scrollToPage(1)--初始页面为战斗界面
    self:addChild(pageView, 0)
    return pageView
end

--[[
    函数用途：大厅背景图
    --]]
function MainScene:createBg()
    local width ,height  =display.width,display.top
    local bgLayer = ccui.Layout:create()
    bgLayer:setBackGroundImage("ui/hall/battle/bg-battle_interface.png")
    bgLayer:setContentSize(width,height)
    bgLayer:setAnchorPoint(0.5,0.5)
    bgLayer:setPosition(width*0.5,height*0.5)
    bgLayer:addTo(self)
end

--[[
    函数用途：底部按钮栏
    --]]
function MainScene:bottomTab(layer,pageView)
    local bottomLayer = BottomTab:createBottomTab(layer)

    --未选择
    local shopUnselectedLayer = BottomTab:shopUnselectedLayer(bottomLayer)
    local atlasUnselectedLayer = BottomTab:atlasUnselectedLayer(bottomLayer)
    local battleUnselectedLayer = BottomTab:battleUnselectedLayer(bottomLayer)
    --已选择
    local shopSelectedLayer = BottomTab:shopSelectedLayer(bottomLayer)
    local atlasSelectedLayer = BottomTab:atlasSelectedLayer(bottomLayer)
    local battleSelectedLayer = BottomTab:battleSelectedLayer(bottomLayer)
    --点击事件
    BottomTab:clickEvent(pageView,shopUnselectedLayer,atlasUnselectedLayer,battleUnselectedLayer,
            shopSelectedLayer,atlasSelectedLayer,battleSelectedLayer)

    -- 触摸回调
    local function PageViewCallBack(sender,event)
        -- 翻页时
        if event==ccui.PageViewEventType.turning then
            local index = pageView:getCurPageIndex()--获取页码，从0开始
            if index == 0 then--商店状态
                BottomTab:shopState(shopSelectedLayer,atlasSelectedLayer,battleSelectedLayer)
            elseif index == 1 then--战斗状态
                BottomTab:battleState(shopSelectedLayer,atlasSelectedLayer,battleSelectedLayer)
            elseif index == 2 then--图鉴状态
                BottomTab:atlasState(shopSelectedLayer,atlasSelectedLayer,battleSelectedLayer)
            end
        end
    end
    pageView:addEventListener(PageViewCallBack)
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

    local loadingBg = ccui.ImageView:create("ui/loading/bottomchart.jpg")--加载页面_背景图
    loadingBg:pos(display.cx,display.cy)
    loadingBg:addTo(loadPanel)

    local tips = cc.Label:createWithTTF("大厅预加载，进行中...","ui/font/fzhz.ttf",20)--文本：大厅预加载
    tips:setPosition(360,30)
    tips:setColor(cc.c3b(255,255,255))
    tips:addTo(loadPanel)

    local progressNum = 0--文本：加载进度
    local progress = cc.Label:createWithTTF(progressNum.."%","ui/font/fzhz.ttf",20)
    progress:setPosition(650,30)
    progress:setColor(cc.c3b(255,239,117))
    progress:addTo(loadPanel)

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

    local loadAction = cc.ProgressFromTo:create(5,0,57)--动作：5秒内从0到100
    local progressScheduler= cc.Director:getInstance():getScheduler()--刷新生命计时器
    local handler = progressScheduler:scheduleScriptFunc(
            function()
                if progressNum<100 then
                    progressNum = progressNum+1
                    progress:setString(progressNum.."%")
                end
            end,1/24,false)
    local callFuncAction = cc.CallFunc:create(function()--动作执行完毕回调函数
        cc.Director:getInstance():getScheduler():unscheduleScriptEntry(handler)
        loadPanel:setVisible(false)
    end)
    local delayTimeAction = cc.DelayTime:create(1)--延时0.1s
    local sequenceAction = cc.Sequence:create(loadAction,delayTimeAction,callFuncAction)
    barPro:runAction(sequenceAction)


end
--[[--
    主界面帧循环

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function MainScene:update(dt)
    KnapsackData:update(dt)
    TopTab:update(dt)
    Shop:update(dt)
end
return MainScene
