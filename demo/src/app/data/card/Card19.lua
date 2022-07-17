--[[
    Card19.lua
    卡牌19
    描述：卡牌19的定义
    编写：李昊
    修订：周星宇
    检查：张昊煜
]]

local Card19 = class("Card19",require("src.app.data.card.CardBase"))
local CardImgDef = require("app.def.CardImgDef")
local CardInfoDef = require("app.def.CardInfoDef")

--[[
    构造函数
    @param x,y
    @return none
]]
function Card19:ctor(x, y, th, enhanceLevel, starLevel)
    Card19.super.ctor(self, x, y, th , enhanceLevel, starLevel)
end

--[[
    注册信息函数
    @param none
    @return none
]]
function Card19:init()
    Card19.super:init()
    -- 基本信息
    self.id_ = CardInfoDef.CARD_ID.CARD_19
    self.name_ = CardInfoDef.CARD_ID.CARD_19
    self.type_ = CardInfoDef.CARD_TYPE.CONTROL
    self.rarity_ = CardInfoDef.CARD_RAR.LEGEND
    self.intro_ = CardInfoDef.CARD_SKILL_INTRO.CARD_19
    self.target_ = CardInfoDef.CARD_ATTACK_SCOPE.FRONT

    -- 图片信息
    self.imgDef_ = CardImgDef.CARD_19

    -- 属性信息
    self.atk_ = 60
    self.atkUpgradedDelta_ = 5
    self.atkEnhancedDelta_ = 20
    self.fireCd_ = 2
    self.fireCdUpgradedDelta_ = nil
    self.skillOne_ = "技能减速效果"
    self.skillOneValue_ = 0.05
    self.skillOneUpgradedDelta_ = 0.005
    self.skillOneEnhancedDelta_ = 0.01
    self.skillTwo_ = "技能发动时间"
    self.skillTwoValue_ = 10

    -- 初始化等级
    self:initLevel()

end

return Card19