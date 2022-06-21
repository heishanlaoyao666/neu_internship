--[[--
    ConstDef.lua
    常量定义
]]
local ConstDef = {
    GRID_SIZE = 32, -- 每个格子的大小(以像素为单位)

    MAIN_BOARD_HEIGHT = 20,
    MAIN_BOARD_WIDTH = 10 + 2,

    NEXT_BOARD_WIDTH = 4,
    NEXT_BOARD_HEIGHT = 4,

    INFO_BOARD_WIDTH = 6,
    INFO_BOARD_HEIGHT = 10,

    GRID_TYPE = { -- 格子类型
        TYPE_0 = "res/img/texture/board.png",
        TYPE_1 = "res/img/texture/t_1.png",
        TYPE_2 = "res/img/texture/t_2.png",
        TYPE_3 = "res/img/texture/t_3.png",
        TYPE_4 = "res/img/texture/t_4.png",
        TYPE_5 = "res/img/texture/t_5.png",
        TYPE_6 = "res/img/texture/t_6.png",
        TYPE_7 = "res/img/texture/t_7.png",
    },

    GAME_BACKGROUND = "img/bg/bg.png", -- 游戏背景图片

    GAME_STATE = { -- 游戏状态
        INIT = 1,   -- 初始状态
        PLAY = 2,   -- 游戏状态
        PAUSE = 3,  -- 暂停状态
        OVER = 4,  -- 结算状态
    },
}

return ConstDef