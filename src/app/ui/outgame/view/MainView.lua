--[[--
    游戏主界面
    PlayView
]]
local MainView = class("MainView", function()
    return display.newColorLayer(cc.c4b(0, 0, 0, 0))
end)
local TopInfoLayer = require("app.ui.outgame.layer.TopInfoLayer")
local BottomInfoLayer = require("app.ui.outgame.layer.BottomInfoLayer")
local EventDef = require("app.def.EventDef")
local EventManager = require("app.manager.EventManager")
local KnapsackLayer = require("app.ui.outgame.layer.KnapsackLayer")
local IntensifiesLayer = require("app.ui.outgame.layer.IntensifiesLayer")
local ShopLayer = require("app.ui.outgame.layer.ShopLayer")
local BattleLayer = require("app.ui.outgame.layer.BattleLayer")
local BuyLayer = require("app.ui.outgame.layer.BuyLayer")
local ObtainItemLayer = require("app.ui.outgame.layer.ObtainItemLayer")
local ConfirmationLayer = require("app.ui.outgame.layer.ConfirmationLayer")
local SettingLayer = require("app.ui.outgame.layer.SettingLayer")
local ComfirmedExitLayer = require("app.ui.outgame.layer.ComfirmedExitLayer")
local MatchLayer = require("app.ui.outgame.layer.MatchLayer")
local UsingLayer = require("app.ui.outgame.layer.UsingLayer")
--local AnimLayer = require("app.ui.outgame.layer.AnimLayer")
--[[--
    构造函数

    @param none

    @return none
]]
function MainView:ctor()
    self.topInfoLayer_ = nil -- 类型：TopInfoLayer，顶部信息层
    self.bottomInfoLayer_ = nil -- 类型：BottomInfoLayer，底部信息层
    self.knapsackLayer_ = nil -- 类型：KnapsackLayer，背包层
    self.shopLayer_=nil -- 类型：ShopLayer，商店层
    self.battleLayer_=nil -- 类型：BattleLayer，战斗层
    --self.matchLayer_ = nil -- 类型：MatchLayer，匹配层
    self.buyLayer_=nil -- 类型：BuyLayer，购买层
    self.obtainItemLayer_=nil -- 类型：ObtainItemLayer，开宝箱层
    self.confirmationLayer_=nil -- 类型：ConfirmationLayer，获取宝箱物品层
    self.settingLayer_=nil -- 类型：SettingLayer，设置层
    self.comfirmedExitLayer_=nil -- 类型：ComfirmedExitLayer，确认退出层
    self.matchLayer_=nil -- 类型：MatchLayer，匹配层
    self.usingLayer_=nil -- 类型：UsingLayer，使用塔层
    --self.animLayer_=nil -- 类型：AnimLayer，动画层

    self:initView()

    self:registerScriptHandler(function(event)
        if event == "enter" then
            self:onEnter()
        elseif event == "exit" then
            self:onExit()
        end
    end)
end

--[[--
    界面初始化

    @param none

    @return none
]]
function MainView:initView()

    local page = ccui.PageView:create()
    local width, height = display.width, 1120


    do
        --战斗界面（游戏外）
        self.container_ = ccui.Layout:create()
        self.container_:setContentSize(display.width, height)
        self.container_:setPosition(0, 0)

        self.battleLayer_=BattleLayer.new()
        self.container_:addChild(self.battleLayer_)
    end

    do
        --商店界面
        self.container_1 = ccui.Layout:create()
        self.container_1:setContentSize(display.width, height)
        self.container_1:setPosition(0, 0)

        self.shopLayer_=ShopLayer.new()
        self.container_1:addChild(self.shopLayer_)

    end

    do
        --图鉴界面
        self.container_2 = ccui.Layout:create()
        self.container_2:setContentSize(display.width, height)
        self.container_2:setPosition(0, 0)

        self.knapsackLayer_=KnapsackLayer.new()
        self.container_2:addChild(self.knapsackLayer_)
    end

    page:addPage(self.container_1)
    page:addPage(self.container_)
    page:addPage(self.container_2)
    self:addChild(page)
    page:setContentSize(720,1200)
    page:setTouchEnabled(true)
    page:setAnchorPoint(cc.p(0.5,0.5))
    page:setPosition(display.cx,display.cy)
    page:scrollToPage(1)

    cc.UserDefault:getInstance():setIntegerForKey("bottom",1)
    self.bottomInfoLayer_1 = BottomInfoLayer.new()
    self:addChild(self.bottomInfoLayer_1)
    self.bottomInfoLayer_1:setVisible(false)
    cc.UserDefault:getInstance():setIntegerForKey("bottom",2)
    self.bottomInfoLayer_2 = BottomInfoLayer.new()
    self:addChild(self.bottomInfoLayer_2)
    self.bottomInfoLayer_2:setVisible(false)
    cc.UserDefault:getInstance():setIntegerForKey("bottom",3)
    self.bottomInfoLayer_3 = BottomInfoLayer.new()
    self:addChild(self.bottomInfoLayer_3)
    self.bottomInfoLayer_3:setVisible(false)

    page:addEventListener(function(sender,event)
        if event==ccui.PageViewEventType.turning then
            self:setName(page:getCurPageIndex())
            --print("当前页码是"..page:getCurPageIndex())
            if page:getCurPageIndex()==0 then
                self.bottomInfoLayer_1:setVisible(true)
                self.bottomInfoLayer_2:setVisible(false)
                self.bottomInfoLayer_3:setVisible(false)
            elseif page:getCurPageIndex()==1 then
                self.bottomInfoLayer_1:setVisible(false)
                self.bottomInfoLayer_2:setVisible(true)
                self.bottomInfoLayer_3:setVisible(false)
            elseif page:getCurPageIndex()==2 then
                self.bottomInfoLayer_1:setVisible(false)
                self.bottomInfoLayer_2:setVisible(false)
                self.bottomInfoLayer_3:setVisible(true)
            end
        end
    end)

    self.topInfoLayer_ = TopInfoLayer.new()
    self:addChild(self.topInfoLayer_)

    -- self.animLayer_ = AnimLayer.new()
    -- self:addChild(self.animLayer_)
end

--[[--
    修改头像

    @param none

    @return none
]]
-- function MainView:setSprite(filename)
--     self.topInfoLayer_ = TopInfoLayer.new()
--     self.topInfoLayer_:setSprite1(filename)
--     self:addChild(self.topInfoLayer_)
-- end

--[[--
    节点进入

    @param none

    @return none
]]
function MainView:onEnter()
    EventManager:regListener(EventDef.ID.PORTRAIT_CHANGE, self, function(filename)
        self.topInfoLayer_:setSprite1(filename)
    end)
    EventManager:regListener(EventDef.ID.GAMEDATA_CHANGE, self, function()
        self.topInfoLayer_:setData()
    end)
    EventManager:regListener(EventDef.ID.KNAPSACK_CHANGE, self, function()
        self.knapsackLayer_=KnapsackLayer.new()
        self.container_2:addChild(self.knapsackLayer_)
    end)
    EventManager:regListener(EventDef.ID.INTENSIFIES, self, function(pack)
        IntensifiesLayer:setTower(pack)
        IntensifiesLayer:new():addTo(self)
    end)
    EventManager:regListener(EventDef.ID.BUY, self, function()
        self.buyLayer_=BuyLayer.new()
        self:addChild(self.buyLayer_)
    end)
    EventManager:regListener(EventDef.ID.OBTAINITEM, self, function()
        self.obtainItemLayer_=ObtainItemLayer:new():addTo(self)
    end)
    EventManager:regListener(EventDef.ID.COMFIRMATION, self, function()
        self.confirmationLayer_=ConfirmationLayer:new():addTo(self)
    end)
    EventManager:regListener(EventDef.ID.SETTING, self, function()
        self.settingLayer_=SettingLayer:new():addTo(self)
    end)
    EventManager:regListener(EventDef.ID.COMFIRMEDEXIT, self, function()
        self.comfirmedExitLayer_=ComfirmedExitLayer:new():addTo(self)
    end)
    EventManager:regListener(EventDef.ID.MATCH, self, function()
        self.matchLayer_=MatchLayer:new():addTo(self)
    end)
    EventManager:regListener(EventDef.ID.USING, self, function(pack)
        self.knapsackLayer_:removeFromParent(true)
        UsingLayer:setTower(pack)
        self.usingLayer_=UsingLayer:new():addTo(self.container_2)
    end)
    EventManager:regListener(EventDef.ID.BATTLE, self, function(pack)
        self.battleLayer_:removeFromParent(true)
        self.battleLayer_=BattleLayer.new()
        self.container_:addChild(self.battleLayer_)
    end)
    -- EventManager:regListener(EventDef.ID.FREE, self, function()
    --     print("free")
    --     --audio.playEffect("sounds/shipDestroyEffect.ogg", false)
    --     local spine = sp.SkeletonAnimation:createWithJsonFile("artcontent/animation/outgame/getcard/cards.json",
    --                 "artcontent/animation/outgame/getcard/cards.atlas")
    --     spine:setAnimation(0, "cards", false)
    --     spine:performWithDelay(function()
    --         spine:removeFromParent()
    --     end, 1)
    --     self:addChild(spine)
    --     spine:setPosition(display.cx, display.cy)
    -- end)
    -- EventManager:regListener(EventDef.ID.LEVEL_CHANGE, self, function(pack)
    --     -- self.knapsackLayer_=KnapsackLayer.new()
    --     -- self.container_2:addChild(self.knapsackLayer_)
    --     IntensifiesLayer:setTower(pack)
    --     IntensifiesLayer:new():addTo(self)
    -- end)
end

--[[--
    节点退出

    @param none

    @return none
]]
function MainView:onExit()
    EventManager:unRegListener(EventDef.ID.GAMESTATE_CHANGE, self)
    EventManager:unRegListener(EventDef.ID.GAMEDATA_CHANGE, self)
    EventManager:unRegListener(EventDef.ID.KNAPSACK_CHANGE, self)
    EventManager:unRegListener(EventDef.ID.BUY, self)
    EventManager:unRegListener(EventDef.ID.OBTAINITEM, self)
    EventManager:unRegListener(EventDef.ID.SETTING, self)
    EventManager:unRegListener(EventDef.ID.COMFIRMEDEXIT, self)
    EventManager:unRegListener(EventDef.ID.MATCH, self)
    EventManager:unRegListener(EventDef.ID.USING, self)
    EventManager:unRegListener(EventDef.ID.BATTLE, self)
    --EventManager:unRegListener(EventDef.ID.LEVEL_CHANGE, self)
end

--[[--
    帧刷新

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function MainView:update(dt)
end

return MainView