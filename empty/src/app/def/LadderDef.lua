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
    LEGEND_CARD1 = "ui/hall/battle/rank/highLadderLegendCard/group 914.png",
    LEGEND_CARD2 = "ui/hall/battle/rank/group92.png",

}
local LadderDef = {
    --[[
        BG_TYPE = {
            LOCKED = "ui/hall/battle/rank/lockedBorder.png",--未解锁
            UNLOCKED_NOT_RECEIVE = "ui/hall/battle/rank/availableButNotReceive.png",--已解锁未领取
            RECEIVE = "ui/hall/battle/rank/Available.png",--已解锁已领取
        },
        ICON_TYPE = {
            LOCKED = "ui/hall/battle/rank/locked.png",--未解锁
            UNLOCKED_NOT_RECEIVE = "null",--已解锁未领取
            RECEIVE = "ui/hall/battle/rank/group 130.png",--已解锁已领取
        },
        TYPE = {
            RARE = "ui/hall/shop/Diamond-shop/TreasureChest - RARE.png",--稀有宝箱
            GOLD_COIN = "ui/hall/battle/rank/coin.png",--金币
            NORMAL1 = "ui/hall/shop/Diamond-shop/TreasureChest - normal.png",--普通宝箱
            EPIC1 = "ui/hall/shop/Diamond-shop/TreasureChest - Epic.png",--史诗宝箱
            EPIC2 = "ui/hall/shop/Diamond-shop/TreasureChest - Epic.png",--史诗宝箱
            EPIC3 = "ui/hall/shop/Diamond-shop/TreasureChest - Epic.png",--史诗宝箱
            EPIC4 = "ui/hall/shop/Diamond-shop/TreasureChest - Epic.png",--史诗宝箱
            EPIC5 = "ui/hall/shop/Diamond-shop/TreasureChest - Epic.png",--史诗宝箱
            EPIC6 = "ui/hall/shop/Diamond-shop/TreasureChest - Epic.png",--史诗宝箱
            EPIC7 = "ui/hall/shop/Diamond-shop/TreasureChest - Epic.png",--史诗宝箱
            EPIC8 = "ui/hall/shop/Diamond-shop/TreasureChest - Epic.png",--史诗宝箱
            EPIC9 = "ui/hall/shop/Diamond-shop/TreasureChest - Epic.png",--史诗宝箱
            LEGEND_CARD = "ui/hall/battle/rank/highLadderLegendCard/group 914.png",--传奇卡
            RARE1 = "ui/hall/shop/Diamond-shop/TreasureChest - RARE.png",--稀有宝箱
            DIAMOND1 = "ui/hall/battle/rank/diamond.png",--钻石
            GOLD_COIN1 = "ui/hall/battle/rank/coin.png",--金币
            RARE2 = "ui/hall/shop/Diamond-shop/TreasureChest - RARE.png",--稀有宝箱
            DIAMOND2 = "ui/hall/battle/rank/diamond.png",--钻石
            GOLD_COIN2 = "ui/hall/battle/rank/coin.png",--金币
            RARE3 = "ui/hall/shop/Diamond-shop/TreasureChest - RARE.png",--稀有宝箱
            DIAMOND3 = "ui/hall/battle/rank/diamond.png",--钻石
            GOLD_COIN3 = "ui/hall/battle/rank/coin.png",--金币
            LEGEND_CARD = "ui/hall/battle/rank/group92.png"--传奇卡
        }
        --]]
    {
        TYPE = 1, -- 宝箱
        ICON = Path.NORMAL,
        TEXT = 285
    },
    {
        TYPE = 2, -- 代币
        ICON = Path.GOLD_COIN,
        TEXT = 500
    },
    {
        TYPE = 1, -- 宝箱
        ICON = Path.RARE,
        TEXT = 456
    },
    --九个史诗宝箱
    {
        TYPE = 1, -- 宝箱
        ICON = Path.EPIC,
        TEXT = 1280
    },
    {
        TYPE = 1, -- 宝箱
        ICON = Path.EPIC,
        TEXT = 1280
    },
    {
        TYPE = 1, -- 宝箱
        ICON = Path.EPIC,
        TEXT = 1280
    },
    {
        TYPE = 1, -- 宝箱
        ICON = Path.EPIC,
        TEXT = 1280
    },
    {
        TYPE = 1, -- 宝箱
        ICON = Path.EPIC,
        TEXT = 1280
    },
    {
        TYPE = 1, -- 宝箱
        ICON = Path.EPIC,
        TEXT = 1280
    },
    {
        TYPE = 1, -- 宝箱
        ICON = Path.EPIC,
    },
    {
        TYPE = 1, -- 宝箱
        ICON = Path.EPIC,
        TEXT = 1280
    },
    {
        TYPE = 1, -- 宝箱
        ICON = Path.EPIC,
        TEXT = 1280
    },
    --一张传奇卡
    {
        TYPE = 3, -- 卡牌
        ICON = Path. LEGEND_CARD1,
    },
    --稀有宝箱，钻石，金币轮换出现三次
    {
        TYPE = 1, -- 宝箱
        ICON = Path.RARE,
        TEXT = 456
    },
    {
        TYPE = 2, -- 代币
        ICON = Path.DIAMOND,
        TEXT = 100
    },
    {
        TYPE = 2, -- 代币
        ICON = Path.GOLD_COIN,
        TEXT = 1000
    },
    {
        TYPE = 1, -- 宝箱
        ICON = Path.RARE,
        TEXT = 456
    },
    {
        TYPE = 2, -- 代币
        ICON = Path.DIAMOND,
        TEXT = 100
    },
    {
        TYPE = 2, -- 代币
        ICON = Path.GOLD_COIN,
        TEXT = 1000
    },
    {
        TYPE = 1, -- 宝箱
        ICON = Path.RARE,
        TEXT = 456
    },
    {
        TYPE = 2, -- 代币
        ICON = Path.DIAMOND,
        TEXT = 100
    },
    {
        TYPE = 2, -- 代币
        ICON = Path.GOLD_COIN,
        TEXT = 1000
    },
    --一张传奇卡
    {
        TYPE = 3, -- 卡牌
        ICON = Path. LEGEND_CARD2,
    },
}





return LadderDef