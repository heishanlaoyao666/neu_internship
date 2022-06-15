
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
    --cc.Director:getInstance():setContentScaleFactor(640/CONFIG_SCREEN_WIDTH) --可以省略（内容缩放因子=1）
    self:enterScene("MainScene")
end

return MyApp
