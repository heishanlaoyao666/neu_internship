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

    EventManager:doEvent(EventDef.ID.CREATE_SELF, self)

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
    塔销毁

    @param none

    @return none
]]
function FightingTower:destory()
    self.isDeath_ = true
    EventManager:doEvent(EventDef.ID.DESTORY_SELF, self)
end

return FightingTower