--[[
    TCP.lua
    描述：用户TCP通信的工具类
    编写：张昊煜
    修订：
    检查：
]]
local SimpleTCP = require("framework.SimpleTCP")
local ByteArray = require("framework.ByteArray")
local json = require("framework.json")
local scheduler = require("framework.scheduler")

local HEART_BEAT_INTERVAL = 5
local STATE_CONNECTED = 1
local STATE_CLOSED = 2
local STATE_FAILED = 3

local KEY_TYPE = "type"
local KEY_HEART_BEAT = "serial"

local TCP = {}

local socket_ = nil
local state_ = nil
local heartScheduler_ = nil
local reqHeartSerial_ = 1
local listenerMap_ = {}
local listenerMapOneTime_ = {}
local requestMap_ = {}

--[[--
    向服务端发送消息
    如果没初始化连接则会初始化，无需在外部手动初始化
    另外连接建立之后如果不主动close会一直在后台保持，切换Scene不会打断连接

    @param type 消息的type字段，一个数字，一定要传入，和服务端保证一致即可
    @param msg 消息内容，一个table
    @param respType 返回消息的type字段，一个数字，可选
    @param callbackF 处理服务器返回消息的回调函数，一个function，可选

    @return none
]]
function TCP.send(type, msg, respType, callbackF)
    TCP:_init()
    msg[KEY_TYPE] = type
    if respType ~= nil and callbackF ~= nil then
        listenerMapOneTime_[respType] = callbackF
    end
    if state_ ~= STATE_CONNECTED then
        -- 如果连接未建立，则需要先建立连接，待发送的消息则先加入requestMap_里面等待
        print("WAIT .... ")
        table.insert(requestMap_, TCP:_clone(msg))
    else
        socket_:send(TCP:_package(msg))
    end
end

--[[--
    注册客户端监听服务端发来消息的回调函数

    @param type 服务端发来消息的type字段
    @param callbackF 处理服务器返回消息的回调函数，一个function

    @return none
]]
function TCP.regListener(type, callbackF)
    listenerMap_[type] = callbackF
end

--[[--
    解除注册客户端监听服务端发来消息的回调函数

    @param type 服务端发来消息的type字段

    @return none
]]
function TCP.unRegListener(type)
    listenerMap_[type] = nil
end

--[[--
    关闭连接，整个游戏退出时主动调用即可
    （其实如果不调用此函数，用户也不会有感知，也无明显报错，但就无法进行TCP的四次挥手，最后看情况调用吧）

    @param none

    @return none
]]
function TCP.close()
    if socket_ and state_ == STATE_CONNECTED then
        print("tcp fin")
        socket_:close()
    end
end

--[[--
    获取这个类中的socket_变量，一般无需外部主动调用

    @param none

    @return socket_
]]
function TCP.getSocket()
    return socket_
end

--[[--
    TCP连接的初始化

    @param none

    @return none
]]
function TCP:_init()
    print("init")
    if self.instance == nil or (state_ == STATE_CLOSED and socket_ ~= nil) then
        o = o or {}
        setmetatable(o, self)
        self.instance = o

        socket_ = nil
        socket_ = SimpleTCP.new("127.0.0.1", 33333, function(event, data)
            TCP:_handleMsg(self, event, data)
        end)
        socket_:connect()
    end
end

--[[--
    深拷贝一个table
    https://juejin.cn/post/6844903972986159117

    @param obj 要拷贝的table

    @return newTable
]]
function TCP:_clone(obj)
    if type(obj) ~= "table" then
        return obj
    end
    local newtable = {}

    for key,value in pairs(obj) do
        newtable[key] = TCP:_clone(value)
    end
    setmetatable(newtable,getmetatable(obj))
    return newtable
end

--[[--
    发送心跳包，改自Test_TCP.lua

    @param serial 心跳序列号

    @return none
]]
function TCP:_requestHeartBeat(serial)
    if not socket_ or state_ ~= STATE_CONNECTED then
        return
    end

    local msg = {}
    msg[KEY_TYPE] = 4
    -- msg[KEY_PLAYER_ID] = 1112
    msg[KEY_HEART_BEAT] = serial
    socket_:send(TCP:_package(msg))
    -- print("client send heart beat")
end

--[[--
    打包消息，复制自Test_TCP.lua

    @param msg 一个table，要发生的消息

    @return none
]]
function TCP:_package(msg)
    local json = json.encode(msg or {})
    local array = ByteArray.new()
    array:setPos(1)
    array:writeInt(#json)
    array:writeStringBytes(json)
    return array:getPack()
end

--[[--
    接收消息，改自Test_TCP.lua

    @param msg 一个table，要发生的消息

    @return none
]]
function TCP:_handleMsg(self, event, data)
    print("客户端接收到了", event)
    if type(event) ~= "string" then
        error("event type is invalid")
    end

    if event == SimpleTCP.EVENT_CONNECTING then
        print("connecting ...")
    elseif event == SimpleTCP.EVENT_CONNECTED then
        state_ = STATE_CONNECTED
        -- register heart beat loop schedule, 5s req once
        heartScheduler_ = scheduler.scheduleGlobal(function(dt)
                TCP:_requestHeartBeat(reqHeartSerial_)
                reqHeartSerial_ = reqHeartSerial_ + 1
            end,
        HEART_BEAT_INTERVAL)
        print("connected. now can send")
        while #requestMap_ ~= 0  do
            socket_:send(TCP:_package(requestMap_[1]))
            table.remove(requestMap_, 1)
        end
    elseif event == SimpleTCP.EVENT_FAILED then
        state_ = STATE_CLOSED
    elseif event == SimpleTCP.EVENT_CLOSED then
        state_ = STATE_CLOSED
    elseif event == SimpleTCP.EVENT_DATA then
        if data then
            local ba = ByteArray.new()
            ba:writeBuf(data)
            ba:setPos(1)
            local len = ba:readInt()
            local dataOK = json.decode(ba:readStringBytes(len))

            local f = listenerMapOneTime_[dataOK[KEY_TYPE]]
            if f then
                f(dataOK)
                listenerMapOneTime_[dataOK[KEY_TYPE]] = nil
            end

            f = listenerMap_[dataOK[KEY_TYPE]]
            if f then
                f(dataOK)
            end
        end
    else
        error("event type is unknown")
    end
end

return TCP
