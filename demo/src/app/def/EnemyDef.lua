--[[
    EnemyDef.lua
    enemy常量定义
    描述：enemy常量定义
    编写：李昊
    修订：周星宇
    检查：张昊煜
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

    --敌人身上的buff
    BUFF_SIZE = {
        "image/fight/fight/buff/firing.png",
        "image/fight/fight/buff/poisoning.png",
    },

    --子弹颜色
    BULLET_SIZE = {
        "image/fight/fight/bullet/1.png",
        "image/fight/fight/bullet/2.png",
        "image/fight/fight/bullet/3.png",
        "image/fight/fight/bullet/4.png",
        "image/fight/fight/bullet/5.png",
        "image/fight/fight/bullet/6.png",
        "image/fight/fight/bullet/7.png",
        "image/fight/fight/bullet/8.png",
        "image/fight/fight/bullet/9.png",
        "image/fight/fight/bullet/10.png",
        "image/fight/fight/bullet/11.png",
        "image/fight/fight/bullet/12.png",
        "image/fight/fight/bullet/13.png",
        "image/fight/fight/bullet/14.png",
        "image/fight/fight/bullet/15.png",
        "image/fight/fight/bullet/16.png",
        "image/fight/fight/bullet/17.png",
        "image/fight/fight/bullet/18.png",
        "image/fight/fight/bullet/19.png",
        "image/fight/fight/bullet/20.png",
    },
}

return EnemyDef