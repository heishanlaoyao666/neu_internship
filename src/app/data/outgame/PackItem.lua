--[[--
    PackItem.lua
    背包物品类
]]
local PackItem = class("PackItem")

--[[--
    构造函数

    @param towerId 类型：number
    @parm num 类型：number

    @return none
]]
function PackItem:ctor(towerId, num)
    self.towerId_ = towerId
    self.num_ = num
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
    cc.UserDefault:getInstance():setNumberForKey(tostring(self.towerId_), self.num_)
end

--[[--
    获取背包数据(模拟)

    @parm none

    @return number
]]
function PackItem:getInfo()
    return cc.cc.UserDefault:getInstance():getNumberForKey(tostring(self.towerId_))
end



return PackItem