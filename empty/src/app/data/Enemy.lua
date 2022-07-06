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

    @param life 类型:number,怪物血量
    @param sp 类型:number,怪物击败获得的sp
    @param tag 类型:number,怪物类型
    @param player 类型:obj,归属玩家

    @return none
]]
function Enemy:ctor(life,sp,tag,player)
    Enemy.super.ctor(self, 0, 0, ConstDef.MONSTER_SIZE[tag].WIDTH, ConstDef.MONSTER_SIZE[tag].HEIGHT)

    self.player_=player
    self.life_ =life
    self.sp_give_=sp
    self.tag_=tag

    self.target_id = 0
    
    --数值和状态区赋值
    --基础区
    self.speed_ = 50
    --buff区
    self.buff_speed_ = 0
    --使用区
    self.true_speed_ = 0
    EventManager:doEvent(EventDef.ID.CREATE_ENEMY, self)
end
--[[--
    获取怪物的移动速度

    @param none

    @return none
]]
function Enemy:getSpeed()
    return self.speed_
end
--[[--
    设置怪物的buff移动速度

    @param speed

    @return none
]]
function Enemy:setBuffSpeed(speed)
    self.buff_speed_=self.buff_speed_+speed
end
--[[--
    获取怪物的tag

    @param none

    @return self.tag_
]]
function Enemy:getTag()
    return self.tag_
end
--[[--
    销毁

    @param none

    @return none
]]
function Enemy:destory()
    if not self.isDeath_ then
        self.isDeath_ = true
        self.player_:setSp(self.sp_give_)
        EventManager:doEvent(EventDef.ID.DESTORY_ENEMY, self)
    end
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
    速度面板计算

    @param none

    @return none
]]
function Enemy:count()
    --初始化
    self.true_speed_=0
    --计算
    self.true_speed_=self.speed_+self.buff_speed_
    --计算结束
    self.buff_speed_=0
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
    --父物体update
    Enemy.super.update(self,dt)

    if self.target_id>Target.MAXID then
        self:destory()
        return
    end
    if Target[self.target_id].MOVEX~=0 then
        if (Target[self.target_id].MOVEX == 1 and self.x_>=Target[self.target_id].X) or (Target[self.target_id].MOVEX == -1 and self.x_<=Target[self.target_id].X) then
        self.target_id=self.target_id+1
        if self.target_id>Target.MAXID then
            return
        end
        self.x_=Target[self.target_id].X or self.x_
        end
    else
        if  (Target[self.target_id].MOVEY == 1 and self.y_>=Target[self.target_id].Y) or (Target[self.target_id].MOVEY == -1 and self.y_<=Target[self.target_id].Y) then
        self.target_id=self.target_id+1
        if self.target_id>Target.MAXID then
            return
        end
        self.y_=Target[self.target_id].Y or self.y_
        end
    end
    self:count()
    self.x_ =self.x_ + Target[self.target_id].MOVEX*self.true_speed_*dt
    self.y_ =self.y_ + Target[self.target_id].MOVEY*self.true_speed_*dt
    -- if not self.isDeath_ then
    --     if self.y_ < display.bottom - ConstDef.ENEMY_PLANE_SIZE.HEIGHT then
    --         self:destory()
    --     end
    -- end
end

return Enemy