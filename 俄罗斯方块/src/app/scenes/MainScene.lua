require("app.Common")
local Scene = require("app.Scene")
local Block = require("app.Block")
local NextBoard=require("app.NextBoard")
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

local scheduler = require("framework.scheduler")

function MainScene:ctor()
    -- local label = display.newTTFLabel({
    --     text = "Hello",
    --     size = 64,
    -- })
    -- label:align(display.CENTER, display.cx, display.cy)
    -- label:addTo(self)

end

function MainScene:onEnter()

    self:ProcessInput()
    self.scene=Scene.new(self)
    self.board=NextBoard.new(self)
    --self.b=Block.new(self.scene,3)
    --self.b:Place()

    self:Gen()

    local  Tick = function()
        -- body
        if self.pauseGame then
            return
        end

        if not self.b:Move(0,-1) then
            self:Gen()
        else
            self.b:Clear()
            while self.scene:CheckAndSweep()>0 do
                self.scene:Shift()
                updataScore(10)
            end
            self.b:Place()
        end
    end
    cc.Director:getInstance():getScheduler():scheduleScriptFunc(Tick,0.3,false)

    self:initUI()
end

function MainScene:Gen()
    -- body
    local style=self.board:Next()

    --生成方块
    self.b=Block.new(self.scene,style)

    --游戏结束
    if not self.b:Place() then
        self.scene:Clear()
    end
end

function MainScene:ProcessInput()
    -- body
    local listener = cc.EventListenerKeyboard:create()

    local keyState = {}

    listener:registerScriptHandler(function(keyCode,event)
        -- body
        keyState[keyCode]=true
    end,cc.Handler.EVENT_KEYBOARD_PRESSED)

    listener:registerScriptHandler(function(keyCode,event)
        -- body
        keyState[keyCode]= nil

        --W
        --顺时针
        if keyCode==146 then
            self.b:Rotate(1)
        --Q
        --逆时针
        elseif keyCode==140 then
            self.b:Rotate(0)
        --P
        elseif keyCode==139 then
            self.pauseGame=not self.pauseGame
        end
    end,cc.Handler.EVENT_KEYBOARD_RELEASED)

    local eventDispatcher = self:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener,self)

    local inputTick=function()
    --local function inputTick()
        -- body
        for keyCode,v in pairs(keyState) do

            --s
            if keyCode==142 then
                self.b:Move(0,-1)
            --a
            elseif keyCode==124 then
                -- body
                self.b:Move(-1,0)
            --d
            elseif keyCode==127 then
                -- body
                self.b:Move(1,0)
            end
        end
    end

    --scheduler.scheduleGlobal(inputTick,0.1)
    cc.Director:getInstance():getScheduler():scheduleScriptFunc(inputTick,0.1,false)
end

function MainScene:initUI()
    -- body
    print("UI")
    -- local Layer = cc.Layout:creat(cc.c4b(255, 0, 0, 255))
    -- Layer:setContentSize(cc.size(300, 300))
    -- Layer:setAnchorPoint(cc.p(0.5, 0.5))
    -- Layer:pos(display.cx, display.cy + 250)
    -- self:addChild(Layer)
    cc.UserDefault:getInstance():setStringForKey("score",0)
    local score = display.newTTFLabel({
        text = "得分：",
        size = 30,
        color = display.COLOR_WHITE,
        x = display.cx-30,
        y = display.top-50,
        })
    :setAnchorPoint(0,1)
    :align(display.CENTER)
    :addTo(self)

    local score1 = display.newTTFLabel({
        text = cc.UserDefault:getInstance():getStringForKey("score"),
        size = 30,
        color = display.COLOR_WHITE,
        x = display.cx+30,
        y = display.top-50,
        })
    :setAnchorPoint(0,1)
    :align(display.CENTER)
    :addTo(self)
    local function updataScore(x)
        -- body
        print("分数更新")
        score:setString("得分："+cc.UserDefault:getInstance():getStringForKey("score")+x)
    end
end

function MainScene:onExit()
end

return MainScene
