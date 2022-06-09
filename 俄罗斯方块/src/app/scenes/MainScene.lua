require("app.Common")
local Scene = require("app.Scene")
local Block = require("app.Block")

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

    self.scene=Scene.new(self)

    self.b=Block.new(self.scene,3)
    self.b:Place()

    self:ProcessInput()

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
            end
            self.b:Place()
        end
    end
    cc.Director:getInstance():getScheduler():scheduleScriptFunc(Tick,0.3,false)
end

function MainScene:Gen()
    -- body
    self.b=Block.new(self.scene,RandomStyle())

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
        if keyCode==146 then
            self.b:Rotate()
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


function MainScene:onExit()
end

return MainScene
