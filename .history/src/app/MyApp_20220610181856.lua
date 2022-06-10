-- require
require("config")
require("dkjson")
require("cocos.init")
require("framework.init")
--

-- local
local AppBase = require("framework.AppBase")
local MyApp = class("MyApp", AppBase)

local ConstantsUtil = require("app.util.ConstantsUtil")
local Log = require("app.util.Log")
local TypeConvert = require("app.util.TypeConvert")
local FileUtil = require("app.util.FileUtil")
local Config = require("app.util.Config")

local GameHandler = require("app.handler.GameHandler")
--

function MyApp:ctor()
    MyApp.super.ctor(self)
end

function MyApp:run()
    cc.FileUtils:getInstance():addSearchPath("res/")

    --- play music
    Audio.loadFile(
        ConstantsUtil.PATH_MAIN_MUSIC,
        function()
            ConstantsUtil.musicKey = UserDefault:getBoolForKey(ConstantsUtil.MUSIC_KEY, true)
            if ConstantsUtil.musicKey == true then
                Audio.playBGM(ConstantsUtil.PATH_MAIN_MUSIC, true)
            end
        end
    )
    Audio.loadFile(
        ConstantsUtil.PATH_BACKGROUND_MUSIC,
        function()
        end
    )

    -- DataLoad
    if GameHandler.isContinue == true then
        FileUtil.loadGame()
    end
    FileUtil.loadRank()

    -- WinSize
    Log.i(tostring(WinSize.width) .. " " .. tostring(WinSize.height))

    Director:setAnimationInterval(ConstantsUtil.INTERVAL_ANIMATION)
    self:enterScene("MainScene")
end

return MyApp
