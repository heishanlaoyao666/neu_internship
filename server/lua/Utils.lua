--[[
    Utils.lua
    描述：存放服务器端可能用到的一些通用工具函数
    编写：张昊煜
    修订：
    检查：
]]

local Utils = {}

--[[--
    保存某用户自己的数据到 db2/{pid}.dat 中
	如果此文件存在，则直接全覆盖写入
	如果不存在，则创建文件并写入

    @param pid 用户ID int
    @param data_str 要保存的数据 string

    @return none
]]
Utils.savePlayerDBDataNow = function(pid, data_str)
    if pid ~= nil and data_str ~= nil then
        file = io.open("./db2/"..tostring(pid)..".dat", "w")
        file:write(data_str.."\n")
        file:close()
    end
end

--[[
	保存用户的昵称和pid到 db2/account.dat 中
    如果用户的pid不存在，则会追加写入
    如果用户的pid存在，则不会进行操作

    @param nick 昵称 string
    @param pid 用户ID int

    @return none
]]
Utils.saveAccount = function(nick, pid)
	-- 加载已有用户到内存
	local accounts = {}
	for line in io.lines("./db2/account.dat") do
		-- print(line)
		local account = {}
		local i = 0
		local nick, pid
		for v in string.gmatch(line,"[^%s]+") do
			if i == 0 then
				account["nick"] = v
				nick = v
			else
				account["pid"] = v
				pid = v
			end
			i = i + 1
			if i == 2 then
				accounts[pid] = nick
				break
			end
		end
	end

	-- print_dump(accounts)
	if accounts[tostring(pid)] == nil then
		-- 如果还没有这个用户
		-- 则需要向accounts.dat里面写入这个用户的昵称和id
		file = io.open("./db2/account.dat", "a")
		file:write(tostring(nick).." "..tostring(pid).."\n")
		file:close()
	end
end

--[[
	从文件中立即读取用户信息
    此函数首先会读取./db2/account.dat
    如果存在昵称为requestNick的用户，则读取./db2/{pid}.dat并和pid一并返回
    如果不存在昵称为requestNick的用户，则返回nil

    @param requestNick 昵称 string

    @return pid 用户id int
    @return data_str 保存的数据 string
]]
Utils.requestPlayerDBDataNow = function(requestNick)
	local tgtPid = nil
    -- 加载已有用户到内存，寻找nick对应的pid
	local accounts = {}
	for line in io.lines("./db2/account.dat") do
        print(line)
		local account = {}
		local i = 0
		local nick, pid
		for v in string.gmatch(line,"[^%s]+") do
			if i == 0 then
				account["nick"] = v
				nick = v
			else
				account["pid"] = v
				pid = v
			end
			i = i + 1
			if i == 2 then
				accounts[pid] = nick
				break
			end
		end
        if requestNick == nick then

            print(requestNick)
            print("lalalalalala")

            tgtPid = pid
            break
        end
	end

    if tgtPid == nil then
        return nil
    else
        print("./db2/"..tostring(tgtPid)..".dat")

        file = io.open("./db2/"..tostring(tgtPid)..".dat", "r")
        local s = file:read()
        file:close()
        return tgtPid ,s
    end
end

--[[
	读取./db2/account.dat，找出最大的pid+1作为新的pid返回

    @param none

    @return pid 新的pid
]]
Utils.getNewPid = function()
    -- 加载已有用户到内存
    local accounts = {}
    local maxPid = -1
    for line in io.lines("./db2/account.dat") do
        local account = {}
        local i = 0
        local nick, pid
        for v in string.gmatch(line,"[^%s]+") do
            if i == 0 then
                account["nick"] = v
                nick = v
            else
                account["pid"] = v
                pid = v
                if tonumber(pid) > maxPid then
                    maxPid = tonumber(pid)
                end
            end
            i = i + 1
        end
    end

    return maxPid + 1
end

--[[
    用于调试输出数据的函数，弥补服务端没有dump()函数的问题
    能够打印出nil,boolean,number,string,table类型的数据，以及table类型值的元表
    https://www.cnblogs.com/Anker/p/6602475.html

    @param data 表示要输出的数据
    @param showMetatable 表示是否要输出元表，可选
    @param lastCount 用于格式控制，用户请勿使用该变量，可选

    @return none
]]
Utils.print_dump = function(data, showMetatable, lastCount)
    if type(data) ~= "table" then
        --Value
        if type(data) == "string" then
            io.write("\"", data, "\"")
        else
            io.write(tostring(data))
        end
    else
        --Format
        local count = lastCount or 0
        count = count + 1
        io.write("{\n")
        --Metatable
        if showMetatable then
            for i = 1,count do io.write("\t") end
            local mt = getmetatable(data)
            io.write("\"__metatable\" = ")
            Utils.print_dump(mt, showMetatable, count)    -- 如果不想看到元表的元表，可将showMetatable处填nil
            io.write(",\n")     --如果不想在元表后加逗号，可以删除这里的逗号
        end
        --Key
        for key,value in pairs(data) do
            for i = 1,count do io.write("\t") end
            if type(key) == "string" then
                io.write("\"", key, "\" = ")
            elseif type(key) == "number" then
                io.write("[", key, "] = ")
            else
                io.write(tostring(key))
            end
            Utils.print_dump(value, showMetatable, count) -- 如果不想看到子table的元表，可将showMetatable处填nil
            io.write(",\n")     --如果不想在table的每一个item后加逗号，可以删除这里的逗号
        end
        --Format
        for i = 1,lastCount or 0 do io.write("\t") end
        io.write("}")
    end
    --Format
    if not lastCount then
        io.write("\n")
    end
end

--[[
    打印出错时堆栈信息的函数，拷贝自原始的服务端框架

    @param none

    @return string
]]
local function traceback()
    local retstr = "\r\n"
    local level = 3
    while true do
        local info = debug.getinfo(level, "Sln")
        if not info then break end
        if info.what == "C" then -- is a C function?
            retstr = retstr .. string.format("level: %s C function '%s'\r\n", tostring(level), tostring(info.name))
        else -- a Lua function
            retstr = retstr .. string.format("[%s]:%s  in function '%s'\r\n",
                tostring(info.source), tostring(info.currentline), tostring(info.name))
        end
        level = level + 1
    end

    return retstr
end

--[[
    仍是打印出错时堆栈信息的函数，拷贝自原始的服务端框架

    @param errorMessage

    @return none
]]
Utils.__G__TRACKBACK__ = function(errorMessage)
    local log = "LUA ERROR: " .. tostring(errorMessage) .. debug.traceback("", 2)
            .. "\r\nFull Path:" .. traceback()
    print(log)
end
return Utils
