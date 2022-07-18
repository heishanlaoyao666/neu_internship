--[[--
    SceneManager.lua

    描述：场景管理器类
]]
local SceneManager = {}
local SceneDef = require("app.def.SceneDef")
local Log = require("app.util.Log")

SceneManager.DEF = SceneDef -- 此处进行桥接，为了少require一个文件

local currentSceneController_

--[[--
    描述：切换场景
    
    @param params 类型：table，参数表，内部定义如下：
    {
        sceneId = 0, -- 类型：number，场景id，SceneDef.ID中定义（必填）
        transitionType = "", -- 类型：string，切换动画类型（非必填）
        transitionTime = 0, -- 类型：number，切换动画执行时间，在有transitionType的情况下，最低0.1（非必填）
    }
    @param ... 类型：任意，透传给场景控制器的可变参数
    
    @return none
]]
function SceneManager:changeScene(params, ...)
    if not isTable(params) or not isNumber(params.sceneId) then
        Log.e("unexpect params=", vardump(params))
        return
    end

    local config = SceneDef.Config[params.sceneId]
    if not config then
        Log.e("scene config not found, sceneId=", params.sceneId)
        return
    end

    -- 场景切换时需要清理toast
    -- 注意，此require不能放到顶部，会循环require
    require("app.manager.ToastManager"):removeAllToast()

    if currentSceneController_ then
        -- 注意，要解耦合，否则交叉引用将导致自动回收不生效
        currentSceneController_:setScene(nil)
    end

    local sceneController = require(config.sceneController).new(...)
    local scene = require(config.scene).new(sceneController)
    sceneController:setScene(scene)
    currentSceneController_ = sceneController
    local transitionTime = params.transitionType and math.max(0.1, tonumber(params.transitionTime))
    display.replaceScene(scene, params.transitionType, transitionTime, nil)
end

--[[--
    描述：获取当前显示的场景控制器

    @param none

    @return BaseSceneController
]]
function SceneManager:getCurrentSceneController()
    return currentSceneController_
end

--[[--
    描述：获取当前显示的场景

    @param none

    @return BaseScene
]]
function SceneManager:getCurrentScene()
    if currentSceneController_ then
        return currentSceneController_:getScene()
    end

    return nil
end

return SceneManager