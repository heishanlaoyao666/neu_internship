--[[--
    EnemyDef.lua
    enemy常量定义
]]

local EnemyDef = {

--初始血量 
    HP = 100,

--初始杀死一只怪物获得的sp,每出一次boss增加此值
    SP = 10,

--怪物在一波中出生的时间间隔
    FREQUENCY_TIME = 1000,

--怪物走完全程需要的时间 18s
    TIME = 18000,--18*1000 = 18000ms

--怪物经过的关键点
    COM_ENEMY_ACTION_UP = {
        {x = 65,y = 1220},
        {x = 65,y = 790},
        {x = 655,y = 790},
        {x = 655,y = 1220},
    },

    COM_ENEMY_ACTION_DOWN = {
        {x = 65,y = 140},
        {x = 65,y = 610},
        {x = 655,y = 610},
        {x = 655,y = 140},
    },

--怪物血量的公差
    HP_RISE = {
        100,
        700,
    },--第一次为100，第二次为700，后面的


}

return EnemyDef