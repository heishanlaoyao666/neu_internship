--[[--
    游戏主界面
    PlayView.lua
]]
local PlayView = class("PlayView", function()
    return display.newColorLayer(cc.c4b(0, 0, 0, 0))
end)
local BGLayer = require("app.mainui.layer.BGLayer")
local InfoLayer = require("app.mainui.layer.InfoLayer")
local RegisterView = require("app.mainui.RegisterView")
local RankView = require("app.mainui.RankView")
local SettingView = require("app.mainui.SettingView")
local ConstDef = require("app.def.ConstDef")
local EventDef = require("app.def.EventDef")
local EventManager = require("app.manager.EventManager")

--[[--
    构造函数

    @param none

    @return none
]]
function PlayView:ctor()
    self.bgLayer_ = nil -- 类型：BGLayer，背景层
    self.RegisterView_ = nil -- 类型：RegisterLayer，注册层
    -- self.BattleScene_ = nil -- 类型：FightLayer，战斗层
    -- self.ContinueScene_ = nil -- 类型：InfoLayer，信息层
    self.RankView_ = nil -- 类型：RankView，排行榜界面
    self.SettingView_ = nil -- 类型：SettingView，设置界面
    self.infoLayer_ = nil -- 类型：InfoLayer，信息层

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
function PlayView:initView()
    self.bgLayer_ = BGLayer.new()
    self:addChild(self.bgLayer_)

    self.infoLayer_ = InfoLayer.new()
    self:addChild(self.infoLayer_)

    self.RegisterView_ = RegisterView.new()
    self:addChild(self.RegisterView_)
    self.RegisterView_:setVisible(false)

    self.RankView_ = RankView.new()
    self:addChild(self.RankView_)
    self.RankView_:setVisible(false)

    self.SettingView_ = SettingView.new()
    self:addChild(self.SettingView_)
    self.SettingView_:setVisible(false)
end

--[[--
    节点进入

    @param none

    @return none
]]
function PlayView:onEnter()
    EventManager:regListener(EventDef.ID.GAMESTATE_CHANGE, self, function(state)
        if state == ConstDef.GAME_STATE.PAUSE then
            self.pauseView_:showView()
        elseif state == ConstDef.GAME_STATE.RESULT then
            self.resultView_:showView()
        end
    end)
end

--[[--
    节点退出

    @param none

    @return none
]]
function PlayView:onExit()
    EventManager:unRegListener(EventDef.ID.GAMESTATE_CHANGE, self)
end

--[[--
    帧刷新

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function PlayView:update(dt)
    self.bgLayer_:update(dt)
    self.fightLayer_:update(dt)
    self.infoLayer_:update(dt)
end

return PlayView