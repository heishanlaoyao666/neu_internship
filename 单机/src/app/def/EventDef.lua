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
    CREATE_MONSTER = 9, -- 创建敌人
    DESTORY_MONSTER = 10, -- 销毁敌人
    CREATE_SELF = 11, -- 创建我方塔
    DESTORY_SELF = 12, -- 销毁我方塔
    BULLET_BOMB = 13, -- 子弹命中
    BUY = 14, -- 金币购买
    OBTAINITEM = 15, -- 开箱子
    COMFIRMATION =16, --获取宝箱物品
    SETTING=17, --设置菜单
    POPUPWINDOW=18, --菜单弹窗
    MATCH=19, --匹配
    CURRENTLINEUP=20, --当前阵容
    USING=21, --使用塔
    BATTLE=22, --战斗界面
    CREATE_ELITE_MONSTER = 23, -- 创建精英怪
    DESTORY_ELITE_MONSTER = 24, -- 销毁精英怪
    BASE_INJURED = 25, -- 基地受伤
    GOODS_CHANGE=26, --商品改变
    GOLDSHOP_CHANGE=27, --金币商店改变
    FIGHT=28, --进入战斗场景
    CREATE_BOSS = 29, -- 创建boss
    DESTORY_BOSS = 30, -- 销毁boss
    UPDATE_STAR = 31, -- 更新星级
    HURT= 32, -- 基地受伤
}

return EventDef