--[[
    Card10.lua
    卡牌10
    描述：卡牌10的定义
    编写：李昊
    修订：周星宇
    检查：张昊煜
]]

local Card10 = class("Card10",require("src.app.data.card.CardBase"))
local CardImgDef = require("app.def.CardImgDef")
local CardInfoDef = require("app.def.CardInfoDef")

--[[
    构造函数
    @param x,y
    @return none
]]
function Card10:ctor(x, y, th, enhanceLevel, starLevel)
    Card10.super.ctor(self, x, y, th , enhanceLevel, starLevel)
end

--[[
    注册信息函数
    @param none
    @return none
]]
function Card10:init()
    Card10.super:init()
    -- 基本信息
    self.id_ = CardInfoDef.CARD_ID.CARD_10
    self.name_ = CardInfoDef.CARD_ID.CARD_10
    self.type_ = CardInfoDef.CARD_TYPE.ATTACK
    self.rarity_ = CardInfoDef.CARD_RAR.RARE
    self.intro_ = CardInfoDef.CARD_SKILL_INTRO.CARD_10
    self.target_ = CardInfoDef.CARD_ATTACK_SCOPE.RAND

    -- 图片信息
    self.imgDef_ = CardImgDef.CARD_10

    -- 属性信息
    self.atk_ = 30
    self.atkUpgradedDelta_ = 2
    self.atkEnhancedDelta_ = 10
    self.fireCd_ = 1.3
    self.fireCdUpgradedDelta_ = nil
    self.skillOne_ = "额外伤害"
    self.skillOneValue_ = 50
    self.skillOneUpgradedDelta_ = 5
    self.skillOneEnhancedDelta_ = 20
    self.skillTwo_ = nil
    self.skillTwoValue_ = nil

    -- 初始化等级
    self:initLevel()

end

return Card10