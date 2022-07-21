--[[
    CardBase.lua
    卡牌的父类
    描述：在player中储存信息
    编写：李昊
    修订：周星宇
    检查：张昊煜
]]
local CardBase  = class("CardBase",require("src.app.data.Object"))
local CardImgDef = require("app.def.CardImgDef")
local CardInfoDef = require("app.def.CardInfoDef")
local EventManager = require("app.manager.EventManager")
local EventDef = require("app.def.EventDef")

--[[
    构造函数
    @param x,y,name
    @return none
]]
function CardBase:ctor(x, y, th ,intensify,starLevel)
    CardBase.super.ctor(self, x, y)

    -- 塔基本信息
    self.th_ = th --塔序号
    self.id_ = "" -- 塔编号
    self.name_ = "" -- 塔名称
    self.num_ = 0 -- 碎片数量
    self.level_ = 1 -- 塔的等级
    self.intensify_ = 1 -- 塔的强化等级
    self.type_ = "" -- 塔类型
    self.rarity_ = "" -- 塔的稀有度
    self.intro_ = "" -- 塔的介绍
    self.target_ = "" -- 塔的攻击目标
    self.starLevel_ = starLevel -- 塔星级
    self.isMove_ = false

    -- 塔属性信息
    self.atk_ = nil
    self.atkUpgradedDelta_ = nil
    self.atkEnhancedDelta_ = nil
    self.fireCd_ = nil
    self.fireCdUpgradedDelta_ = nil
    self.skillOne_ = nil
    self.skillOneValue_ = nil
    self.skillOneUpgradedDelta_ = nil
    self.skillOneEnhancedDelta_ = nil
    self.skillTwo_ = nil
    self.skillTwoValue_ = nil

    -- 塔图片信息
    self.imgDef_ = nil

    self:init()

    EventManager:doEvent(EventDef.ID.CARD_CREATE,self)
    EventManager:doEvent(EventDef.ID.CARD_ENHANCE_LEVEL_CREATE,self)

end

--[[
    init函数
    @param none
    @return none
]]
function CardBase:init()

end

--[[
    update函数
    @param data
    @return none
]]
function CardBase:update(data)
    self.x_ = data.x
    self.y_ = data.y
end

--[[
    isMove
    @param data
    @return none
]]
function CardBase:isMove()
    return self.isMove_
end

--[[
    setIsMove
    @param isMove
    @return none
]]
function CardBase:setIsMove(isMove)
    self.isMove_ = isMove
end

--[[
    getTh函数
    @param none
    @return 序号值
]]
function CardBase:getTh()
    return self.th_
end

--[[
    destroy函数
    @param none
    @return none
]]
function CardBase:destroy()
    EventManager:doEvent(EventDef.ID.CARD_DEATH,self)
    EventManager:doEvent(EventDef.ID.CARD_ENHANCE_LEVEL_DEATH,self)
end

--[[
    初始化等级
    @param none
    @return none
]]
function CardBase:initLevel()
    if self.rarity_ == CardInfoDef.CARD_RAR.NORMAL then
        self.level_ = 1
    elseif self.rarity_ == CardInfoDef.CARD_RAR.RARE then
        self.level_ = 3
    elseif self.rarity_ == CardInfoDef.CARD_RAR.EPIC then
        self.level_ = 5
    elseif self.rarity_ == CardInfoDef.CARD_RAR.LEGEND then
        self.level_ = 9
    end
end

--- 塔基本信息相关函数

--[[
    获取塔的编号
    @param none
    @return string
]]
function CardBase:getId()
    return self.id_
end

--[[
    获取塔的名称
    @param none
    @return string
]]
function CardBase:getName()
    return self.name_
end

--[[
    获取塔的数量
    @param none
    @return number
]]
function CardBase:getNum()
    return self.num_
end

--[[
    设置塔的数量
    @param number
    @return number
]]
function CardBase:setNum(num)
    self.num_ = num
end

--[[
    获取塔的等级
    @param none
    @return number
]]
function CardBase:getLevel()
    return self.level_
end

--[[
    设置塔的等级
    @param number
    @return number
]]
function CardBase:setLevel(level)
    self.level_ = level
end

--[[
    获取塔的强化等级
    @param none
    @return number
]]
function CardBase:getIntensify()
    return self.intensify_
end

--[[
    设置塔的强化等级
    @param number
    @return number
]]
function CardBase:setIntensify(intensify)
    self.intensify_ = intensify
end

--[[
    获取塔的类型
    @param none
    @return number
]]
function CardBase:getType()
    return self.type_
end

--[[
    获取塔的稀有度
    @param none
    @return number
]]
function CardBase:getRarity()
    return self.rarity_
end

--[[
    获取塔的简介
    @param none
    @return string
]]
function CardBase:getIntro()
    return self.intro_
end

--[[
    获取塔的攻击目标
    @param none
    @return string
]]
function CardBase:getTarget()
    return self.target_
end

--[[
    获取攻击力强化增量
    @param none
    @return string
]]
function CardBase:getAtkEnhancedDelta()
    return self.atkEnhancedDelta_
end

--[[
    获取一技能强化增量
    @param none
    @return string
]]
function CardBase:getSkillOneEnhancedDelta()
    return self.skillOneEnhancedDelta_
end

--[[
    获取二技能数值
    @param none
    @return number
]]
function CardBase:getSkillTwoValue()
    return self.type_
end

--- 塔图片信息相关函数

--[[
    获取塔的大图
    @param none
    @return string
]]
function CardBase:getBigSpriteImg()
    return self.imgDef_.SPRITE_1
end

--[[
    获取塔的小图
    @param none
    @return string
]]
function CardBase:getSmallSpriteImg()

    if self:ifCardObtained() then -- 如果已拥有卡牌
        return self.imgDef_.SPRITE_2
    else
        return self.imgDef_.SPRITE_3
    end

end

--[[
    获取塔的彩色小图
    @param none
    @return string
]]
function CardBase:getSmallColorSpriteImg()
    return self.imgDef_.SPRITE_2
end

--[[
    获取塔的灰色小图
    @param none
    @return string
]]
function CardBase:getSmallGreySpriteImg()
    return self.imgDef_.SPRITE_3
end

--[[
    获取塔的商店中图
    @param none
    @return string
]]
function CardBase:getMediumSpriteImg()
    return self.imgDef_.SPRITE_4
end

--[[
    获取塔的类型角标
    @param none
    @return string
]]
function CardBase:getTypeImg()

    return self.imgDef_.TYPE
end

--[[
    获取塔的等级图片
    @param none
    @return string
]]
function CardBase:getLevelImg()

    local res = string.format("LEVEL_%d", self.level_)
    return CardImgDef.CARD_LEVEL[res]
end

--[[
    获取塔的稀有度背景
    @param none
    @return string
]]
function CardBase:getRarityBG()

    if self:ifCardObtained() then -- 如果已拥有卡牌
        return self.imgDef_.RAR_BG
    else
        return CardImgDef.CARD_RAR_BG.NOT_OBTAIN
    end
end

--[[
    获取塔的稀有度文字图片
    @param none
    @return string
]]
function CardBase:getRarityTextImg()

    return self.imgDef_.RAR_TEXT
end

--[[
    获取塔的类型文字图片
    @param none
    @return string
]]
function CardBase:getTypeTextImg()

    return self.imgDef_.ATTR_TYPE
end

--[[
    获取塔的攻击力文字图片
    @param none
    @return string
]]
function CardBase:getAtkTextImg()

    return self.imgDef_.ATTR_ATK
end

--[[
    获取塔的攻速文字图片
    @param none
    @return string
]]
function CardBase:getFireCdTextImg()

    return self.imgDef_.ATTR_AS
end

--[[
    获取塔的目标文字图片
    @param none
    @return string
]]
function CardBase:getTargetTextImg()

    return self.imgDef_.ATTR_TARGET
end

--[[
    获取塔的一技能文字图片
    @param none
    @return string
]]
function CardBase:getSkillOneTextImg()

    return self.imgDef_.ATTR_SKILL_ONE
end

--[[
    获取塔的二技能文字图片
    @param none
    @return string
]]
function CardBase:getSkillTwoTextImg()

    return self.imgDef_.ATTR_SKILL_TWO
end

--[[
    获取塔的STAR等级图片
    @param none
    @return num
]]
function CardBase:getStarLevel()
    return self.starLevel_
end


--- 塔属性信息相关函数

--[[
    获取塔的攻击力
    @param none
    @return number
]]
function CardBase:getAtk()
    return self.atk_
end

--[[
    获取塔的攻击力升级增量
    @param none
    @return number
]]
function CardBase:getAtkUpgradedDelta()
    return self.atkUpgradedDelta_
end

--[[
    获取塔的攻击力强化增量
    @param none
    @return number
]]
function CardBase:getAtkEnhancedDelta()
    return self.atkEnhancedDelta_
end

--[[
    获取塔的攻速
    @param none
    @return number
]]
function CardBase:getFireCd()
    return self.fireCd_
end

--[[
    获取塔的攻速升级增量
    @param none
    @return number
]]
function CardBase:getFireCdUpgradedDelta()
    return self.fireCdUpgradedDelta_
end

--[[
    获取塔的技能1
    @param none
    @return string
]]
function CardBase:getSkillOne()
    return self.skillOne_
end

--[[
    获取塔的技能1数值
    @param none
    @return number
]]
function CardBase:getSkillOneValue()
    return self.skillOneValue_
end

--[[
    获取塔的技能1升级增量
    @param none
    @return number
]]
function CardBase:getSkillOneUpgradedDelta()
    return self.skillOneUpgradedDelta_
end

--[[
    获取塔的技能1强化增量
    @param none
    @return number
]]
function CardBase:getSkillOneEnhancedDelta()
    return self.skillOneEnhancedDelta_
end

--[[
    获取塔的技能2
    @param none
    @return string
]]
function CardBase:getSkillTwo()
    return self.skillTwo_
end

--[[
    获取塔的技能2数值
    @param none
    @return number
]]
function CardBase:getSkillTwoValue()
    return self.skillTwoValue_
end

--- 塔计算信息相关函数

--[[
    获得升级所需的卡片数量
    @param none
    @return number
]]
function CardBase:getRequireCardNum()
    if self:getRarity() == CardInfoDef.CARD_RAR.NORMAL then
        return CardInfoDef.CARD_UPLEVEL_CARD.NORMAL[self.level_+1]
    elseif self:getRarity() == CardInfoDef.CARD_RAR.RARE then
        return CardInfoDef.CARD_UPLEVEL_CARD.RARE[self.level_+1]
    elseif self:getRarity() == CardInfoDef.CARD_RAR.LEGEND then
        return CardInfoDef.CARD_UPLEVEL_CARD.LEGEND[self.level_+1]
    elseif self:getRarity() == CardInfoDef.CARD_RAR.EPIC then
        return CardInfoDef.CARD_UPLEVEL_CARD.EPIC[self.level_+1]
    end
    return 0
end

--[[
    获得升级所需的金币数量
    @param none
    @return number
]]
function CardBase:getRequireGoldNum()
    if self:getRarity() == CardInfoDef.CARD_RAR.NORMAL then
        return CardInfoDef.CARD_UPLEVEL_GOLD.NORMAL[self.level_+1]
    elseif self:getRarity() == CardInfoDef.CARD_RAR.RARE then
        return CardInfoDef.CARD_UPLEVEL_GOLD.RARE[self.level_+1]
    elseif self:getRarity() == CardInfoDef.CARD_RAR.LEGEND then
        return CardInfoDef.CARD_UPLEVEL_GOLD.LEGEND[self.level_+1]
    elseif self:getRarity() == CardInfoDef.CARD_RAR.EPIC then
        return CardInfoDef.CARD_UPLEVEL_GOLD.EPIC[self.level_+1]
    end
    return 0
end

--[[
    计算塔的目前攻击力
    @param none
    @return none
]]
function CardBase:getCurAtk()
    if self.atk_ and self:getAtkUpgradedDelta() then
        return self.atk_ + (self.level_-1)*self:getAtkUpgradedDelta()
    elseif self.atk_ then
        return self.atk_
    else
        return nil
    end

end

--[[
    计算塔的目前攻速
    @param none
    @return none
]]
function CardBase:getCurFireCd()
    if self.fireCd_ and self:getFireCdUpgradedDelta() then
        return self.fireCd_ + (self.level_-1)*self:getFireCdUpgradedDelta()
    elseif self.fireCd_ then
        return self.fireCd_
    else
        return nil
    end
end

--[[
    计算塔的目前一技能参数
    @param none
    @return none
]]
function CardBase:getCurSkillOneValue()
    if self.skillOneValue_ and self:getSkillOneUpgradedDelta() then
        return self.skillOneValue_ + (self.level_-1)*self:getSkillOneUpgradedDelta()
    elseif self.skillOneValue_ then
        return self.skillOneValue_
    else
        return nil
    end
    return nil
end

--[[--
   判断卡牌是否已经获得

   @param card

   @return boolean
]]
function  CardBase:ifCardObtained()
    if self:getNum() == 0 then
        if self:getRarity() == CardInfoDef.CARD_RAR.NORMAL and self:getLevel() == 1 then
            return false
        elseif self:getRarity() == CardInfoDef.CARD_RAR.RARE and self:getLevel() == 3 then
            return false
        elseif self:getRarity() == CardInfoDef.CARD_RAR.EPIC and self:getLevel() == 5 then
            return false
        elseif self:getRarity() == CardInfoDef.CARD_RAR.LEGEND and self:getLevel() == 9 then
            return false
        end
    end
    return true
end

return CardBase