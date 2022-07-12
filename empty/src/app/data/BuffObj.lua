--[[--
    BuffObj.lua
    Buff基类
]]
local BuffObj = class("Buff")
local BuffDef = require("app.def.BuffDef")
--[[--
    初始化数据

    @param id --类型:buffid

    @return none
]]
function BuffObj:ctor(id,tag,priority,maxStack,tickTime,onOccur,onCast,onHit,onTick,onBeHit,onKill,onBeKilled)
    --基础数值，填表初始化
    self.id_ =id
    self.tags_=tag--类型:string,tags表
    self.priority_ =priority --类型：int，buff执行顺序
    self.maxStack_ = maxStack --类型：int，buff最大层数
    self.tickTime_ = tickTime --类型:number,buff执行间隔

    --buff方法
    self.onOccur_ =onOccur  --类型; function
    self.onCast_ =onCast  --类型; function
    self.onHit_ =onHit  --类型; function
    self.onTick_ =onTick --类型:function
    self.onBeHit_ =onBeHit  --类型; function
    self.onKill_ =onKill  --类型; function
    self.onBeKilled_ =onBeKilled  --类型; function

    --实际数据
    self.permanent_ = false --类型:bool，是否是一个永久的buff
    self.runTime_ = 0 --类型: number,buff的运行时间
    self.time_= 0--类型：number,buff运行总时间
    self.caster_ =nil --类型:obj,buff施法者
    self.carrier_ = nil --类型:obj,buff携带者
    self.stack_ = 1 --类型:int ,buff当前层数
    self.ticked_ = 0  --类型:int,buff执行了多少次
    self.value_ = 0 -- 类型:number,buff的数值
    self.isdead_ = false --类型:boolen,buff是否死亡
end
--[[--
    设置buff的层数

    @param none
    @return runtime_
]]
function BuffObj:getRunTime()
    return self.runTime_
end
--[[--
    设置buff的层数

    @param stack
    @return none
]]
function BuffObj:setStack(stack)
    self.stack_=self.stack_+stack
    if self.stack_> self.maxStack_ then
        self.stack_=self.maxStack_
    end
    if self.stack_<= 0 then
        BuffObj:destroy()
    end
    return self.stack_
end
--[[--
    buff死亡

    @param none
    @return none
]]
function BuffObj:destroy()
    self.isdead_=true
end
--[[--
    设置buff的实际数据

    @param carrier --类型:obj,buff的携带者
    @param permanent --类型:boolean buff是否永久存在
    @param time --类型:number buff的存在时间
    @param value --类型:number buff的参数

    @return flag --类型:boolean 是否删除
]]
function BuffObj:setData(carrier,permanent,time,value)
    self.carrier_=carrier
    self.permanent_=permanent
    self.time_=time
    self.value_ = value
end
--[[--
    设置buff的运行时间

    @param dt -类型：number,帧间隔
    @return none
]]
function BuffObj:setRunTime(dt)
    local flag = false
    if self.isdead_ then
        flag = true
        return flag
    end
    self.runTime_=self.runTime_+dt
    if self.runTime_>=self.tickTime_ then
        self.runTime_=self.runTime_+self.tickTime_
        self:onTick()
    end
    if self.runTime_>=self.time_ and self.permanent_==false then
        flag = true
        return flag
    end
    return flag
end
--[[--
    获取buff的数值

    @param none
    @return none
]]
function BuffObj:getValue()
    return self.value_
end
--[[--
    获取buffid

    @param none
    @return none
]]
function BuffObj:getID()
    return self.id_
end
--[[--
    Buff添加时

    @param ...

    @return none
]]
function BuffObj:onOccur(...)
    if self.onOccur_ then
        self.onOccur_(self,self.carrier_,...)
    end
end
--[[--
    技能释放时

    @param ...

    @return none
]]
function BuffObj:onCast(...)
    if self.onCast_ then
        self.onCast_(self,self.carrier_,...)
    end
end
--[[--
    Buff间隔时

    @param ...

    @return none
]]
function BuffObj:onTick()
    if self.onTick_ then
        self.onTick_(self,self.carrier_)
        self.ticked_=self.ticked_+1
    end
end
--[[--
    攻击时

    @param ...

    @return none
]]
function BuffObj:onHit(...)
    if self.onHit_ then
        self.onHit_(self,self.carrier_,...)
    end
end
--[[--
    收到伤害

    @param ...

    @return none
]]
function BuffObj:onBeHit(...)
    if self.onBeHit_ then
        self.onBeHit_(self,self.carrier_,...)
    end
end
--[[--
    能伤害流程中能击杀

    @param ...

    @return none
]]
function BuffObj:onKill(...)
    if self.onKill_ then
        self.onKill_(self,self.carrier_,...)
    end
end
--[[--
    能伤害流程中被buff持有者击杀

    @param ...

    @return none
]]
function BuffObj:onBeKilled(...)
    if self.onBeHit_ then
        self.onBeHit_(self,self.carrier_,...)
    end
end
return BuffObj