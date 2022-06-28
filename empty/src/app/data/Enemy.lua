--[[--
    Enemy.lua
    怪物数据文件
]]
local Enemy = class("Enemy", require("app.data.Object"))
local ConstDef = require("app.def.ConstDef")
local EventDef = require("app.def.EventDef")
local EventManager = require("app/manager/EventManager.lua")

local buffMap_ ={} --状态表 里面存状态
local Target = nil --类型：table 目标点表
local TargetID = 0 --类型: number 当前目标id
--[[--
    构造函数

    @param none

    @return none
]]
function Enemy:ctor()
    Enemy.super.ctor(self, 0, 0, ConstDef.MONSTER_SIZE.WIDTH, ConstDef.MONSTER_SIZE.HEIGHT)

    self.life_ =200

    EventManager:doEvent(EventDef.ID.CREATE_ENEMY, self)
end

--[[--
    销毁

    @param none

    @return none
]]
function Enemy:destory()
    self.isDeath_ = true 
    --EventManager:doEvent(EventDef.ID.DESTORY_ENEMY, self)
end
--[[--
    设置目标

    @param target 类型 table 

    @return none
]]
function Enemy:setTarget(target)
    Target = target
    if TargetID == 0 then
        self.x_ =Target[TargetID].X
        self.y_ =Target[TargetID].Y
        TargetID = 1
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
    if Target.MAXID < TargetID then
        self:destory()
    end
    if Target[TargetID].MOVEX~=0 then
        if (Target[TargetID].MOVEX == 1 and self.x_>=Target[TargetID].X) or (Target[TargetID].MOVEX == -1 and self.x_<=Target[TargetID].X) then
        TargetID=TargetID+1
        self.x_=Target[TargetID].X
        end
    else
        if  (Target[TargetID].MOVEY == 1 and self.y_>=Target[TargetID].Y) or (Target[TargetID].MOVEY == -1 and self.y_<=Target[TargetID].Y) then
        TargetID=TargetID+1
        self.y_=Target[TargetID].Y  
        end
    end
    self.x_ =self.x_ + Target[TargetID].MOVEX*50*dt
    self.y_ =self.y_ + Target[TargetID].MOVEY*50*dt
    -- if not self.isDeath_ then
    --     if self.y_ < display.bottom - ConstDef.ENEMY_PLANE_SIZE.HEIGHT then
    --         self:destory()
    --     end
    -- end
end

return Enemy