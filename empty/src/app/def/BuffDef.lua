--[[--
    BuffDef.lua
    BUFF常量定义
]]
local BuffDef = {
    
    TAG ={
        BURN = 1, --燃烧
        POISON =2, --中毒
        FRAGILE = 3,--脆弱
        CONFUSION = 4, --混乱
        SPEED = 5, --速度改变

    },
    SKILL ={
        EXTRA_DAMAGE= 1,--额外伤害
        FRIST_TRANS =2, --初次变身
        ATTACK_SPEED_BONUS =3, --攻速加成
        ATTACK_POWER_BONUS = 4, --攻击力加成
        ENEMY_SPEED =5, --敌方怪物加速效果
        INCREASE_DAMAGE= 6,--增伤效果
        SKILL_DECELERATE = 7,--技能减速
        SKILL_CONTINUED = 8,--技能持续时间
        SKILL_START = 9, --技能发动

    },
}
return BuffDef