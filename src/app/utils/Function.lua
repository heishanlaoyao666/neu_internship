
--- 用户ID生成
function getUUID()
    local curTime = os.time()
    local uuid = curTime + math.random(100000000)
    return uuid
end

--[[
    vardump的完整版

    @params object
    @params label

    @return vardumpStr
]]
function varDump(object, label)
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


