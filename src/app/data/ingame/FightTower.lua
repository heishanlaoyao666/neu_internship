--[[--
    FightTower.lua
    战斗中的塔类
]]

local FightTower = class("FightTower", require("app.data.ingame.Object"))
local ConstDef = require("app.def.ingame.ConstDef")
local EventDef = require("app.def.EventDef")
local EventManager = require("app.manager.EventManager")

function FightTower:ctor(tower, indexTable, index)
    FightTower.super.ctor(self, indexTable[index][1], indexTable[index][2], ConstDef.TOWER_SIZE.width, ConstDef.TOWER_SIZE.HEIGHT)

    self.star_ = 1
    self.tower_ = tower
    self.index_ = index

    EventManager:doEvent(EventDef.ID.CREATE_SELF, self)
end

--[[--
    获取游戏外塔的数据

    @parm none

    @return 类型：object
]]
function FightTower:getTower()
    return self.tower_
end

--[[--
    获取星级

    @parm none

    @return 类型：number
]]
function FightTower:getStar()
    return self.star_
end

--[[--
    设置星级

    @parm n 类型：number

    @return none
]]
function FightTower:setStar(n)
    self.star_ = n
end

--[[--
    获取塔的位置下标

    @parm none

    @return number
]]
function FightTower:getIndex()
    return self.index_
end

--[[--
    塔升星

    @parm none

    @return none
]]
function FightTower:starUp()
    self.star_ = self.star_ + 1
end

--[[--
    塔销毁

    @param none

    @return none
]]
function FightTower:destory()
    self.isDeath_ = true
    EventManager:doEvent(EventDef.ID.DESTORY_SELF, self)
end

return FightTower