--[[
    Card1.lua
    卡牌1
    描述：卡牌1的定义
    编写：李昊
    修订：周星宇
    检查：张昊煜
]]

local Card1 = class("Card1",require("src.app.data.card.CardBase"))
local CardImgDef = require("app.def.CardImgDef")
local CardInfoDef = require("app.def.CardInfoDef")

--[[
    构造函数
    @param x,y
    @return none
]]
function Card1:ctor(x, y, th, enhanceLevel, starLevel)
    Card1.super.ctor(self, x, y, th , enhanceLevel, starLevel)
end

--[[
    注册信息函数
    @param none
    @return none
]]
function Card1:init()
    Card1.super:init()
    -- 基本信息
    self.id_ = CardInfoDef.CARD_ID.CARD_1
    self.name_ = CardInfoDef.CARD_ID.CARD_1
    self.type_ = CardInfoDef.CARD_TYPE.ATTACK
    self.rarity_ = CardInfoDef.CARD_RAR.NORMAL
    self.intro_ = CardInfoDef.CARD_SKILL_INTRO.CARD_1
    self.target_ = CardInfoDef.CARD_ATTACK_SCOPE.FRONT

    -- 图片信息
    self.imgDef_ = CardImgDef.CARD_1

    -- 属性信息
    self.atk_ = 20
    self.atkUpgradedDelta_ = 3
    self.atkEnhancedDelta_ = 10
    self.fireCd_ = 0.8
    self.fireCdUpgradedDelta_ = -0.01
    self.skillOne_ = "额外伤害"
    self.skillOneValue_ = 20
    self.skillOneUpgradedDelta_ = 3
    self.skillOneEnhancedDelta_ = 20
    self.skillTwo_ = nil
    self.skillTwoValue_ = nil

    -- 初始化等级
    self:initLevel()


end

return Card1