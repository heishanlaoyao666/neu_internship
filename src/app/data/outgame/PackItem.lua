--[[--
    PackItem.lua
    背包物品类
]]
local PackItem = class("PackItem")

--[[--
    构造函数

    @param tower 类型：object
    @parm num 类型：number
    @parm level 类型：number

    @return none
]]
function PackItem:ctor(tower, num, level)
    self.tower= tower
    self.num_ = num
    self.level_ = level
end

-- --[[--
--     传送背包数据(预留)

--     @parm none

--     @return bool
-- ]]
-- function PackItem:sendInfo()
-- end

-- --[[--
--     获取背包数据(预留)

--     @parm none

--     @return object
-- ]]
-- function PackItem:getInfo()
-- end

--[[--
    传送背包数据(模拟)

    @parm none

    @return none
]]
function PackItem:sendInfo()
end

--[[--
    获取背包数据(模拟)

    @parm none

    @return number
]]
function PackItem:getInfo()
end

--[[--
    获取背包塔ID

    @parm none

    @return object
]]
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
    获取背包塔等级

    @parm none

    @return number
]]
function PackItem:getLevel()
    return self.level_
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