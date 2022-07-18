--[[--
    MsgDef.lua

    描述：消息类型常量定义
]]
local MsgDef = {}

--[[
    消息样例：
    {
        type = 1, -- 消息类型（必须存在）
        userId = 10086, -- 玩家id（必须存在）
        ... -- 其它扩展数据
    }
]]
MsgDef.KEY = {
    TYPE = "type",
    USER_ID = "userId",
}

-- 请求消息
MsgDef.REQ = {
    -- 公共消息，号段1 ~ 100
    REGIST = 1, -- 注册消息
    LOGIN = 2, -- 登录消息
    HEART_BEAT = 3, -- 心跳消息
    ACCOUNT_CHANGE_FIGURE = 4,
    -- TODO 其它功能消息

    -- 大厅的消息，号段101~200
    SHOP_INFO = 101, -- 商城：商城信息
    SHOP_BUY_GOODS = 102, -- 商城：购买商品
    SHOP_OPEN_CHEST = 103, -- 商城：开宝箱
    MATCH_SIGNUP = 104, -- 比赛：报名比赛
    MATCH_SIGHUP_CANCEL = 105, -- 比赛：取消报名比赛
    -- TODO 其它功能消息

    -- 游戏内的消息，号段201~300
    GAME_TOWER_GENERATE = 201, -- 生成塔
    GAME_TOWER_COMPOSE = 202, -- 合成塔
    GAME_TOWER_UPGRADE = 203, -- 强化塔
    GAME_BULLET_HIT = 204, -- 子弹射中
    GAME_GIVEUP = 205, -- 认输
    -- TODO 其它功能消息
}

-- 响应消息
MsgDef.ACK = {
    -- 公共消息，号段301~400
    REGIST = 301, -- 注册消息
    LOGIN = 302, -- 登录消息
    HEART_BEAT = 303, -- 心跳消息
    ACCOUNT_INFO = 304, -- 账户信息（主动推送）
    ACCOUNT_CHANGE_FIGURE = 305, -- 更改头像

    -- 大厅的消息，号段401~500
    SHOP_INFO = 101, -- 商城：商城信息
    SHOP_REFRESH_FREE = 102, -- 商城：免费品刷新
    SHOP_BUY_GOODS = 103, -- 商城：购买商品
    SHOP_OPEN_CHEST = 104, -- 商城：开宝箱
    MATCH_SIGNUP = 105, -- 报名比赛
    MATCH_SIGHUP_CANCEL = 106, -- 取消报名比赛
    MATCH_START = 107, -- 比赛开始
    -- TODO 其它功能消息

    -- 游戏内的消息，号段501~600
    GAME_INIT = 201, -- 初始化
    GAME_TOWER_GENERATE = 202, -- 生成塔
    GAME_TOWER_COMPOSE = 203, -- 合成塔
    GAME_TOWER_UPGRADE = 204, -- 强化塔
    GAME_TOWER_FIRE = 205, -- 塔射击
    GAME_ENEMY_GENERAGE = 206, -- 生成敌人
    GAME_ENEMY_SYNC = 207, -- 同步消息，同步敌人快照
    GAME_ENEMY_DEAD = 208, -- 怪物死亡
    GAME_BULLET_ADD = 209, -- 新增子弹
    GAME_GIVEUP = 210, -- 认输
    GAME_RESULT = 211, -- 结算
}

return MsgDef