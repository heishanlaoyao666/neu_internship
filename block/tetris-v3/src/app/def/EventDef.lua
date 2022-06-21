--[[--
    EventDef.lua
    事件ID定义
]]
local EventDef = {}

EventDef.ID = {
    CREATE_CUR_BLOCK = 1, -- 创建当前块
    CREATE_NEXT_BLOCK = 2, -- 创建下一块
    BEGIN_GAME = 3, -- 开始游戏
    UPDATE_SPEED = 4, -- 更新速度,
    OVER_GAME = 5, -- 结束游戏

    RESTART_GAME = 6, -- 重新开始游戏
    EXIT_GAME = 7, -- 退出游戏
}

return EventDef