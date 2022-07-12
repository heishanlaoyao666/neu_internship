--[[--
    FightingTower.lua
    战斗中的塔类
]]

local FightingTower = class("FightingTower", require("app.data.ingame.Object"))
local ConstDef = require("app.def.ingame.ConstDef")
local EventDef = require("app.def.EventDef")
local EventManager = require("app.manager.EventManager")

--[[--
    构造函数

    @parm tower 类型：Tower, 外部塔
    @parm indexTable 类型：table, 塔生成的位置信息
    @parm index 类型：number, 塔生成信息表中的坐标
    @parm star 类型：number, 塔的星级
]]
function FightingTower:ctor(tower, indexTable, index, star)
    FightingTower.super.ctor(self, indexTable[index][1], indexTable[index][2],
    ConstDef.TOWER_SIZE.WIDTH,ConstDef.TOWER_SIZE.HEIGHT)

    self.star_ = star
    self.tower_ = tower
    self.index_ = index
    self.hitChance_ = 0.05

    self.countShoot_ = 0 -- 塔3技能
    self.dt_ = 0 -- 内置计时器，塔5技能

    self.fireCd_ = 1 -- 攻速变化

    EventManager:doEvent(EventDef.ID.CREATE_SELF, self)

end

--[[--
    设置暴击率

    @parm n 类型：number

    @return none
]]
function FightingTower:setHitChance(n)
    self.hitChance_ = n
end

--[[--
    获取暴击率

    @parm none

    @return number
]]
function FightingTower:getHitChance()
    return self.hitChance_
end

--[[--
    设置攻速变化

    @parm n 类型：number，百分比

    @return none
]]
function FightingTower:setFireCd(n)
    if n == 0 then
        self.fireCd_ = 1 -- 重置攻速
    else
        self.fireCd_ = self.fireCd_ * (1 - n)
    end
end

--[[--
    获取攻速变化

    @parm none

    @return number
]]
function FightingTower:getFireCd()
    return self.fireCd_
end

--[[--
    更新计时器

    @parm dt 类型：number，时间间隔

    @return number
]]
function FightingTower:updateTime(dt)
    self.dt_ = self.dt_ + dt
    return self.dt_
end


--[[--
    记录射击子弹数

    @parm none

    @return number
]]
function FightingTower:countShoot()
    self.countShoot_ = self.countShoot_ + 1
    return self.countShoot_
end

--[[--
    获取游戏外塔的数据

    @parm none

    @return 类型：object
]]
function FightingTower:getTower()
    return self.tower_
end

--[[--
    获取星级

    @parm none

    @return 类型：number
]]
function FightingTower:getStar()
    return self.star_
end

--[[--
    设置星级

    @parm n 类型：number

    @return none
]]
function FightingTower:setStar(n)
    self.star_ = n
end

--[[--
    获取塔的位置下标

    @parm none

    @return number
]]
function FightingTower:getIndex()
    return self.index_
end

--[[--
    塔升星

    @parm none

    @return none
]]
function FightingTower:starUp()
    self.star_ = self.star_ + 1
end

--[[--
    塔降星

    @parm none

    @return none
]]
function FightingTower:starDown()
    self.star_ = self.star_ - 1
end

--[[--
    塔销毁

    @param none

    @return none
]]
function FightingTower:destory()
    self.isDeath_ = true
    EventManager:doEvent(EventDef.ID.DESTORY_SELF, self)
end

return FightingTower