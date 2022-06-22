--[[--
    ConstDef.lua
    常量定义
]]
local ConstDef = {
    
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
}

return ConstDef