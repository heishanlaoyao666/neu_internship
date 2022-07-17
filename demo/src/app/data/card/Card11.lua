--[[
    Card11.lua
    卡牌11
    描述：卡牌11的定义
    编写：李昊
    修订：周星宇
    检查：张昊煜
]]

local Card11 = class("Card11",require("src.app.data.card.CardBase"))
local CardImgDef = require("app.def.CardImgDef")
local CardInfoDef = require("app.def.CardInfoDef")

--[[
    构造函数
    @param x,y
    @return none
]]
function Card11:ctor(x, y, th, enhanceLevel, starLevel)
    Card11.super.ctor(self, x, y, th , enhanceLevel, starLevel)
end

--[[
    注册信息函数
    @param none
    @return none
]]
function Card11:init()
    Card11.super:init()
    -- 基本信息
    self.id_ = CardInfoDef.CARD_ID.CARD_11
    self.name_ = CardInfoDef.CARD_ID.CARD_11
    self.type_ = CardInfoDef.CARD_TYPE.INTERFERE
    self.rarity_ = CardInfoDef.CARD_RAR.EPIC
    self.intro_ = CardInfoDef.CARD_SKILL_INTRO.CARD_11
    self.target_ = CardInfoDef.CARD_ATTACK_SCOPE.FRONT

    -- 图片信息
    self.imgDef_ = CardImgDef.CARD_11

    -- 属性信息
    self.atk_ = 10
    self.atkUpgradedDelta_ = 5
    self.atkEnhancedDelta_ = 10
    self.fireCd_ = 0.8
    self.fireCdUpgradedDelta_ = -0.02
    self.skillOne_ = "加速效果"
    self.skillOneValue_ = 0.05
    self.skillOneUpgradedDelta_ = nil
    self.skillOneEnhancedDelta_ = nil
    self.skillTwo_ = nil
    self.skillTwoValue_ = nil

    -- 初始化等级
    self:initLevel()

end

return Card11