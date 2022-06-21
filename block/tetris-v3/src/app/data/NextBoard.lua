local ConstDef = require("app.def.ConstDef")
local Functions = require("app.utils.Functions")

local NextBoard = class("NextBoard")

function NextBoard:ctor()

    self.nextTable_ = {} -- 主表的映射

    for x = 0, ConstDef.NEXT_BOARD_WIDTH - 1 do
        for y = 0, ConstDef.NEXT_BOARD_HEIGHT - 1 do
            local visible = (x == 0 or x == ConstDef.NEXT_BOARD_WIDTH - 1) or y == 0
            -- 初始化不可见
            self.nextTable_[Functions.makeKey(x, y)] = -1
        end
    end
end

--[[--
    清除所有行

    @param none

    @return none
]]
function NextBoard:clear()

    for y = 0, ConstDef.NEXT_BOARD_HEIGHT - 1 do
        self:clearLine(y)
    end
end

--[[--
    清除行

    @param y 类型：number，待清除的行号

    @return none
]]
function NextBoard:clearLine(y)
    for x = 0, ConstDef.NEXT_BOARD_WIDTH -1 do
        self:set(x, y, -1)
    end
end

--[[--
    Set

    @param x，y 类型：number，坐标
    @param value 类型：boolean

    @return none
]]
function NextBoard:set(x, y, value)
    self.nextTable_[Functions.makeKey(x, y)] = value
end

--[[--
    Get

    @param x，y 类型：number，坐标

    @return color
]]
function NextBoard:get(x, y)
    return self.nextTable_[Functions.makeKey(x, y)]
end

return NextBoard