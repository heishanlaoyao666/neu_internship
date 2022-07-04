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
--[[--
    构造函数

    @param none

    @return none
]]
function MainView:ctor()
    self.TopInfoLayer_ = nil -- 类型：TopInfoLayer，顶部信息层
    self.BottomInfoLayer_ = nil -- 类型：BottomInfoLayer，底部信息层
    self.KnapsackLayer_ = nil -- 类型：KnapsackLayer，背包层
    self.ShopLayer_=nil -- 类型：ShopLayer，商店层
    self.BattleLayer_=nil -- 类型：BattleLayer，战斗层
    self.MatchLayer_ = nil -- 类型：MatchLayer，匹配层
    self.BuyLayer_=nil -- 类型：BuyLayer，购买层
    self.ObtainItemLayer_=nil -- 类型：ObtainItemLayer，开宝箱层
    self.ConfirmationLayer_=nil -- 类型：ConfirmationLayer，获取宝箱物品层
    self.SettingLayer_=nil -- 类型：SettingLayer，设置层
    self.ComfirmedExitLayer_=nil -- 类型：ComfirmedExitLayer，确认退出层
    self.MatchLayer_=nil -- 类型：MatchLayer，匹配层
    self.UsingLayer_=nil -- 类型：UsingLayer，使用塔层

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

        self.BattleLayer_=BattleLayer.new()
        self.container_:addChild(self.BattleLayer_)
    end

    do
        --商店界面
        self.container_1 = ccui.Layout:create()
        self.container_1:setContentSize(display.width, height)
        self.container_1:setPosition(0, 0)

        self.ShopLayer_=ShopLayer.new()
        self.container_1:addChild(self.ShopLayer_)

    end

    do
        --图鉴界面
        self.container_2 = ccui.Layout:create()
        self.container_2:setContentSize(display.width, height)
        self.container_2:setPosition(0, 0)

        self.KnapsackLayer_=KnapsackLayer.new()
        self.container_2:addChild(self.KnapsackLayer_)
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
    self.BottomInfoLayer_1 = BottomInfoLayer.new()
    self:addChild(self.BottomInfoLayer_1)
    self.BottomInfoLayer_1:setVisible(false)
    cc.UserDefault:getInstance():setIntegerForKey("bottom",2)
    self.BottomInfoLayer_2 = BottomInfoLayer.new()
    self:addChild(self.BottomInfoLayer_2)
    self.BottomInfoLayer_2:setVisible(false)
    cc.UserDefault:getInstance():setIntegerForKey("bottom",3)
    self.BottomInfoLayer_3 = BottomInfoLayer.new()
    self:addChild(self.BottomInfoLayer_3)
    self.BottomInfoLayer_3:setVisible(false)

    page:addEventListener(function(sender,event)
        if event==ccui.PageViewEventType.turning then
            self:setName(page:getCurPageIndex())
            --print("当前页码是"..page:getCurPageIndex())
            if page:getCurPageIndex()==0 then
                self.BottomInfoLayer_1:setVisible(true)
                self.BottomInfoLayer_2:setVisible(false)
                self.BottomInfoLayer_3:setVisible(false)
            elseif page:getCurPageIndex()==1 then
                self.BottomInfoLayer_1:setVisible(false)
                self.BottomInfoLayer_2:setVisible(true)
                self.BottomInfoLayer_3:setVisible(false)
            elseif page:getCurPageIndex()==2 then
                self.BottomInfoLayer_1:setVisible(false)
                self.BottomInfoLayer_2:setVisible(false)
                self.BottomInfoLayer_3:setVisible(true)
            end
        end
    end)

    self.TopInfoLayer_ = TopInfoLayer.new()
    self:addChild(self.TopInfoLayer_)
end

--[[--
    修改头像

    @param none

    @return none
]]
-- function MainView:setSprite(filename)
--     self.TopInfoLayer_ = TopInfoLayer.new()
--     self.TopInfoLayer_:setSprite1(filename)
--     self:addChild(self.TopInfoLayer_)
-- end

--[[--
    节点进入

    @param none

    @return none
]]
function MainView:onEnter()
    EventManager:regListener(EventDef.ID.PORTRAIT_CHANGE, self, function(filename)
        self.TopInfoLayer_:setSprite1(filename)
    end)
    EventManager:regListener(EventDef.ID.GAMEDATA_CHANGE, self, function()
        self.TopInfoLayer_:setData()
    end)
    EventManager:regListener(EventDef.ID.KNAPSACK_CHANGE, self, function()
        self.KnapsackLayer_=KnapsackLayer.new()
        self.container_2:addChild(self.KnapsackLayer_)
    end)
    EventManager:regListener(EventDef.ID.INTENSIFIES, self, function(pack)
        IntensifiesLayer:setTower(pack)
        IntensifiesLayer:new():addTo(self)
    end)
    EventManager:regListener(EventDef.ID.BUY, self, function()
        self.BuyLayer_=BuyLayer.new()
        self:addChild(self.BuyLayer_)
    end)
    EventManager:regListener(EventDef.ID.OBTAINITEM, self, function()
        self.ObtainItemLayer_=ObtainItemLayer:new():addTo(self)
    end)
    EventManager:regListener(EventDef.ID.COMFIRMATION, self, function()
        self.ConfirmationLayer_=ConfirmationLayer:new():addTo(self)
    end)
    EventManager:regListener(EventDef.ID.SETTING, self, function()
        self.SettingLayer_=SettingLayer:new():addTo(self)
    end)
    EventManager:regListener(EventDef.ID.COMFIRMEDEXIT, self, function()
        self.ComfirmedExitLayer_=ComfirmedExitLayer:new():addTo(self)
    end)
    EventManager:regListener(EventDef.ID.MATCH, self, function()
        self.MatchLayer_=MatchLayer:new():addTo(self)
    end)
    EventManager:regListener(EventDef.ID.USING, self, function(pack)
        self.KnapsackLayer_:removeFromParent(true)
        UsingLayer:setTower(pack)
        self.UsingLayer_=UsingLayer:new():addTo(self.container_2)
    end)
    EventManager:regListener(EventDef.ID.BATTLE, self, function(pack)
        self.BattleLayer_:removeFromParent(true)
        self.BattleLayer_=BattleLayer.new()
        self.container_:addChild(self.BattleLayer_)
    end)
    -- EventManager:regListener(EventDef.ID.LEVEL_CHANGE, self, function(pack)
    --     -- self.KnapsackLayer_=KnapsackLayer.new()
    --     -- self.container_2:addChild(self.KnapsackLayer_)
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