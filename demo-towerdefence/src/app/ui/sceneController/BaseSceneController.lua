--[[--
    BaseSceneController.lua

    描述：场景管理器基类
]]
local BaseSceneController = class("BaseSceneController")
local Log = require("app.util.Log")

--[[--
    描述：构造函数

    @param none

    @return none
]]
function BaseSceneController:ctor()
    Log.d()

    self.scene_ = nil -- 类型：BaseScene，场景派生类
end

--[[--
    描述：设置场景

    @param scene 类型：BaseScene，场景派生类

    @return none
]]
function BaseSceneController:setScene(scene)
    self.scene_ = scene
end

--[[--
    描述：获取场景

    @param none

    @return BaseScene
]]
function BaseSceneController:getScene()
    return self.scene_
end

--[[--
    描述：场景进入，由scene调用
    
    @param none
    
    @return none
]]
function BaseSceneController:onSceneEnter()
    Log.d()
end

--[[--
    描述：场景进入动画执行结束，由scene调用

    @param none

    @return none
]]
function BaseSceneController:onSceneEnterFinish()
    Log.d()
end

--[[--
    描述：场景退出动画开始，由scene调用

    @param none

    @return none
]]
function BaseSceneController:onSceneExitStart()
    Log.d()
end

--[[--
    描述：场景退出，由scene调用

    @param none

    @return none
]]
function BaseSceneController:onSceneExit()
    Log.d()
end

--[[--
    描述：场景清理

    @param none

    @return none
]]
function BaseSceneController:onSceneCleanup()
    Log.d()
end

--[[--
    描述：场景帧刷新

    @param dt 类型：number，帧刷新间隔，单位：秒

    @return none
]]
function BaseSceneController:onSceneUpdate(dt)

end

--[[--
    描述：场景帧刷新后执行

    @param dt 类型：number，帧刷新间隔，单位：秒

    @return none
]]
function BaseSceneController:onSceneUpdateAfter(dt)

end

--[[--
    描述：消息处理

    @param msg 类型：table，消息体

    @return none
]]
function BaseSceneController:handleMsg(msg)
end

return BaseSceneController