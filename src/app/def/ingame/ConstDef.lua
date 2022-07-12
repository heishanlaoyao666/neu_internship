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

    --我方敌人生成位置
    MONSTER_INDEX_X = 70,
    MONSTER_INDEX_Y = 220,

    --我方敌人生成路线边界
    MONSTER_LEFT = 70,
    MONSTER_RIGHT = 650,
    MONSTER_TOP = 620,
    MONSTER_BOTTOM = 220,

    --敌方敌人生成位置
    ENEMY_MONSTER_INDEX_X = 650,
    ENEMY_MONSTER_INDEX_Y = 1100,

    --敌方敌人生成路线边界
    ENEMY_MONSTER_LEFT = 70,
    ENEMY_MONSTER_RIGHT = 650,
    ENEMY_MONSTER_TOP = 1100,
    ENEMY_MONSTER_BOTTOM = 770,

    --子弹大小
    BULLET_SIZE = {
        WIDTH = 10,
        HEIGHT = 10,
    },

    --子弹速度
    BULLET_SPEED = 800,

    --boss出现的时间
    BOSS_CREAT_TIME = {120, 100, 80, 60,},

    --塔强化需要的能量
    ENHANCE_NEED_SP = {100, 200, 400, 700}
}

return ConstDef