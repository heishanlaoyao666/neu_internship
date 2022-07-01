--[[--
    BufffManager.lua
    buff管理类，负责buff的分发
    EventManger.lua
]]
local BuffManager = {}
local BuffDef = require("app.def.BuffDef")
local carrierMap_ = {} -- 类型：监听映射Map，key：EventId，Value：所有监听对象 回调数组

--[[--
    注册监听

    @param eventId 类型：number，事件id
    @param target 类型：Any，监听对象
    @param func 类型：Function，回调

    @return none
]]
function BuffManager:regListener(eventId, target, func)
    carrierMap_[eventId] = carrierMap_[eventId] or {}

    if not carrierMap_[eventId][target] then
        carrierMap_[eventId][target] = {}
    end

    table.insert(carrierMap_[eventId][target], func)
end

--[[--
    取消注册

    @param evnetId 类型：number，事件id
    @param target 类型：Any，监听对象

    @return none
]]
function BuffManager:unRegListener(eventId, target)
    if not carrierMap_[eventId] then
        return
    end

    carrierMap_[eventId][target] = nil
end

--[[--
    派发事件

    @param eventId  类型：number，事件id
    @param 。。。
    
    @return none
]]
function BuffManager:doEvent(eventId, ...)
    print(eventId)
    local tab = carrierMap_[eventId]
    print(tab)
    if not tab then
        return
    end
    for tar, funcs in pairs(tab) do
        for i = 1, #funcs do
            funcs[i](...)
        end
    end
end

--[[--
    添加buff

    @param model buff的模板
    @param caster 释放者
    @param carrier 携带者
    @param time time类
    @param durationSetTo 确实添加一个时间还是更新时间
    @param addStack 添加层数
    @param param 动态设置的字典

    
    @return none
]]
function BuffManager:AddBuffInfo(model,caster,carrier,time,addStack,param)
    carrierMap_[carrier] = carrierMap_[carrier] or {}
end
return BuffManager