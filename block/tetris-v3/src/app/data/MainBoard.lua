local ConstDef = require("app.def.ConstDef")
local Functions = require("app.utils.Functions")

local MainBoard = class("MainBoard")

function MainBoard:ctor()

    self.mainTable_ = {} -- 主表的映射

    for x = 0, ConstDef.MAIN_BOARD_WIDTH - 1 do
        for y = 0, ConstDef.MAIN_BOARD_HEIGHT - 1 do
            local visible = (x == 0 or x == ConstDef.MAIN_BOARD_WIDTH - 1) or y == 0
            if visible then
                -- 初始化为白色方块
                self.mainTable_[Functions.makeKey(x, y)] = 0
            else
                -- 初始化不可见
                self.mainTable_[Functions.makeKey(x, y)] = -1
            end
        end
    end
end

--[[--
    Get

    @param x，y 类型：number，坐标

    @return color
]]
function MainBoard:get(x, y)
    return self.mainTable_[Functions.makeKey(x, y)]
end

--[[--
    是否是满行

    @param y 类型：number，行索引

    @return none
]]
function MainBoard:isFullLine(y)

    for x = 1, ConstDef.MAIN_BOARD_WIDTH - 2 do
        if self:get(x, y) == -1 then
            return false
        end
    end

    return true
end

--[[--
    是否是空行

    @param y 类型：number，行索引

    @return none
]]
function MainBoard:isEmptyLine(y)

    for x = 1, ConstDef.MAIN_BOARD_WIDTH - 2 do
        if self:get(x, y) ~= -1 then
            return false
        end
    end

    return true
end

--[[--
    检查是否可以覆盖

    @param none

    @return none
]]
function MainBoard:checkAndSweep()

    local count = 0
    for y = 1, ConstDef.MAIN_BOARD_HEIGHT - 1 do

        if self:isFullLine(y) then
            self:clearLine(y)
            count = count + 1
            break
        end
    end

    -- 消掉的行数
    return count

end

--[[--
    下移

    @param sy 类型：number，行数

    @return none
]]
function MainBoard:moveDown(sy)

    for y = sy, ConstDef.MAIN_BOARD_HEIGHT - 2 do
        for x = 1, ConstDef.MAIN_BOARD_WIDTH - 2 do
            self:set(x, y, self:get(x, y + 1))
        end
    end

end

--[[--
    移动

    @param none

    @return none
]]
function MainBoard:shift()

    for y = 1, ConstDef.MAIN_BOARD_HEIGHT - 2 do

        -- 如果当前行为空且上一行不为空
        if self:isEmptyLine(y) and (not self:isEmptyLine(y + 1)) then
            self:moveDown(y)
        end
    end
end

--[[--
    清除行

    @param none

    @return none
]]
function MainBoard:clearLine(y)

    for x = 1, ConstDef.MAIN_BOARD_WIDTH - 2 do
        self:set(x, y, -1)
    end
end

--[[--
    清除所有

    @param none

    @return none
]]
function MainBoard:clear()

    for y = 1, ConstDef.MAIN_BOARD_HEIGHT - 1 do
        self:clearLine(y)
    end

end

--[[--
    Set

    @param x，y 类型：number，坐标
    @param value 类型：boolean

    @return none
]]
function MainBoard:set(x, y, value)
    self.mainTable_[Functions.makeKey(x, y)] = value
end

return MainBoard