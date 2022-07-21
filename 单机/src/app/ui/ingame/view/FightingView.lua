--[[--
    战斗主界面
    FightingView.lua
]]
local FightingView = class("FightingView", function()
    return display.newColorLayer(cc.c4b(0, 0, 0, 0))
end)

local FightingBGLayer = require("app.ui.ingame.layer.FightingBGLayer")
local FightingInfoLayer = require("app.ui.ingame.layer.FightingInfoLayer")
local MyFightingLayer = require("app.ui.ingame.layer.MyFightingLayer")

local AdmitDefeatView = require("app.ui.ingame.view.AdmitDefeatView")
local SettlementView = require("app.ui.ingame.view.SettlementView")
local RewardView = require("app.ui.ingame.view.RewardView")
local BossChooseView = require("app.ui.ingame.view.BossChooseView")

local GameData = require("app.data.ingame.GameData")
local ConstDef = require("app.def.ingame.ConstDef")
local EventDef = require("app.def.EventDef")
local EventManager = require("app.manager.EventManager")

--[[--
    构造函数

    @param none

    @return none
]]
function FightingView:ctor()
    self.bgLayer_ = nil -- 加载背景层
    self.infoLayer_ = nil -- 加载信息层
    self.myFightingLayer_ = nil -- 加载战斗层

    self.bossChooseView_ = nil
    self.admitDefeat_ = nil -- 认输视图
    self.settlementView_ = nil -- 结算视图
    self.rewardView_ = nil -- 奖励界面

    self:initView()

    self:registerScriptHandler(function(event)
        if event == "enter" then
            self:onEnter()
            GameData:setGameState(ConstDef.GAME_STATE.CHOOSE_BOOS)
            if cc.UserDefault:getInstance():getBoolForKey("游戏外音乐") then
                audio.playBGM("sounds/ingame_bgm_100bpm.OGG", true)
            end
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
function FightingView:initView()
    self.bgLayer_ = FightingBGLayer.new()
    self:addChild(self.bgLayer_)

    self.myFightingLayer_ = MyFightingLayer.new()
    self:addChild(self.myFightingLayer_)

    self.infoLayer_ = FightingInfoLayer.new()
    self:addChild(self.infoLayer_)

    self.bossChooseView_ = BossChooseView.new()
    self:addChild(self.bossChooseView_)
    self.bossChooseView_:setVisible(false)

    self.admitDefeat_ = AdmitDefeatView.new()
    self:addChild(self.admitDefeat_)
    self.admitDefeat_:setVisible(false)

    self.settlementView_ = SettlementView.new()
    self:addChild(self.settlementView_)
    self.settlementView_:setVisible(false)

    self.rewardView_ = RewardView.new()
    self:addChild(self.rewardView_)
    self.rewardView_:setVisible(false)
end

--[[--
    节点进入

    @param none

    @return none
]]
function FightingView:onEnter()
    local name=cc.UserDefault:getInstance():getStringForKey("昵称")
    local myTrophyNum = GameData:getTrophyNum(1)

    EventManager:regListener(EventDef.ID.GAMESTATE_CHANGE, self, function(state)
        if state == ConstDef.GAME_STATE.ADMIT_DEFEAT then
            self.admitDefeat_:showView()
        elseif state == ConstDef.GAME_STATE.SETTLEMENT_VICTORY then
            self.settlementView_:showView("失败","robot","1","胜利",name,myTrophyNum)
            if cc.UserDefault:getInstance():getBoolForKey("音效") then
                audio.playEffect("sounds/win.OGG")
            end
        elseif state == ConstDef.GAME_STATE.SETTLEMENT_DEFEAT then
            self.settlementView_:showView("胜利","robot","1","失败",name,myTrophyNum)
            if cc.UserDefault:getInstance():getBoolForKey("音效") then
                audio.playEffect("sounds/lose.OGG")
            end
        elseif state == ConstDef.GAME_STATE.REWARD_VICTORY then
            local t = GameData:victoryReward()
            self.rewardView_:showView("胜利",name,myTrophyNum, t[1], t[2], t[3])
            --联机：传奖杯金币与钻石
            --f({t[1][1], t[2][1] ,t[3]})
        elseif state == ConstDef.GAME_STATE.REWARD_DEFREAT then
            local t = GameData:defeatReward()
            self.rewardView_:showView("失败",name,myTrophyNum, t[1], t[2], t[3])
            --联机：传奖杯金币与钻石
            --f({t[1][1], t[2][1] ,t[3]})
        elseif state == ConstDef.GAME_STATE.CHOOSE_BOOS then
            if cc.UserDefault:getInstance():getBoolForKey("音效") then
                audio.playEffect("sounds/confirm_boss.OGG")
            end
            self.bossChooseView_:init()
            self.bossChooseView_:showView()
        elseif state == ConstDef.GAME_STATE.PLAY then
            self.bossChooseView_:setVisible(false)
        end
    end)
end

--[[--
    节点退出

    @param none

    @return none
]]
function FightingView:onExit()
    EventManager:unRegListener(EventDef.ID.GAMESTATE_CHANGE, self)
end

--[[--
    帧刷新

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function FightingView:update(dt)
    if GameData:isChoose() then
        self.bossChooseView_:update(dt)
    end
    if GameData:isPlaying() then
        GameData:update(dt)
        self.infoLayer_:update(dt)
        self.myFightingLayer_:update(dt)
    end
end

return FightingView