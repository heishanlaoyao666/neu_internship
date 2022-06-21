



local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()
    self:onCreate()
end

require "app.scenes.Common"
local Scene = require("app.scenes.Scene")
local Block = require("app.scenes.Block")

function MainScene:onCreate()
    self.scene = Scene.new(self)
    self.b = Block.new(self.scene, 1)
    --print(self.b:Place())
    self.b:Place()
    self:ProcessInput()
    self:Gen()

    -- local label = display.newTTFLabel({
    --     text = "分数",
    --     size = 64,
    -- })
    -- label:align(display.CENTER, display.cx, display.cy)
    -- label:addTo(self)

    local leftmoveBtn = ccui.Button:create("ui/c_2.png")
    leftmoveBtn:setRotation(180)
    leftmoveBtn:setAnchorPoint(0.5,0.5)
    leftmoveBtn:setPosition(display.cx+250,display.cy)
    leftmoveBtn:addTouchEventListener(function(sender,eventType)
        if 2==eventType then
            self.b:Move(-1,0)
        end
    end)
    self:addChild(leftmoveBtn)

    local rightmoveBtn = ccui.Button:create("ui/c_2.png")
    rightmoveBtn:setAnchorPoint(0.5,0.5)
    rightmoveBtn:setPosition(display.cx+430,display.cy)
    rightmoveBtn:addTouchEventListener(function(sender,eventType)
        if 2==eventType then
            self.b:Move(1,0)
        end
    end)
    self:addChild(rightmoveBtn)

    local downmoveBtn = ccui.Button:create("ui/c_2.png")
    downmoveBtn:setRotation(90)
    downmoveBtn:setAnchorPoint(0.5,0.5)
    downmoveBtn:setPosition(display.cx+340,display.cy-100)
    downmoveBtn:addTouchEventListener(function(sender,eventType)
        if 2==eventType then
            self.b:Move(0,-1)
        end
    end)
    self:addChild(downmoveBtn)

    local rmoveBtn = ccui.Button:create("ui/c_1.png")
    rmoveBtn:setAnchorPoint(0.5,0.5)
    rmoveBtn:setPosition(display.cx+340,display.cy+100)
    rmoveBtn:addTouchEventListener(function(sender,eventType)
        if 2==eventType then
            print("1111111111")
            print(self.b)
            print("1111111111")
            self.b:Rotation()
        end
    end)
    self:addChild(rmoveBtn)
--计分板
    local label1 = cc.Label:createWithTTF("score","ui/Marker Felt.ttf",36) 
    label1:setPosition(display.cx-350,display.cy+200)
    self:addChild(label1,1)

    -- local num1 = 0;
    -- local label2 = cc.Label:createWithTTF(num1,"ui/Marker Felt.ttf",36) 
    -- label2:setPosition(display.cx-350,display.cy+150)
    -- self:addChild(label2,1)

    local score = 0

    local Tick = function()
        if self.pauseGame then
            return
        end
        if not self.b:Move(0, -1) then
            self:Gen()
        else
            self.b:Clear()
            local num2 = 0
            
            while self.scene:CheckAndSweep()>0 do
                ---5 15 25 35                 
                self.scene:Shift()
                num2 = num2 + 1
            end


            if num2==1 then
                score = score+5
            elseif num2==2 then
                score = score+15
            elseif num2==3 then
                score = score+25
            elseif num2==4 then
                score = score+35
            end

            display.newSprite("ui/black.png")
                :pos(display.cx-350,display.cy+100)
                :addTo(self)

            self.label3 = ccui.TextBMFont:create(tostring(score),"ui/Marker Felt.ttf") 
            self.label3:setPosition(display.cx-350,display.cy+100)
            self.label3:setScale(3,3)
            self:addChild(self.label3)
            self.label3:setString(tostring(score))


            self.b:Place()
        end
    end
    cc.Director:getInstance():getScheduler():scheduleScriptFunc(Tick, 0.3,false)
end

function MainScene:Gen()
    self.b = Block.new(self.scene,RandomStyle())
    if not self.b:Place() then
        self.scene:Clear()
    end
end

function MainScene:ProcessInput()

    local listener = cc.EventListenerKeyboard:create()
    local keyState = {}

    listener:registerScriptHandler(function ( keyCode,event )
        keyState[keyCode] = true
    end,cc.Handler.EVENT_KEYBOARD_PRESSED)
    listener:registerScriptHandler(function ( keyCode,event )
        keyState[keyCode] = nil
        --w
        if keyCode ==146 then
            self.b:Rotation()
            --p
        elseif keyCode ==139 then
            self.pauseGame = not self.pauseGame
        end

    end,cc.Handler.EVENT_KEYBOARD_RELEASED)
    local eventDispatcher = self:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, self)
    local inputTick = function (  )
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
end

function MainScene:onExit()
end

return MainScene



-- local MainScene = class("MainScene", function()
--     return display.newScene("MainScene")
-- end)

-- function MainScene:ctor()
--     -- local label = display.newTTFLabel({
--     --     text = "Hello, World",
--     --     size = 64,
--     -- })
--     -- label:align(display.CENTER, display.cx, display.cy)
--     -- label:addTo(self)

--     --初始化背景
--     display.newSprite("res/ui/back.png")
--             :pos(display.cx,display.cy)
--             :addTo(self)
    
--     --初始化按钮
--     local images = {
--         normal = "res/ui/start.png",
--         pressed = "",
--         disabled = "res/ui/start.png"
--     }

--     local newGameBtn = ccui.Button:create(images["normal"], images["pressed"], images["disabled"])
--     newGameBtn:setAnchorPoint(cc.p(0.5 ,0.5))
--     -- 居中
--     newGameBtn:setPosition(cc.p(display.cx, display.cy))
--     -- 设置缩放程度
--     newGameBtn:setScale(0.5, 0.5)
--     -- 设置是否禁用(false为禁用)
--     newGameBtn:setEnabled(true)
--     newGameBtn:addClickEventListener(function()
--         print("lalala")
--     end)

--     newGameBtn:addTouchEventListener(function(sender, eventType)
-- 	 	if eventType == ccui.TouchEventType.ended then
-- 	 		local aBtn = import("app.scenes.TitleScene"):new()
--             display.replaceScene(aBtn,"turnOffTiles",0.5)
--             print(transform)
-- 	 	end
-- 	end)

--     self:addChild(newGameBtn, 4)
-- end

-- function MainScene:onEnter()
--     self.scene = Scene.new(self)
-- end

-- function MainScene:onExit()
-- end

-- return MainScene
