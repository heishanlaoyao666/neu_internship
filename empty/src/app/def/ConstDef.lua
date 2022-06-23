--[[--
    ConstDef.lua
    常量定义
]]
local ConstDef = {
    
    GAME_TYPE = {
        BOSS1 = 1, --boss1
        BOSS2 = 2, --boss2
        BOSS3 = 3, --boss3
        BOSS4 = 4, --boss4

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
    }
}

return ConstDef