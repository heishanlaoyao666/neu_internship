--[[--
    Enemy.lua
    怪物数据文件
]]
local Enemy = class("Enemy", require("app.data.Object"))
local ConstDef = require("app.def.ConstDef")
local EventDef = require("app.def.EventDef")
local EventManager = require("app/manager/EventManager.lua")

local Target = nil --类型：table 目标点表
--[[--
    构造函数

    @param none

    @return none
]]
function Enemy:ctor()
    Enemy.super.ctor(self, 0, 0, ConstDef.MONSTER_SIZE.WIDTH, ConstDef.MONSTER_SIZE.HEIGHT)

    self.target_id = 0 
    self.life_ =200
    self.buffMap_ = {}
    EventManager:doEvent(EventDef.ID.CREATE_ENEMY, self)
end
--[[--
    添加Buff

    @param buff 类型 buff 

    @return none
]]
function Enemy:addBuff(buff)
    self.buffMap_[#self.buffMap_+1] = buff
end
--[[--
    获取塔BUFF表

    @param none

    @return life
]]
function Enemy:getBuff()
    return self.buffMap_
end
--[[--
    销毁

    @param none

    @return none
]]
function Enemy:destory()
    self.isDeath_ = true 
    EventManager:doEvent(EventDef.ID.DESTORY_ENEMY, self)
end
--[[--
    设置目标

    @param target 类型 table 

    @return none
]]
function Enemy:setTarget(target)
    Target = target
    if self.target_id == 0 then
        self.x_ =Target[self.target_id].X
        self.y_ =Target[self.target_id].Y
        self.target_id = 1
    end
end
--[[--
    改变生命

    @param life

    @return life
]]
function Enemy:setLife(life)
    self.life_=self.life_+life
    if self.life_<= 0 then
        self:destory()
    end
end
--[[--
    获取生命

    @param none

    @return life
]]
function Enemy:getLife()
    return self.life_
end
--[[--
    帧循环

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function Enemy:update(dt)
    if self.isDeath_ then
        return
    end
    if Target.MAXID < self.target_id then
        self:destory()
    end
    if Target[self.target_id].MOVEX~=0 then
        if (Target[self.target_id].MOVEX == 1 and self.x_>=Target[self.target_id].X) or (Target[self.target_id].MOVEX == -1 and self.x_<=Target[self.target_id].X) then
        self.target_id=self.target_id+1
        self.x_=Target[self.target_id].X
        end
    else
        if  (Target[self.target_id].MOVEY == 1 and self.y_>=Target[self.target_id].Y) or (Target[self.target_id].MOVEY == -1 and self.y_<=Target[self.target_id].Y) then
        self.target_id=self.target_id+1
        self.y_=Target[self.target_id].Y  
        end
    end
    self.x_ =self.x_ + Target[self.target_id].MOVEX*50*dt
    self.y_ =self.y_ + Target[self.target_id].MOVEY*50*dt
    -- if not self.isDeath_ then
    --     if self.y_ < display.bottom - ConstDef.ENEMY_PLANE_SIZE.HEIGHT then
    --         self:destory()
    --     end
    -- end
end

return Enemy