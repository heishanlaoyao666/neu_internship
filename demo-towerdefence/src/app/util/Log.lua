--[[--
    Log.lua

    描述：日志工具类
]]
local Log = {}

local IS_LOG = true -- 是否输出日志开关
local IS_DEBUG = false -- 日志分级：是否输出debug日志
local IS_INFO = true -- 日志分级：是否输出info日志

---------------------------------------------------------------------------
-- 私有函数定义
---------------------------------------------------------------------------
local _getTrackback
local _getFilename
local _args2string

---------------------------------------------------------------------------
-- 公有函数实现
---------------------------------------------------------------------------

--[[--
    描述：日志输出，debug级别

    @param ...

    @return none
]]
function Log.d(...)
    if not IS_LOG then return end
    if not IS_DEBUG then return end

    print("[D]", _getTrackback(), _args2string(...))
end

--[[--
    描述：日志输出，info级别

    @param ...

    @return none
]]
function Log.i(...)
    if not IS_LOG then return end
    if not IS_INFO then return end

    print("[I]", _getTrackback(), _args2string(...))
end

--[[--
    描述：日志输出，warning级别

    @param ...

    @return none
]]
function Log.w(...)
    if not IS_DEBUG then return end

    print("[W]", _getTrackback(), _args2string(...))
end

--[[--
    描述：日志输出，error级别

    @param ...

    @return none
]]
function Log.e(...)
    if not IS_DEBUG then return end

    print("[E]", _getTrackback(), _args2string(...))
end

---------------------------------------------------------------------------
-- 私有函数实现
---------------------------------------------------------------------------

--[[
    描述：获取回溯信息，返回已格式化的一行字符串

    @param none

    @return string
]]
function _getTrackback()
    local ret = ""

    -- 只需要回溯3级，也即调用输出日志的函数
    local traceback = debug.getinfo(3, "nlS")
    if traceback then
        local filename = _getFilename(traceback.source)
        local funcName = traceback.name or "no func name"
        local line = tostring(traceback.currentline or "0")

        ret = string.format("%s:%s() [line:%s]", filename, funcName, line)
    end

    return ret
end

--[[
    描述：根据回溯信息，截取文件名

    @param fullPath 类型：string，全路径

    @return string
]]
function _getFilename(fullPath)
    local filename = "no filename"

    if type(fullPath) == "string" and string.len(fullPath) > 0 then
        local arr = string.split(fullPath, "/") -- 根据“/”截取字符串
        filename = arr[#arr] -- 取最后一个截取字符串
        filename = string.gsub(filename, ".lua", "") -- 替换“.lua”文件后缀
    end

    return filename
end

--[[
    描述：任意参数转换为字符串

    注意：此方法中，将任意参数中的table进行vardump转换

    @param ...

    @return string
]]
function _args2string(...)
    local str = ""

    -- 注意，参数中如果有 nil，会导致参数数组截断，需要优先获取最大长度
    local args = { ... }
    local count = 0
    for k, v in pairs(args)do
        if k > count then
            count = k
        end
    end

    for i = 1, count do
        local arg = args[i]
        if type(arg) == "table" then
            str = str .. " " ..  vardump(arg)
        else
            str = str .. " " .. tostring(arg)
        end
    end

    return str
end

return Log