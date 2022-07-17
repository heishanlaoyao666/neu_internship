--[[
    MsgDef.lua
    描述：消息相关定义，拷贝自原始的服务器框架
    编写：
    修订：
    检查：
]]

local MsgDef = {}

MsgDef.REQ_TYPE = { -- 客户端的请求类型
	SETUP_CONNECTION = 1, -- 建立连接
	CREATE_TOWER = 2, -- 创建防御塔
	UPGRADE_TOWER = 3, -- 防御塔升星
	ENFORCE_TOWER = 5, -- 强化防御塔
	HEARTBEAT = 4, -- 心跳
	LOGIN = 6, -- 登录
	REGISTER = 7, -- 注册
	SEND_PLAYER_DATA = 8, -- 发送用户数据
	REC_PLAYER_DATA = 9, -- 接收用户数据
	START_MAPPING = 10, -- 开始匹配信息
	END_MAPPING = 11, -- 终止匹配信息
	CREATE_GAME = 12, -- 创建游戏

	SEND_STORE_DATA = 20, -- 接收商店数据
	ENTER_GAME = 21, -- 进入游戏
	QUIT_GAME = 22, -- 退出游戏
}

MsgDef.ACK_TYPE = { -- 服务端的响应类型
	START_GAME = 1, -- 开始游戏
	GAME_OVER = 2, -- 游戏结束
	RANK_LIST = 3, -- rank list
	HEARTBEAT = 4, -- 心跳
	LOGIN_SUCCEED = 6, -- 登录成功
	LOGIN_FAIL = 7, -- 登录失败
	REGISTER_SUCCEED = 8, -- 注册成功
	REGISTER_FAIL = 9, -- 注册失败
	MAPPING_SUCCEED = 7, -- 匹配成功
	MAPPING_FAIL = 9, -- 匹配失败
	GAME_SYNC = 10, -- 游戏内数据同步

	PLAYER_DATA_SEND_SUCCEED = 18,
	PLAYER_DATA_REC_SUCCEED = 19,
	STORE_DATA_SEND_SUCCEED = 20, -- 商店数据接收成功
}

return MsgDef