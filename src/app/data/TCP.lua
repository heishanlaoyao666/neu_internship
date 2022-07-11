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
local KEY_PLAYER_ID = "playerid"

local MSG_TYPE = {
    REQ_HEART_BEAT = 4,
    ACK_HEART_BEAT = 524288 + 4
}

local socket_
local state_
local heartScheduler_

local __package
local __handleMsg
local __requestHeartBeat

local reqHeartSerial_ = 1
local lastAckTime_ = 0
local lastHeartSerial_ = 1

--[[--
    https://juejin.cn/post/6844903972986159117
    深拷贝一个table

    @param obj 要拷贝的table

    @return newTable
]]
function clone(obj)
    if type(obj) ~= "table" then
        return obj
    end
    local newtable = {}

    for key,value in pairs(obj) do
        newtable[key] = clone(value)
    end
    setmetatable(newtable,getmetatable(obj))
    return newtable
end


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
function send(type, msg, respType, callbackF)
    -- print("in send func")
    msg[KEY_TYPE] = type
    if respType ~= nil and callbackF ~= nil then
        -- addListener(respType, callbackF)
        Singleton.listenerMapOneTime[respType] = callbackF
    end
    init()
    if state_ ~= STATE_CONNECTED then 
        -- 如果连接未建立，则需要先建立连接，先加入map里面等待
        print("WAIT .... ")
        table.insert(Singleton:Instance().requestMap, clone(msg))
    else
        socket_:send(__package(msg))
    end
end

--[[--
    注册客户端监听服务端发来消息的回调函数

    @param type 服务端发来消息的type字段
    @param callbackF 处理服务器返回消息的回调函数，一个function

    @return none
]]
function regListener(type, callbackF)
    -- print("in addListener")
    -- local id = #Singleton:Instance().listenerMap + 1
    Singleton:Instance().listenerMap[type] = callbackF
end

--[[--
    解除注册客户端监听服务端发来消息的回调函数

    @param type 服务端发来消息的type字段

    @return none
]]
function unRegListener(type)
    -- print("in delListener")
    Singleton:Instance().listenerMap[type] = nil
    -- local i = 1
    -- for key, value in pairs(Singleton:Instance().listenerMap) do
    --     if key == type then
    --         table.remove (Singleton:Instance().listenerMap, i)
    --     end
    --     i = i + 1
    -- end
    -- dump(Singleton:Instance().listenerMap)
end

--[[--
    初始化，一般不需要外部主动调用

    @param none

    @return none
]]
function init()
    Singleton:Instance()
end

--[[--
    关闭连接，整个游戏退出时主动调用即可
    （其实如果不调用此函数，用户也不会有感知，也无明显报错，但就无法进行TCP的四次挥手，最后看情况调用吧）

    @param none

    @return none
]]
function close()
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
function getSocket()
    return socket_
end

Singleton = {}

function Singleton:new(o)
    socket_ = nil
    socket_ =
    SimpleTCP.new(
        "127.0.0.1",
        33333,
        function(event, data)
            __handleMsg(self, event, data)
        end
    )
    print("tcp start connent in SINGLETON -------------------------- ", SimpleTCP._VERSION)
    socket_:connect()
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    self.listenerMap = {}
    self.listenerMapOneTime = {}
    self.requestMap = {}
    return o
end

function Singleton:Instance()
    if self.instance == nil or (state_ == STATE_CLOSED and socket_ ~= nil) then
        self.instance = self:new()
    end
    return self.instance
end


function __requestHeartBeat(serial)
    if not socket_ or state_ ~= STATE_CONNECTED then
        return
    end

    local msg = {}
    msg[KEY_TYPE] = MSG_TYPE.REQ_HEART_BEAT
    -- msg[KEY_PLAYER_ID] = 1112
    msg[KEY_HEART_BEAT] = serial
    socket_:send(__package(msg))
    -- print("client send heart beat")
end

function __package(msg)
    local json = json.encode(msg or {})
    local array = ByteArray.new()
    array:setPos(1)
    array:writeInt(#json)
    array:writeStringBytes(json)
    return array:getPack()
end

function __handleMsg(self, event, data)
    print("客户端接收到了", event)
    if type(event) ~= "string" then
        error("event type is invalid")
    end

    --[[ 注释掉了根据请求时间差大于多少秒就主动close掉连接的功能
    local curTime = os.time()
    if lastAckTime_ ~= 0 and curTime - lastAckTime_ > 100 then
        print("hadn't receive ack too long, close the connection")
        socket_:close()
        socket_ = nil
        return
    else
        print(lastAckTime_, curTime, curTime - lastAckTime_)
        lastAckTime_ = curTime
    end
    ]]

    if event == SimpleTCP.EVENT_CONNECTING then
        print("connecting ...")
    elseif event == SimpleTCP.EVENT_CONNECTED then
        state_ = STATE_CONNECTED
        -- register heart beat loop schedule, 5s req once
        heartScheduler_ =
            scheduler.scheduleGlobal(
            function(dt)
                __requestHeartBeat(reqHeartSerial_)
                reqHeartSerial_ = reqHeartSerial_ + 1
            end,
            HEART_BEAT_INTERVAL
        )
        print("connected. now can send")
        while #Singleton:Instance().requestMap ~= 0  do
            -- print(#Singleton:Instance().requestMap)
            -- dump(Singleton:Instance().requestMap)
            socket_:send(__package(Singleton:Instance().requestMap[1]))
            table.remove(Singleton:Instance().requestMap, 1)
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

            -- for key, value in pairs(Singleton.listenerMap) do
            --     -- print(value[1])
            --     if value[1] == dataOK[KEY_TYPE] then
            --         value[2](dataOK)
            --     end
            -- end

            local f = Singleton.listenerMapOneTime[dataOK[KEY_TYPE]]
            if f then
                f(dataOK)
                Singleton.listenerMapOneTime[dataOK[KEY_TYPE]] = nil
            end

            f = Singleton.listenerMap[dataOK[KEY_TYPE]]
            if f then
                f(dataOK)
            end
        end
    else
        error("event type is unknown")
    end
end

return {send = send, init = init, close = close, getSocket = getSocket, regListener = regListener, unRegListener = unRegListener}
