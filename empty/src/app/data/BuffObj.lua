--[[--
    BuffObj.lua
    Buff基类
]]
local BuffObj = class("Buff")
local BuffDef = require("app.def.BuffDef")
--[[--
    初始化数据

    @param none

    @return none
]]
function BuffObj:ctor(id,tag,priority,maxStack,tickTime,onOccur,onHit,onBeHit,onKill,onBeKilled,state)
    --基础数值，填表初始化
    self.id_ =id
    self.tags_=tag--类型:string,tags表
    self.priority_ =priority --类型：int，buff执行顺序
    self.maxStack_ = maxStack --类型：int，buff最大层数
    self.tickTime_ = tickTime --类型:number,buff执行间隔
    self.permanent_ = false --类型:bool，是否是一个永久的buff

    self.state_=state -- 类型:obj,buff的负责对象
    --实际数据
    self.time_= 0--类型：number,buff运行时间
    self.caster_ =nil --类型:obj,buff施法者
    self.carrier_ = nil --类型:obj,buff携带者
    self.stack_ = 1 --类型:int ,buff当前层数
    self.ticked_ = 0  --类型:int,buff执行了多少次

    --buff方法
    self.onOccur_ =onOccur  --类型; function
    self.onHit_ =onHit  --类型; function
    self.onBeHit_ =onBeHit  --类型; function
    self.onKill_ =onKill  --类型; function
    self.onBeKilled_ =onBeKilled  --类型; function
end
--[[--
    设置buff的负责对象

    @param state
    @return none
]]
function BuffObj:setState(state)
    self.state_=state
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
        self.onOccur_(...)
    end
end
--[[--
    攻击时

    @param ...

    @return none
]]
function BuffObj:onHit(...)
    if self.onHit_ then
        self.onHit_(...)
    end
end
--[[--
    收到伤害

    @param ...

    @return none
]]
function BuffObj:onBeHit(...)
    if self.onBeHit_ then
        self.onBeHit_(self.state_,...)
    end
end
--[[--
    能伤害流程中能击杀

    @param ...

    @return none
]]
function BuffObj:onKill(...)
    if self.onKill_ then
        self.onKill_(...)
    end
end
--[[--
    能伤害流程中被buff持有者击杀

    @param ...

    @return none
]]
function BuffObj:onBeKilled(...)
    if self.onBeHit_ then
        self.onBeHit_(...)
    end
end
return BuffObj