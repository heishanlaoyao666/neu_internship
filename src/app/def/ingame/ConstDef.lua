--[[--
    ConstDef.lua
    常量定义
]]
local ConstDef = {
    BULLET_SPEED = 300, -- 子弹速度
    ENEMY_SPEED = 300,  -- 敌机速度
    SELF_SPEED = 100, -- 我方飞机速度，（滚屏速度）

    ENEMY_PLANE_SCORE = 10, -- 敌机分数
    ENEMY_PLANE_DAMAGE = 20, -- 敌机伤害

    SELF_PLANE_SIZE = { -- 我方飞机尺寸
        WIDTH = 50, 
        HEIGHT = 50,
    },

    ENEMY_PLANE_SIZE = { -- 敌方飞机尺寸
        WIDTH = 37,
        HEIGHT = 39,
    },

    BULLET_SIZE = { -- 子弹尺寸
        WIDTH = 20,
        HEIGHT = 63,
    },

    GAME_STATE = {  
        INIT = 1,   -- 初始状态
        PLAY = 2,   -- 游戏状态
        PAUSE = 3,  -- 暂停状态
        RESULT= 4,  -- 结算状态
    },
}

return ConstDef