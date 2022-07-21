--[[
    Card7.lua
    卡牌7
    描述：卡牌7的定义
    编写：李昊
    修订：周星宇
    检查：张昊煜
]]

local Card7 = class("Card7",require("src.app.data.card.CardBase"))
local CardImgDef = require("app.def.CardImgDef")
local CardInfoDef = require("app.def.CardInfoDef")

--[[
    构造函数
    @param x,y
    @return none
]]
function Card7:ctor(x, y, th, enhanceLevel, starLevel)
    Card7.super.ctor(self, x, y, th , enhanceLevel, starLevel)
end

--[[
    注册信息函数
    @param none
    @return none
]]
function Card7:init()
    Card7.super:init()
    -- 基本信息
    self.id_ = CardInfoDef.CARD_ID.CARD_7
    self.name_ = CardInfoDef.CARD_ID.CARD_7
    self.type_ = CardInfoDef.CARD_TYPE.ATTACK
    self.rarity_ = CardInfoDef.CARD_RAR.NORMAL
    self.intro_ = CardInfoDef.CARD_SKILL_INTRO.CARD_7
    self.target_ = CardInfoDef.CARD_ATTACK_SCOPE.FRONT

    -- 图片信息
    self.imgDef_ = CardImgDef.CARD_7

    -- 属性信息
    self.atk_ = 20
    self.atkUpgradedDelta_ = 3
    self.atkEnhancedDelta_ = 15
    self.fireCd_ = 0.45
    self.fireCdUpgradedDelta_ = nil
    self.skillOne_ = "攻速加强"
    self.skillOneValue_ = 0.1
    self.skillOneUpgradedDelta_ = 0.02
    self.skillOneEnhancedDelta_ = nil
    self.skillTwo_ = nil
    self.skillTwoValue_ = nil

    -- 初始化等级
    self:initLevel()

end

return Card7