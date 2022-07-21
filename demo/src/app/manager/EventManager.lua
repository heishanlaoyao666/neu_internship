--[[
    EventManger.lua
    事件管理器
    描述：类似CMDManager
    编写：周星宇
    修订：李昊
    检查：张昊煜
]]
local EventManger = {}
local listenerMap_ = {} -- 类型：监听映射Map，key：EventId，Value：所有监听对象 回调数组

--[[--
    注册监听

    @param eventId 类型：number，事件id
    @param target 类型：Any，监听对象
    @param func 类型：Function，回调

    @return none
]]
function EventManger:regListener(eventId, target, func)
    listenerMap_[eventId] = listenerMap_[eventId] or {}

    if not listenerMap_[eventId][target] then
        listenerMap_[eventId][target] = {}
    end

    table.insert(listenerMap_[eventId][target], func )
end

--[[--
    取消注册

    @param eventId 类型：number，事件id
    @param target 类型：Any，监听对象

    @return none
]]
function EventManger:unRegListener(eventId, target)
    if not listenerMap_[eventId] then
        return
    end

    listenerMap_[eventId][target] = nil
end

--[[--
    派发事件

    @param eventId  类型：number，事件id
    @param 。。。
    
    @return none
]]
function EventManger:doEvent(eventId, ...)
    local tab = listenerMap_[eventId]
    if not tab then
        return
    end

    for tar, funcs in pairs(tab) do
        for i = 1, #funcs do
            funcs[i](...)
        end
    end
end

return EventManger