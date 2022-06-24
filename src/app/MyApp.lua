
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
    --cc.UserDefault:getInstance():setBoolForKey("游戏外音乐",true)
    self:enterScene("outgame.MainScene")
end

return MyApp
