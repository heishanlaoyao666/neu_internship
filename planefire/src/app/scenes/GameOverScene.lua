local GameOverScene = class("GameOverScene", function()
    return display.newScene("GameOverScene")
end)

function GameOverScene:effectMusic(path)
    if cc.UserDefault:getInstance():getBoolForKey("effectMusic") then
        audio.loadFile(path, function ()
            audio.playEffect(path, false)
        end)
    end
end


function GameOverScene:ctor()
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

function GameOverScene:initView()
    --昵称
    local name = cc.UserDefault:getInstance():getStringForKey("name")
    local font_name = ccui.Text:create("昵称：" .. name, "ui/font/FontNormal.ttf",24)
    font_name:pos(display.left + 150, display.cy + 170)
    font_name:setAnchorPoint(0.5, 0.5)
    font_name:addTo(self)

    --得分
    local score = cc.UserDefault:getInstance():getStringForKey("score")
    local font_score = ccui.Text:create("得分：" .. score, "ui/font/FontNormal.ttf",24)
    font_score:pos(display.right - 150, display.cy+ 170)
    font_score:setAnchorPoint(0.5, 0.5)
    font_score:addTo(self)

    --重新开始按钮
    local btn = ccui.Button:create("ui/gameover/restart.png","ui/gameover/restart.png")
    btn:setScale9Enabled(true)
    btn:addTouchEventListener(function(sender, eventType)
        display.resume()
        local AnotherScene = require("src/app/scenes/GameScene.lua")
        local GameScene = AnotherScene:new()
        display.replaceScene(GameScene, "fade", 0.5, cc.c3b(255, 255, 255))
    end)
    btn:setAnchorPoint(0.5,0.5)
    btn:pos(display.cx, display.cy - 50)
    btn:addTo(self)

    --返回主菜单按钮
    local btn = ccui.Button:create("ui/gameover/back.png","ui/gameover/back.png")
    btn:setScale9Enabled(true)
    btn:addTouchEventListener(function(sender, eventType)
        display.resume()
        local AnotherScene = require("src/app/scenes/MenuScene.lua")
        local MenuScene = AnotherScene:new()
        display.replaceScene(MenuScene, "fade", 0.5, cc.c3b(255, 255, 255))
    end)
    btn:setAnchorPoint(0.5,0.5)
    btn:pos(display.cx, display.cy - 150)
    btn:addTo(self)
end

function GameOverScene:onEnter()
end

function GameOverScene:onExit()
end

return GameOverScene