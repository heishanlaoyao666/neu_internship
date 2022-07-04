--[[--
    Bullet.lua
    子弹类
]]

local Bullet = class("Bullet", require("app.data.ingame.Object"))
local ConstDef = require("app.def.ingame.ConstDef")
local EventDef = require("app.def.EventDef")
local EventManager = require("app.manager.EventManager")

--[[--
    构造函数

    @parm index_x 类型：number, x位置
    @parm index_y 类型：number, y位置
    @parm tower 类型：fightingTower, 发射子弹的塔
    @parm target_x 类型：number, 目标点x位置
    @parm target_y 类型：number, 目标点x位置

    @return none
]]
function Bullet:ctor(index_x, index_y, tower, monster)
    Bullet.super.ctor(self, index_x, index_y,
    ConstDef.BULLET_SIZE.WIDTH, ConstDef.BULLET_SIZE.HEIGHT)

    self.tower_ = tower
    self.monster_ = monster

    EventManager:doEvent(EventDef.ID.CREATE_BULLET, self)
end

--[[--
    获取发射子弹塔的id

    @parm none

    @return number
]]
function Bullet:getId()
    return self.tower_:getTower():getTowerId()
end

--[[--
    获取子弹的伤害

    @parm none

    @return number
]]
function Bullet:getHurt()
    return self.tower_:getTower():GetTowerAtk()
end

--[[--
    设置目标怪物

    @parm monster 类型：Monster

    @return none
]]
function Bullet:setMonster(monster)
    self.monster_ = monster
end

--[[--
    子弹销毁

    @param none

    @return none
]]
function Bullet:destory()
    self.isDeath_ = true
    EventManager:doEvent(EventDef.ID.DESTORY_BULLET, self)
end

--[[--
    子弹帧刷新

    @param dt 类型：number，时间，秒

    @return none
]]
function Bullet:update(dt)
    if self.monster_ ~= nil then
        local a = self.monster_:getX() - self.tower_:getX()
        local b = self.monster_:getY() - self.tower_:getY()
        local c = (a^2 + b^2)^(1/2)
        local sinx = a/c
        local siny = b/c

        local lengthC = dt * ConstDef.BULLET_SPEED
        local lengthA = lengthC * sinx
        local lengthB = lengthC * siny

        self:setX(self:getX() + lengthA)
        self:setY(self:getY() + lengthB)

        --超出屏幕范围删除
        local left = display.left - ConstDef.BULLET_SIZE.WIDTH
        local right = display.right + ConstDef.BULLET_SIZE.WIDTH
        local bottom = display.bottom - ConstDef.BULLET_SIZE.WIDTH
        local top = display.top + ConstDef.BULLET_SIZE.WIDTH
        if self:getX() < left or self:getX() > right or self:getY() < bottom or self:getY() > top then
            self:destory()
        end
    end
end

return Bullet