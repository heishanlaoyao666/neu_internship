--[[
    Card6.lua
    卡牌6
    描述：卡牌6的定义
    编写：李昊
    修订：周星宇
    检查：张昊煜
]]

local Card6 = class("Card6",require("src.app.data.card.CardBase"))
local CardImgDef = require("app.def.CardImgDef")
local CardInfoDef = require("app.def.CardInfoDef")

--[[
    构造函数
    @param x,y
    @return none
]]
function Card6:ctor(x, y, th, enhanceLevel, starLevel)
    Card6.super.ctor(self, x, y, th , enhanceLevel, starLevel)
end

--[[
    注册信息函数
    @param none
    @return none
]]
function Card6:init()
    Card6.super:init()
    -- 基本信息
    self.id_ = CardInfoDef.CARD_ID.CARD_6
    self.name_ = CardInfoDef.CARD_ID.CARD_6
    self.type_ = CardInfoDef.CARD_TYPE.ATTACK
    self.rarity_ = CardInfoDef.CARD_RAR.LEGEND
    self.intro_ = CardInfoDef.CARD_SKILL_INTRO.CARD_6
    self.target_ = CardInfoDef.CARD_ATTACK_SCOPE.FRONT

    -- 图片信息
    self.imgDef_ = CardImgDef.CARD_6

    -- 属性信息
    self.atk_ = 35
    self.atkUpgradedDelta_ = 5
    self.atkEnhancedDelta_ = 11
    self.fireCd_ = 1.2
    self.fireCdUpgradedDelta_ = nil
    self.skillOne_ = "额外伤害"
    self.skillOneValue_ = 35
    self.skillOneUpgradedDelta_ = 5
    self.skillOneEnhancedDelta_ = 10.5
    self.skillTwo_ = nil
    self.skillTwoValue_ = nil

    -- 初始化等级
    self:initLevel()

end

return Card6