--[[--
    ConstDef.lua
    常量定义
]]
local ConstDef = {
    DOWN_SPEED_GRADE = 1, -- 下落速度等级

    GAME_WIDTH_SIZE = 10, --游戏容纳方块宽度数量

    GAME_HEIGHT_SIZE = 20,--游戏容纳方块高度数量

   BLOCK_ROTATION_ANGLE = { -- 方块旋转角度
        ZERO = 0, 
        NINETY = 90,
        FLIP = 180,
        MINUS_NINETY=270,
    },


    BLOCK_SIZE = { -- 方块尺寸
        WIDTH = 20,
        HEIGHT = 63,
    },

    BLOCK_COLOUR = { -- 方块颜色
        GREEN = 1,   --绿色
        PINK = 2,    --粉红色
        ORANGE = 3,  --橘色
        YELLOW = 4,  --黄色
        RED = 5,     --红色
        BLUE = 6,    --蓝色
        CYAN = 7,    --青色
    },

    ROTATION_DIRECTION = {
        LEFT = 1,  --向左旋转
        RIGHT = 2  --向右旋转
    },
    
    GAME_STATE = {  
        INIT = 1,   -- 初始状态
        PLAY = 2,   -- 游戏状态
        PAUSE = 3,  -- 暂停状态
        RESULT= 4,  -- 结算状态
    },
}

return ConstDef