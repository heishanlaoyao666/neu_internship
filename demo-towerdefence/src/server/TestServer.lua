--[[--
    TestServer.lua

    描述：本地测试服务
]]
local TestServer = {}
local ReqController = require("server.ReqController")
local UserInfo = require("server.UserInfo")
local MsgDef = require("app.def.MsgDef")
local SendAck = require("server.SendAck")
local Log = require("app.util.Log")

local scheduler = require("framework.scheduler")

local reqQueue_ = {} -- 类型：table，请求消息队列，先进先出，尾部添加
local updateHandle_ -- 类型：scheduler，帧刷新调度器

---------------------------------------------------------------------------
-- 私有函数定义
---------------------------------------------------------------------------
local _onUpdate

--[[--
    描述：注册ack监听函数

    @param listener 类型：function，监听函数

    @return none
]]
function TestServer:registerAckListener(listener)
    if not isFunction(listener) then
        Log.e("unexpect param, listener=", listener)
        return
    end

    SendAck:setAckListener(listener)
end

--[[--
    描述：取消注册ack监听

    @param none

    @return none
]]
function TestServer:unregisterAckListener()
    SendAck:setAckListener(nil)
end

--[[--
    描述：启动服务

    @param none

    @return none
]]
function TestServer:startServer()
    Log.i()

    if not updateHandle_ then
        updateHandle_ = scheduler.scheduleUpdateGlobal(handler(self, _onUpdate))
    end

    SendAck:send({
        type = MsgDef.ACK.ACCOUNT_INFO,
        userId = UserInfo.userId_,
        nickname = UserInfo.nickname_,
        trophy = UserInfo.trophy_,
        gold = UserInfo.gold_,
        diamond = UserInfo.diamond_,
    })
end

--[[--
    描述：停止服务

    @param none

    @return none
]]
function TestServer:stopServer()
    Log.i()

    if updateHandle_ then
        scheduler.unscheduleGlobal(updateHandle_)
        updateHandle_ = nil
    end
end

--[[--
    描述：收到req消息（来自客户端）
    
    @param req 类型：table，请求消息
    
    @return none
]]
function TestServer:receiveReq(req)
    if not isTable(req) then
        Log.e("unexpect param, req=", req)
        return
    end

    -- 消息先添加到队列中
    reqQueue_[#reqQueue_ + 1] = req
end

---------------------------------------------------------------------------
-- 私有函数实现
---------------------------------------------------------------------------

--[[
    描述：帧刷新

    @param dt 类型：number，帧间隔，单位：秒

    @return none
]]
function _onUpdate(dt)
    -- 处理req消息
    if #reqQueue_ > 0 then
        for i = 1, #reqQueue_ do
            local req = reqQueue_[i]
            ReqController:handleReq(req)
        end

        reqQueue_ = {}
    end
end

return TestServer