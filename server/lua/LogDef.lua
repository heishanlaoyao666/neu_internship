--[[
    LogDef.lua
    日志相关定义，拷贝自原始的服务器框架
    描述：日志相关定义，拷贝自原始的服务器框架
    编写：张昊煜
    修订：李昊
    检查：周星宇
]]
local LogDef = {}

-- 日志类型定义
LogDef.CHANNEL = {
    DEBUG = 0,           -- 调试
    INFO = 1,            -- 服务运行信息
    WARN = 2,            -- 警告
    ERROR = 3,           -- 错误
    FATAL = 4,           -- 严重错误
    STAT = 5,            -- 统计
    TEST = 6,            -- 测试
    NET = 7,             -- 网络信息
    PERF = 8,            -- 性能信息
}

return LogDef