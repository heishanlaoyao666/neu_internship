require("config")
require("cocos.init")
require("framework.init")

local AppBase = require("framework.AppBase")
local MyApp = class("MyApp", AppBase)
local Log = require("app.util.Log")
local TypeConvert = require("app.util.TypeConvert")
local ConstantsUtil = require("app.util.ConstantsUtil")
local GameHandler = require("app.handler.GameHandler")

function MyApp:ctor()
    MyApp.super.ctor(self)
    app.PushCenter = require("app.util.PushCenter")
end

function MyApp:run()
    cc.FileUtils:getInstance():addSearchPath("res/")
    --- play music
    Audio.loadFile(
        ConstantsUtil.PATH_MAIN_MUSIC,
        function()
            local musicKey = UserDefault:getBoolForKey(ConstantsUtil.MUSIC_KEY, true)
            if musicKey == true then
                Audio.playBGM(ConstantsUtil.PATH_MAIN_MUSIC, true)
            end
        end
    )
    Audio.loadFile(
        ConstantsUtil.PATH_BACKGROUND_MUSIC,
        function()
        end
    )
    -- Audio.loadFile(ConstantsUtil.PATH_EXPLOSION_EFFECT, nil)
    -- Audio.loadFile(ConstantsUtil.PATH_DESTROY_EFFECT, nil)
    -- Audio.loadFile(ConstantsUtil.PATH_FIRE_EFFECT, nil)
    -- Audio.loadFile(ConstantsUtil.PATH_BUTTON_EFFECT, nil)

    Director:setAnimationInterval(ConstantsUtil.INTERVAL_ANIMATION)
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
