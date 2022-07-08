--[[--
    Tower.lua
    塔数据文件
]]
local Tower = class("Tower", require("app.data.Object"))
local EventDef = require("app/def/EventDef")
local TowerDef = require("app/def/TowerDef.lua")
local EventManager = require("app/manager/EventManager.lua")

--[[--
    构造函数

    @param tower_id 类型：number，塔编号
    @param level 类型：number，塔等级
    @param grade 类型：number，塔的强化等级
    @param player 类型：number，塔的归宿玩家

    @return none
]]
function Tower:ctor(tower_id,level,grade,player)
    Tower.super.ctor(self, 0, 0, 50, 50)

    self.player = player --塔的归属玩家
    self.tower_id_ = tower_id --类型：number，塔编号
    self.tower_rarity_ = TowerDef.TABLE[tower_id].RARITY --类型：number，塔稀有度
    self.star_level_ = 1 --类型:number,塔基础星极
    self.tower_type_ = TowerDef.TABLE[tower_id].TYPE--类型：number，塔类型
    self.tower_name_ = TowerDef.TABLE[tower_id].NAME --类型：string，塔名称
    self.tower_information_ = TowerDef.TABLE[tower_id].INFORMATION --类型：string，塔技能介绍
    self.tower_mode_ = TowerDef.TABLE[tower_id].MODE --类型：number，塔攻击模式

    self.level_ =level --类型：number 塔等级
    self.grade_ = grade --类型:number 当前强化等级
    self.tower_fireTick_ =0 --类型：number,塔攻击时间tick

    --数值和状态区赋值
    --基础区
    self.criticalRate_=0.05 --类型:number,塔暴击率
    self.criticalDamage_ = 2 --类型:number,塔暴击倍率
    self.tower_fireCd_ = TowerDef.TABLE[tower_id].FIRECD+TowerDef.TABLE[tower_id].FIRECD_UPGRADE*(level-1) --类型：number，塔攻击间隔
    self.tower_atk_=TowerDef.TABLE[tower_id].ATK+TowerDef.TABLE[tower_id].ATK_UPGRADE*(level-1) --类型：number,塔攻击力
    --buff区
    self.buff_criticalRate_ = 0--类型:number,buff暴击率
    self.buff_criticalDamage_ = 2 --类型:number,buff暴击倍率
    self.buff_fireCd_ = 0--类型:number,buff攻速
    self.buff_atk_ = 0--类型:number,buff攻击力
    --使用区
    self.true_criticalRate_ = 0
    self.true_criticalDamage_ = 0
    self.true_fireCd_ = 0
    self.true_atk_ = 0

    self.isShoot =true
    EventManager:doEvent(EventDef.ID.CREATE_TOWER, self)
end
--[[--
    获取塔所在玩家

    @param none

    @return self.player
]]
function Tower:getPlayer()
    return self.player
end
--[[--
    设置塔buff暴击率

    @param number

    @return self.tower_atk_
]]
function Tower:setBuffCriticalRate(number)
    self.buff_criticalRate_=self.buff_criticalRate_+number
end
--[[--
    获取塔暴击率

    @param none

    @return self.tower_atk_
]]
function Tower:getCriticalRate()
    return self.true_criticalRate_
end
--[[--
    获取塔暴击伤害倍率

    @param none

    @return self.criticalDamage_
]]
function Tower:getCritical()
    return self.criticalDamage_
end
--[[--
    设置塔暴击倍率

    @param criticalDamage

    @return self.tower_atk_
]]
function Tower:setCritical(criticalDamage)
    self.criticalDamage_=self.criticalDamage_+criticalDamage
end
--[[--
    获取塔攻击力

    @param none

    @return self.tower_atk_
]]
function Tower:getAtk()
    return self.tower_atk_
end
--[[--
    获取塔攻击模式

    @param none

    @return life
]]
function Tower:getMode()
    return self.tower_mode_
end
--[[--
    获取塔等级

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
    塔强化等级

    @param none

    @return none
]]
function Tower:setGrade()
    self.grade_=self.grade_+1
    self.tower_atk_=self.tower_atk_+TowerDef.TABLE[self.tower_id_].ATK_ENHANCE
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
    设置塔发射CD

    @param number

    @return none
]]
function Tower:setBuffFireCd(number)
    self.buff_fireCd_=number
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
    塔发射

    @param none

    @return none
]]
function Tower:shoot()
    for i = 1, #self.buffMap_ do
        self.buffMap_[i]:onCast(self)
    end
    EventManager:doEvent(EventDef.ID.INIT_BULLET,self)
end
--[[--
    塔面板计算

    @param none

    @return none
]]
function Tower:count()
    --初始化
    self.true_criticalRate_ = 0
    self.true_criticalDamage_ = 0
    self.true_fireCd_ = 0
    self.true_atk_ = 0
    --计算
    self.true_criticalRate_=self.criticalRate_+self.buff_criticalRate_
    self.true_atk_=self.tower_atk_+self.buff_atk_
    self.true_fireCd_=(self.tower_fireCd_+self.buff_fireCd_)/self.star_level_
end
--[[--
    塔帧刷新

    @param dt 类型：number，时间，秒

    @return none
]]
function Tower:update(dt)
    if self.isDeath_ then
        return
    end
    --父物体update
    Tower.super.update(self,dt)
    self:count()
    self.tower_fireTick_ = self.tower_fireTick_ + dt
    if self.tower_fireTick_>=self.true_fireCd_ then
        self.tower_fireTick_=self.tower_fireTick_-self.true_fireCd_
        self:shoot()
    end
end
--getset合集
-- function Tower:getGameState()
--     return self.gameState_
-- end
return Tower