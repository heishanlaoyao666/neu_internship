--[[--
    FightingScene.lua
    战斗场景
]]
local FightingScene = class("FightingScene", function()
    return display.newScene("FightingScene")
end)

local FightingView = require("app.ui.ingame.view.FightingView")

--[[--
    构造函数

    @param none

    @return none
]]
function FightingScene:ctor()
    self.fightingView_ = FightingView.new() -- 类型：PlayView，主游戏界面
    self:addChild(self.fightingView_)

    self:addNodeEventListener(cc.NODE_ENTER_FRAME_EVENT, handler(self, self.update))
    self:performWithDelay(function()
        self:scheduleUpdate()
    end, 1)
end

--[[--
    帧循环

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function FightingScene:update(dt)
    self.fightingView_:update(dt)
end

return FightingScene