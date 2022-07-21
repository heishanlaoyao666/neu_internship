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

    @parm index_x 类型：number，位置x
    @parm index_y 类型：number，位置y
    @parm health 类型：number，生命
    @parm type 类型：number, 区分小怪与精英怪与boss
    @parm id 类型：number, 区分boss类型

    @return none
]]
function Monster:ctor(index_x, index_y, health, type, id)

    Monster.super.ctor(self, index_x, index_y,
    ConstDef.MONSTER_SIZE[type].WIDTH, ConstDef.MONSTER_SIZE[type].HEIGHT)

    self.health_ = health
    self.fullHealth_ = health
    self.speed_ = ConstDef.MONSTER_SPEED
    self.type_ = type
    self.id_ = id

    if self.type_ == 1 then
        EventManager:doEvent(EventDef.ID.CREATE_MONSTER, self)
    elseif self.type_ == 2 then
        EventManager:doEvent(EventDef.ID.CREATE_ELITE_MONSTER, self)
    elseif self.type_ == 3 then
        EventManager:doEvent(EventDef.ID.CREATE_BOSS, self)
    end

    --怪物状态
    self.isBurning_ = 0 -- 灼烧
    self.ispoisoning_ = 0 -- 中毒
    self.isFrail_ = 0 -- 脆弱
    self.isConfusion_ = 0 -- 混乱
    self.isDecelerate_ = 0 -- 减速

    --状态数值
    self.burningVal_ = 0 -- 灼烧数值
    self.poisoningVal_  = 0 -- 中毒数值
    self.frailVal_  = 1 -- 脆弱数值
    self.decelerateVal_  = 0 -- 减速数值

    --状态时间记录
    self.burningTime_ = 1 -- 灼烧时间记录
    self.poisoningTime_ = 1 -- 中毒时间记录
    self.frailTime_ = 0 -- 脆弱时间记录
    self.confusionTime_ = 0 -- 混乱时间记录

    self.burningTimes_ = 0 -- 灼烧次数

    self.accelerated_ = 0 --特殊怪，会加速

    --boss使用属性
    self.time_ = 0 -- 计时器
    self.ina_ = 0 -- 是否无敌
    self.monsterNum_ = 0 -- 已召唤数
end

--[[--
    获取召唤数

    @pram none

    @return 类型：number
]]
function Monster:getNum()
    return self.monsterNum_
end

--[[--
    设置召唤数

    @parm n 类型：number

    @return none
]]
function Monster:setNum(n)
    self.monsterNum_ = n
end

--[[--
    更新计时器

    @parm dt 类型：number，帧间隔，单位秒

    @return 类型：number
]]
function Monster:updateTime(dt)
    self.time_ = self.time_ + dt
    return self.time_
end

--[[--
    返回类型

    @parm none

    @return number
]]
function Monster:getType()
    return self.type_
end

--[[--
    获取bossid

    @parm none

    @return none
]]
function Monster:getId()
    return self.id_
end

--[[--
    设置该怪为特殊怪

    @parm none

    @return none
]]
function Monster:setSpecial()
    self.accelerated_ = 1
end

--[[--
    获取是否为特殊怪

    @parm none

    @return boolen
]]
function Monster:isSpecial()
    return self.accelerated_ == 1
end

--[[--
    设置速度

    @parm type

    @return none
]]
function Monster:setSpeed(type)
    if type == 1 then
        self.speed_ = 2 * ConstDef.MONSTER_SPEED
    elseif type == 2 then
        self.speed_ = ConstDef.MONSTER_SPEED
    end
end

--[[--
    获取最初的血量

    @parm none

    @return number
]]
function Monster:getFullhealth()
    return self.fullHealth_
end

--[[--
    赋予灼烧状态

    @parm t 类型：number，开关
    @parm val 类型：number，伤害

    @return none
]]
function Monster:setBurning(t, val)
    self.isBurning_ = t
    if self.burningVal_ < val then
        self.burningVal_ = val
    end
    self.burningTimes_ = 2
end

--[[--
    赋予中毒状态

    @parm t 类型：number，开关
    @parm val 类型：number，伤害

    @return none
]]
function Monster:setPoisoning(t, val)
    self.ispoisoning_ = t
    if self.poisoningVal_ < val then
        self.poisoningVal_ = val
    end
end

--[[--
    赋予脆弱状态

    @parm t 类型：number，开关
    @parm val 类型：number，伤害

    @return none
]]
function Monster:setFrail(t, val)
    self.isFrail_ = t
    if self.frailVal_ < val then
        self.frailVal_ = val
    end
    self.frailTime_ = 2
end

--[[--
    赋予混乱状态

    @parm t 类型：number，开关
    @parm val 类型：number，持续时间

    @return none
]]
function Monster:setConfusion(t, val)
    self.isConfusion_ = t
    if self.confusionTime_ < val then
        sel.confusionTime_ = val
    end
end

--[[--
    赋予减速状态

    @parm t 类型：number，开关
    @parm val 类型：number，减速比例

    @return none
]]
function Monster:setDecelerate(t, val)
    self.isDecelerate_ = t
    if self.decelerateVal_ < val then
        self.decelerateVal_ = val
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
    self.health_ = self.health_ - n * (self.frailVal_ + 1)
end

--[[--
    怪物销毁

    @param none

    @return none
]]
function Monster:destory()
    self.isDeath_ = true
    if self.type_ == 1 then
        EventManager:doEvent(EventDef.ID.DESTORY_MONSTER, self)
    elseif self.type_ == 2 then
        EventManager:doEvent(EventDef.ID.DESTORY_ELITE_MONSTER, self)
    elseif self.type_ == 3 then
        EventManager:doEvent(EventDef.ID.DESTORY_BOSS, self)
    end
end

--[[--
    怪物帧刷新

    @param dt 类型：number，时间，秒

    @return none
]]
function Monster:update(dt)
    --我方
    if self:getY() <= ConstDef.MONSTER_TOP and self:getX() <= ConstDef.MONSTER_LEFT and self:getY() < 700 then
        self:setY(self:getY() + dt * self.speed_)
    elseif self:getY() >= ConstDef.MONSTER_TOP and self:getX() <= ConstDef.MONSTER_RIGHT and self:getY() < 700 then
        self:setX(self:getX() + dt * self.speed_)
    elseif self:getY() >= ConstDef.MONSTER_BOTTOM and self:getX() >= ConstDef.MONSTER_RIGHT and self:getY() < 700 then
        self:setY(self:getY() - dt * self.speed_)
    --敌方
    elseif self:getY() >= ConstDef.ENEMY_MONSTER_BOTTOM and self:getX() >= ConstDef.ENEMY_MONSTER_RIGHT then
        self:setY(self:getY() - dt * self.speed_)
    elseif self:getY() <= ConstDef.ENEMY_MONSTER_BOTTOM and self:getX() >= ConstDef.ENEMY_MONSTER_LEFT then
        self:setX(self:getX() - dt * self.speed_)
    elseif self:getY() <= ConstDef.ENEMY_MONSTER_TOP and self:getX() <= ConstDef.ENEMY_MONSTER_LEFT then
        self:setY(self:getY() + dt * self.speed_)
    end

    --状态执行
    --灼烧
    if self.isBurning_ == 1 then
        self.burningTime_ = self.burningTime_ + dt
        if self.burningTime_ >= 1 then
            self.burningTime_ = self.burningTime_ - 1
            self.burningTimes_ = self.burningTimes_ - 1
            self:hurt(self.burningVal_)
        end
        if self.burningTimes_ == 0 then
            self.isBurning_ = 0
        end
    end
    --中毒
    if self.ispoisoning_ == 1 then
        self.poisoningTime_ = self.poisoningTime_ + dt
        if self.poisoningTime_ >= 1 then
            self.poisoningTime_ = self.poisoningTime_ - 1
            self:hurt(self.poisoningVal_)
        end
    end
    --脆弱
    if self.isFrail_ == 1 then
        self.frailTime_ = self.frailTime_ - dt
        if self.frailTime_ < 0 then
            self.isFrail_ = 0
            self.frailVal_ = 0
        end
    end
    --混乱
    if self.isConfusion_ == 1 then
        self.confusionTime_ = self.confusionTime_ - dt
        self.speed_ = 0
        if self.confusionTime_ < 0 then
            self.isConfusion_ = 0
            self.speed_ = ConstDef.MONSTER_SPEED
        end
    end
    --减速
    if self.isDecelerate_ == 1 then
        self.speed_ = ConstDef.MONSTER_SPEED * (1 - self.decelerateVal_)
    end
end

return Monster