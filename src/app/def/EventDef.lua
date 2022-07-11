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
}

return EventDef