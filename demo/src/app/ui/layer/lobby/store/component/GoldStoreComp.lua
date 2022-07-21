--[[
    GoldStoreComp.lua
    金币商店组件
    描述：金币商店组件
    编写：周星宇
    修订：李昊
    检查：张昊煜
]]
local GoldStoreComp = class("GoldStoreComp", require("app.ui.layer.BaseUILayout"))
local GoldStoreCardComp = require("app.ui.layer.lobby.store.component.component.GoldStoreCardComp")
local CountdownComp = require("app.ui.layer.lobby.store.component.component.CountdownComp")
local ConstDef = require("app.def.ConstDef")
local StoreData = require("app.data.StoreData")
local EventManager = require("app.manager.EventManager")
local EventDef = require("app.def.EventDef")
local MsgManager = require("app.manager.MsgManager")

--[[--
    构造函数

    @param none

    @return none
]]
function GoldStoreComp:ctor()
    GoldStoreComp.super.ctor(self)

    self.container_ = nil
    self.cardContainer_ = nil

    self:initParam()
    self:initView()
end

--[[--
    参数初始化

    @param none

    @return none
]]
function GoldStoreComp:initParam()
    self.cards_ = StoreData:getGoldStoreCards()
end

--[[--
    界面初始化

    @param none

    @return none
]]
function GoldStoreComp:initView()
    self.container_ = ccui.Layout:create()
    self.container_:setContentSize(ConstDef.WINDOW_SIZE.GOLD_STORE.WIDTH,
            ConstDef.WINDOW_SIZE.GOLD_STORE.HEIGHT)
    self.container_:setAnchorPoint(0, 0)
    self.container_:setPosition(0, 300)
    self:addChild(self.container_)

    -- 牌匾
    local tablet = ccui.Layout:create()
    tablet:setBackGroundImage("image/lobby/store/gold/title_bg.png")
    tablet:setContentSize(ConstDef.WINDOW_SIZE.TABLET.WIDTH,
            ConstDef.WINDOW_SIZE.TABLET.HEIGHT)
    tablet:setPosition(0, ConstDef.WINDOW_SIZE.GOLD_STORE.HEIGHT)
    local tabletTitle = ccui.ImageView:create("image/lobby/store/gold/store_title.png")
    tabletTitle:setAnchorPoint(0, 0)
    tabletTitle:setPosition((tablet:getContentSize().width - tabletTitle:getContentSize().width)/2,
            (tablet:getContentSize().height - tabletTitle:getContentSize().height)/2)
    tablet:addChild(tabletTitle)
    self.container_:addChild(tablet)

    -- 商店刷新剩余时间
    local refreshTime = ccui.Layout:create()
    refreshTime:setBackGroundImage("image/lobby/store/gold/remaining_time_bg.png")
    refreshTime:setPosition(ConstDef.WINDOW_SIZE.GOLD_STORE.WIDTH/2,
            0.95 * ConstDef.WINDOW_SIZE.GOLD_STORE.HEIGHT)
    local refreshTimeTitle = ccui.ImageView:create("image/lobby/store/gold/remaining_time_title.png")
    refreshTimeTitle:setAnchorPoint(0.75, 0.5)
    refreshTime:addChild(refreshTimeTitle)

    -- 创建定时器
    local time = os.date("*t")

    CountdownComp.new()
    CountdownComp.setTime(23-time.hour,59-time.min,60-time.sec)
    --CountdownComp.setTime(0,0,50)
    CountdownComp.add_0()
    local refreshTimeText = CountdownComp.createText()
    refreshTimeText:setAnchorPoint(-1, 0.5)
    refreshTimeText:setTextColor(cc.c4b(255, 206, 55, 255))
    refreshTime:addChild(refreshTimeText)
    CountdownComp.scheduleFunc()                   --创建一个刷新函数
    CountdownComp.function_(function()
        CountdownComp.reset(24, 0, 0)
        MsgManager:recStoreData()
    end)
    self.container_:addChild(refreshTime)

    self.cardContainer_ = ccui.Layout:create()
    self.cardContainer_:setContentSize(ConstDef.WINDOW_SIZE.GOLD_STORE.WIDTH,
    ConstDef.WINDOW_SIZE.GOLD_STORE.HEIGHT)
    self.cardContainer_:setAnchorPoint(0, 0)
    self.container_:addChild(self.cardContainer_)

    -- 卡片
    for i = 1, 6 do
        local index = string.format("%d", i)
        local card = GoldStoreCardComp.new(self.cards_[index], self.cards_[index].cardId, i)
        self.cardContainer_:addChild(card)
        card:setPosition((0.3*((i-1)%3)+0.2)*ConstDef.WINDOW_SIZE.GOLD_STORE.WIDTH,
                (0.7-math.floor((i-1)/3)*0.4)*ConstDef.WINDOW_SIZE.GOLD_STORE.HEIGHT)
    end

end

--[[--
    onEnter

    @param none

    @return none
]]
function GoldStoreComp:onEnter()
    EventManager:regListener(EventDef.ID.GOLD_STORE_REFRESH, self, function()

        self.cards_ = StoreData:getGoldStoreCards()
        self.cardContainer_:removeAllChildren()
        for i = 1, 6 do
            -- 以cardId作为tag
            local index = string.format("%d", i)
            local card = GoldStoreCardComp.new(self.cards_[index], self.cards_[index].cardId, i)
            self.cardContainer_:addChild(card)
            card:setPosition((0.3*((i-1)%3)+0.2)*ConstDef.WINDOW_SIZE.GOLD_STORE.WIDTH,
                    (0.7-math.floor((i-1)/3)*0.4)*ConstDef.WINDOW_SIZE.GOLD_STORE.HEIGHT)
        end
    end)
end

--[[--
    onExit

    @param none

    @return none
]]
function GoldStoreComp:onExit()
    --CountdownComp.exit()
    EventManager:unRegListener(EventDef.ID.GOLD_STORE_REFRESH, self)

end

--[[--
    界面刷新

    @param none

    @return none
]]
function GoldStoreComp:update()

end


return GoldStoreComp