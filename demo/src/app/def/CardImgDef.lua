--[[
    CardImgDef.lua
    卡片图片地址定义
    描述：卡片图片地址定义
    编写：周星宇
    修订：李昊
    检查：张昊煜
]]

local CardImgDef = {}

--[[
    塔种类对应的图片
]]
CardImgDef.CARD_TYPE = {
    ATTACK = "image/tower/type/attack_icon.png",
    INTERFERE = "image/tower/type/interfere_icon.png",
    ASSIST = "image/tower/type/assist_icon.png",
    CONTROL = "image/tower/type/control_icon.png",
    CALL = "image/tower/type/call_icon.png",
}

--[[
    稀有度背景对应的图片
]]
CardImgDef.CARD_RAR_BG = {
    NORMAL = "image/tower/rarity/bg/normal_bg.png",
    RARE = "image/tower/rarity/bg/rare_bg.png",
    LEGEND = "image/tower/rarity/bg/legend_bg.png",
    EPIC = "image/tower/rarity/bg/epic_bg.png",
    NOT_OBTAIN = "image/tower/rarity/bg/not_obtain_bg.png",
}

--[[
    稀有度文字对应的图片
]]
CardImgDef.CARD_RAR_TEXT = {
    NORMAL = "image/tower/rarity/text/normal_text.png",
    RARE = "image/tower/rarity/text/rare_text.png",
    LEGEND = "image/tower/rarity/text/legend_text.png",
    EPIC = "image/tower/rarity/text/epic_text.png",
}

--[[
    等级对应的图片
]]
CardImgDef.CARD_LEVEL = {
    LEVEL_1 = "image/tower/level/lv_1.png",
    LEVEL_2 = "image/tower/level/lv_2.png",
    LEVEL_3 = "image/tower/level/lv_3.png",
    LEVEL_4 = "image/tower/level/lv_4.png",
    LEVEL_5 = "image/tower/level/lv_5.png",
    LEVEL_6 = "image/tower/level/lv_6.png",
    LEVEL_7 = "image/tower/level/lv_7.png",
    LEVEL_8 = "image/tower/level/lv_8.png",
    LEVEL_9 = "image/tower/level/lv_9.png",
    LEVEL_10 = "image/tower/level/lv_10.png",
    LEVEL_11 = "image/tower/level/lv_11.png",
    LEVEL_12 = "image/tower/level/lv_12.png",
    LEVEL_13 = "image/tower/level/lv_13.png",
}


--[[
    防御塔1对应的图片相关地址
]]
CardImgDef.CARD_1 = {
    SPRITE_1 = "image/tower/sprite/big/tower_1.png", -- 无背景大图
    SPRITE_2 = "image/tower/sprite/small/color/tower_1.png", -- 彩色小图
    SPRITE_3 = "image/tower/sprite/small/grey/tower_1.png", -- 灰色小图
    SPRITE_4 = "image/tower/sprite/medium/tower_1.png", -- 商店中图
    TYPE = CardImgDef.CARD_TYPE.ATTACK, -- 塔类型角标
    RAR_BG = CardImgDef.CARD_RAR_BG.NORMAL, -- 塔稀有度背景
    RAR_TEXT = CardImgDef.CARD_RAR_TEXT.NORMAL, -- 塔稀有度文字

    ATTR_TYPE = "image/tower/attr/type_blue_text.png", -- 类型文字
    ATTR_ATK = "image/tower/attr/attack_text.png", -- 攻击力文字
    ATTR_AS = "image/tower/attr/attack_speed_text.png", -- 攻速文字
    ATTR_TARGET = "image/tower/attr/target_text.png", -- 目标文字
    ATTR_SKILL_ONE = "image/tower/attr/additional_damage_text.png", -- 技能1文字
    ATTR_SKILL_TWO = nil, -- 技能2文字
}

--[[
    防御塔2对应的图片相关地址
]]
CardImgDef.CARD_2 = {
    SPRITE_1 = "image/tower/sprite/big/tower_2.png", -- 无背景大图
    SPRITE_2 = "image/tower/sprite/small/color/tower_2.png", -- 彩色小图
    SPRITE_3 = "image/tower/sprite/small/grey/tower_2.png", -- 灰色小图
    SPRITE_4 = "image/tower/sprite/medium/tower_2.png", -- 商店中图
    TYPE = CardImgDef.CARD_TYPE.ATTACK, -- 塔类型角标
    RAR_BG = CardImgDef.CARD_RAR_BG.EPIC, -- 塔稀有度背景
    RAR_TEXT = CardImgDef.CARD_RAR_TEXT.EPIC, -- 塔稀有度文字

    ATTR_TYPE = "image/tower/attr/type_blue_text.png", -- 类型文字
    ATTR_ATK = "image/tower/attr/attack_text.png", -- 攻击力文字
    ATTR_AS = "image/tower/attr/attack_speed_text.png", -- 攻速文字
    ATTR_TARGET = "image/tower/attr/target_text.png", -- 目标文字
    ATTR_SKILL_ONE = "image/tower/attr/additional_damage_text.png", -- 技能1文字
    ATTR_SKILL_TWO = nil, -- 技能2文字
}

--[[
    防御塔3对应的图片相关地址
]]
CardImgDef.CARD_3 = {
    SPRITE_1 = "image/tower/sprite/big/tower_3.png", -- 无背景大图
    SPRITE_2 = "image/tower/sprite/small/color/tower_3.png", -- 彩色小图
    SPRITE_3 = "image/tower/sprite/small/grey/tower_3.png", -- 灰色小图
    SPRITE_4 = "image/tower/sprite/medium/tower_3.png", -- 商店中图
    TYPE = CardImgDef.CARD_TYPE.ATTACK, -- 塔类型角标
    RAR_BG = CardImgDef.CARD_RAR_BG.RARE, -- 塔稀有度背景
    RAR_TEXT = CardImgDef.CARD_RAR_TEXT.RARE, -- 塔稀有度文字

    ATTR_TYPE = "image/tower/attr/type_blue_text.png", -- 类型文字
    ATTR_ATK = "image/tower/attr/attack_text.png", -- 攻击力文字
    ATTR_AS = "image/tower/attr/attack_speed_text.png", -- 攻速文字
    ATTR_TARGET = "image/tower/attr/target_text.png", -- 目标文字
    ATTR_SKILL_ONE = "image/tower/attr/additional_damage_text.png", -- 技能1文字
    ATTR_SKILL_TWO = nil, -- 技能2文字
}

--[[
    防御塔4对应的图片相关地址
]]
CardImgDef.CARD_4 = {
    SPRITE_1 = "image/tower/sprite/big/tower_4.png", -- 无背景大图
    SPRITE_2 = "image/tower/sprite/small/color/tower_4.png", -- 彩色小图
    SPRITE_3 = "image/tower/sprite/small/grey/tower_4.png", -- 灰色小图
    SPRITE_4 = "image/tower/sprite/medium/tower_4.png", -- 商店中图
    TYPE = CardImgDef.CARD_TYPE.ATTACK, -- 塔类型角标
    RAR_BG = CardImgDef.CARD_RAR_BG.NORMAL, -- 塔稀有度背景
    RAR_TEXT = CardImgDef.CARD_RAR_TEXT.NORMAL, -- 塔稀有度文字

    ATTR_TYPE = "image/tower/attr/type_blue_text.png", -- 类型文字
    ATTR_ATK = "image/tower/attr/attack_text.png", -- 攻击力文字
    ATTR_AS = "image/tower/attr/attack_speed_text.png", -- 攻速文字
    ATTR_TARGET = "image/tower/attr/target_text.png", -- 目标文字
    ATTR_SKILL_ONE = nil, -- 技能1文字
    ATTR_SKILL_TWO = nil, -- 技能2文字
}

--[[
    防御塔5对应的图片相关地址
]]
CardImgDef.CARD_5 = {
    SPRITE_1 = "image/tower/sprite/big/tower_5.png", -- 无背景大图
    SPRITE_2 = "image/tower/sprite/small/color/tower_5.png", -- 彩色小图
    SPRITE_3 = "image/tower/sprite/small/grey/tower_5.png", -- 灰色小图
    SPRITE_4 = "image/tower/sprite/medium/tower_5.png", -- 商店中图
    TYPE = CardImgDef.CARD_TYPE.ATTACK, -- 塔类型角标
    RAR_BG = CardImgDef.CARD_RAR_BG.LEGEND, -- 塔稀有度背景
    RAR_TEXT = CardImgDef.CARD_RAR_TEXT.LEGEND, -- 塔稀有度文字

    ATTR_TYPE = "image/tower/attr/type_blue_text.png", -- 类型文字
    ATTR_ATK = "image/tower/attr/attack_text.png", -- 攻击力文字
    ATTR_AS = "image/tower/attr/attack_speed_text.png", -- 攻速文字
    ATTR_TARGET = "image/tower/attr/target_text.png", -- 目标文字
    ATTR_SKILL_ONE = "image/tower/attr/first_trans_time_text.png", -- 技能1文字
    ATTR_SKILL_TWO = "image/tower/attr/second_trans_time_text.png", -- 技能2文字
}

--[[
    防御塔6对应的图片相关地址
]]
CardImgDef.CARD_6 = {
    SPRITE_1 = "image/tower/sprite/big/tower_6.png", -- 无背景大图
    SPRITE_2 = "image/tower/sprite/small/color/tower_6.png", -- 彩色小图
    SPRITE_3 = "image/tower/sprite/small/grey/tower_6.png", -- 灰色小图
    SPRITE_4 = "image/tower/sprite/medium/tower_6.png", -- 商店中图
    TYPE = CardImgDef.CARD_TYPE.ATTACK, -- 塔类型角标
    RAR_BG = CardImgDef.CARD_RAR_BG.LEGEND, -- 塔稀有度背景
    RAR_TEXT = CardImgDef.CARD_RAR_TEXT.LEGEND, -- 塔稀有度文字

    ATTR_TYPE = "image/tower/attr/type_blue_text.png", -- 类型文字
    ATTR_ATK = "image/tower/attr/attack_text.png", -- 攻击力文字
    ATTR_AS = "image/tower/attr/attack_speed_text.png", -- 攻速文字
    ATTR_TARGET = "image/tower/attr/target_text.png", -- 目标文字
    ATTR_SKILL_ONE = "image/tower/attr/additional_damage_text.png", -- 技能1文字
    ATTR_SKILL_TWO = nil, -- 技能2文字
}

--[[
    防御塔7对应的图片相关地址
]]
CardImgDef.CARD_7 = {
    SPRITE_1 = "image/tower/sprite/big/tower_7.png", -- 无背景大图
    SPRITE_2 = "image/tower/sprite/small/color/tower_7.png", -- 彩色小图
    SPRITE_3 = "image/tower/sprite/small/grey/tower_7.png", -- 灰色小图
    SPRITE_4 = "image/tower/sprite/medium/tower_7.png", -- 商店中图
    TYPE = CardImgDef.CARD_TYPE.ATTACK, -- 塔类型角标
    RAR_BG = CardImgDef.CARD_RAR_BG.NORMAL, -- 塔稀有度背景
    RAR_TEXT = CardImgDef.CARD_RAR_TEXT.NORMAL, -- 塔稀有度文字

    ATTR_TYPE = "image/tower/attr/type_blue_text.png", -- 类型文字
    ATTR_ATK = "image/tower/attr/attack_text.png", -- 攻击力文字
    ATTR_AS = "image/tower/attr/attack_speed_text.png", -- 攻速文字
    ATTR_TARGET = "image/tower/attr/target_text.png", -- 目标文字
    ATTR_SKILL_ONE = "image/tower/attr/attack_speed_enforce_text.png", -- 技能1文字
    ATTR_SKILL_TWO = nil, -- 技能2文字
}

--[[
    防御塔8对应的图片相关地址
]]
CardImgDef.CARD_8 = {
    SPRITE_1 = "image/tower/sprite/big/tower_8.png", -- 无背景大图
    SPRITE_2 = "image/tower/sprite/small/color/tower_8.png", -- 彩色小图
    SPRITE_3 = "image/tower/sprite/small/grey/tower_8.png", -- 灰色小图
    SPRITE_4 = "image/tower/sprite/medium/tower_8.png", -- 商店中图
    TYPE = CardImgDef.CARD_TYPE.ATTACK, -- 塔类型角标
    RAR_BG = CardImgDef.CARD_RAR_BG.EPIC, -- 塔稀有度背景
    RAR_TEXT = CardImgDef.CARD_RAR_TEXT.EPIC, -- 塔稀有度文字

    ATTR_TYPE = "image/tower/attr/type_blue_text.png", -- 类型文字
    ATTR_ATK = "image/tower/attr/attack_text.png", -- 攻击力文字
    ATTR_AS = "image/tower/attr/attack_speed_text.png", -- 攻速文字
    ATTR_TARGET = "image/tower/attr/target_text.png", -- 目标文字
    ATTR_SKILL_ONE = "image/tower/attr/attack_addition_text.png", -- 技能1文字
    ATTR_SKILL_TWO = nil, -- 技能2文字
}

--[[
    防御塔9对应的图片相关地址
]]
CardImgDef.CARD_9 = {
    SPRITE_1 = "image/tower/sprite/big/tower_9.png", -- 无背景大图
    SPRITE_2 = "image/tower/sprite/small/color/tower_9.png", -- 彩色小图
    SPRITE_3 = "image/tower/sprite/small/grey/tower_9.png", -- 灰色小图
    SPRITE_4 = "image/tower/sprite/medium/tower_9.png", -- 商店中图
    TYPE = CardImgDef.CARD_TYPE.ATTACK, -- 塔类型角标
    RAR_BG = CardImgDef.CARD_RAR_BG.NORMAL, -- 塔稀有度背景
    RAR_TEXT = CardImgDef.CARD_RAR_TEXT.NORMAL, -- 塔稀有度文字

    ATTR_TYPE = "image/tower/attr/type_blue_text.png", -- 类型文字
    ATTR_ATK = "image/tower/attr/attack_text.png", -- 攻击力文字
    ATTR_AS = "image/tower/attr/attack_speed_text.png", -- 攻速文字
    ATTR_TARGET = "image/tower/attr/target_text.png", -- 目标文字
    ATTR_SKILL_ONE = "image/tower/attr/attack_dead_prob_text.png", -- 技能1文字
    ATTR_SKILL_TWO = nil, -- 技能2文字
}

--[[
    防御塔10对应的图片相关地址
]]
CardImgDef.CARD_10 = {
    SPRITE_1 = "image/tower/sprite/big/tower_10.png", -- 无背景大图
    SPRITE_2 = "image/tower/sprite/small/color/tower_10.png", -- 彩色小图
    SPRITE_3 = "image/tower/sprite/small/grey/tower_10.png", -- 灰色小图
    SPRITE_4 = "image/tower/sprite/medium/tower_10.png", -- 商店中图
    TYPE = CardImgDef.CARD_TYPE.ATTACK, -- 塔类型角标
    RAR_BG = CardImgDef.CARD_RAR_BG.RARE, -- 塔稀有度背景
    RAR_TEXT = CardImgDef.CARD_RAR_TEXT.RARE, -- 塔稀有度文字

    ATTR_TYPE = "image/tower/attr/type_blue_text.png", -- 类型文字
    ATTR_ATK = "image/tower/attr/attack_text.png", -- 攻击力文字
    ATTR_AS = "image/tower/attr/attack_speed_text.png", -- 攻速文字
    ATTR_TARGET = "image/tower/attr/target_text.png", -- 目标文字
    ATTR_SKILL_ONE = "image/tower/attr/additional_damage_text.png", -- 技能1文字
    ATTR_SKILL_TWO = nil, -- 技能2文字
}

--[[
    防御塔11对应的图片相关地址
]]
CardImgDef.CARD_11 = {
    SPRITE_1 = "image/tower/sprite/big/tower_11.png", -- 无背景大图
    SPRITE_2 = "image/tower/sprite/small/color/tower_11.png", -- 彩色小图
    SPRITE_3 = "image/tower/sprite/small/grey/tower_11.png", -- 灰色小图
    SPRITE_4 = "image/tower/sprite/medium/tower_11.png", -- 商店中图
    TYPE = CardImgDef.CARD_TYPE.INTERFERE, -- 塔类型角标
    RAR_BG = CardImgDef.CARD_RAR_BG.EPIC, -- 塔稀有度背景
    RAR_TEXT = CardImgDef.CARD_RAR_TEXT.EPIC, -- 塔稀有度文字

    ATTR_TYPE = "image/tower/attr/type_blue_text.png", -- 类型文字
    ATTR_ATK = "image/tower/attr/attack_text.png", -- 攻击力文字
    ATTR_AS = "image/tower/attr/attack_speed_text.png", -- 攻速文字
    ATTR_TARGET = "image/tower/attr/target_text.png", -- 目标文字
    ATTR_SKILL_ONE = "image/tower/attr/accelerate_effect_text.png", -- 技能1文字
    ATTR_SKILL_TWO = nil, -- 技能2文字
}

--[[
    防御塔12对应的图片相关地址
]]
CardImgDef.CARD_12 = {
    SPRITE_1 = "image/tower/sprite/big/tower_12.png", -- 无背景大图
    SPRITE_2 = "image/tower/sprite/small/color/tower_12.png", -- 彩色小图
    SPRITE_3 = "image/tower/sprite/small/grey/tower_12.png", -- 灰色小图
    SPRITE_4 = "image/tower/sprite/medium/tower_12.png", -- 商店中图
    TYPE = CardImgDef.CARD_TYPE.INTERFERE, -- 塔类型角标
    RAR_BG = CardImgDef.CARD_RAR_BG.EPIC, -- 塔稀有度背景
    RAR_TEXT = CardImgDef.CARD_RAR_TEXT.EPIC, -- 塔稀有度文字

    ATTR_TYPE = "image/tower/attr/type_blue_text.png", -- 类型文字
    ATTR_ATK = "image/tower/attr/attack_text.png", -- 攻击力文字
    ATTR_AS = "image/tower/attr/attack_speed_text.png", -- 攻速文字
    ATTR_TARGET = "image/tower/attr/target_text.png", -- 目标文字
    ATTR_SKILL_ONE = nil, -- 技能1文字
    ATTR_SKILL_TWO = nil, -- 技能2文字
}

--[[
    防御塔13对应的图片相关地址
]]
CardImgDef.CARD_13 = {
    SPRITE_1 = "image/tower/sprite/big/tower_13.png", -- 无背景大图
    SPRITE_2 = "image/tower/sprite/small/color/tower_13.png", -- 彩色小图
    SPRITE_3 = "image/tower/sprite/small/grey/tower_13.png", -- 灰色小图
    SPRITE_4 = "image/tower/sprite/medium/tower_13.png", -- 商店中图
    TYPE = CardImgDef.CARD_TYPE.INTERFERE, -- 塔类型角标
    RAR_BG = CardImgDef.CARD_RAR_BG.LEGEND, -- 塔稀有度背景
    RAR_TEXT = CardImgDef.CARD_RAR_TEXT.LEGEND, -- 塔稀有度文字

    ATTR_TYPE = "image/tower/attr/type_blue_text.png", -- 类型文字
    ATTR_ATK = "image/tower/attr/attack_text.png", -- 攻击力文字
    ATTR_AS = "image/tower/attr/attack_speed_text.png", -- 攻速文字
    ATTR_TARGET = "image/tower/attr/target_text.png", -- 目标文字
    ATTR_SKILL_ONE = nil, -- 技能1文字
    ATTR_SKILL_TWO = nil, -- 技能2文字
}

--[[
    防御塔14对应的图片相关地址
]]
CardImgDef.CARD_14 = {
    SPRITE_1 = "image/tower/sprite/big/tower_14.png", -- 无背景大图
    SPRITE_2 = "image/tower/sprite/small/color/tower_14.png", -- 彩色小图
    SPRITE_3 = "image/tower/sprite/small/grey/tower_14.png", -- 灰色小图
    SPRITE_4 = "image/tower/sprite/medium/tower_14.png", -- 商店中图
    TYPE = CardImgDef.CARD_TYPE.ASSIST, -- 塔类型角标
    RAR_BG = CardImgDef.CARD_RAR_BG.RARE, -- 塔稀有度背景
    RAR_TEXT = CardImgDef.CARD_RAR_TEXT.RARE, -- 塔稀有度文字

    ATTR_TYPE = "image/tower/attr/type_blue_text.png", -- 类型文字
    ATTR_ATK = "image/tower/attr/attack_text.png", -- 攻击力文字
    ATTR_AS = "image/tower/attr/attack_speed_text.png", -- 攻速文字
    ATTR_TARGET = "image/tower/attr/target_text.png", -- 目标文字
    ATTR_SKILL_ONE = nil, -- 技能1文字
    ATTR_SKILL_TWO = nil, -- 技能2文字
}

--[[
    防御塔15对应的图片相关地址
]]
CardImgDef.CARD_15 = {
    SPRITE_1 = "image/tower/sprite/big/tower_15.png", -- 无背景大图
    SPRITE_2 = "image/tower/sprite/small/color/tower_15.png", -- 彩色小图
    SPRITE_3 = "image/tower/sprite/small/grey/tower_15.png", -- 灰色小图
    SPRITE_4 = "image/tower/sprite/medium/tower_15.png", -- 商店中图
    TYPE = CardImgDef.CARD_TYPE.ASSIST, -- 塔类型角标
    RAR_BG = CardImgDef.CARD_RAR_BG.RARE, -- 塔稀有度背景
    RAR_TEXT = CardImgDef.CARD_RAR_TEXT.RARE, -- 塔稀有度文字

    ATTR_TYPE = "image/tower/attr/type_blue_text.png", -- 类型文字
    ATTR_ATK = "image/tower/attr/attack_text.png", -- 攻击力文字
    ATTR_AS = "image/tower/attr/attack_speed_text.png", -- 攻速文字
    ATTR_TARGET = "image/tower/attr/target_text.png", -- 目标文字
    ATTR_SKILL_ONE = nil, -- 技能1文字
    ATTR_SKILL_TWO = nil, -- 技能2文字
}

--[[
    防御塔16对应的图片相关地址
]]
CardImgDef.CARD_16 = {
    SPRITE_1 = "image/tower/sprite/big/tower_16.png", -- 无背景大图
    SPRITE_2 = "image/tower/sprite/small/color/tower_16.png", -- 彩色小图
    SPRITE_3 = "image/tower/sprite/small/grey/tower_16.png", -- 灰色小图
    SPRITE_4 = "image/tower/sprite/medium/tower_16.png", -- 商店中图
    TYPE = CardImgDef.CARD_TYPE.ASSIST, -- 塔类型角标
    RAR_BG = CardImgDef.CARD_RAR_BG.EPIC, -- 塔稀有度背景
    RAR_TEXT = CardImgDef.CARD_RAR_TEXT.EPIC, -- 塔稀有度文字

    ATTR_TYPE = "image/tower/attr/type_blue_text.png", -- 类型文字
    ATTR_ATK = "image/tower/attr/attack_text.png", -- 攻击力文字
    ATTR_AS = "image/tower/attr/attack_speed_text.png", -- 攻速文字
    ATTR_TARGET = "image/tower/attr/target_text.png", -- 目标文字
    ATTR_SKILL_ONE = nil, -- 技能1文字
    ATTR_SKILL_TWO = "image/tower/attr/growth_time_text.png", -- 技能2文字
}

--[[
    防御塔17对应的图片相关地址
]]
CardImgDef.CARD_17 = {
    SPRITE_1 = "image/tower/sprite/big/tower_17.png", -- 无背景大图
    SPRITE_2 = "image/tower/sprite/small/color/tower_17.png", -- 彩色小图
    SPRITE_3 = "image/tower/sprite/small/grey/tower_17.png", -- 灰色小图
    SPRITE_4 = "image/tower/sprite/medium/tower_17.png", -- 商店中图
    TYPE = CardImgDef.CARD_TYPE.ASSIST, -- 塔类型角标
    RAR_BG = CardImgDef.CARD_RAR_BG.EPIC, -- 塔稀有度背景
    RAR_TEXT = CardImgDef.CARD_RAR_TEXT.EPIC, -- 塔稀有度文字

    ATTR_TYPE = "image/tower/attr/type_blue_text.png", -- 类型文字
    ATTR_ATK = "image/tower/attr/attack_text.png", -- 攻击力文字
    ATTR_AS = "image/tower/attr/attack_speed_text.png", -- 攻速文字
    ATTR_TARGET = "image/tower/attr/target_text.png", -- 目标文字
    ATTR_SKILL_ONE = nil, -- 技能1文字
    ATTR_SKILL_TWO = nil, -- 技能2文字
}

--[[
    防御塔18对应的图片相关地址
]]
CardImgDef.CARD_18 = {
    SPRITE_1 = "image/tower/sprite/big/tower_18.png", -- 无背景大图
    SPRITE_2 = "image/tower/sprite/small/color/tower_18.png", -- 彩色小图
    SPRITE_3 = "image/tower/sprite/small/grey/tower_18.png", -- 灰色小图
    SPRITE_4 = "image/tower/sprite/medium/tower_18.png", -- 商店中图
    TYPE = CardImgDef.CARD_TYPE.ASSIST, -- 塔类型角标
    RAR_BG = CardImgDef.CARD_RAR_BG.NORMAL, -- 塔稀有度背景
    RAR_TEXT = CardImgDef.CARD_RAR_TEXT.NORMAL, -- 塔稀有度文字

    ATTR_TYPE = "image/tower/attr/type_blue_text.png", -- 类型文字
    ATTR_ATK = "image/tower/attr/attack_text.png", -- 攻击力文字
    ATTR_AS = "image/tower/attr/attack_speed_text.png", -- 攻速文字
    ATTR_TARGET = "image/tower/attr/target_text.png", -- 目标文字
    ATTR_SKILL_ONE = "image/tower/attr/increase_damage_effect_text.png", -- 技能1文字
    ATTR_SKILL_TWO = nil, -- 技能2文字
}

--[[
    防御塔19对应的图片相关地址
]]
CardImgDef.CARD_19 = {
    SPRITE_1 = "image/tower/sprite/big/tower_19.png", -- 无背景大图
    SPRITE_2 = "image/tower/sprite/small/color/tower_19.png", -- 彩色小图
    SPRITE_3 = "image/tower/sprite/small/grey/tower_19.png", -- 灰色小图
    SPRITE_4 = "image/tower/sprite/medium/tower_19.png", -- 商店中图
    TYPE = CardImgDef.CARD_TYPE.CONTROL, -- 塔类型角标
    RAR_BG = CardImgDef.CARD_RAR_BG.LEGEND, -- 塔稀有度背景
    RAR_TEXT = CardImgDef.CARD_RAR_TEXT.LEGEND, -- 塔稀有度文字

    ATTR_TYPE = "image/tower/attr/type_blue_text.png", -- 类型文字
    ATTR_ATK = "image/tower/attr/attack_text.png", -- 攻击力文字
    ATTR_AS = "image/tower/attr/attack_speed_text.png", -- 攻速文字
    ATTR_TARGET = "image/tower/attr/target_text.png", -- 目标文字
    ATTR_SKILL_ONE = "image/tower/attr/skill_slow_down_text.png", -- 技能1文字
    ATTR_SKILL_TWO = "image/tower/attr/skill_onset_time_text.png", -- 技能2文字
}

--[[
    防御塔20对应的图片相关地址
]]
CardImgDef.CARD_20 = {
    SPRITE_1 = "image/tower/sprite/big/tower_20.png", -- 无背景大图
    SPRITE_2 = "image/tower/sprite/small/color/tower_20.png", -- 彩色小图
    SPRITE_3 = "image/tower/sprite/small/grey/tower_20.png", -- 灰色小图
    SPRITE_4 = "image/tower/sprite/medium/tower_20.png", -- 商店中图
    TYPE = CardImgDef.CARD_TYPE.CONTROL, -- 塔类型角标
    RAR_BG = CardImgDef.CARD_RAR_BG.NORMAL, -- 塔稀有度背景
    RAR_TEXT = CardImgDef.CARD_RAR_TEXT.NORMAL, -- 塔稀有度文字

    ATTR_TYPE = "image/tower/attr/type_blue_text.png", -- 类型文字
    ATTR_ATK = "image/tower/attr/attack_text.png", -- 攻击力文字
    ATTR_AS = "image/tower/attr/attack_speed_text.png", -- 攻速文字
    ATTR_TARGET = "image/tower/attr/target_text.png", -- 目标文字
    ATTR_SKILL_ONE = "image/tower/attr/skill_time_text.png", -- 技能1文字
    ATTR_SKILL_TWO = "image/tower/attr/skill_onset_time_text.png", -- 技能2文字
}


return CardImgDef