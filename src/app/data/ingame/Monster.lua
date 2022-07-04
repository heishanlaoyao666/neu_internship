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
    self.health_ = self.health_ - n
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
    if self:getY() <= ConstDef.MONSTER_TOP and self:getX() == ConstDef.MONSTER_LEFT then
        self:setY(self:getY() + dt * self.speed_)
    end

    if self:getY() > ConstDef.MONSTER_TOP and self:getX() <= ConstDef.MONSTER_RIGHT then
        self:setX(self:getX() + dt * self.speed_)
    end

    if self:getY() > 220 and self:getX() > ConstDef.MONSTER_RIGHT then
        self:setY(self:getY() - dt * self.speed_)
    end
end

return Monster