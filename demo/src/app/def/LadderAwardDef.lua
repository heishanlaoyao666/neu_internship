--[[
    LadderAwardDef.lua
    天梯奖励定义
    描述：天梯奖励定义
    编写：周星宇
    修订：李昊
    检查：张昊煜
]]

local CardInfoDef = require("app.def.CardInfoDef")

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
    CARD_1_IMG = "image/lobby/index/ladder/tower/1.png",
    CARD_2_IMG = "image/lobby/index/ladder/tower/2.png",
    CARD_3_IMG = "image/lobby/index/ladder/tower/3.png",
    CARD_4_IMG = "image/lobby/index/ladder/tower/4.png",

    -- ID
    CARD_1_ID = CardInfoDef.CARD_ID.CARD_6,
    CARD_2_ID = CardInfoDef.CARD_ID.CARD_13,
    CARD_3_ID = CardInfoDef.CARD_ID.CARD_5,
    CARD_4_ID = CardInfoDef.CARD_ID.CARD_19

}

local LadderAwardDef = {
    -- NUM 10
    {
        TYPE = 1, -- 宝箱
        ICON = ImageMap.NORMAL_BOX,
        RARITY = 1,

    },
    {
        TYPE = 2, -- 金币
        ICON = ImageMap.GOLD,
        NUM = 500
    },
    {
        TYPE = 1, -- 宝箱
        ICON = ImageMap.RARE_BOX,
        RARITY = 2,
    },
    {
        TYPE = 3, -- 钻石
        ICON = ImageMap.DIAMOND,
        NUM = 10
    },
    {
        TYPE = 1, -- 宝箱
        ICON = ImageMap.EPIC_BOX,
        RARITY = 3,
    },
    {
        TYPE = 4, -- 卡牌
        ICON = ImageMap.CARD_1_IMG,
        ID = ImageMap.CARD_1_ID,
        NUM = 1
    },
    {
        TYPE = 2, -- 金币
        ICON = ImageMap.GOLD,
        NUM = 1000
    },
    {
        TYPE = 3, -- 钻石
        ICON = ImageMap.DIAMOND,
        NUM = 20
    },
    {
        TYPE = 1, -- 宝箱
        ICON = ImageMap.LEGEND_BOX,
        RARITY = 4,
    },
    {
        TYPE = 4, -- 卡牌
        ICON = ImageMap.CARD_2_IMG,
        ID = ImageMap.CARD_2_ID,
        NUM = 1
    },
}

return LadderAwardDef