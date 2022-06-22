--[[
    方块常量定义
]]

local ConstDef = {

    DIAMOND_GROUP_STATE_SIZE = {
        EAST = 1,
        SOUTH = 2,
        WEST = 3,
        NORTH  = 4,
    },

    DIAMOND_SHOW_SIZE = {
        HEGHT = 2000,
        WIDTH = 1000,
    },

    DIAMOND_CONTROL_SIZE = {
        HEGHT = 500,
        WIDTH = 1000,
    },

    DIAMOND_COLOR_SIZE = {
        RED = "texture/t_5.png",
        YELLOW = "texture/t_4.png",
        ORANGE = "texture/t_3.png",
        CYAN = "texture/t_7.png",
        BLUE = "texture/t_6.png",
        GREEN = "texture/t_1.png",
        PURPLE = "texture/t_2.png",
    },

    DIAMOND_SIZE = {
        HEIGHT = 100,
        WIDTH = 100,
    },

    DIAMOND_GROUP_SIZE = {
        ZHITIAO = "DiamondGroupZhiTiao",
        SIFANGXING = "DiamondGroupSiFangXing",
        TIXING = "DiamondGroupTiXing",
        ZUOSANJIAO = "DiamondGroupZuoSanJiao",
        YOUSANJIAO = "DiamondGroupYouSanJiao",
        ZUOSIJIAO = "DiamondGroupZuoSiJiao",
        YOUSIJIAO = "DiamondGroupYouSiJiao",
    },
    DIAMOND_GROUP_MOVE_SIZE = {
        RIGGT = 1,
        LEFT = 2,
        UP = 3,
        DOWN = 4,
        CLOCKWISE = 5,
        ANTCLOCKWISE = 6,
    },
}

return ConstDef