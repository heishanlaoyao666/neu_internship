--[[--
    LoadingSceneController.lua

    描述：加载场景控制器类
]]
local BaseClass = require("app.ui.sceneController.BaseSceneController")
local LoadingSceneController = class("LoadingSceneController", BaseClass)
local Log = require("app.util.Log")

--[[--
    描述：构造函数

    @param ...

    @return none
]]
function LoadingSceneController:ctor()
    LoadingSceneController.super.ctor(self)

    Log.d()
end

return LoadingSceneController