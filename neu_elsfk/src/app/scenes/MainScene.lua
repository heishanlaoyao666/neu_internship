require("app.Common")

local Scene=require"app.Scene"
local Block=require"app.Block"

local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

local score=0
local speedLevel=1


function MainScene:ctor()

end

function MainScene:onEnter()

    self.scene=Scene.new(self)
    self.b =Block.new(self.scene,1)
    self.b:Place()
    self:processInput()
end

function MainScene:processInput()

    local listener= cc.EventListenerKeyboard:create()

    local keyState={}


    listener:registerScriptHandler(function (keyCode,event)
        keyState[keyCode]=true
    end,cc.Handler.EVENT_KEYBOARD_PRESSED)
    listener:registerScriptHandler(function (keyCode,event)
        keyState[keyCode]=nil
        ---w
        if keyCode==146 then
            self.b:Rotate()
        ---p
        elseif keyCode==139 then
            self.pauseGame =not self.pauseGame
        end
    end,cc.Handler.EVENT_KEYBOARD_RELEASED)

    local eventDispatcher =self:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener,self)

    local inputTick =function()
        for keyCode,v in pairs(keyState)do
            ---s
            if keyCode==142 then
                self.b:Move(0,-1)
            ---a
            elseif keyCode==124 then
                self.b:Move(-1,0)
            ---d
            elseif keyCode==127 then
                self.b:Move(1,0)
            end
        end
    end
    cc.Director:getInstance():getScheduler():scheduleScriptFunc(inputTick,0.1,false)
end

function MainScene:onExit()
end

return MainScene
