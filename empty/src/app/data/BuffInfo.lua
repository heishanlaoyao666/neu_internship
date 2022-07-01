--[[--
    BuffInfo.lua
    Buff基类
]]
local BuffInfo = class("BuffInfo")
function BuffInfo:ctor(caster,target,buffmodel,addStack,durationSetTon,permanment,duration)
    self.caster=caster
    self.target=target
    self.buffmodel=buffmodel
    self.addStack=addStack
    self.durationSetTo=durationSetTon
    self.permanment=permanment
    self.duration=duration
end
function BuffInfo:getCaster()
    return self.caster
end
function BuffInfo:getTarget()
    return self.target
end
function BuffInfo:getBuffModel()
    return self.buffmodel
end
function BuffInfo:getStack()
    return self.addStack
end
function BuffInfo:getDurationSetTo()
    return self.durationSetTo
end
function BuffInfo:getDuration()
    return self.duration
end
return BuffInfo