TypeConvert = {}

function TypeConvert.Integer2StringLeadingZero(value, number)
    local result = tostring(value)
    local len = #result
    for i = 1, number - len do
        result = "0" .. result
    end
    return result
end

return TypeConvert
