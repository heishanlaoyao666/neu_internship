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
local ConstDef = require("app.def.ConstDef")
local StoreData = require("app.data.StoreData")

--[[--
    构造函数

    @param none

    @return none
]]
function GoldStoreComp:ctor()
    GoldStoreComp.super.ctor(self)

    self.container_ = nil

    self:initParam()
    self:initView()
end

--[[--
    参数初始化

    @param none

    @return none
]]
function GoldStoreComp:initParam()
    self.remainingTime_ = "23:59" -- 预留数据接口
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
    local refreshTimeText = ccui.Text:create(self.remainingTime_, "font/fzbiaozjw.ttf", 25)
    refreshTimeText:setAnchorPoint(-1, 0.5)
    refreshTimeText:setTextColor(cc.c4b(255, 206, 55, 255))
    refreshTime:addChild(refreshTimeText)
    self.container_:addChild(refreshTime)



    local card_1 = GoldStoreCardComp.new(self.cards_[1], 1)
    self.container_:addChild(card_1)
    card_1:setPosition(0.2*ConstDef.WINDOW_SIZE.GOLD_STORE.WIDTH, 0.70*ConstDef.WINDOW_SIZE.GOLD_STORE.HEIGHT)

    local card_2 = GoldStoreCardComp.new(self.cards_[2], 2)
    self.container_:addChild(card_2)
    card_2:setPosition(0.5*ConstDef.WINDOW_SIZE.GOLD_STORE.WIDTH, 0.70*ConstDef.WINDOW_SIZE.GOLD_STORE.HEIGHT)

    local card_3 = GoldStoreCardComp.new(self.cards_[3], 3)
    self.container_:addChild(card_3)
    card_3:setPosition(0.8*ConstDef.WINDOW_SIZE.GOLD_STORE.WIDTH, 0.70*ConstDef.WINDOW_SIZE.GOLD_STORE.HEIGHT)

    local card_4 = GoldStoreCardComp.new(self.cards_[4], 4)
    self.container_:addChild(card_4)
    card_4:setPosition(0.2*ConstDef.WINDOW_SIZE.GOLD_STORE.WIDTH, 0.3*ConstDef.WINDOW_SIZE.GOLD_STORE.HEIGHT)

    local card_5 = GoldStoreCardComp.new(self.cards_[5], 5)
    self.container_:addChild(card_5)
    card_5:setPosition(0.5*ConstDef.WINDOW_SIZE.GOLD_STORE.WIDTH, 0.3*ConstDef.WINDOW_SIZE.GOLD_STORE.HEIGHT)

    local card_6 = GoldStoreCardComp.new(self.cards_[6], 6)
    self.container_:addChild(card_6)
    card_6:setPosition(0.8*ConstDef.WINDOW_SIZE.GOLD_STORE.WIDTH, 0.3*ConstDef.WINDOW_SIZE.GOLD_STORE.HEIGHT)


end

return GoldStoreComp