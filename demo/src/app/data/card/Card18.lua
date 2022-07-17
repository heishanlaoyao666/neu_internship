--[[
    Card18.lua
    卡牌18
    描述：卡牌18的定义
    编写：李昊
    修订：周星宇
    检查：张昊煜
]]

local Card18 = class("Card18",require("src.app.data.card.CardBase"))
local CardImgDef = require("app.def.CardImgDef")
local CardInfoDef = require("app.def.CardInfoDef")

--[[
    构造函数
    @param x,y
    @return none
]]
function Card18:ctor(x, y, th, enhanceLevel, starLevel)
    Card18.super.ctor(self, x, y, th , enhanceLevel, starLevel)
end

--[[
    注册信息函数
    @param none
    @return none
]]
function Card18:init()
    Card18.super:init()
    -- 基本信息
    self.id_ = CardInfoDef.CARD_ID.CARD_18
    self.name_ = CardInfoDef.CARD_ID.CARD_18
    self.type_ = CardInfoDef.CARD_TYPE.ASSIST
    self.rarity_ = CardInfoDef.CARD_RAR.NORMAL
    self.intro_ = CardInfoDef.CARD_SKILL_INTRO.CARD_18
    self.target_ = CardInfoDef.CARD_ATTACK_SCOPE.RAND

    -- 图片信息
    self.imgDef_ = CardImgDef.CARD_18

    -- 属性信息
    self.atk_ = 30
    self.atkUpgradedDelta_ = 5
    self.atkEnhancedDelta_ = 10
    self.fireCd_ = 1
    self.fireCdUpgradedDelta_ = nil
    self.skillOne_ = "增伤效果"
    self.skillOneValue_ = 0.1
    self.skillOneUpgradedDelta_ = 0.01
    self.skillOneEnhancedDelta_ = 0.05
    self.skillTwo_ = nil
    self.skillTwoValue_ = nil

    -- 初始化等级
    self:initLevel()

end

return Card18