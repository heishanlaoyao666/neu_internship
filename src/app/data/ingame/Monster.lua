--[[--
    Monster.lua
    怪物类
]]

local Monster = class("Monster", require("app.data.ingame.Object"))
local ConstDef = require("app.def.ingame.ConstDef")
local EventDef = require("app.def.EventDef")
local EventManager = require("app.manager.EventManager")

--[[--
    构造函数

    @parm health，类型：number，生命
    @parm type, 类型：number, 区分小怪与精英怪

    @return none
]]
function Monster:ctor(health, type)
   Monster.super.ctor(self, 70, 220,
   ConstDef.MONSTER_SIZE[type].WIDTH, ConstDef.MONSTER_SIZE[type].HEIGHT)

   self.health_ = health
   self.speed_ = ConstDef.MONSTER_SPEED

    if type == 1 then
        EventManager:doEvent(EventDef.ID.CREATE_MONSTER, self)
    else
        EventManager:doEvent(EventDef.ID.CREATE_ELITE_MONSTER, self)
    end

    --怪物状态
    self.isBurning = 0 -- 灼烧
    self.ispoisoning = 0 -- 中毒
    self.isFrail = 0 -- 脆弱
    self.isConfusion = 0 -- 混乱
    self.isDecelerate = 0 -- 减速

    --状态数值
    self.burningVal = 0 -- 灼烧数值
    self.poisoningVal  = 0 -- 中毒数值
    self.frailVal  = 1 -- 脆弱数值
    self.decelerateVal  = 0 -- 减速数值

    --状态时间记录
    self.burningTime = 1 -- 灼烧时间记录
    self.poisoningTime = 1 -- 中毒时间记录
    self.frailTime = 0 -- 脆弱时间记录
    self.confusionTime = 0 -- 混乱时间记录

    self.burningTimes = 0 -- 灼烧次数

end

--[[--
    赋予灼烧状态

    @parm t 类型：number，开关
    @parm val 类型：number，伤害

    @return none
]]
function Monster:setBurning(t, val)
    self.isBurning = t
    if self.burningVal < val then
        self.burningVal = val
    end
    self.burningTimes = 2
end

--[[--
    赋予中毒状态

    @parm t 类型：number，开关
    @parm val 类型：number，伤害

    @return none
]]
function Monster:setPoisoning(t, val)
    self.ispoisoning = t
    if self.poisoningVal < val then
        self.poisoningVal = val
    end
end

--[[--
    赋予脆弱状态

    @parm t 类型：number，开关
    @parm val 类型：number，伤害

    @return none
]]
function Monster:setFrail(t, val)
    self.isFrail = t
    if self.frailVal < val then
        self.frailVal = val
    end
    self.frailTime = 2
end

--[[--
    赋予混乱状态

    @parm t 类型：number，开关
    @parm val 类型：number，持续时间

    @return none
]]
function Monster:setConfusion(t, val)
    self.isConfusion = t
    if self.confusionTime < val then
        sel.confusionTime = val
    end
end

--[[--
    赋予减速状态

    @parm t 类型：number，开关
    @parm val 类型：number，减速比例

    @return none
]]
function Monster:setDecelerate(t, val)
    self.isDecelerate = t
    if self.decelerateVal < val then
        self.decelerateVal = val
    end
end

--[[--
    获取血量

    @parm none

    @return 类型：number
]]
function Monster:getHealth()
    return self.health_
end

--[[--
    受伤

    @parm n，类型：number

    @return none
]]
function Monster:hurt(n)
    self.health_ = self.health_ - n * (self.frailVal + 1)
end

--[[--
    怪物se销毁

    @param none

    @return none
]]
function Monster:destory()
    self.isDeath_ = true
    EventManager:doEvent(EventDef.ID.DESTORY_MONSTER, self)
end

--[[--
    怪物帧刷新

    @param dt 类型：number，时间，秒

    @return none
]]
function Monster:update(dt)
    if self:getY() <= ConstDef.MONSTER_TOP and self:getX() <= ConstDef.MONSTER_LEFT then
        self:setY(self:getY() + dt * self.speed_)
    end

    if self:getY() >= ConstDef.MONSTER_TOP and self:getX() <= ConstDef.MONSTER_RIGHT then
        self:setX(self:getX() + dt * self.speed_)
    end

    if self:getY() >= ConstDef.MONSTER_BOTTOM and self:getX() >= ConstDef.MONSTER_RIGHT then
        self:setY(self:getY() - dt * self.speed_)
    end

    --状态执行
    --灼烧
    if self.isBurning == 1 then
        self.burningTime = self.burningTime + dt
        if self.burningTime >= 1 then
            self.burningTime = self.burningTime - 1
            self.burningTimes = self.burningTimes - 1
            self:hurt(self.burningVal)
        end
        if self.burningTimes == 0 then
            self.isBurning = 0
        end
    end
    --中毒
    if self.ispoisoning == 1 then
        self.poisoningTime = self.poisoningTime + dt
        if self.poisoningTime >= 1 then
            self.poisoningTime = self.poisoningTime - 1
            self:hurt(self.poisoningVal)
        end
    end
    --脆弱
    if self.isFrail == 1 then
        self.frailTime = self.frailTime - dt
        if self.frailTime < 0 then
            self.isFrail = 0
            self.frailVal = 0
        end
    end
    --混乱
    if self.isConfusion == 1 then
        self.confusionTime = self.confusionTime - dt
        self.speed_ = 0
        if self.confusionTime < 0 then
            self.isConfusion = 0
            self.speed_ = ConstDef.MONSTER_SPEED
        end
    end
    --减速
    if self.isDecelerate == 1 then
        self.speed_ = ConstDef.MONSTER_SPEED * (1 - self.decelerateVal)
    end
end

return Monster