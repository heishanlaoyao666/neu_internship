--[[--
    BaseScene.lua

    描述：场景基类
]]
local BaseScene = class("BaseScene", function() return display.newScene() end)
local Log = require("app.util.Log")
local scheduler = require("framework.scheduler")

--[[--
    描述：构造函数

    @param sceneController 类型：SceneControllerBase，场景控制器派生类

    @return none
]]
function BaseScene:ctor(sceneController)
    Log.d()

    self.sceneController_ = sceneController -- 类型：SceneControllerBase，场景控制器派生类
    self.isUpdateEnable_ = false -- 类型：boolean，是否启动帧刷新
    self.updateHandler_ = nil -- 类型：scheduler，帧刷新句柄
end

--[[--
    描述：2dx 中 scene 的生命周期，由 2dx 回调 onEnter

    @param none

    @return none
]]
function BaseScene:onEnter()
    Log.d()

    self.sceneController_:onSceneEnter()

    -- 初始化默认底图
    local defaultBgLayer = cc.LayerColor:create(cc.c4b(0, 0, 100, 255))
    defaultBgLayer:setContentSize(cc.size(display.width, display.height))
    defaultBgLayer:setPosition(cc.p(0, 0))
    self:addChild(defaultBgLayer, -1000)
end

--[[--
    描述：2dx 中 scene 的生命周期，由 2dx 回调 onExit
    @param none

    @return none
]]
function BaseScene:onExit()
    Log.d()

    if self.updateHandler_ then
        scheduler.unscheduleGlobal(self.updateHandler_)
        self.updateHandler_ = nil
    end

    self.sceneController_:onSceneExit()
end

--[[--
    2dx 中 scene 的生命周期，由 2dx 回调 onEnterTransitionFinish
    @param none

    @return none
]]
function BaseScene:onEnterTransitionFinish()
    Log.d()

    self.sceneController_:onSceneEnterFinish()
end

--[[--
    描述：2dx 中 scene 的生命周期，由 2dx 回调 onExitTransitionStart

    @param none

    @return none
]]
function BaseScene:onExitTransitionStart()
    Log.d()

    self.sceneController_:onSceneExitStart()
end

--[[--
    描述：2dx 中 scene 的生命周期，由 2dx 回调 onCleanup

    @param none

    @return none
]]
function BaseScene:onCleanup()
    Log.d()

    if self.updateHandler_ then
        scheduler.unscheduleGlobal(self.updateHandler_)
        self.updateHandler_ = nil
    end

    self.sceneController_:onSceneCleanup()
end

--[[--
    描述：帧刷新

    @param dt 类型：number，帧刷新间隔，单位：毫秒

    @return none
]]
function BaseScene:onUpdate(dt)

end

--[[--
    描述：设置帧刷新是否生效

    @param isEnable 类型：boolean，是否生效

    @return none
]]
function BaseScene:setUpdateEnable(isEnable)
    if not isBoolean(isEnable) then
        Log.e("unexpecet param, isEnable=", isEnable)
        return
    end

    if self.isUpdateEnable_ == isEnable then
        return
    end

    self.isUpdateEnable_ = isEnable

    if isEnable then
        if not self.updateHandler_ then
            self.updateHandler_ = scheduler.scheduleUpdateGlobal(function(dt)
                -- 注意，优先刷新sceneController，后刷新场景
                self.sceneController_:onSceneUpdate(dt)
                self:onUpdate(dt)
                self.sceneController_:onSceneUpdateAfter(dt)
            end)
        end
    else
        if self.updateHandler_ then
            scheduler.unscheduleGlobal(self.updateHandler_)
            self.updateHandler_ = nil
        end
    end
end

--[[--
    描述：帧刷新是否启用

    @param none

    @return boolean
]]
function BaseScene:isUpdateEnable()
    return self.isUpdateEnable_
end

return BaseScene