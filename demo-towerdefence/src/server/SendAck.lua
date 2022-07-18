--[[--
    SendAck.lua

    描述：发送响应消息
]]
local SendAck = {}
local Log = require("app.util.Log")

local SimpleTCP = require("framework.SimpleTCP")

local ackListener_ -- 类型：function，ack监听函数

--[[--
    描述：设置发送ack的监听函数

    @param listener 类型：function，发送ack监听函数

    @return none
]]
function SendAck:setAckListener(listener)
    -- 只允许有一个监听
    if ackListener_ then
        Log.e("ack listener is exist, do not alow regist more.")
        return
    end

    ackListener_ = listener
end


--[[--
    描述：发送ack消息（发送客户端）

    @param ack 类型：table，响应消息

    @return none
]]
function SendAck:send(ack)
    if not isTable(ack) then
        Log.e("unexpect param, ack=", ack)
        return
    end

    if ackListener_ then
        ackListener_(SimpleTCP.EVENT_DATA, ack)
    end
end

return SendAck