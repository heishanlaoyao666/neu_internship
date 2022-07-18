--[[--
    MsgManager.lua

    描述：消息处理控制器，负责与服务器之间建立消息通道，进行消息收发
]]
local MsgManager = {}
local ByteArray = require("app.util.ByteArray")
local MsgController = require("app.msg.MsgController")
local SceneManager = require("app.manager.SceneManager")
local Log = require("app.util.Log")

local TestServer = require("server.TestServer")
local SimpleTCP = require("framework.SimpleTCP")
local json = require("framework.json")

local TAG = "MsgManager"

local SERVER_IP = "127.0.0.1" -- 服务器地址
local SERVER_PORT = 33333 -- 服务器端口
local HEART_BEAT_INTERVAL = 5 -- 心跳间隔，单位：秒
local IS_TEST = true -- 是否测试模式

-------------------------------------------------------------
-- 本地变量定义
-------------------------------------------------------------
local socket_ -- 类型：SimpleTCP，已封装的tcp对象
local isConnect_ = false -- 类型：boolean，是否连接服务

-------------------------------------------------------------
-- 本地方法声明
-------------------------------------------------------------
local _handleMsg

-------------------------------------------------------------
-- 成员方法声明
-------------------------------------------------------------

--[[--
    描述：连接服务

    @param none

    @return none
]]
function MsgManager:connect()
    Log.i("IS_TEST=", IS_TEST)

    if IS_TEST then
        TestServer:registerAckListener(_handleMsg)
        TestServer:startServer()
        isConnect_ = true
    else
        if isConnect_ or socket_ then
            Log.e("tcp is already connect")
            return
        end

        socket_ = SimpleTCP.new(SERVER_IP, SERVER_PORT, _handleMsg)
        socket_:connect()
    end
end

--[[--
    描述：断开与服务的连接

    @param none

    @return none
]]
function MsgManager:disconnect()
    Log.i("IS_TEST=", IS_TEST)

    if IS_TEST then
        TestServer:unregisterAckListener()
        TestServer:stopServer()
        isConnect_ = false
    else
        if not isConnect_ or not socket_ then
            return
        end

        socket_:close()
        socket_ = nil
        isConnect_ = false
    end
end

--[[--
    描述：是否连接服务

    @param none

    @return boolean
]]
function MsgManager:isConnect()
    return isConnect_
end

--[[--
    描述：发送消息

    @param msg 类型：table，消息数据

    @return boolean 是否发送成功
]]
function MsgManager:sendMsg(msg)
    Log.d("IS_TEST=", IS_TEST)

    if IS_TEST then
        TestServer:receiveReq(msg)
    else
        if not isConnect_ or not socket_ then
            Log.e("send msg fail, socket is not connect.")
            return false
        end

        -- 消息包装，转换为二进制json
        local js = json.encode(msg or {})
        local ba = ByteArray.new()
        ba:setPos(1)
        ba:writeInt(#js)
        ba:writeStringBytes(js)

        socket_:send(ba:getPack())
    end

    return true
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
        Log.i("正在连接...")
    elseif event == SimpleTCP.EVENT_CONNECTED then
        Log.i("连接成功！")
        isConnect_ = true
    elseif event == SimpleTCP.EVENT_FAILED then
        Log.w("连接失败！")
        isConnect_ = false
    elseif event == SimpleTCP.EVENT_CLOSED then
        Log.i("关闭连接！")
        isConnect_ = false
    elseif event == SimpleTCP.EVENT_DATA then
        -- 网络消息处理
        if data then
            local msg
            if IS_TEST then
                msg = data
            else
                local ba = ByteArray.new()
                ba:writeBuf(data)
                ba:setPos(1)
                local len = ba:readInt()
                msg = json.decode(ba:readStringBytes(len))
            end

            --Log.d("msg=", msg)

            -- 数据刷新
            MsgController:handleMsg(msg)

            -- 界面刷新
            local sceneController = SceneManager:getCurrentSceneController()
            if sceneController then
                sceneController:handleMsg(msg)
            end
        end
    else
        Log.e("unexpect event, event=", event)
    end
end

return MsgManager