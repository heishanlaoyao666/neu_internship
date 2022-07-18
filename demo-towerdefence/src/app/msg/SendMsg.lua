--[[--
    SendMsg.lua

    描述：发送消息类
]]
local SendMsg = {}
local MsgManager = require("app.manager.MsgManager")
local MsgDef = require("app.def.MsgDef")
local UserInfo = require("app.data.UserInfo")
local Log = require("app.util.Log")

--[[--
    描述：获取通用消息体

    @param msgType 类型：number，消息类型

    @return table
]]
function SendMsg:genReq(msgType)
    local req = {}
    req[MsgDef.KEY.TYPE] = msgType
    req[MsgDef.KEY.USER_ID] = UserInfo:getUserId()

    return req
end

--[[--
    描述：发送登录请求

    @param none

    @return none
]]
function SendMsg:sendLoginReq()
    local req = self:genReq(MsgDef.REQ.LOGIN)
    MsgManager:sendMsg(req)
end

--[[--
    描述：发送报名比赛请求
    
    @param none
    
    @return none
]]
function SendMsg:sendMatchSignupReq()
    local req = self:genReq(MsgDef.REQ.MATCH_SIGNUP)
    MsgManager:sendMsg(req)
end

--[[--
    描述：发送生成塔请求

    @param none

    @return none
]]
function SendMsg:sendGameTowerGenerateReq()
    local req = self:genReq(MsgDef.REQ.GAME_TOWER_GENERATE)
    MsgManager:sendMsg(req)
end

--[[--
    描述：发送子弹命中请求

    @param bulets 类型：table，命中的子弹数组，内部元素Bulet

    @return none
]]
function SendMsg:sendBuletHitReq(bulets)
    local req = self:genReq(MsgDef.REQ.GAME_BULLET_HIT)
    req.bulets = bulets
    MsgManager:sendMsg(req)
end

--[[--
    描述：发送认输请求

    @param none

    @return none
]]
function SendMsg:sendGameGiveupReq()
    local req = self:genReq(MsgDef.REQ.GAME_GIVEUP)
    MsgManager:sendMsg(req)
end

return SendMsg