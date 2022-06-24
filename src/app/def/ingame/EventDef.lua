--[[--
    EventDef.lua
    事件ID定义
]]
local EventDef = {}

EventDef.ID = {
    CREATE_BULLET = 1, -- 创建子弹
    DESTORY_BULLET = 2, -- 销毁子弹
    CREATE_ENEMY = 3, -- 创建敌机
    DESTORY_ENEMY = 4, -- 销毁敌机
    CREATE_SELF = 5, -- 创建我方飞机
    DESTORY_SELF = 6, -- 销毁我方飞机
    BULLET_BOMB = 7, -- 子弹命中
    CRASH_PLANE = 8, -- 飞机撞毁
    GAMESTATE_CHANGE = 9, -- 游戏状态变化
}

return EventDef