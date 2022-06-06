
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
    cc.Director:getInstance():setContentScaleFactor(640 / CONFIG_SCREEN_HEIGHT)
    self:enterScene("MenuScene")
end

return MyApp

--[[
    菜单界面：MenuScene
    注册界面：RegisterScene
    设置界面：SettingScene
    游戏界面：GameScene
    排行界面：RankScene
    暂停界面：PauseScene
    结束界面：GameOverScene
]]
