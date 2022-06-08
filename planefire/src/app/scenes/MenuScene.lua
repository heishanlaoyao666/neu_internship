local MenuScene = class("MenuScene", function()
    return display.newScene("MenuScene")
end)

local audio = require("framework.audio")



function MenuScene:ctor()
    do
        --背景图片
        local background = display.newSprite("ui/main/bg_menu.jpg")
        background:pos(display.cx, display.cy)
        self:addChild(background)
    end
    self:initView()
end

function MenuScene:effectMusic(path)
    if cc.UserDefault:getInstance():getBoolForKey("effectMusic") then
        audio.loadFile(path, function ()
            audio.playEffect(path, false)
        end)
    end
end

function MenuScene:initView()
    --标题文字
    local title = display.newTTFLabel({
        text = "飞机大战",
        size = 32,
        color = display.COLOR_BLUE,
        x = display.cx,
        y = display.top * 7/8,
    })
    title:align(display.CENTER)
    self:addChild(title)

    --新游戏按钮
    local btn = ccui.Button:create("ui/main/new_game1.png", "ui/main/new_game2.png")
    btn:setScale9Enabled(true)
    btn:addTouchEventListener(function(sender, eventType)
        local id = cc.UserDefault:getInstance():getStringForKey("id")
        local name= cc.UserDefault:getInstance():getStringForKey("name")
        cc.UserDefault:getInstance():setBoolForKey("isDoc", false)
        if id == "" then
            local AnotherScence = require("src/app/scenes/RegisterScene")
            local RegisterScene = AnotherScence:new()
            display.replaceScene(RegisterScene, "fade", 0.5, cc.c3b(255, 255, 255))
        else
            local AnotherScence = require("src/app/scenes/GameScene")
            local GameScene = AnotherScence:new()
            display.replaceScene(GameScene, "fade", 0.5, cc.c3b(255, 255, 255))
        end
        self:effectMusic("sounds/buttonEffet.ogg")
    end)
    btn:pos(display.cx, display.top * 3/4)
    btn:addTo(self)

    --继续按钮
    local btn = ccui.Button:create("ui/main/continue_menu.png", "ui/main/continue_menu2.png")
    btn:setScale9Enabled(true)
    btn:addTouchEventListener(function(sender, eventType)
        if 2 == eventType then
            cc.UserDefault:getInstance():setBoolForKey("isDoc", true)
            local AnotherScence = require("src/app/scenes/GameScene")
            local GameScene = AnotherScence:new()
            display.replaceScene(GameScene, "fade", 0.5, cc.c3b(255, 255, 255))
        end
        self:effectMusic("sounds/buttonEffet.ogg")
    end)
    btn:pos(display.cx, display.top * 5/8)
    btn:addTo(self)

    --排行榜按钮
    local btn = ccui.Button:create("ui/main/rank_menu.png", "ui/main/rank_menu2.png")
    btn:setScale9Enabled(true)
    btn:addTouchEventListener(function(sender, eventType)
        if 2 == eventType then
            local AnotherScence = require("src/app/scenes/RankScene")
            local RankScene = AnotherScence:new()
            display.replaceScene(RankScene, "fade", 0.5, cc.c3b(255, 255, 255))
        end
        self:effectMusic("sounds/buttonEffet.ogg")
    end)
    btn:pos(display.cx, display.top * 1/2)
    btn:addTo(self)

    --设置按钮
    local btn = ccui.Button:create("ui/main/shezhi1_cover.png", "ui/main/shezhi2_cover.png")
    btn:setScale9Enabled(true)
    btn:addTouchEventListener(function(sender, eventType)
        if 2 == eventType then
            local AnotherScence = require("src/app/scenes/SettingScene")
            local SettingScene = AnotherScence:new()
            display.replaceScene(SettingScene, "fade", 0.5, cc.c3b(255, 255, 255))
        end
        self:effectMusic("sounds/buttonEffet.ogg")
    end)
    btn:pos(display.cx, display.top * 3/8)
    btn:addTo(self)
end

function MenuScene:onEnter()
    --开关背景音乐
    if cc.UserDefault:getInstance():getBoolForKey("mainMainMusic") then
        audio.loadFile("sounds/mainMainMusic.ogg", function ()
            audio.playBGM("sounds/mainMainMusic.ogg")
        end)
    else
        audio.stopBGM()
    end

    --开关音效
    if not cc.UserDefault:getInstance():getBoolForKey("effectMusic") then
        audio.stopEffect()
    end
end

function MenuScene:onExit()
end

return MenuScene