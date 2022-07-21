--[[
    Card5.lua
    卡牌5
    描述：卡牌5的定义
    编写：李昊
    修订：周星宇
    检查：张昊煜
]]

local Card5 = class("Card5",require("src.app.data.card.CardBase"))
local CardImgDef = require("app.def.CardImgDef")
local CardInfoDef = require("app.def.CardInfoDef")

--[[
    构造函数
    @param x,y
    @return none
]]
function Card5:ctor(x, y, th, enhanceLevel, starLevel)
    Card5.super.ctor(self, x, y, th , enhanceLevel, starLevel)
end

--[[
    注册信息函数
    @param none
    @return none
]]
function Card5:init()
    Card5.super:init()
    -- 基本信息
    self.id_ = CardInfoDef.CARD_ID.CARD_5
    self.name_ = CardInfoDef.CARD_ID.CARD_5
    self.type_ = CardInfoDef.CARD_TYPE.ATTACK
    self.rarity_ = CardInfoDef.CARD_RAR.LEGEND
    self.intro_ = CardInfoDef.CARD_SKILL_INTRO.CARD_5
    self.target_ = CardInfoDef.CARD_ATTACK_SCOPE.FRONT

    -- 图片信息
    self.imgDef_ = CardImgDef.CARD_5

    -- 属性信息
    self.atk_ = 20
    self.atkUpgradedDelta_ = 3
    self.atkEnhancedDelta_ = 30
    self.fireCd_ = 0.6
    self.fireCdUpgradedDelta_ = nil
    self.skillOne_ = "初次变身时间"
    self.skillOneValue_ = 6
    self.skillOneUpgradedDelta_ = nil
    self.skillOneEnhancedDelta_ = nil
    self.skillTwo_ = "二次变身时间"
    self.skillTwoValue_ = 4

    -- 初始化等级
    self:initLevel()

end

return Card5