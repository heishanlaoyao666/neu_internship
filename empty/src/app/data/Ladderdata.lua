--[[--
    Ladderdata.lua
    天梯数据文件
]]
local Ladderdata = {}

--[[
    函数用途：初始化天梯
--]]
function Ladderdata:initItem(LadderData)
    for i = 1, 23 do
        Ladderdata.ITEM[i].STATE = LadderData[i]["STATE"]
        Ladderdata.ITEM[i].BOTTOM_STATE = LadderData[i]["BOTTOM_STATE"]
        Ladderdata.ITEM[i].BY = LadderData[i]["BY"]
    end
end

--图片路径
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

--背景框状态
local State = {
    --未达到
    NOT_ACHIEVE = "ui/hall/battle/rank/lockedBorder.png",
    --已达到未领取
    ACHIEVED = "ui/hall/battle/rank/availableButNotReceive.png",
    --已领取
    RECEIVE = "ui/hall/battle/rank/Available.png"
}

--下方图标状态
local bottomState= {
    --未达到
    NOT_ACHIEVE = "ui/hall/battle/rank/locked.png",
    --已达到未领取
    ACHIEVED = "null",
    --已领取
    RECEIVE = "ui/hall/battle/rank/group 130.png"
}

Ladderdata.ITEM = {
    {
        TYPE = 1,--1：宝箱，2：金币，3：钻石，4：卡牌1，5：卡牌2
        ICON = Path.NORMAL,--图片路径
        TEXT = 285,--货币数量
        STATE = State.NOT_ACHIEVE,--背景框状态
        BOTTOM_STATE = bottomState.NOT_ACHIEVE,--下方图标状态
        BY = false--进度条状态
    },
    {
        TYPE = 2,
        ICON = Path.GOLD_COIN,
        TEXT = 500,
        STATE = State.NOT_ACHIEVE,
        BOTTOM_STATE = bottomState.NOT_ACHIEVE,
        BY = false
    },
    {
        TYPE = 1,
        ICON = Path.RARE,
        TEXT = 456,
        STATE = State.NOT_ACHIEVE,
        BOTTOM_STATE = bottomState.NOT_ACHIEVE,
        BY = false
    },
    --九个史诗宝箱
    {
        TYPE = 1,
        ICON = Path.EPIC,
        TEXT = 1280,
        STATE = State.NOT_ACHIEVE,
        BOTTOM_STATE = bottomState.NOT_ACHIEVE,
        BY = false
    },
    {
        TYPE = 1,
        ICON = Path.EPIC,
        TEXT = 1280,
        STATE = State.NOT_ACHIEVE,
        BOTTOM_STATE = bottomState.NOT_ACHIEVE,
        BY = false
    },
    {
        TYPE = 1,
        ICON = Path.EPIC,
        TEXT = 1280,
        STATE = State.NOT_ACHIEVE,
        BOTTOM_STATE = bottomState.NOT_ACHIEVE,
        BY = false
    },
    {
        TYPE = 1,
        ICON = Path.EPIC,
        TEXT = 1280,
        STATE = State.NOT_ACHIEVE,
        BOTTOM_STATE = bottomState.NOT_ACHIEVE,
        BY = false
    },
    {
        TYPE = 1,
        ICON = Path.EPIC,
        TEXT = 1280,
        STATE = State.NOT_ACHIEVE,
        BOTTOM_STATE = bottomState.NOT_ACHIEVE,
        BY = false
    },
    {
        TYPE = 1,
        ICON = Path.EPIC,
        TEXT = 1280,
        STATE = State.NOT_ACHIEVE,
        BOTTOM_STATE = bottomState.NOT_ACHIEVE,
        BY = false
    },
    {
        TYPE = 1,
        ICON = Path.EPIC,
        TEXT = 1280,
        STATE = State.NOT_ACHIEVE,
        BOTTOM_STATE = bottomState.NOT_ACHIEVE,
        BY = false
    },
    {
        TYPE = 1,
        ICON = Path.EPIC,
        TEXT = 1280,
        STATE = State.NOT_ACHIEVE,
        BOTTOM_STATE = bottomState.NOT_ACHIEVE,
        BY = false
    },
    {
        TYPE = 1,
        ICON = Path.EPIC,
        TEXT = 1280,
        STATE = State.NOT_ACHIEVE,
        BOTTOM_STATE = bottomState.NOT_ACHIEVE,
        BY = false
    },
    --一张传奇卡
    {
        TYPE = 4,
        ICON = Path. LEGEND_CARD1,
        STATE = State.NOT_ACHIEVE,
        BOTTOM_STATE = bottomState.NOT_ACHIEVE,
        BY = false
    },
    --稀有宝箱，钻石，金币轮换出现三次
    {
        TYPE = 1,
        ICON = Path.RARE,
        TEXT = 456,
        STATE = State.NOT_ACHIEVE,
        BOTTOM_STATE = bottomState.NOT_ACHIEVE,
        BY = false
    },
    {
        TYPE = 3,
        ICON = Path.DIAMOND,
        TEXT = 100,
        STATE = State.NOT_ACHIEVE,
        BOTTOM_STATE = bottomState.NOT_ACHIEVE,
        BY = false
    },
    {
        TYPE = 2,
        ICON = Path.GOLD_COIN,
        TEXT = 1000,
        STATE = State.NOT_ACHIEVE,
        BOTTOM_STATE = bottomState.NOT_ACHIEVE,
        BY = false
    },
    {
        TYPE = 1,
        ICON = Path.RARE,
        TEXT = 456,
        STATE = State.NOT_ACHIEVE,
        BOTTOM_STATE = bottomState.NOT_ACHIEVE,
        BY = false
    },
    {
        TYPE = 3,
        ICON = Path.DIAMOND,
        TEXT = 100,
        STATE = State.NOT_ACHIEVE,
        BOTTOM_STATE = bottomState.NOT_ACHIEVE,
        BY = false
    },
    {
        TYPE = 2,
        ICON = Path.GOLD_COIN,
        TEXT = 1000,
        STATE = State.NOT_ACHIEVE,
        BOTTOM_STATE = bottomState.NOT_ACHIEVE,
        BY = false
    },
    {
        TYPE = 1,
        ICON = Path.RARE,
        TEXT = 456,
        STATE = State.NOT_ACHIEVE,
        BOTTOM_STATE = bottomState.NOT_ACHIEVE,
        BY = false
    },
    {
        TYPE = 3,
        ICON = Path.DIAMOND,
        TEXT = 100,
        STATE = State.NOT_ACHIEVE,
        BOTTOM_STATE = bottomState.NOT_ACHIEVE,
        BY = false
    },
    {
        TYPE = 2,
        ICON = Path.GOLD_COIN,
        TEXT = 1000,
        STATE = State.NOT_ACHIEVE,
        BOTTOM_STATE = bottomState.NOT_ACHIEVE,
        BY = false
    },
    --一张传奇卡
    {
        TYPE = 5,
        ICON = Path. LEGEND_CARD2,
        STATE = State.NOT_ACHIEVE,
        BOTTOM_STATE = bottomState.NOT_ACHIEVE,
        BY = false
    },
}





return Ladderdata