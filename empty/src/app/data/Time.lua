--[[--
    Time.lua 
    给buff提供时间用
]]
local Time = class("Time")
--[[--
    构造函数

    @param none

    @return none
]]
function Time:ctor()
    self.permanent = true --类型 bool,判断是否永久，ture为永久
    self.duration = 0 --类型 number buff持续时间,到点消失
    self.timeElapsed = 0 --类型 number,运行时间
    self.ticked = 0 --类型 int,
end

return Time