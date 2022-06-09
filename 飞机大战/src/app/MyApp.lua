
require("config")
require("cocos.init")
require("framework.init")

local AppBase = require("framework.AppBase")
local MyApp = class("MyApp", AppBase)

function MyApp:ctor()
    MyApp.super.ctor(self)
end

function MyApp:run()
    cc.FileUtils:getInstance():addSearchPath("res/")
    display.addSpriteFrames("Images_hd.plist","Images_hd.png","rank_bg.png", "rank_bg.png")
    local audio = require("framework.audio")
    audio.loadFile("res\\sounds\\mainMainMusic.ogg", function ()
        audio.playBGM("res\\sounds\\mainMainMusic.ogg",true)
    end)
    cc.UserDefault:getInstance():setBoolForKey("yinyue",true)

    --按钮音效
    audio.loadFile("res\\sounds\\buttonEffet.ogg", function ()
        audio.stopEffect()
    end)
    --子弹音效
    audio.loadFile("res\\sounds\\fireEffect.ogg", function ()
        audio.stopEffect()
    end)
    --击毁敌机音效
    audio.loadFile("res\\sounds\\explodeEffect.ogg", function ()
        audio.stopEffect()
    end)
    --飞机爆炸音效
    audio.loadFile("res\\sounds\\shipDestroyEffect.ogg", function ()
        audio.stopEffect()
    end)
    cc.UserDefault:getInstance():setBoolForKey("yinxiao",true)
    self:enterScene("MainScene")
end

return MyApp
