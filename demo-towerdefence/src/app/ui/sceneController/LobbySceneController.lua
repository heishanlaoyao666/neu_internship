--[[--
    LobbySceneController.lua

    描述：大厅场景控制器类
]]
local BaseClass = require("app.ui.sceneController.BaseSceneController")
local LobbySceneController = class("LobbySceneController", BaseClass)
local SceneManager = require("app.manager.SceneManager")
local ToastManager = require("app.manager.ToastManager")
local MsgDef = require("app.def.MsgDef")
local Log = require("app.util.Log")

--[[--
    描述：构造函数

    @param ...

    @return none
]]
function LobbySceneController:ctor()
    LobbySceneController.super.ctor(self)

    Log.d()
end

--[[--
    描述：消息处理

    @param msg 类型：table，消息体

    @return none
]]
function LobbySceneController:handleMsg(msg)
    if not isTable(msg) then
        Log.e("unexpect param, msg=", msg)
        return
    end

    local msgType = msg[MsgDef.KEY.TYPE]
    if msgType == MsgDef.ACK.MATCH_SIGNUP then
        local isSuccess = msg.ret == 0
        ToastManager:showToast("报名" .. (isSuccess and "成功" or "失败"))
    elseif msgType == MsgDef.ACK.MATCH_START then
        SceneManager:changeScene({
            sceneId = SceneManager.DEF.ID.LOADING,
            transitionType = "slideInR",
            transitionTime = 0.3,
        })
    end
end

return LobbySceneController