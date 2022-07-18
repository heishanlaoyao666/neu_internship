----内容：商店定义
----编写人员：郑蕾
---修订人员：郑蕾
---最后修改日期：7/17

local ShopDef = {
    GOLD_STORE_TITLE = {--金币商店标题区域
        BG = "ui/hall/shop/Goldcoin-shop/bg-title_block.png",
        TEXT = "ui/hall/shop/Goldcoin-shop/Title - gold_coin_store.png",
        REFRESH_BG = "ui/hall/shop/Goldcoin-shop/bg-remaining_refresh_time.png",
        REFRESH_TEXT = "ui/hall/shop/Goldcoin-shop/Prompt-refresh_time_remaining.png"
    },
    DIAMOND_STORE_TITLE = {--钻石商店标题区域
        BG = "ui/hall/shop/Diamond-shop/bg-title.png",
        TEXT = "ui/hall/shop/Diamond-shop/Title-diamond_store.png"
    },
    FREE_ITEM = {--免费商品
        BG = "ui/hall/shop/Goldcoin-shop/bg-free_items.png",
        ICON = "ui/hall/shop/Goldcoin-shop/ItemIcon-Diamond.png",
        TITLE = "ui/hall/shop/Goldcoin-shop/PriceIcon-free.png"
    },
    GOLD_ITEM = {--金币商品
        FRAGMENT_BG = "ui/hall/shop/Goldcoin-shop/bg-fragment_number.png",
        GOLD_COIN_ICON = "ui/hall/shop/Goldcoin-shop/PriceIcon-gold_coins.png"
    },
    NORMAL_TREASURE = {--普通宝箱
        BG= "ui/hall/shop/Diamond-shop/bg-normal.png",
        ICON = "ui/hall/shop/Diamond-shop/TreasureChest - normal.png",
        TITLE = "ui/hall/common/SecondaryInterface-Treasure chest opening confirmation pop-up window/Title - common treasure chest.png",
        PRICE = 150,
        N_CARD_NUM = 38,
        R_CARD_NUM = 7,
        E_CARD_NUM = 1,
        L_CARD_NUM = 0,
        COIN_NUM = 285
    },
    RARE_TREASURE = {--稀有宝箱
        BG = "ui/hall/shop/Diamond-shop/bg-rare.png",
        ICON = "ui/hall/shop/Diamond-shop/TreasureChest - RARE.png",
        TITLE = "ui/hall/common/SecondaryInterface-Treasure chest opening confirmation pop-up window/Title - rare treasure chest.png",
        PRICE = 250,
        N_CARD_NUM = 74,
        R_CARD_NUM = 14,
        E_CARD_NUM = 2,
        L_CARD_NUM = 0,
        COIN_NUM = 456
    },
    EPIC_TREASURE = {--史诗宝箱
        BG = "ui/hall/shop/Diamond-shop/bg-epic.png",
        ICON = "ui/hall/shop/Diamond-shop/TreasureChest - Epic.png",
        TITLE = "ui/hall/common/SecondaryInterface-Treasure chest opening confirmation pop-up window/Title - Epic chest.png",
        PRICE = 750,
        N_CARD_NUM = 139,
        R_CARD_NUM = 36,
        E_CARD_NUM = 7,
        L_CARD_NUM = "0~1",
        COIN_NUM = 1280
    },
    LEGEND_TREASURE = {--传说宝箱
        BG = "ui/hall/shop/Diamond-shop/bg-legend.png",
        ICON = "ui/hall/shop/Diamond-shop/TreasureChest - Legend.png",
        TITLE = "ui/hall/common/SecondaryInterface-Treasure chest opening confirmation pop-up window/Title - legendary treasure chest.png",
        PRICE = 2500,
        N_CARD_NUM = 187,
        R_CARD_NUM = 51,
        E_CARD_NUM = 21,
        L_CARD_NUM = 1,
        COIN_NUM = 3040
    },
    OPEN_VIEW = {--二级界面打开宝箱可能获得内容弹窗
        BG = "ui/hall/common/SecondaryInterface-Treasure chest opening confirmation pop-up window/bg-pop-up.png",
        COIN_BG = "ui/hall/common/SecondaryInterface-Treasure chest opening confirmation pop-up window/bg-gold coin.png",
        OPEN_BUTTON = "ui/hall/common/SecondaryInterface-Treasure chest opening confirmation pop-up window/Button - on.png",
        CLOSE_BUTTON = "ui/hall/common/SecondaryInterface-Treasure chest opening confirmation pop-up window/Button - off.png",
        COIN_ICON = "ui/hall/common/SecondaryInterface-Treasure chest opening confirmation pop-up window/Icon - gold coin.png",
        N_ICON = "ui/hall/common/SecondaryInterface-Treasure chest opening confirmation pop-up window/Icon - normal.png",
        R_ICON = "ui/hall/common/SecondaryInterface-Treasure chest opening confirmation pop-up window/Icon - RARE.png",
        E_ICON = "ui/hall/common/SecondaryInterface-Treasure chest opening confirmation pop-up window/Icon - Epic.png",
        L_ICON = "ui/hall/common/SecondaryInterface-Treasure chest opening confirmation pop-up window/Icon-legend.png",
        TEXT_BG = "ui/hall/common/SecondaryInterface-Treasure chest opening confirmation pop-up window/bg-text.png"
    },
    OBTAIN_VIEW = {--二级界面宝箱获得物品确认弹窗
        BG = "ui/hall/common/SecondaryInterface-Open the treasure chest to obtain the item pop-up window/bg-pop-up.png",
        COIN_ICON = "ui/hall/common/SecondaryInterface-Open the treasure chest to obtain the item pop-up window/Icon - gold coin.png",
        CONFIRM = "ui/hall/common/SecondaryInterface-Open the treasure chest to obtain the item pop-up window/Button - confirm.png"
    },
    ITEM = {--金币商店六个商品
        {
            TYPE = 1, --钻石
            FRAGMENT_NUM = 100, --数量
            PRICE = 0, --价格
            ID = nil,
            SOLD_OUT = false
        },
        {
            TYPE = 2, --普通卡
            FRAGMENT_NUM = 36,
            PRICE = 360,
            ID = 01,
            SOLD_OUT = false
        },
        {
            TYPE = 2, --普通卡
            FRAGMENT_NUM = 36,
            PRICE = 360,
            ID = 01,
            SOLD_OUT = false
        },
        {
            TYPE = 2, --普通卡
            FRAGMENT_NUM = 36,
            PRICE = 360,
            ID = 01,
            SOLD_OUT = false
        },
        {
            TYPE = 3, --稀有卡
            FRAGMENT_NUM = 6,
            PRICE = 600,
            ID = 01,
            SOLD_OUT = false
        },
        {
            TYPE = 4, --史诗卡
            FRAGMENT_NUM = 1,
            PRICE = 1000,
            ID = 01,
            SOLD_OUT = false
        }
    }
}

return ShopDef