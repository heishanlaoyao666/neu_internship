--[[--
    FightTower.lua
    战斗中的塔类
]]

local FightTower = class("FightTower", require("app.data.ingame.Object"))
local ConstDef = require("app.def.ingame.ConstDef")

function FightTower:ctor(tower)
    FightTower.super.ctor(self, 0, 0, ConstDef.TOWER_SIZE.width, ConstDef.TOWER_SIZE.HEIGHT)

    self.tower_ = tower
end

--[[--
    获取游戏外塔的数据

    @parm none
]]
function FightTower:getTower()
    return self.tower_
end

return FightTower