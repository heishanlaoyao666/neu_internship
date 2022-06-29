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
        INFORMATION = "每隔一段时间可以在三个形态之间切换，二形态攻速大幅度加强，三形态攻击必定暴击。",
        MODE = TowerDef.MODE.FRIST,
    },
    [6] ={
        RARITY = TowerDef.RARITY.LEGEND,
        TYPE = TowerDef.TYPE.ATTACK,
        NAME = "6",
        ATK = 35,
        FIRECD = 1.2,
        INFORMATION = "当场上有1，4，9个该种类防御塔时，攻速加强，同时造成额外伤害。",
        MODE = TowerDef.MODE.FRIST,
    },
    [7] ={
        RARITY = TowerDef.RARITY.NORMAL,
        TYPE = TowerDef.TYPE.ATTACK,
        NAME = "7",
        ATK = 20,
        FIRECD = 0.45,
        INFORMATION = "攻击时攻速获得提高。",
        MODE = TowerDef.MODE.FRIST,
    },
    [8] ={
        RARITY = TowerDef.RARITY.EPIC,
        TYPE = TowerDef.TYPE.ATTACK,
        NAME = "8",
        ATK = 10,
        FIRECD = 1.0,
        INFORMATION = "每合成一次，获得攻击力加成。",
        MODE = TowerDef.MODE.FRIST,
    },
    [9] ={
        RARITY = TowerDef.RARITY.NORMAL,
        TYPE = TowerDef.TYPE.ATTACK,
        NAME = "9",
        ATK = 20,
        FIRECD = 1.2,
        INFORMATION = "攻击时有概率直接杀死怪物，对BOSS无效。",
        MODE = TowerDef.MODE.RANDOM,
    },
    [10] ={
        RARITY = TowerDef.RARITY.LEGEND,
        TYPE = TowerDef.TYPE.ATTACK,
        NAME = "10",
        ATK = 30,
        FIRECD = 1.3,
        INFORMATION = "使被攻击目标得到“中毒”状态。中毒：每秒造成额外伤害。",
        MODE = TowerDef.MODE.RANDOM,
    },
    [11] ={
        RARITY = TowerDef.RARITY.EPIC,
        TYPE = TowerDef.TYPE.INTERFERE,
        NAME = "11",
        ATK = 10,
        FIRECD = 0.8,
        INFORMATION = "合成时在对方玩家区域召唤一个特殊怪，使该区域的所有怪物加速。",
        MODE = TowerDef.MODE.FRIST,
    },
    [12] ={
        RARITY = TowerDef.RARITY.EPIC,
        TYPE = TowerDef.TYPE.INTERFERE,
        NAME = "12",
        ATK = 30,
        FIRECD = 0.8,
        INFORMATION = "对战开始时，随机选择一种敌方防御塔，获得其属性及技能。",
        MODE = TowerDef.MODE.FRIST,
    },
    [13] ={
        RARITY = TowerDef.RARITY.LEGEND,
        TYPE = TowerDef.TYPE.INTERFERE,
        NAME = "13",
        ATK = 10,
        FIRECD = 0.8,
        INFORMATION = "合成时随机降低一个敌方防御塔的星级。",
        MODE = TowerDef.MODE.FRIST,
    },
    [14] ={
        RARITY = TowerDef.RARITY.RARE,
        TYPE = TowerDef.TYPE.AUXILIARY,
        NAME = "14",
        ATK = 10,
        FIRECD = 0.8,
        INFORMATION = "复制任意相同星级的防御塔。",
        MODE = TowerDef.MODE.FRIST,
    },
    [15] ={
        RARITY = TowerDef.RARITY.RARE,
        TYPE = TowerDef.TYPE.AUXILIARY,
        NAME = "15",
        ATK = 10,
        FIRECD = 1,
        INFORMATION = "合成或遭受攻击时获得能量。",
        MODE = TowerDef.MODE.FRIST,
    },
    [16] ={
        RARITY = TowerDef.RARITY.EPIC,
        TYPE = TowerDef.TYPE.AUXILIARY,
        NAME = "16",
        ATK = 10,
        FIRECD = 2,
        INFORMATION = "生成一段时间后，变成星级加一的随机防御塔。",
        MODE = TowerDef.MODE.FRIST,
    },
    [17] ={
        RARITY = TowerDef.RARITY.EPIC,
        TYPE = TowerDef.TYPE.AUXILIARY,
        NAME = "17",
        ATK = 20,
        FIRECD = 1,
        INFORMATION = "可以和任意相同星级的防御塔合成，不改变防御塔种类。",
        MODE = TowerDef.MODE.FRIST,
    },
    [18] ={
        RARITY = TowerDef.RARITY.NORMAL,
        TYPE = TowerDef.TYPE.AUXILIARY,
        NAME = "18",
        ATK = 30,
        FIRECD = 1,
        INFORMATION = "使被攻击目标得到“灼烧”状态。灼烧：造成两次额外伤害。",
        MODE = TowerDef.MODE.RANDOM,
    },
    [19] ={
        RARITY = TowerDef.RARITY.LEGEND,
        TYPE = TowerDef.TYPE.CONTROL,
        NAME = "19",
        ATK = 60,
        FIRECD = 2,
        INFORMATION = "每隔一段时间使本方半场所有敌人减速。",
        MODE = TowerDef.MODE.FRIST,
    },
    [20] ={
        RARITY = TowerDef.RARITY.NORMAL,
        TYPE = TowerDef.TYPE.CONTROL,
        NAME = "20",
        ATK = 20,
        FIRECD = 1,
        INFORMATION = "使被攻击目标进入“混乱”状态。混乱：无法移动。",
        MODE = TowerDef.MODE.RANDOM,
    },
}

return TowerDef