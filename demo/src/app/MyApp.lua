
require("config")
require("cocos.init")
require("framework.init")

local AppBase = require("framework.AppBase")
local MyApp = class("MyApp", AppBase)
local PlayerData = require("app.data.PlayerData")
local StoreData = require("app.data.StoreData")

function MyApp:ctor()
    MyApp.super.ctor(self)
end

function MyApp:run()
    cc.FileUtils:getInstance():addSearchPath("res/")

    PlayerData:init() -- 初始化数据(单机情况)
    StoreData:init() -- 初始化商店(单机情况)

    self:enterScene("LoadingScene")
end

return MyApp
