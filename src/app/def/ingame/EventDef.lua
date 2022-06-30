--[[--
    EventDef.lua
    事件ID定义
]]
local EventDef = {}

EventDef.ID = {
    CREATE_BULLET = 1, -- 创建子弹
    DESTORY_BULLET = 2, -- 销毁子弹
    CREATE_ENEMY = 3, -- 创建敌人
    DESTORY_ENEMY = 4, -- 销毁敌人
    CREATE_SELF = 5, -- 创建我方塔
    DESTORY_SELF = 6, -- 销毁我方塔
    BULLET_BOMB = 7, -- 子弹命中
}

return EventDef