--[[--
    Tower.lua
    塔数据文件
]]
local Tower = class("Tower", require("app.data.Object"))
local ConstDef = require("app/def/ConstDef")
local EventDef = require("app/def/EventDef")
local TowerDef = require("app/def/TowerDef.lua")
local EventManager = require("app/manager/EventManager.lua")


local buffMap_ ={} --状态表 里面存状态
--[[--
    构造函数

    @param tower_id 类型：number，塔编号
    @param tower_id 类型：level，塔等级

    @return none
]]
function Tower:ctor(tower_id,level)
    Tower.super.ctor(self, 0, 0, 50, 50)

    
    self.tower_id_ = tower_id --类型：number，塔编号
    self.tower_rarity_ = TowerDef.TABLE[tower_id].RARITY --类型：number，塔稀有度
    self.tower_type_ = TowerDef.TABLE[tower_id].TYPE--类型：number，塔类型
    self.tower_name_ = TowerDef.TABLE[tower_id].NAME --类型：string，塔名称
    self.tower_fireCd_ = TowerDef.TABLE[tower_id].FIRECD --类型：number，塔攻击间隔
    self.tower_information_ = TowerDef.TABLE[tower_id].INFORMATION --类型：string，塔技能介绍
    -- self.tower_skill1_ = tower_skill1 --类型：Skill，塔技能
    self.tower_mode_ = TowerDef.TABLE[tower_id].MODE --类型：number，塔攻击模式

    self.level_ =level --类型：number 塔等级
    self.grade_ = 1 --类型:number 当前强化等级
    self.tower_fireTick_ =0 --类型：number,塔攻击时间tick
    EventManager:doEvent(EventDef.ID.CREATE_TOWER, self)
end
--[[--
    获取塔等级等级

    @param none

    @return life
]]
function Tower:getMode()
    return self.tower_mode_
end
--[[--
    获取塔等级等级

    @param none

    @return life
]]
function Tower:getLevel()
    return self.level_
end
--[[--
    获取塔强化等级

    @param none

    @return life
]]
function Tower:getGrade()
    return self.grade_
end
--[[--
    获取塔ID

    @param none

    @return life
]]
function Tower:getID()
    return self.tower_id_
end
--[[--
    获取塔发射CD

    @param none

    @return fireTick
]]
function Tower:getFireCD()
    return self.tower_fireCd_
end
--[[--
    获取塔发射间隔

    @param none

    @return fireTick
]]
function Tower:getFireTick()
    return self.tower_fireTick_
end
--[[--
    设置塔发射间隔

    @param tick 类型 number 

    @return fireTick
]]
function Tower:setFireTick(tick)
    self.tower_fireTick_=self.tower_fireTick_+tick
end
--[[--
    塔销毁

    @param none

    @return none
]]
function Tower:destory()
    self.isDeath_ = true 
    EventManager:doEvent(EventDef.ID.DESTORY_TOWER, self)
end
--[[--
    塔帧刷新

    @param dt 类型：number，时间，秒

    @return none
]]
function Tower:update(dt)
    self.tower_fireTick_ = self.tower_fireTick_ + dt
end
--getset合集
-- function Tower:getGameState()
--     return self.gameState_
-- end
return Tower