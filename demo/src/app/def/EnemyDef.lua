--[[--
    EnemyDef.lua
    enemy常量定义
]]

local EnemyDef = {

--初始血量 
    HP = 100,

--初始杀死一只怪物获得的sp,每出一次boss增加此值
    SP = 10,

--怪物走完全程需要的时间
    TIME = 12,

--怪物经过的关键点
    COM_ENEMY_ACTION = {
        {x = 100,y = 100},
        {x = 100,y = 500},
        {x = 600,y = 500},
        {x = 600,y = 100},
    },

    --怪物血量的公差
    HP_RISE = {
        100,
        700,
    },--第一次为100，第二次为700，后面的


    --血量文字的字号
    HP_SIZE  = 23,
}

return EnemyDef