--[[--
    游戏主界面
    PlayView.lua
]]
local PlayView = class("PlayView", function()
    return display.newColorLayer(cc.c4b(0, 0, 0, 0))
end)
local BGLayer = require("app/scenes/GameView/ui/layer/BGLayer.lua")
-- local InfoLayer = require("app.ui.layer.InfoLayer")
-- local FightLayer = require("app.ui.layer.FightLayer")
-- local AnimLayer = require("app.ui.layer.AnimLayer")
-- local PauseView = require("app.ui.PauseView")
-- local ResultView = require("app.ui.ResultView")
-- local ConstDef = require("app.def.ConstDef")
-- local EventDef = require("app.def.EventDef")
-- local EventManager = require("app.manager.EventManager")

--[[--
    构造函数

    @param none

    @return none
]]
function PlayView:ctor()
    self.bgLayer_ = nil -- 类型：BGLayer，背景层
    self.fightLayer_ = nil -- 类型：FightLayer，战斗层
    self.infoLayer_ = nil -- 类型：InfoLayer，信息层
    self.pauseView_ = nil -- 类型：PauseView，暂停界面
    self.resultView_ = nil -- 类型：ResultView，结算界面

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

    -- self.fightLayer_ = FightLayer.new()
    -- self:addChild(self.fightLayer_)

    -- self.infoLayer_ = InfoLayer.new()
    -- self:addChild(self.infoLayer_)

    -- self.animLayer_ = AnimLayer.new()
    -- self:addChild(self.animLayer_)

    -- self.pauseView_ = PauseView.new()
    -- self:addChild(self.pauseView_)
    -- self.pauseView_:setVisible(false)

    -- self.resultView_ = ResultView.new()
    -- self:addChild(self.resultView_)
    -- self.resultView_:setVisible(false)
end

--[[--
    节点进入

    @param none

    @return none
]]
function PlayView:onEnter()
    -- EventManager:regListener(EventDef.ID.GAMESTATE_CHANGE, self, function(state)
    --     if state == ConstDef.GAME_STATE.PAUSE then
    --         self.pauseView_:showView()
    --     elseif state == ConstDef.GAME_STATE.RESULT then
    --         self.resultView_:showView()
    --     end
    -- end)
end

--[[--
    节点退出

    @param none

    @return none
]]
function PlayView:onExit()
    -- EventManager:unRegListener(EventDef.ID.GAMESTATE_CHANGE, self)
end

--[[--
    帧刷新

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function PlayView:update(dt)
    -- self.bgLayer_:update(dt)
    -- self.fightLayer_:update(dt)
    -- self.infoLayer_:update(dt)
end

return PlayView