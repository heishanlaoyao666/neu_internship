--[[--
    ConstDef.lua
    常量定义
]]
local ConstDef = {

    GAME_TAG = {
        UP = 1,
        DOWN = 2,
    },
    TOWER_POS = {
        UP_X = 155,
        DOWN_X = 160,
        UP_Y = 1095,
        DOWN_Y = 510,
        MOVE_X = 100,
        MOVE_Y = -110,
    },
    MONSTER_SIZE = {
        WIDTH = 43,
        HEIGHT = 44,
    },
    MONSTERPLUS_SIZE = {
        WIDTH = 72,
        HEIGHT = 74,
    },
    GAME_TYPE = {
        BOSS_1 = 1, --boss1
        BOSS_2 = 2, --boss2
        BOSS_3 = 3, --boss3
        BOSS_4 = 4, --boss4

        NULL = 288, --空对手
        NET = 999, --联网
    },
    Tower_ATK_MODE ={
        FRONT = 1, --前方
        MAXLIFE = 2,--最大生命
        RANDOM = 3, --随机敌人
    },
    GAME_STATE = {  
        INIT = 1,   -- 初始状态
        PLAY = 2,   -- 游戏状态
        PAUSE = 3,  -- 暂停状态
        RESULT= 4,  -- 结算状态
    },
    GAME_VIEW = {
        OPPOSITEBOSS = 1, --对方boss信息界面
        OPPOSITETOWER = 2, --对方塔信息界面
        RANDOMBOSS = 3, --随机BOSS信息界面
        RESULT = 4, --结算界面
        SURRENDER = 5, --投降界面
    },
    SURRENDER ="是否认输,放弃该场战斗?",

    BULLET_SIZE = { -- 子弹尺寸
        WIDTH = 10,
        HEIGHT = 10,
    },
}
ConstDef.BOSS ={
    [ConstDef.GAME_TYPE.BOSS_1] ={
        ID = 1, --ID
        NAME = "嬉戏者", --名字
        SKILL = "将所有我方防御塔种类随机变化", --描述
    },
    [ConstDef.GAME_TYPE.BOSS_2] ={
        ID = 2, --ID
        NAME = "静谧者", --名字
        SKILL = "每隔7秒沉默两个防御塔，使其不能攻击", --描述
    },
    [ConstDef.GAME_TYPE.BOSS_3] ={
        ID = 3, --ID
        NAME = "癫狂者", --名字
        SKILL = "出场时使所有防御塔降低一星（一星防御塔直接被摧毁），行进过程中每隔一段时间会向前方高速移动一次", --描述
    },
    [ConstDef.GAME_TYPE.BOSS_4] ={
        ID = 4, --ID
        NAME = "狂战者", --名字
        SKILL = "不受控制效果影响，在血量为75%、50%、25%时会召唤普通怪物三个，召唤期间无敌", --描述
    },
}
ConstDef.TARGET ={
    [ConstDef.GAME_TAG.UP] = {
        MAXID = 3,
        [1] ={
            MOVEX = 0,
            MOVEY = -1,
            X = 100,
            Y = 400,
        },
        [2] ={
            MOVEX = -1,
            MOVEY = 0,
            X = 600,
            Y = 400,
        },
        [3] ={
            MOVEX = 0,
            MOVEY = 1,
            X = 100,
            Y = 100,
        },
    },
    [ConstDef.GAME_TAG.DOWN] ={
        MAXID = 3,
        [0] ={
            MOVEX = 1,
            MOVEY = 1,
            X = 70,
            Y = 140,
        },
        [1] ={
            MOVEX = 0,
            MOVEY = 1,
            X = 60,
            Y = 600,
        },
        [2] ={
            MOVEX = 1,
            MOVEY = 0,
            X = 650,
            Y = 600,
        },
        [3] ={
            MOVEX = 0,
            MOVEY = -1,
            X = 650,
            Y = 140,
        },
    },
}
ConstDef.DAMAGE= {
    NORMAL = 1,--正常伤害，计算攻击者和受伤者的buff
    BUFF = 2, --BUFF伤害，不进行二次计算，直接执行最终伤害(待定)
}
ConstDef.UPGRADE ={
    [1] =100,
    [2] =200,
    [3] =400,
    [4] =700, 
}
return ConstDef