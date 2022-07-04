--[[--
    DamageInfo.lua
]]
local DamageInfo = class("Damage", require("app.data.Object"))
local EventDef = require("app/def/EventDef.lua")
local EventManager = require("app/manager/EventManager.lua")
local ConstDef     = require("app.def.ConstDef")
--[[--
    初始化数据

    @param attack 类型 obj,攻击者
    @param target 类型 obj,被攻击者
    @param damage 类型 number,基础伤害数值
    @param tag 类型 number,伤害类型

    @return none
]]
function DamageInfo:ctor(attack,target,damage,tag,gamedata)
    DamageInfo.super.ctor(self, 0, 0, 0, 0)
    self.attack_=attack or nil
    self.target_=target
    self.damage_=damage
    self.gamedata_=gamedata --游戏总数据
    self.addBuffMap_={} --伤害结束时目标添加的buff表,添加的buff

    self.tick_ = 0 --销毁时间
    EventManager:doEvent(EventDef.ID.INIT_DAMAGE, self)
    self:Count(tag)
end
--[[--
    获取游戏数据

    @param none

    @return self.gamedata_
]]
function DamageInfo:getGameData()
    return self.gamedata_
end
--[[--
    获取攻击目标

    @param none

    @return none
]]
function DamageInfo:getTarget()
    return self.target_
end
--[[--
    设置buff添加

    @param buffInfo 类型:BuffInfo buff信息

    @return none
]]
function DamageInfo:setBuffInfo(BuffInfo)
    self.addBuffMap_[#self.addBuffMap_+1] = BuffInfo
end
--[[--
    修改攻击伤害

    @param damage

    @return none
]]
function DamageInfo:setDamage(damage)
    self.damage_=self.damage_+damage
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
function DamageInfo:Count(tag)
    --buff遍历
    if self.attack_ then
        for _, func in pairs(self.attack_:getBuff()) do
            func:onHit(self)
        end
    end
    if self.target_ and tag == ConstDef.DAMAGE.NORMAL then
        for _, func in pairs(self.target_:getBuff())  do

            func:onBeHit(self)
        end
    end
    --伤害执行
    self.target_:setLife(-self.damage_)
    --击杀后处理
    self.x_=self.target_:getX()
    self.y_=self.target_:getY()
    --伤害结束处理
    for i = 1,#self.addBuffMap_ do
        self.target_:addBuff(self.addBuffMap_[i])
    end
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