--[[
    Card20.lua
    卡牌20
    描述：卡牌20的定义
    编写：李昊
    修订：周星宇
    检查：张昊煜
]]

local Card20 = class("Card20",require("src.app.data.card.CardBase"))
local CardImgDef = require("app.def.CardImgDef")
local CardInfoDef = require("app.def.CardInfoDef")

--[[
    构造函数
    @param x,y
    @return none
]]
function Card20:ctor(x, y, th, enhanceLevel, starLevel)
    Card20.super.ctor(self, x, y, th , enhanceLevel, starLevel)
end

--[[
    注册信息函数
    @param none
    @return none
]]
function Card20:init()
    Card20.super:init()
    -- 基本信息
    self.id_ = CardInfoDef.CARD_ID.CARD_20
    self.name_ = CardInfoDef.CARD_ID.CARD_20
    self.type_ = CardInfoDef.CARD_TYPE.CONTROL
    self.rarity_ = CardInfoDef.CARD_RAR.NORMAL
    self.intro_ = CardInfoDef.CARD_SKILL_INTRO.CARD_20
    self.target_ = CardInfoDef.CARD_ATTACK_SCOPE.RAND

    -- 图片信息
    self.imgDef_ = CardImgDef.CARD_20

    -- 属性信息
    self.atk_ = 20
    self.atkUpgradedDelta_ = 5
    self.atkEnhancedDelta_ = 20
    self.fireCd_ = 1
    self.fireCdUpgradedDelta_ = -0.02
    self.skillOne_ = "技能持续时间"
    self.skillOneValue_ = 2
    self.skillOneUpgradedDelta_ = 0.5
    self.skillOneEnhancedDelta_ = 0.5
    self.skillTwo_ = "技能发动时间"
    self.skillTwoValue_ = 10

    -- 初始化等级
    self:initLevel()

end

return Card20