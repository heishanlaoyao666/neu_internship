require("app.utils.Common")
local Block = require("app.entity.Block")
local Scene = require("app.scenes.Scene")
local NextBoard = require("app.other.NextBoard")


local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()

    self.size = cc.Director:getInstance():getWinSize()
    -- 设置游戏背景
    local bg = cc.Sprite:create("img/game_background.png")
    bg:setPosition(cc.p(self.size.width/2, self.size.height/2))
    bg:setScale(0.8, 0.8)
    self:addChild(bg)

    local masking = ccui.Layout:create()
    masking:setBackGroundColor(cc.c3b(255, 255, 255))
    masking:setBackGroundColorType(1)
    masking:setContentSize(display.width, display.height)
    masking:setPosition(display.cx, 0)
    masking:setAnchorPoint(0.5, 0)
    masking:setCascadeOpacityEnabled(true)
    masking:setOpacity(0.2 * 255)
    self:addChild(masking)


end

function MainScene:onEnter()

    self:ProcessInput()


    self.scene = Scene.new(self)
    self.board = NextBoard.new(self)

    self:Gen()

    -- 方块自动下坠
    local Tick = function()

        if self.pauseGame then
            return
        end

        -- 如果没有移动好就重新生成
        if not self.b:Move(0, -1) then
            self:Gen()
        else
            self.b:Clear()

            while self.scene:CheckAndSweep() > 0 do

                self.scene:Shift()
            end

            self.b:Place()

        end
    end

    -- 自动下坠
    cc.Director:getInstance():getScheduler():scheduleScriptFunc(Tick, 0.8, false)
end


function MainScene:Gen()

    local style = self.board:Next()

    self.b = Block.new(self.scene, style)

    if not self.b:Place() then

        -- GameOver
        self.scene:Clear()

    end
end


function MainScene:onExit()
end

function MainScene:ProcessInput()

    -- 创建一个键盘监听器
    local listener = cc.EventListenerKeyboard:create()

    local keyState = {}
    --- 接受键盘事件

    -- 按下键盘
    listener:registerScriptHandler(function(keyCode, event)
        -- 记录
        keyState[keyCode] = true
    end, cc.Handler.EVENT_KEYBOARD_PRESSED)

    -- 松开键盘
    listener:registerScriptHandler(function(keyCode, event)
        keyState[keyCode] = nil

        --- 不支持连发(抬起时只触发一次)

        -- w(旋转)
        if keyCode == 146 then
            self.b:Rotate()
        -- p(暂停游戏)
        elseif keyCode == 139 then
            self.pauseGame = not self.pauseGame
        end
    end, cc.Handler.EVENT_KEYBOARD_RELEASED)

    -- 创建事件分发器
    local eventDispatcher = self:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, self)


    --- 支持连发

    local inputTick = function()

        for keyCode, v in pairs(keyState) do

            -- s(向下)
            if keyCode == 142 then
                print("向下")
                self.b:Move(0, -1)
            -- a(向左)
            elseif keyCode == 124 then
                self.b:Move(-1, 0)
            -- d(向右)
            elseif keyCode == 127 then
                self.b:Move(1, 0)
            end
        end
    end

    cc.Director:getInstance():getScheduler():scheduleScriptFunc(inputTick, 0.1, false)



end

return MainScene
