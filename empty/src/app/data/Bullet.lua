--[[--
    Bullet.lua
    子弹数据文件
]]
local Bullet = class("Bullet", require("app.data.Object"))
local ConstDef = require("app.def.ConstDef")
local EventDef = require("app.def.EventDef")
local EventManager = require("app/manager/EventManager.lua")
local TowerDef = require("app/def/TowerDef.lua")
--[[--
    构造函数

    @param tower 类型:子弹的发射者塔

    @return none
]]
function Bullet:ctor(tower)
    Bullet.super.ctor(self, 0, 0, ConstDef.BULLET_SIZE.WIDTH, ConstDef.BULLET_SIZE.HEIGHT)
    self.tower_ =tower
    self.tower_id_ = tower:getID() --类型：number，塔编号
    self.speed_x_ = 0 --x方向速度
    self.speed_y_ = 0 --y方向速度
    self.target_ =nil --子弹目标
    --buff表初始化
    EventManager:doEvent(EventDef.ID.CREATE_BULLET, self)
end
--[[--
    获取塔伤害

    @param none

    @return life
]]
function Bullet:getTower()
    return self.tower_
end
--[[--
    获取塔伤害

    @param none

    @return life
]]
function Bullet:getAtk()
    return self.atk_
end
--[[--
    获取塔ID

    @param none

    @return life
]]
function Bullet:getID()
    return self.tower_id_
end
--[[--
    子弹命中爆炸

    @param none

    @return none
]]
function Bullet:bomb()
    EventManager:doEvent(EventDef.ID.BULLET_BOMB, self)
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
    子弹设置目标

    @param monster

    @return none
]]
function Bullet:setTarget(monster)
    self.target_ = monster
end

--[[--
    获取子弹目标

    @param none

    @return target_
]]
function Bullet:getTarget(monster)
    return self.target_
end
--[[--
    子弹帧刷新

    @param dt 类型：number，时间，秒

    @return none
]]
function Bullet:update(dt)
    if not self.target_ then
        self:destory()
        return
    end
    self.speed_x_ = (self.target_:getX()-self.x_)
    self.speed_y_ = (self.target_:getY()-self.y_)
    self.y_ = self.y_ + self.speed_y_ * dt *10
    self.x_ = self.x_ + self.speed_x_ * dt *10
    -- if not self.isDeath_ then
    --     if self.y_ > display.top + ConstDef.BULLET_SIZE.HEIGHT then
    --         self:destory()
    --     end
    -- end
end

return Bullet