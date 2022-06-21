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

--[[
    打印table

    @params object
    @params label

    @return table的字符串表示
]]
function Functions.varDump(object, label)
    local lookupTable = {}
    local result = {}

    local function _v(v)
        if type(v) == "string" then
            v = "\"" .. v .. "\""
        end
        return tostring(v)
    end

    local function _varDump(object, label, indent, nest)
        label = label or "<var>"
        local postfix = ""
        if nest > 1 then postfix = "," end
        if type(object) ~= "table" then
            result[#result +1] = string.format("%s%s = %s%s", indent, tostring(label), _v(object), postfix)
        elseif not lookupTable[object] then
            lookupTable[object] = true
            result[#result +1 ] = string.format("%s%s = {", indent, tostring(label))
            local indent2 = indent .. "    "
            local keys = {}
            local values = {}
            for k, v in pairs(object) do
                keys[#keys + 1] = k
                values[k] = v
            end
            table.sort(keys, function(a, b)
                if type(a) == "number" and type(b) == "number" then
                    return a < b
                else
                    return tostring(a) < tostring(b)
                end
            end)
            for i, k in ipairs(keys) do
                _varDump(values[k], k, indent2, nest + 1)
            end
            result[#result +1] = string.format("%s}%s", indent, postfix)
        end
    end
    _varDump(object, label, "", 1)

    return table.concat(result, "\n")
end


return Functions