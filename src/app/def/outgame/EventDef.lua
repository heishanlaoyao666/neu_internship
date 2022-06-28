--[[--
    EventDef.lua
    事件ID定义
]]
local EventDef = {}

EventDef.ID = {
    PORTRAIT_CHANGE = 1, -- 头像变化
    GAMESTATE_CHANGE = 2, -- 游戏状态变化
    GAMEDATA_CHANGE = 3, --游戏数据改变
    KNAPSACK_CHANGE = 4, --背包数据改变
    INTENSIFIES = 5, --强化
}

return EventDef