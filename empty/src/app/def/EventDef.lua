--[[--
    EventDef.lua
    事件ID定义
]]
local EventDef = {}

EventDef.ID = {
    OPPOSITE_SELECT= 1, --对手选择
    VIEW_OPEN = 11, --界面打开
    CREATE_ENEMY = 112, --敌人创建
    DESTORY_ENEMY = 113, --敌人销毁
    OPPOSITE_ENEMY= 114,--敌人在对面生成

    INIT_BULLET = 330, --子弹创建
    CREATE_BULLET = 331, --子弹创建
    DESTORY_BULLET =332, --子弹销毁

    CREATE_TOWER = 111, --创建塔
    DESTORY_TOWER = 222, --摧毁塔

    INIT_DAMAGE = 440, --伤害信息初始化
    CREATE_DAMAGE = 441, --伤害信息创建
    DESTORY_DAMAGE = 442, --伤害信息销毁

    UP_TOWER_GRADE = 770, --塔强化
    CHECKCOLLIDER = 550, --碰撞计算
    GAMESTATE_CHANGE = 666, -- 游戏状态变化
    PLAYER_LIFE_CHANGE = 667,--玩家血量变化
    PLAYER_SURRENDER = 668,-- 玩家投降

    KNAPSACK_LOGIN = 5088, --背包系统登陆

    CREATE_GAME = 50885,--游戏创建
}

return EventDef