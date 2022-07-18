--[[--
    PlayerInfo.lua

    描述：玩家信息
]]
local PlayerInfo = class("PlayerInfo")

--[[--
    描述：构造函数

    @param none

    @return none
]]
function PlayerInfo:ctor()
    self.sp_ = 0 -- 类型：number，sp点数
    self.lineupTowerIds_ = {} -- 类型：table，出战的塔id数组，内部元素number
end

return PlayerInfo