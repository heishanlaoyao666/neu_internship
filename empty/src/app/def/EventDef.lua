--[[--
    EventDef.lua
    事件ID定义
]]
local EventDef = {}

EventDef.ID = {
    OPPOSITE_SELECT= 1, --对手选择
    VIEW_OPEN = 11, --界面打开
    CREATE_TOWER = 111, --创建塔
    DESTORY_TOWER = 222, --摧毁塔
    GAMESTATE_CHANGE = 666, -- 游戏状态变化
}

return EventDef