--[[--
    BuffObj.lua
    Buff基类
]]
local BuffObj = class("Object")

--[[--
    初始化数据

    @param none

    @return none
]]
function BuffObj:init()
    --基础数值，填表初始化
    self.tags={ }--类型:string,tags表
    self.priority =0 --类型：int，buff执行顺序
    self.maxStack = 1 --类型：int，buff最大层数
    --实际数据
    self.time_= 0--类型：number,buff运行时间
    self.caster_ =nil --类型:obj,buff施法者
    self.carrier_ = nil --类型:obj,buff携带者
    self.stack_ = 1 --类型:int ,buff当前层数
    
end
--[[--
    Buff添加时

    @param none

    @return none
]]
function BuffObj:onOccur()
    
end
--[[--
    攻击时

    @param target 攻击目标

    @return none
]]
function BuffObj:onHit(target)
    
end
--[[--
    收到伤害

    @param attacker 攻击者

    @return none
]]
function BuffObj:onBeHit(attacker)
    
end
return BuffObj