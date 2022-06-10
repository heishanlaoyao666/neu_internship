

local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

---properties
MainScene.backGround = {"res/ui/main/bg_menu.jpg"}
MainScene.menuData = {
    {"ContinueView","res/ui/main/continue_menu.png","res/ui/main/continue_menu2.png"},
    {"NewGameView","res/ui/main/new_game1.png","res/ui/main/new_game2.png"},
    {"RankView","res/ui/main/rank_menu.png","res/ui/main/rank_menu2.png"},
    {"SettingView","res/ui/main/shezhi1_cover.png","res/ui/main/shezhi2_cover.png"}
}
MainScene.sound = {
    music = "res/sounds/mainMainMusic.ogg",
    buttonEffect = "res/sounds/buttonEffet.ogg"
}
--for setting
MainScene.userConfig = {}
---constructor
function MainScene:ctor()
    --[[
    this block use to get user config
    not completed
    --]]
    audio.playBGMSync(self.sound.music, true)
    self:createBackground()
    self:createMenu()
end
---method
function MainScene:createBackground()
    local width, height = display.width, display.height
    local backLayer = display.newColorLayer(cc.c4b(255,255,255,0))
    backLayer:setContentSize(width, height)
    backLayer:setPosition(0, 0)
    local sprite = display.newScale9Sprite(self.backGround[1],0,0,cc.size(width, height))
    sprite:setContentSize(width, height)
    sprite:setAnchorPoint(0, 0)
    sprite:setPosition(0, 0)
    backLayer:addChild(sprite)
    self:addChild(backLayer)
end
function MainScene:createMenu()

    local width, height = 150, display.height
    local menuLayer = ccui.Layout:create()
    menuLayer:setBackGroundColor(cc.c4b(255, 255, 255, 0))
    --
    menuLayer:setBackGroundColorType(3)
    menuLayer:setContentSize(width, height)
    menuLayer:setAnchorPoint(0.5, 0.5)
    menuLayer:setPosition(display.width/2, height/2)
    for i, v in pairs(self.menuData) do
        --print("tag1")
        local button = ccui.Button:create(v[2], v[3])
        button:setAnchorPoint(0.5, 0.5)
        --button:setScale9Enabled(true)
        button:setContentSize(130, 40)
        button:setTitleText("")
        button:pos(width * 0.5, height - 260 - i * 80)
        button:setTitleFontSize(20)
        button:addTouchEventListener(function(sender, eventType)
            audio.playEffectSync(self.sound.buttonEffect, false)
            if 2 == eventType then
                self:switch(v[1])
            end
        end)
        menuLayer:addChild(button)
    end
    self:addChild(menuLayer)
end

function MainScene:switch(str)
    if str == "RankView" or str == "SettingView" then
        app:createView(str):addTo(self)
    elseif str == "ContinueView" then
        local GameScene = require("src.app.scenes.ContinueGameScene")
        local gameScene = GameScene:new()
        cc.Director:getInstance():replaceScene(gameScene)
    elseif str == "NewGameView" then
        local GameScene = require("src.app.scenes.NewGameScene")
        local gameScene = GameScene:new()
        cc.Director:getInstance():replaceScene(gameScene)
    else
        print("shabi")
    end
end

function MainScene:onEnter()
end
function MainScene:onExit()
end
return MainScene

