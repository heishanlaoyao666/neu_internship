local Func = require("app.Func")
local Block = require("app.Block")
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)
local score = 0
function MainScene:ctor()
    local Label = cc.Label:createWithTTF("Score:","fonts/Marker Felt.ttf",200)
    Label:setPosition(1600,2400)
    Label:setColor(cc.c3b(225,225,225))
    Label:addTo(self)

    scoreLabel = cc.Label:createWithTTF(score,"fonts/Marker Felt.ttf",200)
    scoreLabel:setPosition(1600,2000)
    scoreLabel:setColor(cc.c3b(225,225,225))
    scoreLabel:addTo(self)
    self:onCreate()

end
--[[
    函数用途：播放按钮音效
    --]]
function MainScene:playEffect(path)
    local effectPath = path
    local audio = require("framework.audio")
    audio.loadFile(effectPath,function()
        audio.playEffect(effectPath,false)
    end)
end

function MainScene:onCreate()
    self.func = Func.new(self)
    self.b = Block.new(self.func, 1)

    self:ProcessInput()--提供键盘输入
    self:Button()--提供按钮输入
    local game = function()
        if self.pauseGame then--正在暂停游戏
            return
        end
        if not self.b:Move(0, -1) then--没有正在向下移动方块则调用gen函数产生新方块
            self:Generate()
        else
            self.b:Clear()
            local num = 0
            while self.func:CheckAndSweep()>0 do
                num = num+1
            end
            if num ==1 then
                score = score+5
                elseif num == 2 then
                score = score+15
                elseif num == 3 then
                score = score+25
                elseif num == 4 then
                score = score+35
            end
            --print(score)
            self.b:Place()
            cc.Director:getInstance():getScheduler():scheduleScriptFunc(--刷新分数计时器
                    function()
                        scoreLabel:setString(score)
                    end,0.1,false)
        end
    end
    cc.Director:getInstance():getScheduler():scheduleScriptFunc(game, 0.3,false)
end

function MainScene:Generate()--产生新方块
    self.b = Block.new(self.func,RandomStyle())
    if not self.b:Place() then
        self.func:Clear()
    end
end


function MainScene:Button()--通过按钮控制移动旋转
    --按钮：左移
    local leftButton = ccui.Button:create("ui/c_2.png","ui/c_2.png")
    leftButton:setScale(3,3)
    leftButton:pos(300, 400)
    leftButton:setRotation(180)
    leftButton:setAnchorPoint(0.5,0.5)
    leftButton:addTouchEventListener(function(sender,eventType)
        if eventType == ccui.TouchEventType.ended then
            self.b:Move(-1, 0)
            --self:playEffect("sounds/move.mp3")
        end
    end)
    leftButton:addTo(self)

    --按钮：右移
    local rightButton = ccui.Button:create("ui/c_2.png","ui/c_2.png")
    rightButton:setScale(3,3)
    rightButton:pos(800, 400)
    rightButton:setAnchorPoint(0.5,0.5)
    rightButton:addTouchEventListener(function(sender,eventType)
        if eventType == ccui.TouchEventType.ended then
            self.b:Move(1, 0)
            --self:playEffect("sounds/move.mp3")
        end
    end)
    rightButton:addTo(self)

    --按钮：下落
    local fallButton = ccui.Button:create("ui/c_2.png","ui/c_2.png")
    fallButton:setScale(3,3)
    fallButton:pos(550,220)
    fallButton:setRotation(90)
    fallButton:setAnchorPoint(0.5,0.5)
    fallButton:addTouchEventListener(function(sender,eventType)
        if eventType == ccui.TouchEventType.ended then
            self.b:Move(0, -1)
            self:playEffect("sounds/fast_down.mp3")
        end
    end)
    fallButton:addTo(self)

    --按钮：旋转
    local rotateButton = ccui.Button:create("ui/c_1.png","ui/c_1.png")
    rotateButton:setScale(3,3)
    rotateButton:pos(1200,400)
    rotateButton:setAnchorPoint(0.5,0.5)
    rotateButton:addTouchEventListener(function(sender,eventType)
        if eventType == ccui.TouchEventType.ended then
            self.b:Rotation()
            --self:playEffect("sounds/rotate.mp3")
        end
    end)
    rotateButton:addTo(self)
end



function MainScene:ProcessInput()--通过家农安控制移动下落

    local listener = cc.EventListenerKeyboard:create()
    local keyState = {}

    listener:registerScriptHandler(function ( keyCode,event )--监听键盘是否被按下
        keyState[keyCode] = true
    end,cc.Handler.EVENT_KEYBOARD_PRESSED)

    listener:registerScriptHandler(function ( keyCode,event )--监听键盘是否被释放
        keyState[keyCode] = nil
        if keyCode ==146 then--W键旋转
            self.b:Rotation()
        elseif keyCode ==139 then--P键停止
            self.pauseGame = not self.pauseGame
        end

    end,cc.Handler.EVENT_KEYBOARD_RELEASED)
    local eventDispatcher = self:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, self)
    local input = function (  )
        for keyCode, v in pairs(keyState) do
            if keyCode == 142 then--S键快速下落
                self.b:Move(0, -1)
                --self:playEffect("sounds/fast_down.mp3")
            elseif keyCode == 124 then--A键左移
                self.b:Move(-1, 0)
            elseif keyCode == 127 then--D键右移
                self.b:Move(1, 0)
            end

        end
    end
    cc.Director:getInstance():getScheduler():scheduleScriptFunc(input, 0.1, false)
end

function MainScene:onEnter()
end

function MainScene:onExit()
end

return MainScene
