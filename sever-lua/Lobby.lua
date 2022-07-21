local cjson = require "cjson"
local Timer = require("lua.Timer")
local LogDef = require("lua.LogDef")
local MsgDef = require("lua.MsgDef")
local Player = require("lua.lobby.player")
local TowerDef= require("lua.TowerDef")
local Match = require("lua.Match")

local matchEntity=nil
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
	matchEntity=Match.init()
	slog("./log/start_info", "init lobby module succ")
end
function randomId(TYPE)
	local normalArray = {"01","04","07","09","18","20"}
	local rareArray = {"03","10","14","15"}
	local epicArray = {"02","08","11","12","16","17"}
	if TYPE == 1 then
		local index = math.random(1, #normalArray)
		return normalArray[index]
	elseif TYPE == 2 then
		local index = math.random(1, #rareArray)
		return rareArray[index]
	elseif TYPE == 3 then
		local index = math.random(1, #epicArray)
		return epicArray[index]
	end
end
function shopData(msg)
	local id, data_str = requestPlayerDBData(msg["loginname"])
	local data = cjson.decode(data_str)
	data["shopData"][msg["i_"]]["SOLD_OUT"]=msg["SOLD_OUT"]
	data_str = cjson.encode(data)
	savePlayerDBData(id, data_str)

	local ack = {};
	ack["type"] = MsgDef.ACKTYPE.SHOPDATA
	ack["pid"] = data["pid"]
	ack["nick"] =data["nick"]
	ack["shopData"] =data["shopData"]

	local retMsg = cjson.encode(ack)
	sendMsg2ClientByPid(ack["pid"], retMsg)
end
function shopRefresh(msg)
	local id, data_str = requestPlayerDBData(msg["loginname"])
	local data = cjson.decode(data_str)
	--商品数据初始化
	data["shopData"]={}
	shopTableInit(data["shopData"])
	data_str = cjson.encode(data)
	savePlayerDBData(id, data_str)
	local ack = {};
	ack["type"] = MsgDef.ACKTYPE.SHOPREFRESH
	ack["pid"] = data["pid"]
	ack["nick"] =data["nick"]
	ack["shopData"] =data["shopData"]

	local retMsg = cjson.encode(ack)
	sendMsg2ClientByPid(ack["pid"], retMsg)
end
function shopTableInit(shopData)
	for i = 1, 4 do
		shopData[i]={}
		shopData[i]["ID"]=randomId(1)
		shopData[i]["SOLD_OUT"]=false
	end
	shopData[5]={}
	shopData[5]["ID"]=randomId(2)
	shopData[5]["SOLD_OUT"]=false
	shopData[6]={}
	shopData[6]["ID"]=randomId(3)
	shopData[6]["SOLD_OUT"]=false
	return shopData
end
function playerInit(id,loginname)
	local saveData = {}
	saveData["pid"] = id
	saveData["nick"] = loginname
	saveData["gold"] = 10000
	saveData["diamond"] = 1000
	saveData["cup"]=0
	saveData["towerData"]={}
	saveData["winStreak"]=0
	--塔数据初始化
	for i = 1, 20 do
		saveData["towerData"][i]={}
		if i <= 10 then
			saveData["towerData"][i]["unlock"]=true
		else
			saveData["towerData"][i]["unlock"]=false
		end
	    saveData["towerData"][i]["fragment"]=0
	    saveData["towerData"][i]["level"]= TowerDef.LEVEL.START_LEVEL[TowerDef.TABLE[i].RARITY]  --濉斿綋鍓嶇瓑绾?
	end
	--塔阵容数据初始化
	saveData["towerArray"]={}
	for i = 1, 3 do
		saveData["towerArray"][i]={}
		for j = 1, 5 do
			saveData["towerArray"][i][j] = {}
			saveData["towerArray"][i][j]["id"] = j
			saveData["towerArray"][i][j]["level"] = 1
		end
	end
	--商品数据初始化
	saveData["shopData"]={}
	shopTableInit(saveData["shopData"])
	return saveData
end
function playerLogin(msg)
	local id, data_str = requestPlayerDBData(msg["loginname"])
	--init player with db data
	print("get player db data")
	if (data_str == nil or data_str == '') then
		local saveData=playerInit(id,msg["loginname"])
	    data_str = cjson.encode(saveData)
		savePlayerDBData(id, data_str)
	end
	local data = cjson.decode(data_str)
	setPid2Sid(data["pid"], msg["sid"])
	newPlayer = Player.new()
	newPlayer:setPid(data["pid"])
	newPlayer:setSid(msg["sid"])
	newPlayer:setNick(data["nick"])
	newPlayer:setLoginName(msg["loginname"])

	-- local logInfo = tostring(id) .. " login succ"
	-- print(logInfo)
	-- qlog(LogDef.CHANNEL.DEBUG, logInfo)

	sendLoginAck2Client(data)
end

function startGame(msg)
	print("start game lobby")
	sendStartGameReq2Game(msg["playerid"], msg["nick"], msg["hp"])
end

function playerUpdateData(msg)
	local id, data_str = requestPlayerDBData(msg["loginname"])
	--init player with db data
	print("数据更新")
	if (data_str == nil or data_str == '') then
		print("用户为空数据更新失败")
	end
	local data = cjson.decode(data_str)
	data["gold"]=msg["gold"]
	data["diamond"]=msg["diamond"]
	data["cup"]=msg["cup"]
	for i = 1, 20 do
		data["towerData"][i]["unlock"]=msg.towerData[i].unlock
		data["towerData"][i]["fragment"]=msg.towerData[i].fragment
		data["towerData"][i]["level"]=msg.towerData[i].level
	end
	for i = 1, 3 do
		for j = 1, 5 do
			data["towerArray"][i][j] = {}
			data["towerArray"][i][j]["id"] = msg["towerArray"][i][j]["id"]
			data["towerArray"][i][j]["level"] = msg["towerArray"][i][j]["level"]
		end
	end
	data_str = cjson.encode(data)
	savePlayerDBData(id, data_str)

	print("开始进行数据发送")
	local ack = {};
	ack["type"] = MsgDef.ACKTYPE.UPDATE_DATA
	ack["pid"] = data["pid"]
	ack["nick"] =data["nick"]
	ack["gold"] = data["gold"]
	ack["diamond"] = data["diamond"]
	ack["cup"]=data["cup"]
	ack["towerData"]=data["towerData"]
	ack["towerArray"]=data["towerArray"]

	local retMsg = cjson.encode(ack)
	sendMsg2ClientByPid(ack["pid"], retMsg)
end
function sendLoginAck2Client(data)
	local ack = {};
	ack["type"] = MsgDef.ACKTYPE.LOGIN
	ack["pid"] = data["pid"]
	ack["nick"] =data["nick"]
	ack["gold"] = data["gold"]
	ack["diamond"] = data["diamond"]
	ack["cup"]=data["cup"]
	ack["towerData"]=data["towerData"]
	ack["towerArray"]=data["towerArray"]
	ack["shopData"] =data["shopData"]

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

function gameMatch(msg)
	local playerName1,playerName2,id= matchEntity:playerJoin(msg["loginname"])
	if playerName2 ~=nil then
		local pid1,data_str1 = requestPlayerDBData(playerName1)
		local pid2,data_str2 = requestPlayerDBData(playerName2)
		local data1=cjson.decode(data_str1)
		local data2=cjson.decode(data_str2)
		local req = {}
		req["type"] = MsgDef.REQTYPE.CREATEGAME
		req["pid1"]=pid1
		req["pid2"]=pid2
		req["data1"]={}
		req["data1"]["nick"]=data1["nick"]
		req["data1"]["towerArray"]=data1["towerArray"][1]
		req["data2"]={}
		req["data2"]["nick"]=data2["nick"]
		req["data2"]["towerArray"]=data2["towerArray"][1]
		req["roomid"]=id
		local retMsg = cjson.encode(req)
		sendMsg2Game(retMsg)
	end
end
function cancelMatch(msg)
	matchEntity:cancelMatch(msg["loginname"])
end
function getSubForCup(number)
	local sub=1
	if number<=200 then
		return 1
	end
	if number<=400 then
		return 2
	end
	if number<=600 then
		return 3
	end
	if number<=1000 then
		return 4
	end
	if number<=3000 then
		return 4+math.ceil((number-1000)/500)
	end
	return 8+math.ceil((number-3000)/1000)
end
function countGame(msg)
	local winpid,data_str1=requestPlayerDBData(msg["win_name"])
	local losepid,data_str2=requestPlayerDBData(msg["lose_name"])
	--进行获胜者的计算
	local data1 = cjson.decode(data_str1)
	local data2 = cjson.decode(data_str2)
	local ack1={
		type=MsgDef.ACKTYPE.GAMEWIN,
		pid=winpid,
		gold1=getSubForCup(data1["cup"])*10,
		cup2=data1["winStreak"]*5,
		gold2=getSubForCup(data1["cup"])*5*data1["winStreak"],
		cup3=40,
		gold3=getSubForCup(data1["cup"])*10,
		dim3=50
	}
	local ack2={
		type=MsgDef.ACKTYPE.GAMELOSE,
		pid=losepid,
	}
	if data1["winStreak"]>=12 then
		ack1["cup2"]=55
		ack1["gold2"]=getSubForCup(data1["cup"])*5*11
	end
	if msg["sd"]<=200 then
		ack1["cup1"]=math.random(35,40)
		ack2["cup1"]=math.random(30,35)*-1
	else
		if data1["cup"]<data2["cup"] then
			ack1["cup1"]=math.random(40,45)
			ack2["cup1"]=math.random(35,40)*-1
		else
			ack1["cup1"]=math.random(30,35)
			ack2["cup1"]=math.random(25,30)*-1
		end
	end
	data1["cup"]=data1["cup"]+ack1["cup1"]+ack1["cup2"]+ack1["cup3"]
	data1["gold"]=data1["gold"]+ack1["gold1"]+ack1["gold2"]+ack1["gold3"]
	data1["winStreak"]=data1["winStreak"]+1
	data1["diamond"]=data1["diamond"]+ack1["dim3"]
	ack1["selfcup"]=data1["cup"]
	--data1["cup"]=data1["cup"]+ack1["cup1"]+ack1["cup2"]+ack1["cup3"]
	data_str1 = cjson.encode(data1)
	savePlayerDBData(winpid, data_str1)
	sendMsg2ClientByPid(ack1["pid"], cjson.encode(ack1))
	data2["cup"]=data2["cup"]+ack2["cup1"]
	data2["winStreak"]=0
	if data2["cup"] < 0 then
		data2["cup"]=0
	end
	ack2["othercup"]=data1["cup"]
	ack2["selfcup"]=data2["cup"]
	data_str2 = cjson.encode(data2)
	savePlayerDBData(losepid, data_str2)
	sendMsg2ClientByPid(ack2["pid"], cjson.encode(ack2))
	matchEntity:gameOver(msg["serialNumber"])
end
function processLobbyMsg()
	local msgStr = recvLobbyMsg()
	if (msgStr == nil or msgStr == '') then
		return
	end
	local msg = cjson.decode(msgStr)
	--进行消息处理
	if (msg["type"] == MsgDef.REQTYPE.LOGIN) then
		playerLogin(msg)
	elseif (msg["type"] == MsgDef.REQTYPE.UPDATE_DATA) then
		print("进行数据更新")
		playerUpdateData(msg)
	elseif (msg["type"] == MsgDef.REQTYPE.STARTGAME) then
		startGame(msg)
	elseif (msg["type"] == MsgDef.REQTYPE.SHOPDATA) then
		print("进行商品数据更新")
		shopData(msg)
	elseif (msg["type"] == MsgDef.REQTYPE.SHOPREFRESH) then
		print("进行商品数据刷新")
		shopRefresh(msg)
	elseif (msg["type"] == MsgDef.REQTYPE.GAMEMATCH) then
		print("进行玩家匹配")
		gameMatch(msg)
	elseif (msg["type"] == MsgDef.REQTYPE.CANCELMATCH) then
		print("玩家退出匹配")
		cancelMatch(msg)
	elseif (msg["type"] == MsgDef.REQTYPE.GAMEOVER) then
		print("玩家游戏结束")
		countGame(msg)
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