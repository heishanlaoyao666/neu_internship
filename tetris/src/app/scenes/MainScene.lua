require"app.scenes.Common"
local Scene = require "app.scenes.Scene"
local Block = require "app.scenes.Block"
local NextBoard = require"app.scenes.NextBoard"


local score = 0

local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()
    self.font_score = nil
    self:View()
end

function MainScene:View()
    local img_score = ccui.Text:create("score", "Marker Felt.ttf",24)
    img_score:pos(display.right * 1/6, display.top * 9/10)
    img_score:setAnchorPoint(0, 0.5)
    img_score:addTo(self)
    self.font_score = ccui.Text:create(score, "Marker Felt.ttf",24)
    self.font_score:pos(display.right * 2/6, display.top * 9/10)
    self.font_score:setAnchorPoint(0, 0.5)
    self.font_score:addTo(self)
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
        --q：逆时针旋转
        if keyCode == 140 then
            self.b:Rotate(1)
        --e:顺时针旋转
        elseif keyCode == 128 then
            self.b:Rotate(0)
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

function MainScene:Gen()
    local style = self.board:Next()
    self.b = Block.new(self.scene, style)
    if not self.b:Place() then
        --GameOver
        self.scene:Clear()
    end
end

function MainScene:onEnter()
    self.scene = Scene.new(self)
    self.board = NextBoard.new(self)

    self:ProcessInput()
    self:Gen()

    local Tick = function()
        if self.pauseGame then
            return
        end

        if not self.b:Move(0, -1) then
            self:Gen()
        else
            self.b:Clear()
            local getscore = self.scene:CheckAndSweep()
            while getscore > 0 do
                self.scene:Shift()
                score = score + getscore
                self.font_score:setString(score)
            end
            self.b:Place()
        end
    end

    cc.Director:getInstance():getScheduler():scheduleScriptFunc(Tick, 0.3, false)
end

function MainScene:onExit()
end

return MainScene
