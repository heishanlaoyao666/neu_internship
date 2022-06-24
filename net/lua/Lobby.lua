local cjson = require "cjson"
local Timer = require("lua.Timer")
local LogDef = require("lua.LogDef")
local MsgDef = require("lua.MsgDef")
local Player = require("lua.lobby.player")

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

function initLobbyModule()
	--init lobby module here
	print("init lobby module succ")
	slog("./log/start_info", "init lobby module succ")
end

function playerLogin(msg)
	local id, data_str = requestPlayerDBData(msg["loginname"])
	--init player with db data
	print("get player db data")
	print(data_str)
	if (data_str == nil or data_str == '') then
		local saveData = {}
	    saveData["pid"] = id
		saveData["nick"] = msg["loginname"]
	    data_str = cjson.encode(saveData)
		savePlayerDBData(id, data_str)
		print(data_str)
	end
	local data = cjson.decode(data_str)
	setPid2Sid(data["pid"], msg["sid"])
	newPlayer = Player.new()
	newPlayer:setPid(data["pid"])
	newPlayer:setSid(msg["sid"])
	newPlayer:setNick(data["nick"])
	newPlayer:setLoginName(msg["loginname"])

	local logInfo = tostring(id) .. " login succ"
	print(logInfo)
	qlog(LogDef.CHANNEL.DEBUG, logInfo)

	sendLoginAck2Client(data)
end

function startGame(msg)
	print("start game lobby")
	sendStartGameReq2Game(msg["playerid"], msg["nick"], msg["hp"])
end

function sendLoginAck2Client(data)
	local ack = {};
	ack["type"] = MsgDef.ACKTYPE.LOGIN
	ack["pid"] = data["pid"]
	ack["nick"] = data["nick"]
	local retMsg = cjson.encode(ack)
	sendMsg2ClientByPid(ack["pid"], retMsg)
end

function sendStartGameReq2Game(pid, nick, hp)
	local req = {}
	req["type"] = MsgDef.REQTYPE.CREATEGAME
	req["pid"] = pid
	req["nick"] = nick
	req["hp"] = hp
	local retMsg = cjson.encode(req)
	sendMsg2Game(retMsg)
end

function processLobbyMsg()
	local msgStr = recvLobbyMsg()
	if (msgStr == nil or msgStr == '') then
		return
	end
	print(msgStr)
	local msg = cjson.decode(msgStr)
	if (msg["type"] == MsgDef.REQTYPE.LOGIN) then
		playerLogin(msg)
	elseif (msg["type"] == MsgDef.REQTYPE.STARTGAME) then
		startGame(msg)
	end
end

function update()
	--main loop
	processLobbyMsg()
	--other logic update
end

function main()
	initLobbyModule()
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