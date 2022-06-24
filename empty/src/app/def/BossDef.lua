--[[--
    BossDef.lua
    Boss描述定义
]]
local BossDef = {
    
    BOSS_1 ={
        NAME = "嬉戏者", --名字
        SKILL = "将所有我方防御塔种类随机变化", --描述
    },
    BOSS_2 ={
        NAME = "静谧者", --名字
        SKILL = "每隔7秒沉默两个防御塔，使其不能攻击", --描述
    },
    BOSS_3 ={
        NAME = "癫狂者", --名字
        SKILL = "出场时使所有防御塔降低一星（一星防御塔直接被摧毁），行进过程中每隔一段时间会向前方高速移动一次", --描述
    },
    BOSS_4 ={
        NAME = "狂战者", --名字
        SKILL = "不受控制效果影响，在血量为75%、50%、25%时会召唤普通怪物三个，召唤期间无敌", --描述
    },
}

return BossDef