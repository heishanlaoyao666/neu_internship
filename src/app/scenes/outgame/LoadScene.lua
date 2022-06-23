--[[--
    LoadScene.lua
    战斗场景
]]
local LoadScene = class("LoadScene", function()
    return display.newScene("LoadScene")
end)
local LoadView = require("app.ui.outgame.view.LoadView")
local OutGameData = require("app.data.outgame.OutGameData")

--[[--
    构造函数

    @param none

    @return none
]]
function LoadScene:ctor()
    OutGameData:init()

    self.loadView_ = LoadView.new() -- 类型：PlayView，主游戏界面
    self:addChild(self.loadView_)

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
function LoadScene:update(dt)
    self.loadView_:update(dt)
end

return LoadScene