require("app/scenes/Common")

local Scene=require"app/scenes/Scene"
local Block=require"app/scenes/Block"
local eventDispatcher = cc.Director:getInstance():getEventDispatcher()

local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)


function MainScene:yinXiao(path)
        audio.loadFile(path, function ()
            audio.playEffect(path, false)
        end)
end



function MainScene:ctor()
    self:ini()

end

function MainScene:ini()

    cc.UserDefault:getInstance():setStringForKey("Score" ,0)
end
function MainScene:level(score)
    if tonumber(score)<= 90000 then
        return 1
    end
    return 9
end
function MainScene:onEnter()

    self.scene=Scene.new(self)
    self.b =Block.new(self.scene,1)
    self.b:Place()
    self:processInput()

    self:Gen()

    local Tick =function()
        if self.pauseGame then
            return
        end
        if not self.b:Move(0, -1) then
            self:Gen()
        else
            self.b:Clear()

            while self.scene:CheckAndSweep() > 0 do
                self.scene:Shift()

            end
            self.b:Place()
        end
        print(cc.UserDefault:getInstance():getStringForKey("Score"))
    end
    cc.Director:getInstance():getScheduler():scheduleScriptFunc(Tick,1-self:level(cc.UserDefault:getInstance():getStringForKey("Score"))*0.1, false)
end

function MainScene:Gen()

    self.b = Block.new(self.scene, RandomStyle() )
    if not self.b:Place() then
        --GameOver
        self.scene:Clear()
    end
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
            self.b:zRotate()
            ---e
         elseif keyCode==128 then
                self.b:yRotate()
        ---p
        elseif keyCode==139 then
            self.pauseGame =not self.pauseGame
        end
    end,cc.Handler.EVENT_KEYBOARD_RELEASED)

    local eventDispatcher =self:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener,self)

    local inputTick =function()
        for keyCode,v in pairs(keyState)do
            ---s  下落
            if keyCode==142 then
                self.b:Move(0,-1)
            ---q  加速下落
            elseif keyCode==140 then
                self.b:Move(0,-2)
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
