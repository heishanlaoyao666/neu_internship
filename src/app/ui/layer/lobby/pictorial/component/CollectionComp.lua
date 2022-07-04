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
local PlayerData = require("app.data.PlayerData")

--[[--
    构造函数

    @param none

    @return none
]]
function CollectionComp:ctor()
    CollectionComp.super.ctor(self)

    self.container_ = nil

    -- 已获得卡组
    self.obtainedCardGroup_ = PlayerData:getObtainedCardGroup()

    -- 未获得卡组
    self.notObtainCardGroup_ = PlayerData:getNotObtainCardGroup()

    self:initView()
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
    self.mainListView_:setBackGroundColor(cc.c4b(255, 255, 255, 255))
    self.mainListView_:setBackGroundColorType(1)
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

    local obtainContainer = ccui.Layout:create()
    obtainContainer:setContentSize(display.width,
            1.2*rowNum*cardHeight)
    self.mainListView_:pushBackCustomItem(obtainContainer)

    for i = 1, listLen do
        local card = PictorialCardComp.new(self.obtainedCardGroup_[i], true)
        card:setPosition((1+(i-1)%4-0.25)*cardWidth,
        (rowNum-math.floor((i-1)/4))*cardHeight)

        obtainContainer:addChild(card)
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

    local notObtainContainer = ccui.Layout:create()
    notObtainContainer:setContentSize(display.width,
            1.2* rowNum *ConstDef.CARD_SIZE.TYPE_2.HEIGHT)
    self.mainListView_:pushBackCustomItem(notObtainContainer)

    for i = 1, listLen do
        local card = PictorialCardComp.new(self.notObtainCardGroup_[i], false)
        card:setPosition((1+(i-1)%4-0.25)*cardWidth,
                (rowNum-math.floor((i-1)/4))*cardHeight)

        notObtainContainer:addChild(card)
    end

end

return CollectionComp