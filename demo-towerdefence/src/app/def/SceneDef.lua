--[[--
    SceneDef.lua

    描述：场景相关常量定义
]]
local SceneDef = {}

-- 场景ID定义
SceneDef.ID = {
    LAUNCHER = 1,
    LOBBY = 2,
    PLAY = 3,
    LOADING = 4,
}

-- 场景路径
local SCENE_PATH = "app.ui.scene."

-- 场景控制器路径
local SCENE_CONTROLLER_PATH = "app.ui.sceneController."

-- 场景关联关系定义
SceneDef.Config = {
    [SceneDef.ID.LAUNCHER] = {
        scene = SCENE_PATH .. "LauncherScene",
        sceneController = SCENE_CONTROLLER_PATH .. "LauncherSceneController",
    },
    [SceneDef.ID.LOBBY] = {
        scene = SCENE_PATH .. "LobbyScene",
        sceneController = SCENE_CONTROLLER_PATH .. "LobbySceneController",
    },
    [SceneDef.ID.LOADING] = {
        scene = SCENE_PATH .. "LoadingScene",
        sceneController = SCENE_CONTROLLER_PATH .. "LoadingSceneController",
    },
    [SceneDef.ID.PLAY] = {
        scene = SCENE_PATH .. "PlayScene",
        sceneController = SCENE_CONTROLLER_PATH .. "PlaySceneController",
    },
}

-- 场景内zorder层级划分
SceneDef.ZORDER = {
    DEFAULT = 0, -- 默认
    DIALOG = 10000, -- 弹窗
    TOAST = 10001, -- toast提示
}

return SceneDef