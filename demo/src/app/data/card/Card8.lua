--[[
    Card8.lua
    卡牌8
    描述：卡牌8的定义
    编写：李昊
    修订：周星宇
    检查：张昊煜
]]

local Card8 = class("Card8",require("src.app.data.card.CardBase"))
local CardImgDef = require("app.def.CardImgDef")
local CardInfoDef = require("app.def.CardInfoDef")

--[[
    构造函数
    @param x,y
    @return none
]]
function Card8:ctor(x, y, th, enhanceLevel, starLevel)
    Card8.super.ctor(self, x, y, th , enhanceLevel, starLevel)
end

--[[
    注册信息函数
    @param none
    @return none
]]
function Card8:init()
    Card8.super:init()
    -- 基本信息
    self.id_ = CardInfoDef.CARD_ID.CARD_8
    self.name_ = CardInfoDef.CARD_ID.CARD_8
    self.type_ = CardInfoDef.CARD_TYPE.ATTACK
    self.rarity_ = CardInfoDef.CARD_RAR.EPIC
    self.intro_ = CardInfoDef.CARD_SKILL_INTRO.CARD_8
    self.target_ = CardInfoDef.CARD_ATTACK_SCOPE.FRONT

    -- 图片信息
    self.imgDef_ = CardImgDef.CARD_8

    -- 属性信息
    self.atk_ = 10
    self.atkUpgradedDelta_ = 10
    self.atkEnhancedDelta_ = 10
    self.fireCd_ = 1.0
    self.fireCdUpgradedDelta_ = nil
    self.skillOne_ = "攻击力加成"
    self.skillOneValue_ = 20
    self.skillOneUpgradedDelta_ = 1
    self.skillOneEnhancedDelta_ = nil
    self.skillTwo_ = nil
    self.skillTwoValue_ = nil

    -- 初始化等级
    self:initLevel()

end

return Card8