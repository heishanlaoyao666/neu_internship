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
	CREATEGAME   =    500,
}

-- 响应消息
MsgDef.MSG_TYPE_ACK = {
    STARTGAME   =    0x80000 + 1,
	GAMEOVER    =    0x80000 + 2,
	RANKLIST    =    0x80000 + 3,
	HEARTBEAT   =    0x80000 + 4,
	LOGIN       =    0x80000 + 5,

    UPDATE_DATA =    0x80000 + 6,
}

return MsgDef