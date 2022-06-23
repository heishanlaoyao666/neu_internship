--[[--
    MsgController.lua

    描述：消息处理控制器，负责与服务器之间建立消息通道，进行消息收发
]]
local MsgController = {}
local ByteArray = require("app.msg.ByteArray")
local Log = require("app.util.Log")

local SimpleTCP = require("framework.SimpleTCP")
local scheduler = require("framework.scheduler")
local json = require("framework.json")

local TAG = "MsgController"

local SERVER_IP = "127.0.0.1" -- 服务器地址
local SERVER_PORT = 33333 -- 服务器端口
local HEART_BEAT_INTERVAL = 5 -- 心跳间隔，单位：秒

-------------------------------------------------------------
-- 本地变量定义
-------------------------------------------------------------
local socket_ -- 类型：SimpleTCP，已封装的tcp对象
local isConnect_ = false -- 类型：boolean，是否连接服务
local listenerMap_ = {} -- 类型：table，监听数据，key为唯一标识，value为function

-------------------------------------------------------------
-- 本地方法声明
-------------------------------------------------------------
local _init
local _handleMsg

-------------------------------------------------------------
-- 成员方法声明
-------------------------------------------------------------

--[[--
    描述：连接服务

    @param none

    @return none
]]
function MsgController:connect()
    Log.i(TAG, "connect()")

    if isConnect_ or socket_ then
        Log.w(TAG, "connect() tcp is already connect")
        return
    end

    socket_ = SimpleTCP.new(SERVER_IP, SERVER_PORT, _handleMsg)
    socket_:connect()
end

--[[--
    描述：断开与服务的连接

    @param none

    @return none
]]
function MsgController:disconnect()
    Log.i(TAG, "disconnect()")

    if not isConnect_ or not socket_ then
        return
    end

    socket_:close()
    socket_ = nil
    isConnect_ = false
end

--[[--
    描述：是否连接服务

    @param none

    @return boolean
]]
function MsgController:isConnect()
    return isConnect_
end

--[[--
    描述：发送消息

    @param msg 类型：table，消息数据

    @return boolean 是否发送成功
]]
function MsgController:sendMsg(msg)
    if not isConnect_ or not socket_ then
        Log.e(TAG, "sendMsg() send msg fail, socket is not connect.")
        return false
    end

    -- 消息包装，转换为二进制json
    local js = json.encode(msg or {})
    local ba = ByteArray.new()
    ba:setPos(1)
    ba:writeInt(#js)
    ba:writeStringBytes(js)

    socket_:send(ba:getPack())

    return true
end

--[[--
    描述：注册消息处理监听

    @param key 类型：...，唯一标识

    @return none
]]
function MsgController:registerListener(key, listener)
    if not key or type(listener) ~= "function" then
        Log.e(TAG, "registerListener() unexpect param, key is nil or listener is not function")
        return
    end

    if listenerMap_[key] then
        Log.w(TAG, "registerListener() key is already exist， key=", key)
        return
    end

    listenerMap_[key] = listener
end

--[[--
    描述：注销消息处理监听

    @param key 类型：...，唯一标识

    @return none
]]
function MsgController:unregisterListener(key)
    if not key then
        Log.w(TAG, "unregisterListener() unexpect param, key=", key)
        return
    end

    listenerMap_[key] = nil
end

-------------------------------------------------------------
-- 本地方法实现
-------------------------------------------------------------

--[[
    描述：消息处理入口

    @param event
    @param data

    @return none
]]
function _handleMsg(event, data)
    if event == SimpleTCP.EVENT_CONNECTING then
        Log.i(TAG, "正在连接...")
    elseif event == SimpleTCP.EVENT_CONNECTED then
        Log.i(TAG, "连接成功！")
        isConnect_ = true
    elseif event == SimpleTCP.EVENT_FAILED then
        Log.w(TAG, "连接失败！")
        isConnect_ = false
    elseif event == SimpleTCP.EVENT_CLOSED then
        Log.i(TAG, "关闭连接！")
        isConnect_ = false
    elseif event == SimpleTCP.EVENT_DATA then
        -- 网络消息处理
        if data then
            local ba = ByteArray.new()
            ba:writeBuf(data)
            ba:setPos(1)
            local len = ba:readInt()
            local msg = json.decode(ba:readStringBytes(len))

            Log.i(TAG, "_handleMsg() msg=", vardump(msg))

            for _, listener in pairs(listenerMap_) do
                listener(msg)
            end
        end
    else
        Log.e(TAG, "_handleMsg() unexpect event, event=", event)
    end
end

return MsgController