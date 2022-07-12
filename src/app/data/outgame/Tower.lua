--[[--
    Tower.lua
    塔对象类
]]
local Tower = class("Tower", require("app.data.ingame.Object"))


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
    @param fireCdUpgrade 类型：number 塔升级后攻速的变化
    @param towerSkill1 类型：string 塔技能1的描述
    @param towerSkill1Num 类型：num 塔技能1
    @param skill1Value 类型：number 塔技能1的数值
    @param valueUpgrade 类型：number 塔技能1升级后的数值变化
    @param valueEnhance 类型：number 塔技能1强化后的数值变化
    @param towerSkill2 类型：string 塔技能2的描述
    @param towerSkill2Num 类型：num 塔技能2
    @param skill2Value 类型：number 塔技能2的数值

    @return none
]]
function Tower:ctor(towerId, towerRarity, towerType, towerName, towerInfo,
    atkTarget, towerAtk, atkUpgrade, atkEnhance, towerFireCd, fireCdUpgrade,
    towerSkill1, towerSkill1Num,skill1Value, valueUpgrade, valueEnhance, towerSkill2,towerSkill2Num, skill2Value)
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
    self.towerSkill1Num_ =towerSkill1Num
    self.skill1Value_ = skill1Value
    self.valueUpgrade_ = valueUpgrade
    self.valueEnhance_ = valueEnhance
    self.towerSkill2_ = towerSkill2
    self.towerSkill2Num_ =towerSkill2Num
    self.skill2Value_ = skill2Value
    self.level_ = 1
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
function Tower:getTowerName()
    return self.towerName_
end

--[[--
    获取塔的技能介绍

    @parm none

    @return number
]]
function Tower:getTowerInfo()
    return self.towerInfo_
end

--[[--
    获取塔的攻击目标

    @parm none

    @return string
]]
function Tower:getAtkTarget()
    return self.atkTarget_
end

--[[--
    获取塔的攻击力

    @parm none

    @return number
]]
function Tower:getTowerAtk()
    return self.towerAtk_
end

--[[--
    获取塔的攻击力变化

    @parm none

    @return number
]]
function Tower:getAtkUpgrade()
    return self.atkUpgrade_
end

--[[--
    升级后塔的攻击力改变

    @parm none

    @return none
]]
function Tower:atkUpgrade()
    if self.atkUpgrade_ ~= nil then
        self.towerAtk_ = self.towerAtk_ + self.atkUpgrade_
    end
end

--[[--
    强化后塔的攻击力改变

    @parm n 类型：number，攻击力加成

    @return none
]]
function Tower:atkEnhance(n)
    if self.atkEnhance_ ~= nil and n == nil then
        self.towerAtk_ = self.towerAtk_ + self.atkEnhance_
    end
end

--[[--
    获取塔的攻速

    @parm none

    @return number
]]
function Tower:getTowerFireCd()
    return self.towerFireCd_
end

--[[--
    设置塔的攻速

    @parm n 类型：number, 时间

    @return none
]]
function Tower:setFireCd(n)
    self.towerFireCd_ = self.towerFireCd_ - n
end

--[[--
    获取塔的攻速变化

    @parm none

    @return number
]]
function Tower:getFireCdUpgrade()
    return self.fireCdUpgrade_
end

--[[--
    升级后塔的攻速改变

    @parm none

    @return none
]]
function Tower:fireCdUpgrade()
    if self.fireCdUpgrade_ ~= nil then
        self.towerFireCd_ = self.towerFireCd_ - self.fireCdUpgrade_
    end
end

--[[--
    获取塔的技能1的描述

    @parm none

    @return string
]]
function Tower:getTowerSkill1()
    return self.towerSkill1_
end

--[[--
    获取塔的技能1对应数字

    @parm none

    @return number
]]
function Tower:getTowerSkill1Num()
    return self.towerSkill1Num_
end

--[[--
    获取塔的技能1的数值

    @parm none

    @return number
]]
function Tower:getSkill1Value()
    return self.skill1Value_
end

--[[--
    获取塔的技能1的数值变化

    @parm none

    @return number
]]
function Tower:getValueUpgrade()
    return self.valueUpgrade_
end

--[[--
    塔的技能1升级后的数值改变

    @parm none

    @return none
]]
function Tower:valueUpgrade()
    if self.valueUpgrade_ ~= nil then
        self.skill1Value_ = self.skill1Value_ + self.valueUpgrade_
    end
end

--[[--
    塔的技能1强化后的数值改变

    @parm none

    @return none
]]
function Tower:valueEnhance()
    if self.valueEnhance_ ~= nil then
        self.skill1Value_ = self.skill1Value_ + self.valueEnhance_
    end
end

--[[--
    获取塔的技能2的描述

    @parm none

    @return string
]]
function Tower:getTowerSkill2()
    return self.towerSkill2_
end

--[[--
    获取塔的技能2对应数字

    @parm none

    @return number
]]
function Tower:getTowerSkill2Num()
    return self.towerSkill2Num_
end
--[[--
    获取塔的技能2的数值

    @parm none

    @return number
]]
function Tower:getSkill2Value()
    return self.skill2Value_
end

--[[--
    塔升级

    @parm none

    @return none
]]

function Tower:levelUp()
    self.level_ = self.level_ + 1
end

--[[--
    获取塔的等级

    @paem none

    @return number
]]
function Tower:getLevel()
    return self.level_
end

return Tower