--[[--
    BufffTable 储存buff
]]
local BuffDef = require("app.def.BuffDef")
local BuffInfo =require("app.data.BuffInfo")
local BuffObj = require("app.data.BuffObj")

--表中使用的方法定义 state代表buff的携带者
--OnBeHit(buff,state,...)
function Burn(buff,state,damageinfo)
    damageinfo:setDamage(20)
end

local BuffTable = {
    ["burn"] = BuffObj.new(
        "burn",
        {BuffDef.TAG.BURN},
        0,
        1,
        0,
        nil,
        nil,
        nil,
        Burn,
        nil,
        nil,
        nil
    )
}
--[[--
    添加buff


    @param caster 释放者
    @param carrier 携带者
    @param model buff的模板
    @param durationSetTo 确实添加一个时间还是更新时间 true为添加时间，false为更新时间
    @param addStack 添加层数
    @param duration 添加的世界

    
    @return none
]]
function BuffTable:addBuffInfo(caster,carrier,buffmodel,addStack,durationSetTon,permanment,duration)
    buffmodel:setState(carrier)
    return BuffInfo.new(caster,carrier,buffmodel,addStack,durationSetTon,permanment,duration)
end



























return BuffTable