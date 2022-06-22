--[[--
    OutGameData.lua
    游戏外数据文件，全局唯一
]]

local OutGameData = {}

local ConstDef = require("app.def.outgame.ConstDef")
local Tower = require("app.data.outgame.Tower")

local towers_ = {}

--[[--
    初始化数据

    @param none

    @return none
]]
function OutGameData:init()
    local tower_1 = Tower.new(1, 1, 1, "tower_1", "使被攻击目标得到“灼烧”状态。灼烧：造成两次额外伤害。",
    "前方", 20, 3, 10, 0.8, 0.01, "额外伤害", 20, 3, 20, nil, nil)
    local tower_2 = Tower.new(2, 3, 1, "tower_2", "使星级数个怪物受到伤害。",
    "前方", 20, 5, 10, 0.8, 0, "额外伤害", 50, 4, 40, nil, nil)
    local tower_3 = Tower.new(3, 2, 1, "使星级数个怪物受到伤害。",
    "前方", 40, 8, 20, 0.8, 0.01, "额外伤害", 120, 24, 40, nil, nil)
    local tower_4 = Tower.new()
    local tower_5 = Tower.new()
    local tower_6 = Tower.new()
    local tower_7 = Tower.new()
    local tower_8 = Tower.new()
    local tower_9 = Tower.new()
    local tower_10 = Tower.new()
    local tower_11 = Tower.new()
    local tower_12 = Tower.new()
    local tower_13 = Tower.new()
    local tower_14 = Tower.new()
    local tower_15 = Tower.new()
    local tower_16 = Tower.new()
    local tower_17 = Tower.new()
    local tower_18 = Tower.new()
    local tower_19 = Tower.new()
    local tower_20 = Tower.new()

    towers_ = {
        tower_1, tower_2, tower_3, tower_4, tower_5, tower_6, tower_7, tower_8, tower_9, tower_10,
        tower_11, tower_12, tower_13, tower_14, tower_15, tower_16, tower_17, tower_18, tower_19, tower_20
    }
end

return OutGameData