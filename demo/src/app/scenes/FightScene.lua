--[[
    FightScene.lua
    战斗场景
    描述：战斗场景
    编写：李昊
    修订：周星宇
    检查：张昊煜
]]

local FightScene = class("FightScene", function()
    return display.newScene("FightScene")
end)

local TCP = require("app.network.TCP")
local FightView = require("src.app.ui.view.fight.FightView")
local ResultView = require("src.app.ui.view.fight.ResultView")
local MsgDef = require("app.def.MsgDef")
local GameData = require("src.app.data.GameData")
local PlayerData = require("app.data.PlayerData")

local data = nil

--[[
    构造函数
    @param none
    @return none
]]

function FightScene:ctor()

    GameData:init()

    self.fightView_ = FightView.new()
    self:addChild(self.fightView_)  --战斗画面

    self.resultView_ = ResultView.new() --战斗结算界面
    self:addChild(self.resultView_)
    self.resultView_:hideView()

    self:registerScriptHandler(function(event)
        if event == "enter" then
            self:onEnter()
        elseif event == "exit" then
            self:onExit()
        end
    end)
end

--[[
    节点进入
    @param none
    @return none
]]
function FightScene:onEnter()

    self:addNodeEventListener(cc.NODE_ENTER_FRAME_EVENT, handler(self, self.update))
    self:performWithDelay(function()
        self:scheduleUpdate()
    end, 1)

    --注册一个监听器监听服务端发来的消息
    TCP.regListener(MsgDef.ACK_TYPE.GAME_SYNC, function(resp)
        print("This is a sync from server!")
        data = resp["data"]
        GameData:update(nil, data)
    end)

    TCP.regListener(MsgDef.ACK_TYPE.GAME_OVER, function(resp)
        TCP.unRegListener(MsgDef.ACK_TYPE.GAME_OVER)
        TCP.send(MsgDef.REQ_TYPE.GAME_OVER_CANCEL, resp["data"])

        local data = resp.data.data
        local me = nil
        local enemy = nil
        local ifWin = false

        print("WINNER NAME", data.winner.name)
        if data.winner.name == GameData:getName()[1] then
            -- 己方胜利
            me = data.winner
            enemy = data.loser
            ifWin = true
        else
            me = data.loser
            enemy = data.winner
            ifWin = false
        end

        local resultData = {}
        resultData.isWin_ = ifWin -- 己方是否胜利
        local cardGroup = GameData:getCardGroup()
        resultData.cardGroup_ = {}
        resultData.enemyCardGroup_ = {}
        for i = 1,5 do
            table.insert(resultData.cardGroup_, cardGroup[i])
            table.insert(resultData.enemyCardGroup_, cardGroup[i+5])
        end

        resultData.enemyName_ = GameData:getName()[2] --类型 string 敌方名字
        resultData.enemyPlayerLevel_ = 5 --敌方段位
        resultData.enemyTrophyNum_ = enemy.integral
        print("enemy.integral", enemy.integral)

        resultData.name_ = GameData:getName()[1] --类型 string 己方名字
        resultData.playerLevel_ = 5 --己方段位
        resultData.trophyNum_ = me.integral
        print("me.integral", me.integral)
        print("me.integral D", me.integralDelta)

        resultData.baseAwards_ = {me.integralDelta, me.gold} -- 胜利后结算时第一行，基本奖励，{奖杯数量，金币数量}
        resultData.winningStreakAwards_ = {0, 0} -- 胜利后结算第二行，连胜奖励，{奖杯数量，金币数量}
        resultData.buffAwards_ = {0, 0, me.diamond} -- 胜利后结算第二行，特殊奖励，{奖杯数量，金币数量，钻石数量}

        -- 更新数据
        PlayerData:calculateAward(me.integral, me.gold, me.diamond)

        self.resultView_:showView(resultData)
    end)

end

--[[--
    节点退出
    @param none
    @return none
]]
function FightScene:onExit()
    GameData:reset()
    TCP.close()
    self.resultView_ = nil
    self.fightView_ = nil
    self = nil
end


--[[
    帧循环
    @param dt 类型：number，帧间隔，单位秒
    @return none
]]
function FightScene:update(dt)
    self.fightView_:update(dt)
    self.resultView_:update(dt)
end

return FightScene