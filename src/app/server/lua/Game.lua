local cjson = require "cjson"
local Timer = require("lua.Timer")
local LogDef = require("lua.LogDef")
local MsgDef = require("lua.MsgDef")
local GameEntity = require("lua.game.GameEntity")

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

function __G__TRACKBACK__(errorMessage)
    local log = "LUA ERROR: " .. tostring(errorMessage) .. debug.traceback("", 2)
            .. "\r\nFull Path:" .. traceback()
    print(log)
end

function initGameModule()
	--init game module here
	print("init game module succ")

end
--
function  initGameData(msg)


	local id1, data_str1 = requestPlayerDBData(msg["loginName1"])
	local id2, data_str2 = requestPlayerDBData(msg["loginName2"])
	local data1 = cjson.decode(data_str1)
	local data2 = cjson.decode(data_str2)
	local ack={}
	ack["sid"]=msg["sid"]
	ack["pid1"]=data1["pid"]
	ack["pid2"]=data2["pid"]
	ack["id1"]=id1
	ack["id2"]=id2
	ack["data1"]=data1
	ack["data2"]=data2
	ack["type"]=3
	local retMsg =cjson.encode(ack)
	sendData(ack)
end

function sendData(msg)

	if(msg == nil or msg == '') then
	else
		if msg["type"]== MsgDef.REQTYPE.INIT then
			local data = cjson.decode(msg)
			setPid2Sid(data["pid1"], msg["sid"])
			setPid2Sid(data["pid2"], msg["sid"])
			local ack= {}
			ack["data1"]=data["data1"]
			ack["data2"]=data["data2"]
			local retMsg =cjson.encode(ack)
			sendMsg2ClientByPid(data["pid1"], retMsg)
			sendMsg2ClientByPid(data["pid2"], retMsg)

		elseif msg["type"]== MsgDef.REQTYPE.HANDLE then
			local data = cjson.decode(msg)
			setPid2Sid(data["pid1"], msg["sid"])
			setPid2Sid(data["pid2"], msg["sid"])
			local ack= {}
			ack["data1"]=data["data1"]
			ack["data2"]=data["data2"]
			local retMsg =cjson.encode(ack)
			sendMsg2ClientByPid(data["pid1"], retMsg)
			sendMsg2ClientByPid(data["pid2"], retMsg)
		end
	end
end

-- local gameSerial = 0
-- function createGameEntity(msg)
-- 	gameSerial = gameSerial + 1
-- 	newGame = GameEntity.new()
-- 	newGame:init(gameSerial, msg)
-- 	print("xxxxxxxxxxxxxxxxxxxx")
-- end

function processGameMsg()
	local handle={}
	local msgStr = recvGameMsg()
	if (msgStr == nil or msgStr == '') then
		return
	end
	local msg = cjson.decode(msgStr)
	print(msg["loginName1"])
	if (msg["type"] == MsgDef.REQTYPE.HANDLE) then
		createGameEntity(msg)
	elseif  (msg["type"] == MsgDef.REQTYPE.STARTGAME) then
		initGameData(msg)
	end
end

function update()
	--main loop
	processGameMsg()
	--other logic update
end

function main()

	initGameModule()
	local loopTimer = Timer.new()
	loopTimer:beginTimer(50)
	while true do
		if loopTimer:countingTimer() then
			update()
		end
		msSleep(1)
	end
end

xpcall(main, __G__TRACKBACK__)
