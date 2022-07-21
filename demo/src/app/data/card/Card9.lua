--[[
    Card9.lua
    卡牌9
    描述：卡牌9的定义
    编写：李昊
    修订：周星宇
    检查：张昊煜
]]

local Card9 = class("Card9",require("src.app.data.card.CardBase"))
local CardImgDef = require("app.def.CardImgDef")
local CardInfoDef = require("app.def.CardInfoDef")

--[[
    构造函数
    @param x,y
    @return none
]]
function Card9:ctor(x, y, th, enhanceLevel, starLevel)
    Card9.super.ctor(self, x, y, th , enhanceLevel, starLevel)
end

--[[
    注册信息函数
    @param none
    @return none
]]
function Card9:init()
    Card9.super:init()
    -- 基本信息
    self.id_ = CardInfoDef.CARD_ID.CARD_9
    self.name_ = CardInfoDef.CARD_ID.CARD_9
    self.type_ = CardInfoDef.CARD_TYPE.ATTACK
    self.rarity_ = CardInfoDef.CARD_RAR.NORMAL
    self.intro_ = CardInfoDef.CARD_SKILL_INTRO.CARD_9
    self.target_ = CardInfoDef.CARD_ATTACK_SCOPE.RAND

    -- 图片信息
    self.imgDef_ = CardImgDef.CARD_9

    -- 属性信息
    self.atk_ = 20
    self.atkUpgradedDelta_ = 4
    self.atkEnhancedDelta_ = nil
    self.fireCd_ = 1.2
    self.fireCdUpgradedDelta_ = nil
    self.skillOne_ = "攻击致死概率"
    self.skillOneValue_ = 0.02
    self.skillOneUpgradedDelta_ = 0.002
    self.skillOneEnhancedDelta_ = 0.005
    self.skillTwo_ = nil
    self.skillTwoValue_ = nil

    -- 初始化等级
    self:initLevel()

end

return Card9