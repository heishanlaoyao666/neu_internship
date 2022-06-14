--[[--
    EventDef.lua
    事件ID定义
]]
local EventDef = {}

EventDef.ID = {
    MOVE_LEFT = 1, -- 向左移动
    MOVE_RIGHT = 2, -- 向右移动
    MOVE_DOWN = 3, -- 向下移动
    ROTATION_LEFT = 4, -- 向左旋转
    ROTATION_RIGHT = 5, -- 向右旋转
    DESTORY_SELF = 6, -- 销毁我方飞机
    BULLET_BOMB = 7, -- 子弹命中
    CRASH_PLANE = 8, -- 飞机撞毁
    GAMESTATE_CHANGE = 9, -- 游戏状态变化
}

return EventDef