--[[
    Card16.lua
    卡牌16
    描述：卡牌16的定义
    编写：李昊
    修订：周星宇
    检查：张昊煜
]]

local Card16 = class("Card16",require("src.app.data.card.CardBase"))
local CardImgDef = require("app.def.CardImgDef")
local CardInfoDef = require("app.def.CardInfoDef")

--[[
    构造函数
    @param x,y
    @return none
]]
function Card16:ctor(x, y, th, enhanceLevel, starLevel)
    Card16.super.ctor(self, x, y, th , enhanceLevel, starLevel)
end

--[[
    注册信息函数
    @param none
    @return none
]]
function Card16:init()
    Card16.super:init()
    -- 基本信息
    self.id_ = CardInfoDef.CARD_ID.CARD_16
    self.name_ = CardInfoDef.CARD_ID.CARD_16
    self.type_ = CardInfoDef.CARD_TYPE.ASSIST
    self.rarity_ = CardInfoDef.CARD_RAR.EPIC
    self.intro_ = CardInfoDef.CARD_SKILL_INTRO.CARD_16
    self.target_ = CardInfoDef.CARD_ATTACK_SCOPE.FRONT

    -- 图片信息
    self.imgDef_ = CardImgDef.CARD_16

    -- 属性信息
    self.atk_ = 10
    self.atkUpgradedDelta_ = 5
    self.atkEnhancedDelta_ = 10
    self.fireCd_ = 2
    self.fireCdUpgradedDelta_ = nil
    self.skillOne_ = nil
    self.skillOneValue_ = nil
    self.skillOneUpgradedDelta_ = nil
    self.skillOneEnhancedDelta_ = nil
    self.skillTwo_ = "成长时间"
    self.skillTwoValue_ = 15

    -- 初始化等级
    self:initLevel()

end

return Card16