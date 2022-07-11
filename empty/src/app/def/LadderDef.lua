--[[--
    LadderDef.lua
    天梯数据文件
]]
local Path = {
    --宝箱1
    NORMAL = "ui/hall/shop/Diamond-shop/TreasureChest - normal.png",
    RARE = "ui/hall/shop/Diamond-shop/TreasureChest - RARE.png",
    EPIC = "ui/hall/shop/Diamond-shop/TreasureChest - Epic.png",

    --奖励2
    GOLD_COIN = "ui/hall/battle/rank/coin.png",
    DIAMOND = "ui/hall/battle/rank/diamond.png",

    --传奇卡3
    LEGEND_CARD1 = "ui/hall/battle/rank/highLadderLegendCard/19.png",
    LEGEND_CARD2 = "ui/hall/battle/rank/group92.png",

}
local LadderDef = {
--1：宝箱，2：金币，3：钻石，4：卡牌1，5：卡牌2
    {
        TYPE = 1,
        ICON = Path.NORMAL,
        TEXT = 285
    },
    {
        TYPE = 2,
        ICON = Path.GOLD_COIN,
        TEXT = 500
    },
    {
        TYPE = 1,
        ICON = Path.RARE,
        TEXT = 456
    },
    --九个史诗宝箱
    {
        TYPE = 1,
        ICON = Path.EPIC,
        TEXT = 1280
    },
    {
        TYPE = 1,
        ICON = Path.EPIC,
        TEXT = 1280
    },
    {
        TYPE = 1,
        ICON = Path.EPIC,
        TEXT = 1280
    },
    {
        TYPE = 1,
        ICON = Path.EPIC,
        TEXT = 1280
    },
    {
        TYPE = 1,
        ICON = Path.EPIC,
        TEXT = 1280
    },
    {
        TYPE = 1,
        ICON = Path.EPIC,
        TEXT = 1280
    },
    {
        TYPE = 1,
        ICON = Path.EPIC,
    },
    {
        TYPE = 1,
        ICON = Path.EPIC,
        TEXT = 1280
    },
    {
        TYPE = 1,
        ICON = Path.EPIC,
        TEXT = 1280
    },
    --一张传奇卡
    {
        TYPE = 4,
        ICON = Path. LEGEND_CARD1,
    },
    --稀有宝箱，钻石，金币轮换出现三次
    {
        TYPE = 1,
        ICON = Path.RARE,
        TEXT = 456
    },
    {
        TYPE = 3,
        ICON = Path.DIAMOND,
        TEXT = 100
    },
    {
        TYPE = 2,
        ICON = Path.GOLD_COIN,
        TEXT = 1000
    },
    {
        TYPE = 1,
        ICON = Path.RARE,
        TEXT = 456
    },
    {
        TYPE = 3,
        ICON = Path.DIAMOND,
        TEXT = 100
    },
    {
        TYPE = 2,
        ICON = Path.GOLD_COIN,
        TEXT = 1000
    },
    {
        TYPE = 1,
        ICON = Path.RARE,
        TEXT = 456
    },
    {
        TYPE = 3,
        ICON = Path.DIAMOND,
        TEXT = 100
    },
    {
        TYPE = 2,
        ICON = Path.GOLD_COIN,
        TEXT = 1000
    },
    --一张传奇卡
    {
        TYPE = 5,
        ICON = Path. LEGEND_CARD2,
    },
}





return LadderDef