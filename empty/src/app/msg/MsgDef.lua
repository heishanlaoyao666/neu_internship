--[[--
    MsgDef.lua

    描述：消息类型常量定义
]]
local MsgDef = {}

-- 请求消息
MsgDef.MSG_TYPE_REQ = {
    STARTGAME   =    1,
	REFRESHHP   =    2,
	UPLOADSCORE =    3,
	HEARTBEAT   =    4,
	LOGIN       =    5,

    UPDATE_DATA = 6,
	GAMEMATCH = 7,
	CANCELMATCH = 8,

	SHOPDATA = 9,
	SHOPREFRESH = 10,
	CREATEGAME   =    500,
	--游戏消息定义
	GAMEPLAY = 1001,
	TOWERCOMPOSE= 1002,
	TOWERUPGRADE = 1003,
	TOWERCREATE = 1004,
	BOSSTRUE = 1005,
}

-- 响应消息
MsgDef.MSG_TYPE_ACK = {
    STARTGAME   =    0x80000 + 1,
	GAMEOVER    =    0x80000 + 2,
	RANKLIST    =    0x80000 + 3,
	HEARTBEAT   =    0x80000 + 4,
	LOGIN       =    0x80000 + 5,

    UPDATE_DATA =    0x80000 + 6,
	GAMEMATCH   =    0x80000 + 7,
	CANCELMATCH =    0x80000 + 8,
	SHOPDATA    =    0x80000 + 9,
	SHOPREFRESH =    0x80000 + 10,
	CREATEGAME  =    0x80000 + 500,
	GAMEPLAY    =    0x80000 - 1001,
	TOWERCOMPOSE=    0x80000 - 1002,
	TOWERUPGRADE=    0x80000 - 1003,
	TOWERCREATE =    0x80000 - 1004,
	BOSSTRUE    =    0x80000 - 1005,
}

return MsgDef