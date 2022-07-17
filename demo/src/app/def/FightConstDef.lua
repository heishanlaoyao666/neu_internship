--[[
    FightConstDef.lua
    游戏内常量定义
    描述：游戏内常量定义
    编写：李昊
]]

local FightConstDef = {
    ENEMY_SIZE = {

        CARD_SIZE_X = 60,--card卡组展示尺寸
        CARD_SIZE_Y = 60,
        CARD_SIZE_INTERVAL = 15,
        CARD_POSITION_Y = 20,--card距离顶端距离

        CARD_LEVEL_SIZE_X = 36,--card等级展示尺寸
        CARD_LEVEL_SIZE_Y = 20,
        CARD_LEVEL_POSITION_Y = 85,--card的level距离顶端距离

        CARD_TYPE_SIZE_X = 17,--card种类展示尺寸
        CARD_TYPE_SIZE_Y = 21,
        CARD_TYPE_POSITION_Y = 20,--card的角标距离顶端距离

        LIFR_SIZE_X = 41,--敌人血量的尺寸
        LIFR_SIZE_Y = 40,
        LIFR_SIZE_INTERVAL = 10,--敌人血量的间隔
        LIFR_POSITION_X = display.cx,--敌人血量的位置
        LIFR_POSITION_Y = display.cy,

        INTEGRAL_SIZE_X = 60,--敌人段位的大小
        INTEGRAL_SIZE_Y = 49,
        INTEGRAL_POSITION_X = 170,--敌人段位的位置
        INTEGRAL_POSITION_Y = 1230,

        NAME_POSITION_X = 170,--敌人名字
        NAME_POSITION_Y = 1200,
        NAME_SIZE = 21,--字号

    },
    ME_SIZE = {

        CARD_SIZE_X = 90,--card卡组展示尺寸
        CARD_SIZE_Y = 90,
        CARD_SIZE_INTERVAL = 15,
        CARD_POSITION_Y = 150,--card距离底部距离

        CARD_LEVEL_SIZE_X = 54,--card等级展示尺寸
        CARD_LEVEL_SIZE_Y = 30,
        CARD_LEVEL_POSITION_Y = 60,--card的level距离顶端距离

        CARD_TYPE_SIZE_X = 25.5,--card种类展示尺寸
        CARD_TYPE_SIZE_Y = 31.5,
        CARD_TYPE_POSITION_Y = 150,--card的角标距离底端距离

        CARD_SP_SIZE_X = 80.6, -- sp图片设计大小
        CARD_SP_SIZE_Y = 26,
        CARD_SP_POSITION_Y =  75, --sp图片距离底端距离

        CARD_SP_NUM_POSITION_Y = 75,--sp图片的文字距离地段距离
        CARD_SP_NUM_SIZE = 20,--字号

        LIFR_SIZE_X = 41,--玩家血量的尺寸
        LIFR_SIZE_Y = 40,
        LIFR_SIZE_INTERVAL = 10,--玩家血量的间隔
        LIFR_POSITION_X = display.cx,--玩家血量的位置
        LIFR_POSITION_Y = display.cy,

        INTEGRAL_SIZE_X = 60,--玩家段位的大小
        INTEGRAL_SIZE_Y = 46,
        INTEGRAL_POSITION_X = 540,--玩家段位的位置
        INTEGRAL_POSITION_Y = 200,

        NAME_POSITION_X = 540, --名字的位置
        NAME_POSITION_Y = 165,
        NAME_SIZE = 21,--字号
    },
    WIFI_SIZE = {
        --图标
       SIZE_X = 38,--图标大小
       SIZE_Y = 29,
       POSITION_X  = 320,--距游戏界面中心点距离 左
       POSITION_Y  = 70,--距游戏界面中心点距离 上
        --文本
       NUM_POSITION_X = 320,--距游戏界面中心点距离 左
       NUM_POSITION_Y  = 50,--距游戏界面中心点距离 上
       NUM_SIZE = 21,--字号
    },
    LIFE_SIZE = {
        SIZE_X = 41,--血量设计大小
        SIZE_Y = 40, 

        SIZE_INTERVAL = 10,--血的间隔 

        ENEMY_POSITION_X = 320, --敌方血量位置距游戏界面中心点距离 左
        ENEMY_POSITION_Y = 105, --距游戏界面中心点距离 上

        ME_POSITION_X = 220, --我方血量位置距游戏界面中心点距离 右
        ME_POSITION_Y = 25, --距游戏界面中心点距离 上
    },
    OTHER_SIZE = {
        GIVEIN_SIZE_X = 157,--投降的设计大小
        GIVEIN_SIZE_Y = 102,

        GIVEIN_POSITION_X = 250,--投降的位置距游戏界面中心点距离 右
        GIVEIN_POSITION_Y = 85, --距游戏界面中心点距离 上

        BOSS_SIZE_X = 54, --boss图标的设计大小
        BOSS_SIZE_Y = 59,
        
        BOSS_POSITION_X = 130 ,--BOSS的位置距游戏界面中心点距离左
        BOSS_POSITION_Y = 80 ,--距游戏界面中心点距离 上

        BOSS_SIZE = {
            "image/fight/fight/bossbutton/boss_1.png",
            "image/fight/fight/bossbutton/boss_2.png",
            "image/fight/fight/bossbutton/boss_3.png",
            "image/fight/fight/bossbutton/boss_4.png",
        },

        TIME_POSITION_X = 0 ,--时间的位置距游戏界面中心点距离左
        TIME_POSITION_Y = 80 ,--距游戏界面中心点距离 上
        TIME_SIZE =  28, --字号大小
    },
    SP_SIZE = {
        CREATE_SIZE_X  =  160, --生成按钮大小
        CREATE_SIZE_Y  =  105, 
        CREATE_POSITION_X = 0,--距游戏界面中心点距离 左
        CREATE_POSITION_Y = 435,--距游戏界面中心点距离 下

        CREATE_NUM_POSITION_X = 0,--生成sp下面的文字距游戏界面中心点距离 左
        CREATE_NUM_POSITION_Y = 472,--距游戏界面中心点距离 下
        CREATE_NUM_SIZE = 25,--字号

        SIZE_X = 124,--s随时间增长的sp的图片大小
        SIZE_Y = 40,
        SIZE_POSITION_X = 165,--距游戏界面中心点距离 左
        SIZE_POSITION_Y = 435,--距游戏界面中心点距离 下

         
        NUM_POSITION_Y =  435,--sp随时间增长的文字的位置
        NUM_SIZE = 25,--字号
    }
}

FightConstDef.OTHER_IMAGE = {
    STAR_LEVEL = {
        "image/fight/fight/cornerlevel/1.png",
        "image/fight/fight/cornerlevel/2.png",
        "image/fight/fight/cornerlevel/3.png",
        "image/fight/fight/cornerlevel/4.png",
        "image/fight/fight/cornerlevel/5.png",
        "image/fight/fight/cornerlevel/6.png",
        "image/fight/fight/cornerlevel/7.png",
    }
}


return FightConstDef