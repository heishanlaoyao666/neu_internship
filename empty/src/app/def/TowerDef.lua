--[[--
    TowerDef.lua
    塔数据文件
]]
local TowerDef = {
    
    RARITY = {
        NORMAL = 1,-- 普通
        RARE = 2, --稀有
        EPIC = 3, --史诗
        LEGEND = 4, --传说
    },
    TYPE = {
        ATTACK = 1,-- 攻击
        INTERFERE = 2, --干扰
        AUXILIARY = 3, --辅助
        CONTROL = 4, --控制
    },
    MODE = {
        FRIST = 1 ,--前方
        MAXLIFE =2 ,--最大生命
        RANDOM = 3, --随机
    }
}
TowerDef.SKILL ={
    [1] = {

    }
}
TowerDef.TABLE = {
    [1] ={
        RARITY = TowerDef.RARITY.NORMAL,
        TYPE = TowerDef.TYPE.ATTACK,
        NAME = "1",
        ATK = 20,
        FIRECD = 0.8,
        INFORMATION = "使被攻击目标得到“灼烧”状态。灼烧：造成两次额外伤害。",
        MODE = TowerDef.MODE.FRIST,
    },
    [2] ={
        RARITY = TowerDef.RARITY.EPIC,
        TYPE = TowerDef.TYPE.ATTACK,
        NAME = "2",
        ATK = 20,
        FIRECD = 0.8,
        INFORMATION = "使星级数个怪物受到伤害。",
        MODE = TowerDef.MODE.FRIST,
    },
    [3] ={
        RARITY = TowerDef.RARITY.RARE,
        TYPE = TowerDef.TYPE.ATTACK,
        NAME = "3",
        ATK = 40,
        FIRECD = 0.8,
        INFORMATION = "攻击五次后，造成额外伤害。",
        MODE = TowerDef.MODE.FRIST,
    },
    [4] ={
        RARITY = TowerDef.RARITY.NORMAL,
        TYPE = TowerDef.TYPE.ATTACK,
        NAME = "4",
        ATK = 100,
        FIRECD = 1,
        INFORMATION = "攻击生命值最高的怪物，对BOSS造成双倍伤害。",
        MODE = TowerDef.MODE.MAXLIFE,
    },
    [5] ={
        RARITY = TowerDef.RARITY.LEGEND,
        TYPE = TowerDef.TYPE.ATTACK,
        NAME = "5",
        ATK = 20,
        FIRECD = 0.6,
        INFORMATION = "使被攻击目标得到“灼烧”状态。灼烧：造成两次额外伤害。",
        MODE = TowerDef.MODE.FRIST,
    },
    [6] ={
        RARITY = TowerDef.RARITY.LEGEND,
        TYPE = TowerDef.TYPE.ATTACK,
        NAME = "6",
        ATK = 35,
        FIRECD = 1.2,
        INFORMATION = "使被攻击目标得到“灼烧”状态。灼烧：造成两次额外伤害。",
        MODE = TowerDef.MODE.FRIST,
    },
    [7] ={
        RARITY = TowerDef.RARITY.NORMAL,
        TYPE = TowerDef.TYPE.ATTACK,
        NAME = "1",
        ATK = 20,
        FIRECD = 0.8,
        INFORMATION = "使被攻击目标得到“灼烧”状态。灼烧：造成两次额外伤害。",
        MODE = TowerDef.MODE.FRIST,
    },
    [8] ={
        RARITY = TowerDef.RARITY.NORMAL,
        TYPE = TowerDef.TYPE.ATTACK,
        NAME = "1",
        ATK = 20,
        FIRECD = 0.8,
        INFORMATION = "使被攻击目标得到“灼烧”状态。灼烧：造成两次额外伤害。",
        MODE = TowerDef.MODE.FRIST,
    },
    [9] ={
        RARITY = TowerDef.RARITY.NORMAL,
        TYPE = TowerDef.TYPE.ATTACK,
        NAME = "1",
        ATK = 20,
        FIRECD = 0.8,
        INFORMATION = "使被攻击目标得到“灼烧”状态。灼烧：造成两次额外伤害。",
        MODE = TowerDef.MODE.FRIST,
    },
    [10] ={
        RARITY = TowerDef.RARITY.NORMAL,
        TYPE = TowerDef.TYPE.ATTACK,
        NAME = "1",
        ATK = 20,
        FIRECD = 0.8,
        INFORMATION = "使被攻击目标得到“灼烧”状态。灼烧：造成两次额外伤害。",
        MODE = TowerDef.MODE.FRIST,
    },
    [11] ={
        RARITY = TowerDef.RARITY.NORMAL,
        TYPE = TowerDef.TYPE.ATTACK,
        NAME = "1",
        ATK = 20,
        FIRECD = 0.8,
        INFORMATION = "使被攻击目标得到“灼烧”状态。灼烧：造成两次额外伤害。",
        MODE = TowerDef.MODE.FRIST,
    },
    [12] ={
        RARITY = TowerDef.RARITY.NORMAL,
        TYPE = TowerDef.TYPE.ATTACK,
        NAME = "1",
        ATK = 20,
        FIRECD = 0.8,
        INFORMATION = "使被攻击目标得到“灼烧”状态。灼烧：造成两次额外伤害。",
        MODE = TowerDef.MODE.FRIST,
    },
    [13] ={
        RARITY = TowerDef.RARITY.NORMAL,
        TYPE = TowerDef.TYPE.ATTACK,
        NAME = "1",
        ATK = 20,
        FIRECD = 0.8,
        INFORMATION = "使被攻击目标得到“灼烧”状态。灼烧：造成两次额外伤害。",
        MODE = TowerDef.MODE.FRIST,
    },
    [14] ={
        RARITY = TowerDef.RARITY.NORMAL,
        TYPE = TowerDef.TYPE.ATTACK,
        NAME = "1",
        ATK = 20,
        FIRECD = 0.8,
        INFORMATION = "使被攻击目标得到“灼烧”状态。灼烧：造成两次额外伤害。",
        MODE = TowerDef.MODE.FRIST,
    },
    [15] ={
        RARITY = TowerDef.RARITY.NORMAL,
        TYPE = TowerDef.TYPE.ATTACK,
        NAME = "1",
        ATK = 20,
        FIRECD = 0.8,
        INFORMATION = "使被攻击目标得到“灼烧”状态。灼烧：造成两次额外伤害。",
        MODE = TowerDef.MODE.FRIST,
    },
    [16] ={
        RARITY = TowerDef.RARITY.NORMAL,
        TYPE = TowerDef.TYPE.ATTACK,
        NAME = "1",
        ATK = 20,
        FIRECD = 0.8,
        INFORMATION = "使被攻击目标得到“灼烧”状态。灼烧：造成两次额外伤害。",
        MODE = TowerDef.MODE.FRIST,
    },
    [17] ={
        RARITY = TowerDef.RARITY.NORMAL,
        TYPE = TowerDef.TYPE.ATTACK,
        NAME = "1",
        ATK = 20,
        FIRECD = 0.8,
        INFORMATION = "使被攻击目标得到“灼烧”状态。灼烧：造成两次额外伤害。",
        MODE = TowerDef.MODE.FRIST,
    },
    [18] ={
        RARITY = TowerDef.RARITY.NORMAL,
        TYPE = TowerDef.TYPE.ATTACK,
        NAME = "1",
        ATK = 20,
        FIRECD = 0.8,
        INFORMATION = "使被攻击目标得到“灼烧”状态。灼烧：造成两次额外伤害。",
        MODE = TowerDef.MODE.FRIST,
    },
    [19] ={
        RARITY = TowerDef.RARITY.NORMAL,
        TYPE = TowerDef.TYPE.ATTACK,
        NAME = "1",
        ATK = 20,
        FIRECD = 0.8,
        INFORMATION = "使被攻击目标得到“灼烧”状态。灼烧：造成两次额外伤害。",
        MODE = TowerDef.MODE.FRIST,
    },
    [20] ={
        RARITY = TowerDef.RARITY.NORMAL,
        TYPE = TowerDef.TYPE.ATTACK,
        NAME = "1",
        ATK = 20,
        FIRECD = 0.8,
        INFORMATION = "使被攻击目标得到“灼烧”状态。灼烧：造成两次额外伤害。",
        MODE = TowerDef.MODE.FRIST,
    },
}

return TowerDef