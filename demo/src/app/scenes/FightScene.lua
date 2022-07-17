--[[--
    FightSceneScene.lua
    大厅
]]

local FightScene = class("FightScene", function()
    return display.newScene("FightScene")
end)

local TCP = require("app.network.TCP")

local FightView = require("src.app.ui.view.fight.FightView")
local ResultView = require("src.app.ui.view.fight.ResultView")
local MsgDef = require("app.def.MsgDef")
local GameData = require("src.app.data.GameData")

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

    self.resultView_ = nil --战斗结算界面

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

    --客户端给服务端发一个消息表示开赛
    --TCP.send(MsgDef.REQ_TYPE.SETUP_CONNECTION, {data="start"})

    --注册一个监听器监听服务端发来的消息
    TCP.regListener(MsgDef.ACK_TYPE.GAME_SYNC, function(resp)
        print("This is a sync from server!")
        data = resp["data"]
        GameData:update(nil, data)
    end)

end

--[[--
    节点退出
    @param none
    @return none
]]
function FightScene:onExit()
    TCP.close()
end


--[[
    帧循环
    @param dt 类型：number，帧间隔，单位秒
    @return none
]]
function FightScene:update(dt)
    self.fightView_:update(dt)
end

return FightScene