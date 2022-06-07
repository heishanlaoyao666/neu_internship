
require("config")
require("cocos.init")
require("framework.init")

local AppBase = require("framework.AppBase")
local MyApp = class("MyApp", AppBase)

function MyApp:ctor()
    MyApp.super.ctor(self)
end

function MyApp:run()
    --TODO音乐播放
    -- local audio = require("framework.audio")
    -- audio.loadFile("sounds/bgMusic.ogg", function ()
    --     audio.playBGM("sounds/bgMusic.ogg")
    -- end)
    local id=cc.UserDefault:getInstance():getIntegerForKey("id")
    if(id~="") then
        self:enterScene("MainScene")
    else
        self:enterScene("RegisterScene")
    end
end

return MyApp
