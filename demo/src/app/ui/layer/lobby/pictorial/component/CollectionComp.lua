--[[
    CollectionComp.lua
    卡片收集组件
    描述：卡片收集组件
    编写：周星宇
    修订：李昊
    检查：张昊煜
]]
local CollectionComp = class("CollectionComp", require("app.ui.layer.BaseUILayout"))
local PictorialCardComp = require("app.ui.layer.lobby.pictorial.component.component.PictorialCardComp")
local ConstDef = require("app.def.ConstDef")
local EventManager = require("app.manager.EventManager")
local EventDef = require("app.def.EventDef")
local PlayerData = require("app.data.PlayerData")
local MsgManager = require("app.manager.MsgManager")

--[[--
    构造函数

    @param none

    @return none
]]
function CollectionComp:ctor()
    CollectionComp.super.ctor(self)

    self.mainListView_ = nil
    self.obtainContainer_ = nil
    self.notObtainContainer_ = nil

    self:initParam()
    self:initView()
end

--[[--
    参数初始化

    @param none

    @return none
]]
function CollectionComp:initParam()
    -- 已获得卡组
    self.obtainedCardGroup_ = PlayerData:getObtainedCardGroup()
    -- 未获得卡组
    self.notObtainCardGroup_ = PlayerData:getNotObtainCardGroup()
end

--[[--
    界面初始化

    @param none

    @return none
]]
function CollectionComp:initView()

    self.mainListView_ = ccui.ListView:create()
    self.mainListView_:setContentSize(ConstDef.WINDOW_SIZE.COLLECTION_VIEW.WIDTH,
            ConstDef.WINDOW_SIZE.COLLECTION_VIEW.HEIGHT)

    self.mainListView_:setAnchorPoint(0, 0)
    self.mainListView_:setDirection(1)
    self.mainListView_:setPosition(0, 0.8*ConstDef.WINDOW_SIZE.DOWNBAR.HEIGHT)
    self:addChild(self.mainListView_)

    -- 已收集牌匾
    local collectedTablet = ccui.ImageView:create("image/lobby/pictorial/towerlist/line_collected.png")
    collectedTablet:setContentSize(ConstDef.WINDOW_SIZE.TABLET.WIDTH,
            ConstDef.WINDOW_SIZE.TABLET.HEIGHT)
    collectedTablet:setAnchorPoint(0, 0)
    collectedTablet:setPosition(0, ConstDef.WINDOW_SIZE.COLLECTION_VIEW.HEIGHT - collectedTablet:getContentSize().height)
    self.mainListView_:pushBackCustomItem(collectedTablet)

    -- 已收集卡牌列表
    local listLen = #self.obtainedCardGroup_ -- 已获得卡牌数量
    local rowNum = math.ceil(listLen / 4) -- 行数
    local cardWidth, cardHeight = ConstDef.CARD_SIZE.TYPE_2.WIDTH, ConstDef.CARD_SIZE.TYPE_2.HEIGHT -- 卡片大小

    self.obtainContainer_ = ccui.Layout:create()
    self.obtainContainer_:setContentSize(display.width,
            1.2*rowNum*cardHeight)
    self.mainListView_:pushBackCustomItem(self.obtainContainer_)

    for i = 1, listLen do
        local card = PictorialCardComp.new(self.obtainedCardGroup_[i], true)
        card:setPosition((1+(i-1)%4-0.25)*cardWidth,
                (rowNum-math.floor((i-1)/4))*cardHeight-0.2*cardHeight)

        self.obtainContainer_:addChild(card)
    end

    -- 未收集牌匾
    local unCollectedTablet = ccui.ImageView:create("image/lobby/pictorial/towerlist/line_not_collected.png")
    unCollectedTablet:setContentSize(ConstDef.WINDOW_SIZE.TABLET.WIDTH,
            ConstDef.WINDOW_SIZE.TABLET.HEIGHT)
    unCollectedTablet:setAnchorPoint(0, 0)
    unCollectedTablet:setPosition(0, ConstDef.WINDOW_SIZE.COLLECTION_VIEW.HEIGHT - unCollectedTablet:getContentSize().height)
    self.mainListView_:pushBackCustomItem(unCollectedTablet)

    -- 未收集卡牌列表
    listLen = #self.notObtainCardGroup_ -- 未获得卡牌数量
    rowNum = math.ceil(listLen / 4) -- 行数

    self.notObtainContainer_ = ccui.Layout:create()
    self.notObtainContainer_:setContentSize(display.width,
            1.2* rowNum *ConstDef.CARD_SIZE.TYPE_2.HEIGHT)
    self.mainListView_:pushBackCustomItem(self.notObtainContainer_)

    for i = 1, listLen do
        local card = PictorialCardComp.new(self.notObtainCardGroup_[i], false)
        card:setPosition((1+(i-1)%4-0.25)*cardWidth,
                (rowNum-math.floor((i-1)/4))*cardHeight-0.2*cardHeight)

        self.notObtainContainer_:addChild(card)
    end

end

--[[--
    onEnter

    @param none

    @return none
]]
function CollectionComp:onEnter()
    EventManager:regListener(EventDef.ID.INIT_PLAYER_DATA, self, function()
        self:update() -- 只会执行一次，不需要tag
    end)
    EventManager:regListener(EventDef.ID.CARD_PURCHASE, self, function()
        self:update() -- 只会执行一次，不需要tag
    end)
    EventManager:regListener(EventDef.ID.BOX_PURCHASE, self, function()
        self:update() -- 只会执行一次，不需要tag
    end)
end

--[[--
    onExit

    @param none

    @return none
]]
function CollectionComp:onExit()
    EventManager:unRegListener(EventDef.ID.INIT_PLAYER_DATA, self)
    EventManager:unRegListener(EventDef.ID.CARD_PURCHASE, self)
    EventManager:unRegListener(EventDef.ID.BOX_PURCHASE, self)
end

--[[--
    界面刷新

    @param none

    @return none
]]
function CollectionComp:update()

    self:initParam()
    -- 已收集卡牌列表
    local listLen = #self.obtainedCardGroup_ -- 已获得卡牌数量
    local rowNum = math.ceil(listLen / 4) -- 行数
    local cardWidth, cardHeight = ConstDef.CARD_SIZE.TYPE_2.WIDTH, ConstDef.CARD_SIZE.TYPE_2.HEIGHT -- 卡片大小

    self.obtainContainer_ = ccui.Layout:create()
    self.obtainContainer_:setContentSize(display.width,
            rowNum*cardHeight)

    for i = 1, listLen do
        local card = PictorialCardComp.new(self.obtainedCardGroup_[i], true)
        card:setPosition((1+(i-1)%4-0.25)*cardWidth,
                (rowNum-math.floor((i-1)/4))*cardHeight-0.5*cardHeight)

        self.obtainContainer_:addChild(card)
    end

    self.mainListView_:removeItem(1)
    self.mainListView_:insertCustomItem(self.obtainContainer_, 1)

    -- 未收集卡牌列表
    listLen = #self.notObtainCardGroup_ -- 未获得卡牌数量
    rowNum = math.ceil(listLen / 4) -- 行数

    self.notObtainContainer_ = ccui.Layout:create()
    self.notObtainContainer_:setContentSize(display.width,
            rowNum *ConstDef.CARD_SIZE.TYPE_2.HEIGHT)

    for i = 1, listLen do
        local card = PictorialCardComp.new(self.notObtainCardGroup_[i], false)
        card:setPosition((1+(i-1)%4-0.25)*cardWidth,
                (rowNum-math.floor((i-1)/4))*cardHeight-0.5*cardHeight)

        self.notObtainContainer_:addChild(card)
    end

    self.mainListView_:removeItem(3)
    self.mainListView_:insertCustomItem(self.notObtainContainer_, 3)

     -- 向服务端更新数据
    MsgManager:sendPlayerData()
end

return CollectionComp