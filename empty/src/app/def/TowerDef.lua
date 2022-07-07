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
        ATTACK = "attack",-- 攻击
        INTERFERE = "interfere", --干扰
        AUXILIARY = "auxiliary", --辅助
        CONTROL = "control", --控制
        SUMMONER = "summoner", -- 召唤
    },
    MODE = {
        FRIST = 1 ,--前方
        MAXLIFE =2 ,--最大生命
        RANDOM = 3, --随机
    },
    SKILL ={
        EXTRA_DAMAGE= 1,--额外伤害
        FRIST_TRANS =2, --初次变身
        SECOND_TRANS = 22, --二次变身
        ATTACK_SPEED_BONUS =3, --攻速加成
        ATTACK_POWER_BONUS = 4, --攻击力加成
        ENEMY_SPEED =5, --敌方怪物加速效果
        INCREASE_DAMAGE= 6,--增伤效果
        SKILL_DECELERATE = 7,--技能减速
        SKILL_CONTINUED = 8,--技能持续时间
        SKILL_START = 9, --技能发动
        ATTACK_DEATH = 10 ,--攻击致死
        GROWTH_TIME = 11, --成长时间
    },
}
TowerDef.UPLEVELFRAG = {
    [TowerDef.RARITY.NORMAL] = {
        2,4,10,20,50,100,200,400,800,1000,2000,5000
    },
    [TowerDef.RARITY.RARE] = {
        2,4,10,20,50,100,200,400,800,1000
    },
    [TowerDef.RARITY.EPIC] = {
        2,4,10,20,50,100,200,400
    },
    [TowerDef.RARITY.LEGEND] = {
        2,4,10,20
    }
}
TowerDef.UPLEVELFRAG2={2,4,10,20,50,100,200,400,800,1000,2000,5000}
TowerDef.UPLEVELCOIN2={5,20,50,150,400,1000,2000,4000,8000,20000,50000,100000}
TowerDef.UPLEVELCOIN = {
    [TowerDef.RARITY.NORMAL] = {
        5,20,50,150,400,1000,2000,4000,8000,20000,50000,100000
    },
    [TowerDef.RARITY.RARE] = {
        50,150,400,1000,2000,4000,8000,20000,50000,100000
    },
    [TowerDef.RARITY.EPIC] = {
        400,1000,2000,4000,8000,20000,50000,100000
    },
    [TowerDef.RARITY.LEGEND] = {
        8000,20000,50000,100000
    }
}
TowerDef.LEVEL = {
    START_LEVEL = {
        [TowerDef.RARITY.NORMAL] = 1,
        [TowerDef.RARITY.RARE] = 3,
        [TowerDef.RARITY.EPIC] = 5,
        [TowerDef.RARITY.LEGEND] = 9,
    },
    MAX_LEVEL = 13,
}
TowerDef.SKILLNAME ={
    [TowerDef.SKILL.EXTRA_DAMAGE]="额外伤害",
    [TowerDef.SKILL.FRIST_TRANS]="初次变身时间", 
    [TowerDef.SKILL.SECOND_TRANS]="二次变身时间", 
    [TowerDef.SKILL.ATTACK_SPEED_BONUS]="攻速加强 ", 
    [TowerDef.SKILL.ATTACK_POWER_BONUS]="攻击力加成", 
    [TowerDef.SKILL.ATTACK_DEATH]="攻击致死概率",
    [TowerDef.SKILL.ENEMY_SPEED]="加速效果",--敌方怪物加速效果
    [TowerDef.SKILL.GROWTH_TIME]="成长时间",
    [TowerDef.SKILL.INCREASE_DAMAGE]="增伤效果",
    [TowerDef.SKILL.SKILL_DECELERATE]="技能减速效果", 
    [TowerDef.SKILL.SKILL_CONTINUED]="技能持续时间", 
    [TowerDef.SKILL.SKILL_START]="技能发动时间", 
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
        --升级和强化的数据变化
        ATK_UPGRADE = 3,
        FIRECD_UPGRADE = 0.01,
        ATK_ENHANCE = 10,
        --技能相关
        SKILLS = {
            [1] = {
                ID = TowerDef.SKILL.EXTRA_DAMAGE,
                VALUE = 20,
                VALUE_UPGRADE = 3,
                VALUE_ENHANCE = 20,
            },
        },
    },
    [2] ={
        RARITY = TowerDef.RARITY.EPIC,
        TYPE = TowerDef.TYPE.ATTACK,
        NAME = "2",
        ATK = 20,
        FIRECD = 0.8,
        INFORMATION = "使星级数个怪物受到伤害。",
        MODE = TowerDef.MODE.FRIST,
        --升级和强化的数据变化
        ATK_UPGRADE = 5,
        FIRECD_UPGRADE = 0,
        ATK_ENHANCE = 10,
        --技能相关
        SKILLS = {
            [1] = {
                ID = TowerDef.SKILL.EXTRA_DAMAGE,
                VALUE = 50,
                VALUE_UPGRADE = 4,
                VALUE_ENHANCE = 40,
            },
        },
    },
    [3] ={
        RARITY = TowerDef.RARITY.RARE,
        TYPE = TowerDef.TYPE.ATTACK,
        NAME = "3",
        ATK = 40,
        FIRECD = 0.8,
        INFORMATION = "攻击五次后，造成额外伤害。",
        MODE = TowerDef.MODE.FRIST,
        --升级和强化的数据变化
        ATK_UPGRADE = 8,
        FIRECD_UPGRADE = 0.01,
        ATK_ENHANCE = 20,
        --技能相关
        SKILLS = {
            [1] = {
                ID = TowerDef.SKILL.EXTRA_DAMAGE,
                VALUE = 120,
                VALUE_UPGRADE = 24,
                VALUE_ENHANCE = 40,
            },
        },
    },
    [4] ={
        RARITY = TowerDef.RARITY.NORMAL,
        TYPE = TowerDef.TYPE.ATTACK,
        NAME = "4",
        ATK = 100,
        FIRECD = 1,
        INFORMATION = "攻击生命值最高的怪物，对BOSS造成双倍伤害。",
        MODE = TowerDef.MODE.MAXLIFE,
        --升级和强化的数据变化
        ATK_UPGRADE = 10,
        FIRECD_UPGRADE = 0,
        ATK_ENHANCE = 100,
        --技能相关
        SKILLS = {
            
        },
    },
    [5] ={
        RARITY = TowerDef.RARITY.LEGEND,
        TYPE = TowerDef.TYPE.ATTACK,
        NAME = "5",
        ATK = 20,
        FIRECD = 0.6,
        INFORMATION = "每隔一段时间可以在三个形态之间切换，二形态攻速大幅度加强，三形态攻击必定暴击。",
        MODE = TowerDef.MODE.FRIST,
        --升级和强化的数据变化
        ATK_UPGRADE = 3,
        FIRECD_UPGRADE = 0,
        ATK_ENHANCE = 30,
        --技能相关
        SKILLS = {
            [1] = {
                ID = TowerDef.SKILL.FRIST_TRANS,
                VALUE = 6,
                VALUE_UPGRADE = 0,
                VALUE_ENHANCE = 0,
            },
            [2] = {
                ID = TowerDef.SKILL.SECOND_TRANS,
                VALUE = 4,
                VALUE_UPGRADE = 0,
                VALUE_ENHANCE = 0,
            },
        },
    },
    [6] ={
        RARITY = TowerDef.RARITY.LEGEND,
        TYPE = TowerDef.TYPE.ATTACK,
        NAME = "6",
        ATK = 35,
        FIRECD = 1.2,
        INFORMATION = "当场上有1，4，9个该种类防御塔时，攻速加强，同时造成额外伤害。",
        MODE = TowerDef.MODE.FRIST,
        --升级和强化的数据变化
        ATK_UPGRADE = 5,
        FIRECD_UPGRADE = 0,
        ATK_ENHANCE = 11,
        --技能相关
        SKILLS = {
            [1] = {
                ID = TowerDef.SKILL.EXTRA_DAMAGE,
                VALUE = 35,
                VALUE_UPGRADE = 5,
                VALUE_ENHANCE = 10.5,
            },
        },
    },
    [7] ={
        RARITY = TowerDef.RARITY.NORMAL,
        TYPE = TowerDef.TYPE.ATTACK,
        NAME = "7",
        ATK = 20,
        FIRECD = 0.45,
        INFORMATION = "攻击时攻速获得提高。",
        MODE = TowerDef.MODE.FRIST,
        --升级和强化的数据变化
        ATK_UPGRADE = 3,
        FIRECD_UPGRADE = 0,
        ATK_ENHANCE = 15,
        --技能相关
        SKILLS = {
            [1] = {
                ID = TowerDef.SKILL.ATTACK_SPEED_BONUS,
                VALUE = 0.1,
                VALUE_UPGRADE = 0.02,
                VALUE_ENHANCE = 0,
            },
        },
    },
    [8] ={
        RARITY = TowerDef.RARITY.EPIC,
        TYPE = TowerDef.TYPE.ATTACK,
        NAME = "8",
        ATK = 10,
        FIRECD = 1.0,
        INFORMATION = "每合成一次，获得攻击力加成。",
        MODE = TowerDef.MODE.FRIST,
        --升级和强化的数据变化
        ATK_UPGRADE = 10,
        FIRECD_UPGRADE = 0,
        ATK_ENHANCE = 10,
        --技能相关
        SKILLS = {
            [1] = {
                ID = TowerDef.SKILL.ATTACK_POWER_BONUS,
                VALUE = 20,
                VALUE_UPGRADE = 1,
                VALUE_ENHANCE = 0,
            },
        },
    },
    [9] ={
        RARITY = TowerDef.RARITY.NORMAL,
        TYPE = TowerDef.TYPE.ATTACK,
        NAME = "9",
        ATK = 20,
        FIRECD = 1.2,
        INFORMATION = "攻击时有概率直接杀死怪物，对BOSS无效。",
        MODE = TowerDef.MODE.RANDOM,
        --升级和强化的数据变化
        ATK_UPGRADE = 4,
        FIRECD_UPGRADE = 0,
        ATK_ENHANCE = 0,
        --技能相关
        SKILLS = {
            [1] = {
                ID = TowerDef.SKILL.ATTACK_DEATH,
                VALUE = 0.02,
                VALUE_UPGRADE = 0.002,
                VALUE_ENHANCE = 0.5,
            },
        },
    },
    [10] ={
        RARITY = TowerDef.RARITY.LEGEND,
        TYPE = TowerDef.TYPE.ATTACK,
        NAME = "10",
        ATK = 30,
        FIRECD = 1.3,
        INFORMATION = "使被攻击目标得到“中毒”状态。中毒：每秒造成额外伤害。",
        MODE = TowerDef.MODE.RANDOM,
        --升级和强化的数据变化
        ATK_UPGRADE = 2,
        FIRECD_UPGRADE = 0,
        ATK_ENHANCE = 10,
        --技能相关
        SKILLS = {
            [1] = {
                ID = TowerDef.SKILL.EXTRA_DAMAGE,
                VALUE = 50,
                VALUE_UPGRADE = 5,
                VALUE_ENHANCE = 20,
            },
        },
    },
    [11] ={
        RARITY = TowerDef.RARITY.EPIC,
        TYPE = TowerDef.TYPE.INTERFERE,
        NAME = "11",
        ATK = 10,
        FIRECD = 0.8,
        INFORMATION = "合成时在对方玩家区域召唤一个特殊怪，使该区域的所有怪物加速。",
        MODE = TowerDef.MODE.FRIST,
        --升级和强化的数据变化
        ATK_UPGRADE = 5,
        FIRECD_UPGRADE = 0.02,
        ATK_ENHANCE = 10,
        --技能相关
        SKILLS = {
            [1] = {
                ID = TowerDef.SKILL.ENEMY_SPEED,
                VALUE = 0.05,
                VALUE_UPGRADE = 0,
                VALUE_ENHANCE = 0,
            },
        },
    },
    [12] ={
        RARITY = TowerDef.RARITY.EPIC,
        TYPE = TowerDef.TYPE.INTERFERE,
        NAME = "12",
        ATK = 30,
        FIRECD = 0.8,
        INFORMATION = "对战开始时，随机选择一种敌方防御塔，获得其属性及技能。",
        MODE = TowerDef.MODE.FRIST,
        --升级和强化的数据变化
        ATK_UPGRADE = 0,
        FIRECD_UPGRADE = 0,
        ATK_ENHANCE = 0,
        --技能相关
        SKILLS = {
            
        },
    },
    [13] ={
        RARITY = TowerDef.RARITY.LEGEND,
        TYPE = TowerDef.TYPE.INTERFERE,
        NAME = "13",
        ATK = 10,
        FIRECD = 0.8,
        INFORMATION = "合成时随机降低一个敌方防御塔的星级。",
        MODE = TowerDef.MODE.FRIST,
        --升级和强化的数据变化
        ATK_UPGRADE = 3,
        FIRECD_UPGRADE = 0.01,
        ATK_ENHANCE = 10,
        --技能相关
        SKILLS = {
            
        },
    },
    [14] ={
        RARITY = TowerDef.RARITY.RARE,
        TYPE = TowerDef.TYPE.AUXILIARY,
        NAME = "14",
        ATK = 10,
        FIRECD = 0.8,
        INFORMATION = "复制任意相同星级的防御塔。",
        MODE = TowerDef.MODE.FRIST,
        --升级和强化的数据变化
        ATK_UPGRADE = 5,
        FIRECD_UPGRADE = 0.02,
        ATK_ENHANCE = 10,
        --技能相关
        SKILLS = {
            
        },
    },
    [15] ={
        RARITY = TowerDef.RARITY.RARE,
        TYPE = TowerDef.TYPE.AUXILIARY,
        NAME = "15",
        ATK = 10,
        FIRECD = 1,
        INFORMATION = "合成或遭受攻击时获得能量。",
        MODE = TowerDef.MODE.FRIST,
        --升级和强化的数据变化
        ATK_UPGRADE = 5,
        FIRECD_UPGRADE = 0,
        ATK_ENHANCE = 10,
        --技能相关
        SKILLS = {
           
        },
    },
    [16] ={
        RARITY = TowerDef.RARITY.EPIC,
        TYPE = TowerDef.TYPE.AUXILIARY,
        NAME = "16",
        ATK = 10,
        FIRECD = 2,
        INFORMATION = "生成一段时间后，变成星级加一的随机防御塔。",
        MODE = TowerDef.MODE.FRIST,
        --升级和强化的数据变化
        ATK_UPGRADE = 10,
        FIRECD_UPGRADE = 0,
        ATK_ENHANCE = 10,
        --技能相关
        SKILLS = {
            [1] = {
                ID = TowerDef.SKILL.GROWTH_TIME,
                VALUE = 15,
                VALUE_UPGRADE = 0,
                VALUE_ENHANCE = 0,
            },
        },
    },
    [17] ={
        RARITY = TowerDef.RARITY.EPIC,
        TYPE = TowerDef.TYPE.AUXILIARY,
        NAME = "17",
        ATK = 20,
        FIRECD = 1,
        INFORMATION = "可以和任意相同星级的防御塔合成，不改变防御塔种类。",
        MODE = TowerDef.MODE.FRIST,
        --升级和强化的数据变化
        ATK_UPGRADE = 10,
        FIRECD_UPGRADE = 0,
        ATK_ENHANCE = 10,
        --技能相关
        SKILLS = {
            
        },
    },
    [18] ={
        RARITY = TowerDef.RARITY.NORMAL,
        TYPE = TowerDef.TYPE.AUXILIARY,
        NAME = "18",
        ATK = 30,
        FIRECD = 1,
        INFORMATION = "使被攻击目标得到“灼烧”状态。灼烧：造成两次额外伤害。",
        MODE = TowerDef.MODE.RANDOM,
        --升级和强化的数据变化
        ATK_UPGRADE = 5,
        FIRECD_UPGRADE = 0,
        ATK_ENHANCE = 10,
        --技能相关
        SKILLS = {
            [1] = {
                ID = TowerDef.SKILL.INCREASE_DAMAGE,
                VALUE = 0.1,
                VALUE_UPGRADE = 0.01,
                VALUE_ENHANCE = 0.05,
            },
        },
    },
    [19] ={
        RARITY = TowerDef.RARITY.LEGEND,
        TYPE = TowerDef.TYPE.CONTROL,
        NAME = "19",
        ATK = 60,
        FIRECD = 2,
        INFORMATION = "每隔一段时间使本方半场所有敌人减速。",
        MODE = TowerDef.MODE.FRIST,
        --升级和强化的数据变化
        ATK_UPGRADE = 5,
        FIRECD_UPGRADE = 0,
        ATK_ENHANCE = 20,
        --技能相关
        SKILLS = {
            [1] = {
                ID = TowerDef.SKILL.SKILL_DECELERATE,
                VALUE = 0.05,
                VALUE_UPGRADE = 0.005,
                VALUE_ENHANCE = 0.01,
            },
            [2] = {
                ID = TowerDef.SKILL.SKILL_START,
                VALUE = 10,
                VALUE_UPGRADE = 0,
                VALUE_ENHANCE = 0,
            },
        },
    },
    [20] ={
        RARITY = TowerDef.RARITY.NORMAL,
        TYPE = TowerDef.TYPE.CONTROL,
        NAME = "20",
        ATK = 20,
        FIRECD = 1,
        INFORMATION = "使被攻击目标进入“混乱”状态。混乱：无法移动。",
        MODE = TowerDef.MODE.RANDOM,
        --升级和强化的数据变化
        ATK_UPGRADE = 5,
        FIRECD_UPGRADE = 0,
        ATK_ENHANCE = 20,
        --技能相关
        SKILLS = {
            [1] = {
                ID = TowerDef.SKILL.SKILL_CONTINUED,
                VALUE = 2,
                VALUE_UPGRADE = 0.5,
                VALUE_ENHANCE = 0.5,
            },
            [2] = {
                ID = TowerDef.SKILL.SKILL_START,
                VALUE = 10,
                VALUE_UPGRADE = 0,
                VALUE_ENHANCE = 0,
            },
        },
    },
}
TowerDef.BUFF = {
    [1] = {
        TOWER = {
            [1] ={
                NAME = "bullet_burn", --BUFF名字
                ADDSTACK = 1, --BUFF的添加层数
                PERMANENT = true, --BUFF是否是永久的
                DURATION = 0, --BUFF的持续时间
            }
        },
        BULLET = {
        },
    },
    [2] = {
        TOWER = {
            [1] ={
                NAME = "grade_damage", --BUFF名字
                ADDSTACK = 1, --BUFF的添加层数
                PERMANENT = true, --BUFF是否是永久的
                DURATION = 0, --BUFF的持续时间
            }
        },
        BULLET = {
        },
    },
    [3] = {
        TOWER = {
            [1] ={
                NAME = "five_time", --BUFF名字
                ADDSTACK = 1, --BUFF的添加层数
                PERMANENT = true, --BUFF是否是永久的
                DURATION = 0, --BUFF的持续时间
            },
            [2] ={
                NAME = "extra_damage", --BUFF名字
                ADDSTACK = 1, --BUFF的添加层数
                PERMANENT = true, --BUFF是否是永久的
                DURATION = 0, --BUFF的持续时间
            }
        },
        BULLET = {
        },
    },
    [4] = {
        TOWER = {

        },
        BULLET = {
            
        },
    },
    [5] = {
        TOWER = {

        },
        BULLET = {
            
        },
    },
    [6] = {
        TOWER = {

        },
        BULLET = {
            
        },
    },
    [7] = {
        TOWER = {

        },
        BULLET = {
            
        },
    },
    [8] = {
        TOWER = {

        },
        BULLET = {
            
        },
    },
    [9] = {
        TOWER = {

        },
        BULLET = {
            
        },
    },
    [10] = {
        TOWER = {

        },
        BULLET = {
            
        },
    },
    [11] = {
        TOWER = {

        },
        BULLET = {
            
        },
    },
    [12] = {
        TOWER = {

        },
        BULLET = {
            
        },
    },
    [13] = {
        TOWER = {

        },
        BULLET = {
            
        },
    },
    [14] = {
        TOWER = {
        },
        BULLET = {
        },
    },
    [15] = {
        TOWER = {
        },
        BULLET = {
        },
    },
    [16] = {
        TOWER = {

        },
        BULLET = {
            
        },
    },
    [17] = {
        TOWER = {

        },
        BULLET = {
            
        },
    },
    [18] = {
        TOWER = {

        },
        BULLET = {
            
        },
    },
    [19] = {
        TOWER = {

        },
        BULLET = {
            
        },
    },
    [20] = {
        TOWER = {

        },
        BULLET = {
            
        },
    },

}
return TowerDef