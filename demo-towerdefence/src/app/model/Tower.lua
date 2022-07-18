--[[--
    Tower.lua

    描述：塔信息（游戏内）
]]
local Tower = class("Tower")
local GameDef = require("app.def.GameDef")
local TowerConfig = require("app.config.TowerConfig")
local Log = require("app.util.Log")

--[[--
    描述：构造函数

    @param id 类型：number，塔对象id
    @param towerId 类型：number，塔id
    @param level 类型：number，塔等级
    @param pos 类型：number，塔位置，范围1~15

    @return none
]]
function Tower:ctor(id, towerId, level, pos)
    self.id_ = id -- 类型：number，塔对象id
    self.towerId_ = towerId -- 类型：number，塔id
    self.level_ = level -- 类型：number，塔等级
    self.pos_ = pos -- 类型：number，塔位置，范围1~15
    self.config_ = TowerConfig:getConfig(towerId) -- 类型：table，塔配置

    local width, height = GameDef.WIDTH, GameDef.HEIGHT
    local startX = width * 0.5 - 200
    local startY = height - 180
    local offsetX = 100
    local offsetY = 110

    local row = math.floor((pos - 1) / 5) + 1
    local column = (pos - 1) % 5 + 1
    self.x_ = startX + (column - 1) * offsetX
    self.y_ = startY - (row - 1) * offsetY
end

return Tower