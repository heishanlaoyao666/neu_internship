--[[
    Card4.lua
    卡牌4
    描述：卡牌4的定义
    编写：李昊
    修订：周星宇
    检查：张昊煜
]]

local Card4 = class("Card4",require("src.app.data.card.CardBase"))
local CardImgDef = require("app.def.CardImgDef")
local CardInfoDef = require("app.def.CardInfoDef")

--[[
    构造函数
    @param x,y
    @return none
]]
function Card4:ctor(x, y, th, enhanceLevel, starLevel)
    Card4.super.ctor(self, x, y, th , enhanceLevel, starLevel)
end

--[[
    注册信息函数
    @param none
    @return none
]]
function Card4:init()
    Card4.super:init()
    -- 基本信息
    self.id_ = CardInfoDef.CARD_ID.CARD_4
    self.name_ = CardInfoDef.CARD_ID.CARD_4
    self.type_ = CardInfoDef.CARD_TYPE.ATTACK
    self.rarity_ = CardInfoDef.CARD_RAR.NORMAL
    self.intro_ = CardInfoDef.CARD_SKILL_INTRO.CARD_4
    self.target_ = CardInfoDef.CARD_ATTACK_SCOPE.MAX_LIFE

    -- 图片信息
    self.imgDef_ = CardImgDef.CARD_4

    -- 属性信息
    self.atk_ = 100
    self.atkUpgradedDelta_ = 10
    self.atkEnhancedDelta_ = 100
    self.fireCd_ = 1
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

return Card4