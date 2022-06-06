local PauseScene = class("PauseScene", function()
    return display.newScene("PauseScene")
end)

function PauseScene:ctor()
    local inputLayer = ccui.Layout:create()
    inputLayer:setBackGroundColor(cc.c3b(255, 255, 255))
    inputLayer:setBackGroundColorType(1)
    inputLayer:setContentSize(480, 720)
    inputLayer:setPosition(display.cx, display.cy)
    inputLayer:setAnchorPoint(0.5, 0.5)
    inputLayer:setOpacity(80)
    inputLayer:addTo(self)

    self:initView()
end

function PauseScene:initView()
    --返回按钮
    local btn = ccui.Button:create("ui/continue/pauseResume.png","ui/continue/pauseResume.png")
    btn:setScale9Enabled(true)
    btn:addTouchEventListener(function(sender, eventType)
        display.resume()
        self:removeFromParent(true)
    end)
    btn:setAnchorPoint(0.5,0.5)
    btn:pos(display.cx, display.cy + 50)
    btn:addTo(self)

    --返回主菜单按钮
    local btn = ccui.Button:create("ui/continue/pauseBackRoom.png","ui/continue/pauseBackRoom.png")
    btn:setScale9Enabled(true)
    btn:addTouchEventListener(function(sender, eventType)
        display.resume()
        local AnotherScene = require("src/app/scenes/MenuScene.lua")
        local MenuScene = AnotherScene:new()
        display.replaceScene(MenuScene, "fade", 0.5, cc.c3b(255, 255, 255))
    end)
    btn:setAnchorPoint(0.5,0.5)
    btn:pos(display.cx, display.cy - 50)
    btn:addTo(self)
end

function PauseScene:onEnter()
end

function PauseScene:onExit()
end

return PauseScene