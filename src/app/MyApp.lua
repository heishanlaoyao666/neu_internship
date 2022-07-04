
require("config")
require("cocos.init")
require("framework.init")

local AppBase = require("framework.AppBase")
local MyApp = class("MyApp", AppBase)
local PlayerData = require("app.data.PlayerData")

function MyApp:ctor()
    MyApp.super.ctor(self)
end

function MyApp:run()
    cc.FileUtils:getInstance():addSearchPath("res/")
    PlayerData:init() -- 初始化数据

    self:enterScene("LobbyScene")
end

return MyApp
