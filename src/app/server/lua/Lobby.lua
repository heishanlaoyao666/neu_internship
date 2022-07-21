local cjson = require "cjson"
local Timer = require("lua.Timer")
local LogDef = require("lua.LogDef")
local MsgDef = require("lua.MsgDef")
local Player = require("lua.lobby.player")

local MatchingNumber =0   --正在匹配的人数
local Matcharr={
	loginName="",
	trophyAmount=0,
}                         --匹配数组
local trophyAmountSort={} --将匹配的人按照trophyAmount进行排序 key为trophyAmount，内为loginName
local onlineNumber   =0   --在线人数

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


---登录
function playerLogin(msg)

	print(msg["loginName"])
	local id, data_str = requestPlayerDBData(msg["loginName"])
	print(data_str)
	local data = cjson.decode(data_str)

	--init player with db data
	local logInfo
	if (data["passWord"]==msg["passWord"]) then
		print(data["loginName"].."login succ ")
		logInfo = tostring(id) .. " login succ"
	elseif(data["loginName"]==nil) then 
		print(msg["loginName"].."not find ")
		logInfo = tostring(id) .. "loginName not find"
	elseif(data["passWord"]~=msg["passWord"]) then 
		print(data["loginName"].." passWord unconnect ")
		logInfo = tostring(id) .. " passWord unconnect "
	end
	setPid2Sid(data["pid"], msg["sid"])
	qlog(LogDef.CHANNEL.DEBUG, logInfo)
	sendLoginAck2Client(data)
end


--注册, 输入用户名账号和密码，若账号已存在则不完成注册
function playerregister(msg)

	-- local id, data_str = requestPlayerDBData(msg["loginName"])
	-- --init player with db data
	-- print("get player db data")
	-- print(data_str)
	-- if (data_str == nil or data_str == '') then
	-- 	local saveData = {}
	--     saveData["pid"] = id
	-- 	saveData["nick"] = msg["loginName"]
	--     data_str = cjson.encode(saveData)
	-- 	savePlayerDBData(id, data_str)
	-- 	print(data_str)
	-- end

	local id, data_str = requestPlayerDBData(msg["loginName"])
	--init player with db data
	if (data_str == nil or data_str == '') then
		print("111")
		local saveData = {}
	 	saveData["pid"] = id
		saveData["loginName"] = msg["loginName"]
		saveData["passWord"]=msg["passWord"]
	    data_str = cjson.encode(saveData)
		print(data_str)
		savePlayerDBData(id, data_str)
	else
		print("123")
	end
	local data = cjson.decode(data_str)
	setPid2Sid(data["pid"], msg["sid"])
	-- newPlayer = Player.new()
	-- newPlayer:setPid(data["pid"])
	-- newPlayer:setSid(msg["sid"])
	-- newPlayer:setPassWord(data["passWord"])
	-- newPlayer:setLoginName(data["loginName"])
	-- print(newPlayer)
	local logInfo = tostring(id) .. " register succ"
	print(logInfo)
	qlog(LogDef.CHANNEL.DEBUG, logInfo)

	sendLoginAck2Client(data)
end

--客户端向服务器发送数据，客户端完成存档
function getData(msg)
	local id, data_str = requestPlayerDBData(msg["loginName"])
	newPlayer =Player.new()
	local data_t = cjson.decode(data_str)
	if msg["dataType"] then
		newPlayer:setFinanceData(msg["data"])
		data_t[msg["dataType"]]=newPlayer.financeData
		print(data_t[msg["dataType"]][1])
		local data=cjson.encode(data_t)
		savePlayerDBData(id, data)

	end

end

--服务器向客户端发送需要的数据。

function sendData(msg)
	local id, data_str = requestPlayerDBData(msg["loginName"])
	print(data_str)
	if(data_str == nil or data_str == '') then
	else 
		if msg["dataType"] then
			local data = cjson.decode(data_str)
			setPid2Sid(data["pid"], msg["sid"])
			local ack= {};
			ack["dataType"]=msg["dataType"]
			ack[msg["dataType"]]=data[msg["dataType"]]
			local retMsg =cjson.encode(ack)
			sendMsg2ClientByPid(data["pid"], retMsg)
		end
	end
end
--将对象添加到匹配池中
function addMatch(msg)
	local id, data_str = requestPlayerDBData(msg["loginName"])
	local data = cjson.decode(data_str)
	if data["achieveData"][1]==nil then
		data["achieveData"][1]=0
	end
	if(data_str == nil or data_str == '') then	
		print("not found player")
	else
		if(msg["matching"]==1)then
			MatchingNumber=MatchingNumber+1
			Matcharr[MatchingNumber]["trophyAmount"]=data["achieveData"][1]
			Matcharr[MatchingNumber]["loginName"]=data["loginName"]
			table.insert(trophyAmountSort[data["achieveData"][1]],data["loginName"])
		end
		if(msg["matching"]==0)then
			Matcharr[MatchingNumber]=nil
			table.remove(trophyAmountSort[data["achieveData"][1]],data["loginName"])
		end
	end
end
--匹配，将achieveData相同玩家匹配
function match()

	local loginName1=""
	local loginName2=""
	if MatchingNumber>=2 then
		print("123")
		for i=1,MatchingNumber do
			local trophyAmount=Matcharr[i]["trophyAmount"]
			if(#trophyAmountSort[trophyAmount]>=2)	then
				loginName1=trophyAmountSort[trophyAmount][1]
				loginName2=trophyAmountSort[trophyAmount][2]
				table.remove(trophyAmountSort[trophyAmount][1],loginName1)
				table.remove(trophyAmountSort[trophyAmount][1],loginName2)
				startGame(loginName1, loginName2)
			end
		end
	end

end
function startGame(loginName1,loginName2)
	print("start game lobby")
	sendStartGameReq2Game(loginName1,loginName2)
end

function sendLoginAck2Client(data)
	local ack = {};
	ack["type"] = MsgDef.ACKTYPE.LOGIN
	ack["pid"] = data["pid"]
	ack["loginName"] = data["loginName"]
	ack["passWord"]=data["passWord"]
	local retMsg = cjson.encode(ack)
	sendMsg2ClientByPid(data["pid"], retMsg)
end

--将匹配成功的用户名传入至游戏内
function sendStartGameReq2Game(loginName1,loginName2)
	local req ={}
	req["type"]=1
	req["loginName1"]=loginName1
	req["loginName2"]=loginName2
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
	elseif (msg["type"] == MsgDef.REQTYPE.REGISTER) then
		playerregister(msg)
	elseif (msg["type"] == MsgDef.REQTYPE.STARTGAME) then
		startGame(msg)
	elseif (msg["type"] == MsgDef.REQTYPE.GETDATA) then
		getData(msg)
	elseif (msg["type"] == MsgDef.REQTYPE.SENDDATA) then
		sendData(msg)
	elseif (msg["type"] == MsgDef.REQTYPE.MATCHING) then
		addMatch(msg)
		MatchingNumber=MatchingNumber+1
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