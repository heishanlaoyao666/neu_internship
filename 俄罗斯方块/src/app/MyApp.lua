
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
    self:enterScene("MainScene")
end

return MyApp
