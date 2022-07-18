--[[--
    EventManager.lua

    描述：事件管理类
]]
local EventManager = {}
local EventDef = require("app.def.EventDef")
local Log = require("app.util.Log")

EventManager.DEF = EventDef -- 此处进行桥接，为了少require一个文件

local listenerMapMap_ = {} -- 类型：table，监听数据，二维数据，第一维key为事件id；第二维，key为唯一标识，value为function

---------------------------------------------------------------------------
-- 私有函数定义
---------------------------------------------------------------------------
local _isEventIdValid

--[[--
    描述：注册监听

    @param eventId 类型：number，事件id
    @param key 类型：...，唯一标识
    @param listener 类型：function，监听函数

    @return none
]]
function EventManager:registerListener(eventId, key, listener)
    if not _isEventIdValid(eventId) or not key or not isFunction(listener) then
        Log.e(TAG, "unexpect param, eventId not valid, or key is nil, or listener is not function.")
        return
    end

    local listenerMap = listenerMapMap_[eventId]
    if not listenerMap then
        listenerMap = {}
        listenerMapMap_[eventId] = listenerMap
    end

    if listenerMap[key] then
        Log.w(TAG, "key is already exist， key=", key)
        return
    end

    listenerMap[key] = listener
end

--[[--
    描述：注销监听

    @param eventId 类型：number，事件id
    @param key 类型：...，唯一标识

    @return none
]]
function EventManager:unregisterListener(eventId, key)
    if not _isEventIdValid(eventId) or not key then
        Log.e(TAG, "unexpect param, eventId not valid, or key is nil.")
        return
    end

    local listenerMap = listenerMapMap_[eventId]
    if not listenerMap then
        return
    end

    if listenerMap[key] then
        Log.w(TAG, "key is not exist， key=", key)
        return
    end

    listenerMap[key] = nil
end

--[[--
    描述：发送事件

    @param eventId 类型：number，事件id
    @param ...
]]
function EventManager:sendEvent(eventId, ...)
    local listenerMap = listenerMapMap_[eventId]
    if not listenerMap then
        return
    end

    for _, listener in pairs(listenerMap) do
        listener(...)
    end
end

---------------------------------------------------------------------------
-- 私有函数实现
---------------------------------------------------------------------------

--[[
    描述：检查eventId是否合法

    @param eventId 类型：number，事件id

    @return boolean
]]
function _isEventIdValid(eventId)
    local isValid = false
    if not isNumber(eventId) then
        return isValid
    end

    -- 检查id是否存在
    -- 注意，此处的设计并不好，应该将数据结构转换为map，通过查表的方式检查，而不是遍历
    for _, id in pairs(EventDef.ID) do
        if id == eventId then
            isValid = true
            break
        end
    end

    return isValid
end

return EventManager