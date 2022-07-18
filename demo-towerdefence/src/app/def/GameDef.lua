--[[--
    GameDef.lua

    描述：游戏内常量定义
]]
local GameDef = {}

-- 游戏状态
GameDef.STATE = {
    NONE = 0, -- 无状态，默认值
    BOSS_SELECT = 1, -- boss选择
    PLAY = 2, -- 游戏进行
    RESULT = 3, -- 结算
}

-- 战斗场景尺寸
GameDef.WIDTH = 600
GameDef.HEIGHT = 450

return GameDef