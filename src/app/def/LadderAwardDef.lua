--[[
    LadderAwardDef.lua
    天梯奖励定义
    描述：天梯奖励定义
    编写：周星宇
    修订：李昊
    检查：张昊煜
]]

local ImageMap = {

    -- 宝箱
    LEGEND_BOX = "image/lobby/index/ladder/legend_box.png",
    EPIC_BOX = "image/lobby/index/ladder/epic_box.png",
    RARE_BOX = "image/lobby/index/ladder/rare_box.png",
    NORMAL_BOX = "image/lobby/index/ladder/normal_box.png",

    -- 资源
    GOLD = "image/lobby/index/ladder/gold_icon.png",
    DIAMOND = "image/lobby/index/ladder/diamond_icon.png",

    -- 卡牌
    CARD_1 = "image/lobby/index/ladder/tower/1.png",
    CARD_2 = "image/lobby/index/ladder/tower/2.png",
    CARD_3 = "image/lobby/index/ladder/tower/3.png",
    CARD_4 = "image/lobby/index/ladder/tower/4.png",
}

local LadderAwardDef = {
    -- NUM 10
    {
        TYPE = 1, -- 宝箱
        ICON = ImageMap.NORMAL_BOX
    },
    {
        TYPE = 2, -- 代币
        ICON = ImageMap.GOLD,
        TEXT = 500
    },
    {
        TYPE = 1, -- 宝箱
        ICON = ImageMap.RARE_BOX
    },
    {
        TYPE = 2, -- 代币
        ICON = ImageMap.DIAMOND,
        TEXT = 10
    },
    {
        TYPE = 1, -- 宝箱
        ICON = ImageMap.EPIC_BOX
    },
    {
        TYPE = 3, -- 卡牌
        ICON = ImageMap.CARD_1
    },
    {
        TYPE = 2, -- 代币
        ICON = ImageMap.GOLD,
        TEXT = 1000
    },
    {
        TYPE = 2, -- 代币
        ICON = ImageMap.DIAMOND,
        TEXT = 20
    },
    {
        TYPE = 1, -- 宝箱
        ICON = ImageMap.LEGEND_BOX
    },
    {
        TYPE = 3, -- 卡牌
        ICON = ImageMap.CARD_2
    },
}

return LadderAwardDef