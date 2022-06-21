--[[--
    MainScene.lua
    主场景定义
]]
local ConstDef = require("app.def.ConstDef")
local Block = require("app.data.Block")
local GameData = require("app.data.GameData")
local PlayView = require("app.ui.PlayView")

local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

--[[--
    构造函数

    @param none

    @return none
]]
function MainScene:ctor()

    GameData:init()

    self.playView_ = PlayView.new() -- 类型：PlayView，主游戏界面
    self:addChild(self.playView_)

    self:addNodeEventListener(cc.NODE_ENTER_FRAME_EVENT, handler(self, self.update))
    -- 延时执行
    self:performWithDelay(function()
        self:scheduleUpdate()
    end, 1)

end

--[[--
    帧循环

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function MainScene:update(dt)

    GameData:update(dt)

    if GameData:isPlaying() then
        self.playView_:update(dt)
    end
end



return MainScene
