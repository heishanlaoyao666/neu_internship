--[[--
    BufffTable 储存buff
]]
local BuffDef = require("app.def.BuffDef")
local BuffInfo =require("app.data.BuffInfo")
local BuffObj = require("app.data.BuffObj")

--表中使用的方法定义
--OnBeHit(state,...)
function Burn(state,damageinfo)
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
        Burn,
        nil,
        nil,
        nil
    )
}

function BuffTable:addBuffInfo(caster,target,buffmodel,addStack,durationSetTon,permanment,duration)
    buffmodel:setState(target)
    return BuffInfo.new(caster,target,buffmodel,addStack,durationSetTon,permanment,duration)
end



























return BuffTable