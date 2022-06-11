
require("config")
require("cocos.init")
require("framework.init")

local AppBase = require("framework.AppBase")
local MyApp = class("MyApp", AppBase)
local defaults = cc.UserDefault:getInstance()
local SystemConst = require("app.utils.SystemConst")

function MyApp:ctor()
    MyApp.super.ctor(self)
end

function MyApp:run()
    cc.FileUtils:getInstance():addSearchPath("res/")

    --- 初始化
    defaults:setBoolForKey(SystemConst.IF_CONTINUE, false)

    -- 判断是否已经注册

    -- 未注册
    if(defaults:getIntegerForKey("id") == 0 and defaults:getStringForKey("name") == "") then
        print(defaults:getIntegerForKey("id") )
        print(defaults:getStringForKey("name"))
        --self:enterScene("RegisterScene")
        print("进入Register场景...")
        cc.Director:getInstance():pushScene(require("app.scenes.RegisterScene").new())
    else
        print(defaults:getIntegerForKey("id") == 0 )
        print(defaults:getStringForKey("name") == "")
        --self:enterScene("MainScene")
        print("进入Main场景...")
        cc.Director:getInstance():pushScene(require("app.scenes.MainScene").new())
    end
end

return MyApp
