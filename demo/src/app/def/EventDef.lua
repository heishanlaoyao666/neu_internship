--[[
    EventDef.lua
    事件ID定义
    描述：事件ID定义
    编写：周星宇
    修订：李昊
    检查：张昊煜
]]
local EventDef = {}

EventDef.ID = {
    -- 游戏外
    LOBBY_VIEW_SWITCH = 1, -- 大厅视图切换
    AVATAR_SWITCH = 2, -- 头像切换
    COLLECTION_VIEW_HIDE = 3, -- 隐藏卡牌收集组件
    COLLECTION_VIEW_SHOW = 4, -- 显示卡牌收集组件
    CARD_SWITCH = 5, -- 替换卡牌
    CARD_UPGRADE = 6, -- 升级卡牌
    CARD_PURCHASE = 7, -- 购买卡牌
    BOX_PURCHASE = 8, -- 购买宝箱
    GOLD_OBTAIN = 9, -- 天梯领取金币
    DIAMOND_OBTAIN = 10, -- 天梯领取钻石
    CARD_ENFORCE_SHOW = 11, -- 卡牌强化展示
    CARD_ENFORCE_HIDE = 12, -- 卡牌强化隐藏
    INIT_PLAYER_DATA = 13, -- 初始化用户数据
    GOLD_STORE_REFRESH = 14, -- 刷新金币商店
    CARD_GROUP_SWITCH = 15, -- 卡组切换
    MAPPING_SUCCEED = 16, -- 匹配成功

    -- 登陆注册
    LOGIN_SUCCEED = 17,
    LOGIN_FAIL = 18,
    REGISTER_SUCCEED = 19,
    REGISTER_FAIL = 20,

    -- 游戏内
    ENEMY_CREATE = 21,
    ENEMY_DEATH = 22,
    CARD_CREATE = 23,
    CARD_DEATH = 24,
    BULLET_CREATE = 25,
    BULLET_DEATH = 26,
    ENEMY_LIFE_CREATE = 27,
    ENEMY_LIFE_DEATH = 28,
    CARD_ENHANCE_LEVEL_CREATE = 29,
    CARD_ENHANCE_LEVEL_DEATH = 30,
    BOSS_CREATE = 31,
    BOSS_DEATH = 32,
    STATE_CREATE = 33,
    STATE_DEATH = 34,
    HURT_CREATE = 35,
    HURT_DEATH = 36,
    CARD_BEGAN_DRAG = 37,
    CARD_MOVED_DRAG = 38,
    CARD_ENDED_DRAG = 39,
}

return EventDef