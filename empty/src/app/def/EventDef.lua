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

    KNAPSACK_LOGIN = 5088, --背包系统登陆

    CREATE_GAME = 50885,--游戏创建

    score_show_1 =11111,--结算分数演示1
    SCORE_SHOW_2 =22222,--结算分数演示2
    SCORE_SHOW_3 =33333,--结算分数演示3

    INTO_GAME = 1001,--进入游戏
    SELECT_BOSS = 1002,--选择boss
    CONFIRM_BOSS = 1003,--选中boss
    BOSS_SHOW = 1004,--boss出现
    TOWER_BUILD = 1005,--防御塔生成
    TOWER_COMPOSE = 1006,--防御塔合成
    TOWER_ATK = 1007,--防御塔攻击
    TOWER_ATK_HIT = 1008,--防御塔击中目标
    WIN = 1009,--胜利音效
    GET_AWRADS = 1010,--领取奖励音效
    LOSE = 1011,--失败音效
}

return EventDef