--[[--
    Tower.lua
    塔对象类
]]
local Tower = class("Tower")


--[[--
    构造函数

    @param towerId 类型：number 塔的编号
    @param towerRarity 类型：number 稀的有度
    @param towerType 类型：number 塔的类型
    @param towerName string 塔的名称
    @param towerInfo string 塔的技能介绍
    @param atkTarget 类型：string 塔的攻击目标
    @param towerAtk 类型：number 塔的攻击力
    @param atkUpgrade 类型：number 塔升级后攻击力的变化
    @param atkEnhance 类型：number 塔强化后攻击力的变化
    @param towerFireCd 类型：number 塔的攻速
    @param fireCdUpgrade 类型：number 塔升级后公诉的变化
    @param towerSkill1 类型：string 塔技能1的描述
    @param skill1Value 类型：number 塔技能1的数值
    @param valueUpgrade 类型：number 塔技能1升级后的数值变化
    @param valueEnhance 类型：number 塔技能1强化后的数值变化
    @param towerSkill2 类型：string 塔技能2的描述
    @param skill2Value 类型：number 塔技能2的数值

    @return none
]]
function Tower:ctor(towerId, towerRarity, towerType, towerName, towerInfo,
    atkTarget, towerAtk, atkUpgrade, atkEnhance, towerFireCd, fireCdUpgrade,
    towerSkill1, skill1Value, valueUpgrade, valueEnhance, towerSkill2, skill2Value)
    self.towerId_ = towerId
    self.towerRarity_ = towerRarity
    self.towerType_ = towerType
    self.towerName_ = towerName
    self.towerInfo_ = towerInfo
    self.atkTarget_ = atkTarget
    self.towerAtk_ = towerAtk
    self.atkUpgrade_ = atkUpgrade
    self.atkEnhance_ = atkEnhance
    self.towerFireCd_ = towerFireCd
    self.fireCdUpgrade_ = fireCdUpgrade
    self.towerSkill1_ = towerSkill1
    self.skill1Value_ = skill1Value
    self.valueUpgrade_ = valueUpgrade
    self.valueEnhance_ = valueEnhance
    self.towerSkill2_ = towerSkill2
    self.skill2Value_ = skill2Value
end

--[[--
    获取塔的编号

    @parm none

    @return number
]]
function Tower:getTowerId()
    return self.towerId_
end

--[[--
    获取塔的稀有度

    @parm none

    @return number
]]
function Tower:getTowerRarity()
    return self.towerRarity_
end

--[[--
    获取塔的类型

    @parm none

    @return number
]]
function Tower:getTowerType()
    return self.towerType_
end

--[[--
    获取塔的名称

    @parm none

    @return number
]]
function Tower:GetTowerName()
    return self.towerName_
end

--[[--
    获取塔的技能介绍

    @parm none

    @return number
]]
function Tower:GetTowerInfo()
    return self.towerInfo_
end

--[[--
    获取塔的攻击目标

    @parm none

    @return string
]]
function Tower:GetAtkTarget()
    return self.atkTarget_
end

--[[--
    获取塔的攻击力

    @parm none

    @return number
]]
function Tower:GetTowerAtk()
    return self.atkTarget_
end

--[[--
    升级后塔的攻击力改变

    @parm none

    @return none
]]
function Tower:AtkUpgrade()
    self.towerAtk_ = self.towerAtk_ + self.atkUpgrade_
end

--[[--
    强化后塔的攻击力改变

    @parm none

    @return none
]]
function Tower:AtkEnhance()
    self.towerAtk_ = self.towerAtk_ + self.atkEnhance_
end

--[[--
    获取塔的攻速

    @parm none

    @return number
]]
function Tower:GetTowerFireCd()
    return self.towerFireCd_
end

--[[--
    升级后塔的攻速改变

    @parm none

    @return none
]]
function Tower:FireCdUpgrade()
    if self.fireCdUpgrade_ ~= nil then
        self.towerFireCd_ = self.towerFireCd_ - self.fireCdUpgrade_
    end
end

--[[--
    获取塔的技能1的描述

    @parm none

    @return string
]]
function Tower:GetTowerSkill1()
    return self.towerSkill1_
end

--[[--
    获取塔的技能1的数值

    @parm none

    @return number
]]
function Tower:GetSkill1Value()
    return self.skill1Value_
end

--[[--
    塔的技能1升级后的数值改变

    @parm none

    @return none
]]
function Tower:ValueUpgrade()
    if self.valueUpgrade_ ~= nil then
        self.skill1Value_ = self.skill1Value_ + self.valueUpgrade_
    end
end

--[[--
    塔的技能1强化后的数值改变

    @parm none

    @return none
]]
function Tower:ValueEnhance()
    if self.valueEnhance_ ~= nil then
        self.skill1Value_ = self.skill1Value_ + self.valueEnhance_
    end
end

--[[--
    获取塔的技能2的描述

    @parm none

    @return string
]]
function Tower:GetTowerSkill2()
    return self.towerSkill2_
end

--[[--
    获取塔的技能2的数值

    @parm none

    @return number
]]
function Tower:GetSkill2Value()
    return self.skill2Value_
end

return Tower