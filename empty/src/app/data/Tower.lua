--[[--
    Tower.lua
    塔数据文件
]]
local Tower = class("Tower", require("app.data.Object"))
local ConstDef = require("app/def/ConstDef")
local EventDef = require("app/def/EventDef")
local EventManager = require("app/manager/EventManager")


local bullets_ = {} -- 类型：子弹数组


--[[--
    构造函数

    @param tower_id 类型：number，塔编号
    @param tower_rarity 类型：number，塔稀有度
    @param tower_type 类型：number，塔类型
    @param tower_name 类型：string，塔名称
    @param tower_atk 类型：number，塔攻击力
    @param tower_fireCd 类型：number，塔攻击间隔
    @param tower_information 类型：string，塔技能介绍
    @param tower_skill1 类型：Skill，塔技能
    @param tower_mode 类型：number，塔攻击模式

    @return none
]]
function Tower:ctor(tower_id,tower_rarity,tower_type,tower_name,tower_atk,tower_fireCd,tower_information,tower_skill1,tower_mode)
    Tower.super.ctor(self, 0, 0, 50, 50)

    self.tower_id_ = tower_id --类型：number，塔编号
    self.tower_rarity_ = tower_rarity --类型：number，塔稀有度
    self.tower_type_ = tower_type--类型：number，塔类型
    self.tower_name_ = tower_name --类型：string，塔名称
    self.tower_atk_ = tower_atk --类型：number，塔攻击力
    self.tower_fireCd_ = tower_fireCd --类型：number，塔攻击间隔
    self.tower_information_ = tower_information --类型：string，塔技能介绍
    self.tower_skill1_ = tower_skill1 --类型：Skill，塔技能
    self.tower_mode_ = tower_mode --类型：number，塔攻击模式

    self.tower_fireTick_ =0 --类型：number,塔攻击时间tick
    EventManager:doEvent(EventDef.ID.CREATE_TOWER, self)
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
    开炮

    @param dt 类型：number，时间间隔，单位秒

    @return none
]]
function Tower:shoot(dt)
    self.tower_fireTick_ = self.tower_fireTick_ + dt
    if self.shootTick_ > self.tower_fireCd_ then
        self.tower_fireTick_ = self.shootTick_ - self.tower_fireCd_

        -- 产生子弹,设置攻击目标
        -- for i = 1, #allies_ do
        --     local bullet = Bullet.new()
        --     bullets_[#bullets_ + 1] = bullet
        --     bullet:setX(allies_[i]:getX())
        --     bullet:setY(allies_[i]:getY() + 30)
        -- end
    end
end
--[[--
    塔帧刷新

    @param dt 类型：number，时间，秒

    @return none
]]
function Tower:update(dt)
    Tower:shoot(dt)
end
--getset合集
function Tower:getGameState()
    return self.gameState_
end
return Tower