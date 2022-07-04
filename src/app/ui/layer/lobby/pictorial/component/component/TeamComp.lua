--[[
    TeamComp.lua
    当前队伍展示组件
    描述：当前队伍展示组件
    编写：周星宇
    修订：李昊
    检查：张昊煜
]]
local TeamComp = class("TeamComp", require("app.ui.layer.BaseLayer"))
local ConstDef = require("app.def.ConstDef")


--[[--
    构造函数

    @param none

    @return none
]]
function TeamComp:ctor(cardGroup)
    TeamComp.super.ctor(self)

    self.container_ = nil
    self.teamListView_ = nil
    self.cardGroup_ = cardGroup

    self:initView()
end

--[[--
    界面初始化

    @param none

    @return none
]]
function TeamComp:initView()
    self.container_ = ccui.Layout:create()
    self.container_:setBackGroundImage("image/lobby/index/team_bg.png")
    self.container_:setContentSize(ConstDef.WINDOW_SIZE.TEAM_VIEW.WIDTH,
            ConstDef.WINDOW_SIZE.TEAM_VIEW.HEIGHT)
    self.container_:setAnchorPoint(0.5, 0.5)
    self.container_:setPosition(display.cx, 0.2 * display.size.height)
    self:addChild(self.container_)

    -- 当前队伍展示区内容 - ListView
    self.teamListView_ = ccui.ListView:create()
    self.teamListView_:setContentSize(ConstDef.WINDOW_SIZE.TEAM_VIEW.WIDTH,
            ConstDef.WINDOW_SIZE.TEAM_VIEW.HEIGHT)
    self.teamListView_:setAnchorPoint(0, 0)
    self.teamListView_:setDirection(2)
    self.container_:addChild(self.teamListView_)

    for i = 1, 5 do

        local width, height = 1.2*ConstDef.CARD_SIZE.TYPE_1.WIDTH, ConstDef.CARD_SIZE.TYPE_1.HEIGHT

        local itemLayer = ccui.Layout:create()
        itemLayer:setContentSize(width, height)

        local card = ccui.ImageView:create(self.cardGroup_[i]:getSmallSpriteImg())
        card:setPosition(width * 0.5, height * 0.6)
        itemLayer:addChild(card)

        local level = ccui.ImageView:create(self.cardGroup_[i]:getLevelImg())
        level:setPosition(width * 0.5, height * 0.1)
        itemLayer:addChild(level)

        local attr = ccui.ImageView:create(self.cardGroup_[i]:getTypeImg())
        attr:setPosition(width * 0.8, height * 0.9)
        itemLayer:addChild(attr)

        self.teamListView_:pushBackCustomItem(itemLayer)
    end
end

return TeamComp