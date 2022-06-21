--[[--
    MainScene.lua
    主场景定义
]]
local ConstDef = require("app.def.ConstDef")
local GameData = require("app.data.GameData")
local PlayView = require("app.ui.PlayView")
local OverView = require("app.ui.OverView")
local EventManager = require("app.manager.EventManager")
local EventDef = require("app.def.EventDef")

local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

--[[--
    构造函数

    @param none

    @return none
]]
function MainScene:ctor()

    self.listener_ = nil

    self.scheduleIdA_ = nil
    self.scheduleIdB_ = nil

    self.gameData_ = GameData.new() -- GameData

    self.playView_ = PlayView.new(self.gameData_) -- 类型：PlayView，主游戏界面
    self:addChild(self.playView_)

    self.overView_ = OverView.new(self.gameData_)
    self:addChild(self.overView_)
    self.overView_:setVisible(false)

    self:addNodeEventListener(cc.NODE_ENTER_FRAME_EVENT, handler(self, self.update))
    -- 延时执行
    self:performWithDelay(function()
        self:scheduleUpdate()
    end, 1)

end

--[[--
    节点进入

    @param none

    @return none
]]
function MainScene:onEnter()

    EventManager:regListener(EventDef.ID.UPDATE_SPEED, self, function()
        print("Update speed!")
        self:updateSpeed()
    end)

    EventManager:regListener(EventDef.ID.OVER_GAME, self, function()
        print("OverView!")
        self.overView_:showView()
    end)

    EventManager:regListener(EventDef.ID.RESTART_GAME, self, function()
        print("Restart Game!")
        cc.Director:getInstance():replaceScene(require("app.scenes.MainScene").new())
    end)

    EventManager:regListener(EventDef.ID.EXIT_GAME, self, function()
        print("Exit Game!")
        cc.Director:getInstance():popScene()
    end)
end

--[[--
    节点退出

    @param none

    @return none
]]
function MainScene:onExit()

    print("MainScene Exit!")

    EventManager:unRegListener(EventDef.ID.UPDATE_SPEED, self)
    EventManager:unRegListener(EventDef.ID.OVER_GAME, self)
    EventManager:unRegListener(EventDef.ID.RESTART_GAME, self)
    EventManager:unRegListener(EventDef.ID.EXIT_GAME, self)

    cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.scheduleIdA_)
    cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.scheduleIdB_)
end


--[[--
    进入结束函数

    @param none

    @return none
]]
function MainScene:onEnterTransitionFinish()

    print("OnEnterTransitionFinish!")

    -- 开始游戏
    self.gameData_:setGameState(ConstDef.GAME_STATE.PLAY)

    self:processInput()
end

--[[--
    帧循环

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function MainScene:update(dt)

    self.gameData_:update(dt)

    if self.gameData_:isPlaying() then
        self.playView_:update(dt)
    end
end

--[[--
    处理键盘事件

    @param none

    @return none
]]
function MainScene:processInput()

    self.listener_ = cc.EventListenerKeyboard:create()
    local keyState = {}

    -- 按下键盘
    self.listener_:registerScriptHandler(function(keyCode, event)
        keyState[keyCode] = true
    end, cc.Handler.EVENT_KEYBOARD_PRESSED)
    -- 松开键盘
    self.listener_:registerScriptHandler(function(keyCode, event)
        keyState[keyCode] = nil
        -- w(旋转)
        if keyCode == 133 then
            self.gameData_:getMainBlock():rotateCW()
        elseif keyCode == 134 then
            self.gameData_:getMainBlock():rotateCCW()
            -- p(暂停游戏)
        elseif keyCode == 139 then
            if self.gameData_:getGameState() == ConstDef.GAME_STATE.PLAY then
                self.gameData_:setGameState(ConstDef.GAME_STATE.PAUSE)
            elseif self.gameData_:getGameState() == ConstDef.GAME_STATE.PAUSE then
                self.gameData_:setGameState(ConstDef.GAME_STATE.PLAY)
            end
        end
    end, cc.Handler.EVENT_KEYBOARD_RELEASED)

    -- 创建事件分发器
    local eventDispatcher = self:getEventDispatcher() --- 放在GameData中会报错
    eventDispatcher:addEventListenerWithSceneGraphPriority(self.listener_, self)

    -- 操作调度器
    self.scheduleIdA_ = cc.Director:getInstance():getScheduler():scheduleScriptFunc(function()

        for keyCode, v in pairs(keyState) do

            -- s(向下)
            if keyCode == 142 then
                self.gameData_:getMainBlock():move(0, -1)
                -- a(向左)
            elseif keyCode == 124 then
                self.gameData_:getMainBlock():move(-1, 0)
                -- d(向右)
            elseif keyCode == 127 then
                self.gameData_:getMainBlock():move(1, 0)
            end
        end
    end, 0.1, false)

    -- 自动下坠调度器
    self.scheduleIdB_ = cc.Director:getInstance():getScheduler():scheduleScriptFunc(function ()
        self.gameData_:tick()
    end , self.gameData_:getSpeed(), false)

    self.gameData_:gen()

end

--[[--
    更新速度

    @param none

    @return none
]]
function MainScene:updateSpeed()
    print("Update speed!")
    if self.scheduleIdB_ ~= nil then
        cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.scheduleIdB_)
    end
    self.scheduleIdB_ = cc.Director:getInstance():getScheduler():scheduleScriptFunc(function ()
        self.gameData_:tick()
    end , self.gameData_:getSpeed(), false)

end


return MainScene
