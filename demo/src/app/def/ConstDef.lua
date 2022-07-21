--[[
    ConstDef.lua
    常量定义
    描述：常量定义
    编写：周星宇
    修订：李昊
    检查：张昊煜
]]
local ConstDef = {

    WINDOW_SIZE = { -- 窗口大小
        TOPBAR = { -- 顶部栏大小
            HEIGHT = 153,
            WIDTH = 720
        },
        DOWNBAR = { -- 底部栏大小
            HEIGHT = 140,
            WIDTH = 720
        },
        LADDER_VIEW = { -- 天梯奖励展示大小
            HEIGHT = 285,
            WIDTH = 676
        },
        TEAM_VIEW = { -- 队伍展示大小
            HEIGHT = 160,
            WIDTH = 720
        },
        MAIN = { -- 除顶部栏和底部栏的可视区域大小
            HEIGHT = 1020,
            WIDTH = 720
        },
        GOLD_STORE = { -- 金币商店区域大小
            HEIGHT = 600,
            WIDTH = 720
        },
        DIAMOND_STORE = { -- 钻石商店区域大小
            HEIGHT = 700,
            WIDTH = 720
        },
        TABLET = { -- 牌匾大小
            HEIGHT = 70,
            WIDTH = 720
        },
        AVATAR_VIEW = { -- 头像展示区大小
            HEIGHT = 634,
            WIDTH = 598
        },
        COLLECTION_VIEW = { -- 图鉴中已收集和未收集
            HEIGHT = 550,
            WIDTH = 720
        },
        CURRENT_TEAM_VIEW = { -- 当前阵容窗口大小
            HEIGHT = 288,
            WIDTH = 662
        }
    },

    CARD_SIZE = { -- 卡片大小
        TYPE_1 = { -- 小图标(头像与队伍展示)
            HEIGHT = 120,
            WIDTH = 120
        },
        TYPE_2 = { -- 中等图标(图鉴中已收集和未收集的展示)
            HEIGHT = 232,
            WIDTH = 159
        },
        TYPE_3 = { -- 中等图标(金币商店中卡牌大小)
            HEIGHT = 198,
            WIDTH = 156
        },
        TYPE_4 = { -- 中等图标(钻石商店小宝箱大小)
            HEIGHT = 282,
            WIDTH = 211
        },
        TYPE_5 = { -- 中等图标(钻石商店大宝箱大小)
            HEIGHT = 307,
            WIDTH = 234
        }
    },

    DIALOG_SIZE = { -- 弹窗大小
        TOWER_DETAIL = {
            ATTR = {
                WIDTH = 665,
                HEIGHT = 812
            }
        }
    },

    TAB_SIZE = {
        UNSELECTED = { -- 未选中Tab
            HEIGHT = 115,
            WIDTH = 230
        },
        SELECTED = { -- 已选中Tab
            HEIGHT = 139,
            WIDTH = 260
        }
    },

    VERSION = "1.0", -- 版本号

    LOBBY_VIEW_CODE = { -- 底部栏代码
        STORE = 1,
        INDEX = 2,
        PICTORIAL = 3
    },

    STORE_COST = { -- 商店物品价格
        GOLD = {
            GOLD = 1000,
            DIAMOND = 20,
            NORMAL = 360,
            RARE = 600,
            EPIC = 1000,
        },
        DIAMOND = {
            NORMAL = 150,
            RARE = 250,
            EPIC = 750,
            LEGEND = 2500
        }
    },

    FAIL_CODE = { -- 购买以及升级失败代码
        PURCHASE_GOLD_DEFICIENCY = 1,
        PURCHASE_DIAMOND_DEFICIENCY = 2,
        UPGRADE_GOLD_DEFICIENCY = 3,
        UPGRADE_CARD_DEFICIENCY = 4,
    },

    -- key
    SOUND_KEY = "sound_key", -- UserDefault中保存音效播放状态键
    MUSIC_KEY = "music_key", -- UserDefault中保存背景音乐播放状态键
}

return ConstDef