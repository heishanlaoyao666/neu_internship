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
    EventManager:doEvent(EventDef.ID.CREATE_BULLET, self)
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
    子弹帧刷新

    @param dt 类型：number，时间，秒

    @return none
]]
function Bullet:update(dt)
    self.y_ = self.y_ + 30 * dt

    -- if not self.isDeath_ then
    --     if self.y_ > display.top + ConstDef.BULLET_SIZE.HEIGHT then
    --         self:destory()
    --     end
    -- end
end

return Bullet