--[[--
    MathUtil.lua

    描述：数学计算工具类
]]
local MathUtil = {}

--[[--
    描述：线性插值，插值结果处于current和target之间的值，alpha越小越接近current,alpha越大越接近target

    @param current 类型：number，当前值
    @param target 类型：number，目标值
    @param alpha 类型：number，变换系数，取值范围0 ~ 1

    @return number
]]
function MathUtil.lerp(current, target, alpha)
    if alpha > 1 then
        return target
    end

    if alpha < 0 then
        return current
    end

    return (current + (target - current) * alpha)
end

return MathUtil