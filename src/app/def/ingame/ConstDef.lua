--[[--
    ConstDef.lua
    常量定义
]]
local ConstDef = {
    --我方塔大小
    TOWER_SIZE = {
        WIDTH = 100,
        HEIGHT = 100,
    },

    --敌人大小
    MONSTER_SIZE = {
        {
            WIDTH = 43,
            HEIGHT = 44,
        },

        {
            WIDTH = 72,
            HEIGHT = 74,
        }
    },

    --敌人速度
    MONSTER_SPEED = 100,

    --敌人生成路线边界
    MONSTER_LEFT = 70,
    MONSTER_RIGHT = 650,
    MONSTER_TOP = 620,
}

return ConstDef