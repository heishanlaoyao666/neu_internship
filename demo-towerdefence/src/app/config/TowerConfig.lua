--[[--
    TowerConfig.lua

    描述：塔数据，塔配置解析
]]
local TowerConfig = {}
local TowerDef = require("app.def.TowerDef")
local Log = require("app.util.Log")

-- 桥接def，为使用方便
TowerConfig.DEF = TowerDef

local configs_ = {} -- 类型：table，配置数组，value为塔配置
local configMap_ = {} -- 类型：table，塔配置数据，key为塔id，value为塔配置

---------------------------------------------------------------------------
-- 私有函数定义
---------------------------------------------------------------------------
local _init

--[[--
    描述：获取塔配置

    @param towerId 类型：number，塔id

    @return table
]]
function TowerConfig:getConfig(towerId)
    if not isNumber(towerId) or towerId < TowerDef.ID_MIN or towerId > TowerDef.ID_MAX then
        Log.e("unexpect param, towerId=", towerId)
        return
    end

    return configMap_[towerId]
end

---------------------------------------------------------------------------
-- 私有函数实现
---------------------------------------------------------------------------

--[[
    描述：初始化

    @param none

    @return none
]]
function _init()
    local jsonStr = cc.FileUtils:getInstance():getStringFromFile("res/config/tower.json")
    local data = json.decode(jsonStr)
    local ids = data.ids
    local keys = data.keys
    local pairs = pairs
    for i = 1, #ids do
        local id = ids[i]
        local arr = data[tostring(id)]
        local config = {}
        for key, index in pairs(keys) do
            config[key] = arr[index]
        end
        configs_[#configs_ + 1] = config
        configMap_[id] = config
    end

    Log.d("tower config=", configs_)
end

-- 文件被require时执行
_init()

return TowerConfig