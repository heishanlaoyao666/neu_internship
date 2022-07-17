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
local LobbyData = require("app.data.LobbyData")
local PlayerData = require("app.data.PlayerData")
local EventManager = require("app.manager.EventManager")
local EventDef = require("app.def.EventDef")
local TeamCardComp = require("app.ui.layer.lobby.pictorial.component.component.component.TeamCardComp")

--[[--
    构造函数

    @param index 当前阵容索引

    @return none
]]
function TeamComp:ctor(index)
    TeamComp.super.ctor(self)

    self.container_ = nil
    self.teamListView_ = nil

    self:initParam(index)
    self:initView()
end

--[[--
    参数初始化

    @param none

    @return none
]]
function TeamComp:initParam(index)
    self.index_ = index
    self.cardGroup_ = PlayerData:getCurrentCardGroup(index)
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

        local teamCard = TeamCardComp.new(self.cardGroup_[i])
        self.teamListView_:pushBackCustomItem(teamCard)

        teamCard:addTouchEventListener(function(sender, event)
            if LobbyData:getCurSelectedTower() then
                if event == 0 then
                    -- 放大事件
                    local ac1 = cc.ScaleTo:create(0.1, 1.1)
                    local ac2 = cc.ScaleTo:create(0.1, 1)
                    local action = cc.Sequence:create(ac1, ac2)
                    teamCard:runAction(action)
                    return true
                elseif event == 2 then
                    local card = LobbyData:getCurSelectedTower()

                    -- 判断卡牌是否出现在卡组中
                    for i = 1, 5 do
                        if card:getId() == self.cardGroup_[i]:getId() then
                            print("重复")
                            return false
                        end
                    end

                    PlayerData:modifyCurrentCardGroup(self.index_, i, card)
                    teamCard = TeamCardComp.new(card)
                    self.teamListView_:removeItem(i-1)
                    self.teamListView_:insertCustomItem(teamCard, i-1)
                    EventManager:doEvent(EventDef.ID.CARD_SWITCH)
                    return true
                end

            end
        end)
        teamCard:setTouchEnabled(true)

    end
end

--[[--
    onEnter事件

    @param none

    @return none
]]
function TeamComp:onEnter()
    EventManager:regListener(EventDef.ID.INIT_PLAYER_DATA, self, function()
        self:update()
    end)
    EventManager:regListener(EventDef.ID.CARD_SWITCH, self, function()
        self:update()
    end)
end

--[[--
    onExit事件

    @param none

    @return none
]]
function TeamComp:onExit()
    EventManager:unRegListener(EventDef.ID.INIT_PLAYER_DATA, self)
    EventManager:unRegListener(EventDef.ID.CARD_SWITCH, self)
end

--[[--
    界面初始化

    @param none

    @return none
]]
function TeamComp:update()
    -- 更新视图
    self.teamListView_:removeAllItems()
    for i = 1, 5 do
        local teamCard = TeamCardComp.new(PlayerData:getCurrentCardGroup(self.index_)[i])
        self.teamListView_:pushBackCustomItem(teamCard)

        teamCard:addTouchEventListener(function(sender, event)
            if LobbyData:getCurSelectedTower() then
                if event == 0 then
                    -- 放大事件
                    local ac1 = cc.ScaleTo:create(0.1, 1.1)
                    local ac2 = cc.ScaleTo:create(0.1, 1)
                    local action = cc.Sequence:create(ac1, ac2)
                    teamCard:runAction(action)
                    return true
                elseif event == 2 then
                    local card = LobbyData:getCurSelectedTower()

                    -- 判断卡牌是否出现在卡组中
                    for i = 1, 5 do
                        if card:getId() == self.cardGroup_[i]:getId() then
                            print("重复")
                            return false
                        end
                    end

                    PlayerData:modifyCurrentCardGroup(self.index_, i, card)
                    teamCard = TeamCardComp.new(card)
                    self.teamListView_:removeItem(i-1)
                    self.teamListView_:insertCustomItem(teamCard, i-1)
                    EventManager:doEvent(EventDef.ID.CARD_SWITCH)
                    return true
                end

            end
        end)
        teamCard:setTouchEnabled(true)
    end
end

return TeamComp