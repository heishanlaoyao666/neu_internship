--[[
    信息层
    InfoLayer.lua
    描述：信息层
    编写：周星宇
    修订：李昊
    检查：张昊煜
]]

local InfoLayer = class("InfoLayer", require("app.ui.layer.BaseLayer"))
local ConstDef = require("app.def.ConstDef")
local PlayerData = require("app.data.PlayerData")
local EventDef = require("app.def.EventDef")
local EventManager = require("app.manager.EventManager")
--[[--
    构造函数

    @param none

    @return none
]]
function InfoLayer:ctor()
    InfoLayer.super.ctor(self)

    self.container_ = nil -- 容器
    self.goldLabelTtf_ = nil -- 金币
    self.diamondLabelTtf_ = nil -- 钻石
    self.nicknameLabelTtf_ = nil -- 昵称
    self.trophyLabelTtf_ = nil -- 奖杯

    self:initParam()
    self:initView()
end

--[[--
    参数初始化

    @param none

    @return none
]]
function InfoLayer:initParam()
    self.goldText_ = PlayerData:getGold()
    self.diamondText_ = PlayerData:getDiamond()
    self.nicknameText_ = PlayerData:getName()
    self.trophyText_ = PlayerData:getIntegral()
end

--[[--
    界面初始化

    @param none

    @return none
]]
function InfoLayer:initView()
    self.container_ = ccui.Layout:create()
    self.container_:setContentSize(ConstDef.WINDOW_SIZE.TOPBAR.WIDTH,
            ConstDef.WINDOW_SIZE.TOPBAR.HEIGHT) -- 设置为顶部栏大小
    self.container_:setAnchorPoint(0, 1)
    self.container_:setPosition(0, display.size.height)
    self:addChild(self.container_)

    -- 金币
    self.goldLabelTtf_ = ccui.Text:create(self.goldText_, "font/fzbiaozjw.ttf", 26)
    self.goldLabelTtf_:setTextColor(cc.c4b(255, 255, 255, 255))
    self.goldLabelTtf_:setAnchorPoint(1, 0)
    self.goldLabelTtf_:setPosition( 600, 85)
    self.container_:addChild(self.goldLabelTtf_)

    -- 钻石
    self.diamondLabelTtf_ = ccui.Text:create(self.diamondText_, "font/fzbiaozjw.ttf", 26)
    self.diamondLabelTtf_:setTextColor(cc.c4b(255, 255, 255, 255))
    self.diamondLabelTtf_:setAnchorPoint(1, 0)
    self.diamondLabelTtf_:setPosition( 600, 35)
    self.container_:addChild(self.diamondLabelTtf_)

    -- 昵称
    self.nicknameLabelTtf_ = ccui.Text:create(self.nicknameText_, "font/fzbiaozjw.ttf", 26)
    self.nicknameLabelTtf_:setTextColor(cc.c4b(255, 255, 255, 255))
    self.nicknameLabelTtf_:setAnchorPoint(0, 0)
    self.nicknameLabelTtf_:setPosition( 180, 85)
    self.container_:addChild(self.nicknameLabelTtf_)

    -- 奖杯
    self.trophyLabelTtf_ = ccui.Text:create(self.trophyText_, "font/fzbiaozjw.ttf", 24)
    self.trophyLabelTtf_:setTextColor(cc.c4b(255, 206, 55, 255))
    self.trophyLabelTtf_:setAnchorPoint(0, 0)
    self.trophyLabelTtf_:setPosition( 200, 40)
    self.container_:addChild(self.trophyLabelTtf_)

end

--[[--
    onEnter

    @param none

    @return none
]]
function InfoLayer:onEnter()
    EventManager:regListener(EventDef.ID.INIT_PLAYER_DATA, self, function()
        self:update()
    end)
    EventManager:regListener(EventDef.ID.CARD_UPGRADE, self, function()
        self:update()
    end)
    EventManager:regListener(EventDef.ID.CARD_PURCHASE, self, function()
        self:update()
    end)
    EventManager:regListener(EventDef.ID.BOX_PURCHASE, self, function()
        self:update()
    end)
    EventManager:regListener(EventDef.ID.GOLD_OBTAIN, self, function()
        self:update()
    end)
    EventManager:regListener(EventDef.ID.DIAMOND_OBTAIN, self, function()
        self:update()
    end)
end

--[[--
    onExit

    @param none

    @return none
]]
function InfoLayer:onExit()
    EventManager:unRegListener(EventDef.ID.INIT_PLAYER_DATA, self)
    EventManager:unRegListener(EventDef.ID.CARD_UPGRADE, self)
    EventManager:unRegListener(EventDef.ID.CARD_PURCHASE, self)
    EventManager:unRegListener(EventDef.ID.BOX_PURCHASE, self)
    EventManager:unRegListener(EventDef.ID.GOLD_OBTAIN, self)
    EventManager:unRegListener(EventDef.ID.DIAMOND_OBTAIN, self)
end

--[[--
    界面刷新

    @param none

    @return none
]]
function InfoLayer:update()
    self.goldLabelTtf_:setString(PlayerData:getGold())
    self.diamondLabelTtf_:setString(PlayerData:getDiamond())
    self.nicknameLabelTtf_:setString(PlayerData:getName())
    self.trophyLabelTtf_:setString(PlayerData:getIntegral())
end

return InfoLayer

