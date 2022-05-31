require("config")
require("cocos.init")
require("framework.init")

local AppBase = require("framework.AppBase")
local MyApp = class("MyApp", AppBase)
local Log = require("app.util.Log")
local ConstantsUtil = require("app.util.ConstantsUtil")

function MyApp:ctor()
    MyApp.super.ctor(self)
    app.PushCenter = require("app.util.PushCenter")
end

function MyApp:run()
    cc.FileUtils:getInstance():addSearchPath("res/")

    local director = cc.Director:getInstance()
    director:setAnimationInterval(1.0 / 60)
    self:enterScene("MainScene")

    -- local scene = require("app.scenes.MainScene")
    -- local mainScene = scene.create()

    -- if cc.Director:getInstance():getRunningScene() then
    --     cc.Director:getInstance():replaceScene(mainScene)
    -- else
    --     cc.Director:getInstance():runWithScene(mainScene)
    -- end
end

return MyApp
