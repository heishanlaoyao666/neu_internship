--[[
    Card3.lua
    卡牌3
    描述：卡牌3的定义
    编写：李昊
    修订：周星宇
    检查：张昊煜
]]

local Card3 = class("Card3",require("src.app.data.card.CardBase"))
local CardImgDef = require("app.def.CardImgDef")
local CardInfoDef = require("app.def.CardInfoDef")

--[[
    构造函数
    @param x,y
    @return none
]]
function Card3:ctor(x, y, th, enhanceLevel, starLevel)
    Card3.super.ctor(self, x, y, th , enhanceLevel, starLevel)
end

--[[
    注册信息函数
    @param none
    @return none
]]
function Card3:init()
    Card3.super:init()
    -- 基本信息
    self.id_ = CardInfoDef.CARD_ID.CARD_3
    self.name_ = CardInfoDef.CARD_ID.CARD_3
    self.type_ = CardInfoDef.CARD_TYPE.ATTACK
    self.rarity_ = CardInfoDef.CARD_RAR.RARE
    self.intro_ = CardInfoDef.CARD_SKILL_INTRO.CARD_3
    self.target_ = CardInfoDef.CARD_ATTACK_SCOPE.FRONT

    -- 图片信息
    self.imgDef_ = CardImgDef.CARD_3

    -- 属性信息
    self.atk_ = 40
    self.atkUpgradedDelta_ = 8
    self.atkEnhancedDelta_ = 20
    self.fireCd_ = 0.8
    self.fireCdUpgradedDelta_ = -0.01
    self.skillOne_ = "额外伤害"
    self.skillOneValue_ = 120
    self.skillOneUpgradedDelta_ = 24
    self.skillOneEnhancedDelta_ = 40
    self.skillTwo_ = nil
    self.skillTwoValue_ = nil

    -- 初始化等级
    self:initLevel()


end

return Card3