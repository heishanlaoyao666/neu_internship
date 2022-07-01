--[[--
    Enemy.lua
    敌人类
]]

local Enemy = class("Enemy", require("app.data.ingame.Object"))
local ConstDef = require("app.def.ingame.ConstDef")
local EventDef = require("app.def.EventDef")
local EventManager = require("app.manager.EventManager")

function Enemy:ctor(health, type)
   Enemy.super.ctor(self, 70, 220,
   ConstDef.MONSTER_SIZE[type].WIDTH, ConstDef.MONSTER_SIZE[type].HEIGHT)

   self.health_ = health
   self.speed_ = ConstDef.MONSTER_SPEED

    EventManager:doEvent(EventDef.ID.CREATE_MONSTER, self)
end

--[[--
    获取血量

    @parm none

    @return 类型：number
]]
function Enemy:getHealth()
    return self.health_
end

--[[--
    受伤

    @parm n，类型：number

    @return none
]]
function Enemy:hurt(n)
    self.health_ = self.health_ - n
end

--[[--
    敌人销毁

    @param none

    @return none
]]
function Enemy:destory()
    self.isDeath_ = true
    EventManager:doEvent(EventDef.ID.DESTORY_MONSTER, self)
end

--[[--
    敌人帧刷新

    @param dt 类型：number，时间，秒

    @return none
]]
function Enemy:update(dt)
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

return Enemy