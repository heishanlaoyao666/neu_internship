--[[--
    Enemy.lua
    敌人类
]]

local Enemy = class("Enemy", require("app.data.ingame.Object"))
local ConstDef = require("app.def.ingame.ConstDef")

function Enemy:ctor()
   Enemy.super.ctor()
end

return Enemy