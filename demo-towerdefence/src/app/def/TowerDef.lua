--[[--
    TowerDef.lua

    描述：塔常量定义类
]]
local TowerDef = {}

TowerDef.ID_MIN = 1 -- 塔id最大值
TowerDef.ID_MAX = 20 -- 塔id最小值

-- 塔类型定义
TowerDef.TYPE = {
    GONG = 1, -- 攻击
    RAO = 2, -- 干扰
    FU = 3, -- 辅助
    KONG = 4, -- 控制
}

return TowerDef