--[[--
    LauncherSceneController.lua

    描述：启动场景控制器类
]]
local BaseClass = require("app.ui.sceneController.BaseSceneController")
local LauncherSceneController = class("LauncherSceneController", BaseClass)
local Log = require("app.util.Log")

--[[--
    描述：构造函数

    @param ...

    @return none
]]
function LauncherSceneController:ctor()
    LauncherSceneController.super.ctor(self)

    Log.d()
end

return LauncherSceneController