--[[
    Card12.lua
    卡牌12
    描述：卡牌12的定义
    编写：李昊
    修订：周星宇
    检查：张昊煜
]]

local Card12 = class("Card12",require("src.app.data.card.CardBase"))
local CardImgDef = require("app.def.CardImgDef")
local CardInfoDef = require("app.def.CardInfoDef")

--[[
    构造函数
    @param x,y
    @return none
]]
function Card12:ctor(x, y, th, enhanceLevel, starLevel)
    Card12.super.ctor(self, x, y, th , enhanceLevel, starLevel)
end

--[[
    注册信息函数
    @param none
    @return none
]]
function Card12:init()
    Card12.super:init()
    -- 基本信息
    self.id_ = CardInfoDef.CARD_ID.CARD_12
    self.name_ = CardInfoDef.CARD_ID.CARD_12
    self.type_ = CardInfoDef.CARD_TYPE.INTERFERE
    self.rarity_ = CardInfoDef.CARD_RAR.EPIC
    self.intro_ = CardInfoDef.CARD_SKILL_INTRO.CARD_12
    self.target_ = CardInfoDef.CARD_ATTACK_SCOPE.FRONT

    -- 图片信息
    self.imgDef_ = CardImgDef.CARD_12

    -- 属性信息
    self.atk_ = 30
    self.atkUpgradedDelta_ = nil
    self.atkEnhancedDelta_ = nil
    self.fireCd_ = 0.8
    self.fireCdUpgradedDelta_ = nil
    self.skillOne_ = nil
    self.skillOneValue_ = nil
    self.skillOneUpgradedDelta_ = nil
    self.skillOneEnhancedDelta_ = nil
    self.skillTwo_ = nil
    self.skillTwoValue_ = nil

    -- 初始化等级
    self:initLevel()

end

return Card12