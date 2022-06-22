--[[--
    GameSceneScene.lua
    战斗场景
]]
local GameScene = class("GameScene", function()
    return display.newScene("GameScene")
end)
local PlayView = require("app/scenes/GameView/ui/PlayView")
--local GameData = require("app.data.GameData")
--[[--
    构造函数

    @param none

    @return none
]]
function GameScene:ctor()

    self.playView_ = PlayView.new() -- 类型：PlayView，主游戏界面
    self:addChild(self.playView_)

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
function GameScene:update(dt)
    self.playView_:update(dt)
end
function GameScene:onEnter()
end

function GameScene:onExit()
end

return GameScene