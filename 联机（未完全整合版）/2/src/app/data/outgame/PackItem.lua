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
end

function PackItem:getTower()
    return self.tower
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