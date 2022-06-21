--[[--
    Functions.lua
    功能函数定义
]]
local ConstDef = require("app.def.ConstDef")
local Functions = {}

--[[--
    格子转坐标

    @param none

    @return none
]]
function Functions.Grid2Pos(x, y)

    local visibleSize = cc.Director:getInstance():getVisibleSize()
    local origin = cc.Director:getInstance():getVisibleOrigin()
    local finalX = origin.x + visibleSize.width * 0.5 + x * ConstDef.GRID_SIZE - ConstDef.MAIN_BOARD_WIDTH / 2 * ConstDef.GRID_SIZE
    local finalY = origin.y + visibleSize.height * 0.5 + y * ConstDef.GRID_SIZE - ConstDef.MAIN_BOARD_HEIGHT / 2 * ConstDef.GRID_SIZE

    return finalX, finalY
end

--[[--
    构建坐标映射

    @param none

    @return none
]]
function Functions.makeKey(x, y)
    return x * 1000 + y
end

return Functions