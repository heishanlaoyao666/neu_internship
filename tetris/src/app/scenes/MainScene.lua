require"app.scenes.Common"
local Scene = require "app.scenes.Scene"
local Block = require "app.scenes.Block"

local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()

end

function MainScene:ProcessInput()
    local listener = cc.EventListenerKeyboard:create()

    local keyState = {}

    --创建键盘按下的监听器
    listener:registerScriptHandler(function(keyCode, event)
        keyState[keyCode] = true
    end,cc.Handler.EVENT_KEYBOARD_PRESSED)

    --创建键盘抬起的监听器
    listener:registerScriptHandler(function(keyCode, event)
        keyState[keyCode] = nil
        --w：旋转
        if keyCode == 146 then
            self.b:Rotate()
        --p：暂停
        elseif keyCode == 139 then
            self.pauseGame = not self.pauseGame
        end
    end,cc.Handler.EVENT_KEYBOARD_RELEASED)

    local eventDispatcher = self:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, self)

    local inputTick = function()
        for keyCode, v in pairs(keyState) do
            --s
            if keyCode == 142 then
                self.b:Move(0, -1)

            --a
            elseif keyCode == 124 then
                self.b:Move(-1, 0)

            --d
            elseif keyCode == 127 then
                self.b:Move(1, 0)
            end
        end
    end
    cc.Director:getInstance():getScheduler():scheduleScriptFunc(inputTick, 0.1, false)

end

function MainScene:onEnter()
    self.scene = Scene.new(self)
    self.b = Block.new(self.scene, 1)
    self.b:Place()

    self:ProcessInput()
end

function MainScene:onExit()
end

return MainScene
