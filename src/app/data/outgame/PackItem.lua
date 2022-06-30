--[[--
    PackItem.lua
    背包物品类
]]
local PackItem = class("PackItem")

--[[--
    构造函数

    @param tower 类型：object
    @parm num 类型：number

    @return none
]]
function PackItem:ctor(tower, num)
    self.tower= tower
    self.num_ = num
    self.level_ = 1             -- 当前等级
    self.enhanceLevel_ = 1      -- 强化等级
end

function PackItem:getTower()
    return self.tower
end

--[[--
    背包塔升级

    @parm none

    @return none
]]
function PackItem:towerLevelUp()
    self.level_ = self.level_ + 1
end

--[[--
    背包塔强化

    @parm none

    @return none
]]
function PackItem:towerEnganceUp()
    self.enhanceLevel_ = self.enhanceLevel_ + 1
end

--[[--
    获取背包塔等级

    @parm none

    @return number
]]
function PackItem:getLevel()
    return self.level_
end

--[[--
    获取背包塔强化等级

    @parm none

    @return number
]]
function PackItem:getEnhanceLevel()
    return self.enhanceLevel_
end

--[[--
    更改背包塔的数量

    @parm n 类型：number

    @return none
]]
function PackItem:setTowerNumber(n)
    self.num_ = self.num_ + n
end

--[[--
    获取背包塔的数量

    @parm none

    @return number
]]
function PackItem:getTowerNumber()
    return self.num_
end

return PackItem