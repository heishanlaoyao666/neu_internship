--[[--
    游戏主界面
    PlayView.lua
]]
local PlayView = class("PlayView", function()
    return display.newColorLayer(cc.c4b(0, 0, 0, 0))
end)
local BGLayer = require("app/scenes/GameView/ui/layer/BGLayer.lua")
local InfoLayer = require("app/scenes/GameView/ui/layer/InfoLayer.lua")
local FightLayer = require("app/scenes/GameView/ui/layer/FightLayer.lua")
--local AnimLayer = require("app.ui.layer.AnimLayer")
local OppositeBossView = require("app/scenes/GameView/ui/OppositeBossView.lua")
local OppositeTowerView = require("app/scenes/GameView/ui/OppositeTowerView.lua")
local SurrenderView = require("app/scenes/GameView/ui/SurrenderView.lua")
local GameLoseView = require("app/scenes/GameView/ui/GameLoseView")
local GameWinView = require("app/scenes/GameView/ui/GameWinView")
local ConstDef = require("app/def/ConstDef.lua")
local EventDef = require("app/def/EventDef.lua")
local EventManager = require("app/manager/EventManager.lua")

--[[--
    构造函数

    @param none

    @return none
]]
function PlayView:ctor()
    self.bgLayer_ = nil -- 类型：BGLayer，背景层
    self.fightLayer_ = nil -- 类型：FightLayer，战斗层
    self.infoLayer_ = nil -- 类型：InfoLayer，信息层

    --以下是二级界面
    self.surrenderView_ = nil -- 类型：SurrenderView，投降界面
    self.oppositeTowerView_ = nil --类型：OppositeTowerView,对面塔信息界面
    self.oppositeBossView_ = nil --类型： OppositeBossView，对面boss信息界面

    self.gameLoseView = nil -- 类型：GameLoseView,游戏失败画面
    self.gameWinView = nil --类型: GameWinView, 游戏胜利画面
    self:initView()

    EventManager:doEvent(EventDef.ID.INTO_GAME)
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

    self.fightLayer_ = FightLayer.new()
    self:addChild(self.fightLayer_)

    self.infoLayer_ = InfoLayer.new()
    self:addChild(self.infoLayer_)

    -- self.animLayer_ = AnimLayer.new()
    -- self:addChild(self.animLayer_)

    --二级界面添加

    self.surrenderView_ = SurrenderView.new()
    self.surrenderView_:addTo(self)
    self.surrenderView_:setVisible(false)

    self.oppositeTowerView_ = OppositeTowerView.new()
    self.oppositeTowerView_:addTo(self)
    self.oppositeTowerView_:setVisible(false)

    self.oppositeBossView_ = OppositeBossView.new()
    self.oppositeBossView_:addTo(self)
    self.oppositeBossView_:setVisible(false)
    

    self.gameLoseView = GameLoseView.new()
    self:addChild(self.gameLoseView)
    self.gameLoseView:setVisible(false)
    self.gameWinView = GameWinView.new()
    self:addChild(self.gameWinView)
    self.gameWinView:setVisible(false)
end

--[[--
    节点进入

    @param none

    @return none
]]
function PlayView:onEnter()
    EventManager:regListener(EventDef.ID.VIEW_OPEN, self, function(state,tower_id)
        if state == ConstDef.GAME_VIEW.OPPOSITEBOSS then
            --self.oppositeTowerView_:showView()
            self.oppositeBossView_:showView()
        elseif state == ConstDef.GAME_VIEW.OPPOSITETOWER then
            self.oppositeTowerView_:showView(tower_id)
        elseif state == ConstDef.GAME_VIEW.SURRENDER then
            self.surrenderView_:showView()
        end
    end)
    EventManager:regListener(EventDef.ID.GAMESTATE_CHANGE, self, function(state,msg)
        if state == ConstDef.GAME_STATE.LOSE then
            self.surrenderView_:hideView()
            self.gameLoseView:showView(msg)
        elseif state == ConstDef.GAME_STATE.WIN then
            self.gameWinView:showView(msg)
        elseif state == ConstDef.GAME_STATE.INIT then
            self.randomBossView_:showView()
        end
    end)
    EventManager:regListener(EventDef.ID.OPPOSITE_SELECT, self, function(state)
        self.infoLayer_:BossBtnCreate()
    end)
end

--[[--
    节点退出

    @param none

    @return none
]]
function PlayView:onExit()
    EventManager:unRegListener(EventDef.ID.GAMESTATE_CHANGE, self)
    EventManager:unRegListener(EventDef.ID.VIEW_OPEN, self)
    EventManager:unRegListener(EventDef.ID.OPPOSITE_SELECT, self)
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