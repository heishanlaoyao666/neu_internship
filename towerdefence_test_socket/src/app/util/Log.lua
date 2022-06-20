--[[--
    Log.lua

    描述：日志文件
]]
local Log = {}
local Config = require("app.Config")

--[[--
    描述：输出info级别日志

    @param ...

    @return none
]]
function Log.i(...)
    if not Config.IS_LOG then
        return
    end

    print("[INFO]", ...)
end

--[[--
    描述：输出warn级别日志

    @param ...

    @return none
]]
function Log.w(...)
    if not Config.IS_LOG then
        return
    end

    print("[WARN]", ...)
end

--[[--
    描述：输出error级别日志

    @param ...

    @return none
]]
function Log.e(...)
    if not Config.IS_LOG then
        return
    end

    print("[ERROR]", ...)
end

return Log