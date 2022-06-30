--[[--
    EventDef.lua
    事件ID定义
]]
local EventDef = {}

EventDef.ID = {
    PORTRAIT_CHANGE = 1, --头像变化
    GAMESTATE_CHANGE = 2, -- 游戏状态变化
    GAMEDATA_CHANGE = 3, --游戏数据改变
    KNAPSACK_CHANGE = 4, --背包数据改变
    INTENSIFIES = 5, --强化升级界面
    LEVEL_CHANGE = 6, --等级改变
    CREATE_BULLET = 7, -- 创建子弹
    DESTORY_BULLET = 8, -- 销毁子弹
    CREATE_ENEMY = 9, -- 创建敌人
    DESTORY_ENEMY = 10, -- 销毁敌人
    CREATE_SELF = 11, -- 创建我方塔
    DESTORY_SELF = 12, -- 销毁我方塔
    BULLET_BOMB = 13, -- 子弹命中
}

return EventDef