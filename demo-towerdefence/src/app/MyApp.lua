
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

    -- 初始化消息处理器
    local MsgManager = require("app.manager.MsgManager")
    MsgManager:connect()

    -- 初始化场景管理器
    local SceneManager = require("app.manager.SceneManager")
    SceneManager:changeScene({ sceneId = SceneManager.DEF.ID.LAUNCHER })
end

return MyApp