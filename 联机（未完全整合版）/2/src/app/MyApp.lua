
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
    cc.UserDefault:getInstance():setIntegerForKey("play",1)
    cc.UserDefault:getInstance():setIntegerForKey("imgstatus",1)
    cc.UserDefault:getInstance():setIntegerForKey("towerData",1)
    self:enterScene("outgame/MainScene")
end
--[[--
    LoadScene --加载界面
]]

return MyApp
