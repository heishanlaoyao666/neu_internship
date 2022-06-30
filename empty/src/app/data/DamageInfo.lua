--[[--
    DamageInfo.lua
]]
local DamageInfo = class("Damage", require("app.data.Object"))
local EventDef = require("app/def/EventDef.lua")
local EventManager = require("app/manager/EventManager.lua")
--[[--
    初始化数据

    @param attack 类型 obj,攻击者
    @param target 类型 obj,被攻击者

    @return none
]]
function DamageInfo:ctor(attack,target)
    DamageInfo.super.ctor(self, 0, 0, 0, 0)
    self.attack_=attack
    self.target_=target
    self.damage_=attack:getAtk()
    self.addBuffMap_={} --伤害结束时目标添加的buff表,添加的buff

    self.tick_ = 0 --销毁时间
    self:Count()
end
--[[--
    销毁

    @param none

    @return none
]]
function DamageInfo:destory()
    self.isDeath_ = true 
    EventManager:doEvent(EventDef.ID.DESTORY_DAMAGE, self)
end

--[[--
    获取伤害数值

    @param damage 类型;number 伤害数值

    @return none
]]
function DamageInfo:getDamage(damage)
    return self.damage_
end
--[[--
    最终结果计算

    @param none

    @return none
]]
function DamageInfo:Count()
    --buff遍历
    --伤害执行
    self.target_:setLife(-self.damage_)
    self.x_=self.target_:getX()
    self.y_=self.target_:getY()
    EventManager:doEvent(EventDef.ID.CREATE_DAMAGE, self)
end
--[[--
    伤害信息帧刷新

    @param dt 类型：number，时间，秒

    @return none
]]
function DamageInfo:update(dt)
    self.tick_ = self.tick_ + dt
    self.y_=self.y_+5*dt
    if self.tick_ >=0.5 and self.isDeath_==false then
        self:destory()
    end
end
return DamageInfo