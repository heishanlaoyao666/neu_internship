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

    @param tower_id 类型:number 塔的id

    @return none
]]
function Bullet:ctor(tower_id)
    Bullet.super.ctor(self, 0, 0, ConstDef.BULLET_SIZE.WIDTH, ConstDef.BULLET_SIZE.HEIGHT)
    self.tower_id_ = tower_id --类型：number，塔编号
    self.atk_ = TowerDef.TABLE[tower_id].ATK --类型：number，攻击力
    self.speed_x_ = 0 --x方向坐标
    self.speed_y_ = 0 --y方向坐标
    self.buffMap_ ={} --状态表 里面存状态
    EventManager:doEvent(EventDef.ID.CREATE_BULLET, self)
end
--[[--
    添加Buff

    @param buff 类型 buff 

    @return none
]]
function Bullet:addBuff(buff)
    self.buffMap_[#self.buffMap_+1] = buff
end
--[[--
    获取塔BUFF表

    @param none

    @return life
]]
function Bullet:getBuff()
    return self.buffMap_
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

    @param x 
    @param y

    @return none
]]
function Bullet:setTarget(x,y)
    self.speed_x_ = (x-self.x_)
    self.speed_y_ = (y-self.y_)
end

--[[--
    子弹帧刷新

    @param dt 类型：number，时间，秒

    @return none
]]
function Bullet:update(dt)
    self.y_ = self.y_ + self.speed_y_ * dt *3
    self.x_ = self.x_ + self.speed_x_ * dt *3
    -- if not self.isDeath_ then
    --     if self.y_ > display.top + ConstDef.BULLET_SIZE.HEIGHT then
    --         self:destory()
    --     end
    -- end
end

return Bullet