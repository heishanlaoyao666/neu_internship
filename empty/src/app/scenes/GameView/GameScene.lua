--[[--
    GameSceneScene.lua
    战斗场景
]]
local GameScene = class("GameScene", function()
    return display.newScene("GameScene")
end)
local PlayView = require("app/scenes/GameView/ui/PlayView")
local ConstDef = require("app/def/ConstDef.lua")
local GameData = require("app/data/GameData.lua")
local KnapsackData=require("app.data.KnapsackData")
local EventDef = require("app/def/EventDef.lua")
local EventManager = require("app/manager/EventManager.lua")
--[[--
    构造函数

    @param none

    @return none
]]
function GameScene:ctor()

    GameData:init()
    print("进行初始化")
    KnapsackData:gameMatch()
    EventManager:regListener(EventDef.ID.CREATE_GAME, self, function(msg)
        GameData:playerInit(msg)
        self.playView_ = PlayView.new() -- 类型：PlayView，主游戏界面
        print("匹配到了开赛")
        self:addChild(self.playView_)
        --audio.playEffect("sounds/fireEffect.ogg", false))
        self:addNodeEventListener(cc.NODE_ENTER_FRAME_EVENT, handler(self, self.update))
        self:performWithDelay(function() 
        self:scheduleUpdate()
    end, 1)
    end)
end
--[[--
    帧循环

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function GameScene:update(dt)
    --GameData:update(dt)
    self.playView_:update(dt)
end
function GameScene:onEnter()
end

function GameScene:onExit()
end

return GameScene