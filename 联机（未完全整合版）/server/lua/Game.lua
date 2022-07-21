local cjson = require "cjson"
local Timer = require("lua.Timer")
local LogDef = require("lua.LogDef")
local MsgDef = require("lua.MsgDef")
local GameEntity = require("lua.game.GameEntity")

local match_={}
local handle_={}

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
--初始化游戏 
function  initGameData(msg)

	msSleep(150)
	local id1, data_str1 = requestPlayerDBData(msg["loginName1"])
	local id2, data_str2 = requestPlayerDBData(msg["loginName2"])
	local data1 = cjson.decode(data_str1)
	local data2 = cjson.decode(data_str2)
	local ack={}
	ack["sid"]=msg["sid"]
	ack["pid1"]=data1["pid"]
	ack["pid2"]=data2["pid"]
	ack["loginName1"]=msg["loginName1"]
	ack["loginName2"]=msg["loginName2"]
	ack["data1"]=data1.towerData
	ack["data2"]=data2.towerDate
	ack["trophyAmount1"]=data1.achieveData.trophyAmount
	ack["trophyAmount2"]=data2.achieveData.trophyAmount
	ack["type"]=3
	local retMsg =cjson.encode(ack)
	sendData(ack)
end

--帧同步，派发数据
function  handleData(msg)

	local id1, data_str1 = requestPlayerDBData(msg["loginName1"])
	local id2, data_str2 = requestPlayerDBData(msg["loginName2"])
	local data1 = cjson.decode(data_str1)
	local data2 = cjson.decode(data_str2)
	local ack={}
	ack["sid"]=msg["sid"]
	ack["loginName1"]=msg["loginName1"]
	ack["loginName2"]=msg["loginName2"]
	ack["pid1"]=data1["pid"]
	ack["pid2"]=data2["pid"]
	ack["data1"]=data1
	ack["data2"]=data2
	ack["type"]=1
	local retMsg =cjson.encode(ack)
	sendData(ack)
end

--向客户端发送操作

function sendData(msg)

	if(msg == nil or msg == '') then
	else
		if msg["type"]== MsgDef.REQTYPE.STARTGAME then
			local data = cjson.decode(msg)
			setPid2Sid(data["pid1"], msg["sid"])
			setPid2Sid(data["pid2"], msg["sid"])
			local ack= {}
			ack["type"]=1
			ack["data1"]=data["data1"]
			ack["data2"]=data["data2"]
			ack["trophyAmount1"]=data["trophyAmount1"]
			ack["trophyAmount2"]=data["trophyAmount1"]
			ack["loginName1"]=data["loginName1"]
			ack["loginName2"]=data["loginName2"]
			local retMsg =cjson.encode(ack)
			sendMsg2ClientByPid(data["pid1"], retMsg)
			sendMsg2ClientByPid(data["pid2"], retMsg)

		elseif msg["type"]== MsgDef.REQTYPE.HANDLE then
			local data = cjson.decode(msg)
			setPid2Sid(data["pid1"], msg["sid"])
			setPid2Sid(data["pid2"], msg["sid"])
			local ack= {}
			ack["type"]=2
			ack["data1"]=data["data1"]
			ack["data2"]=data["data2"]
			ack["loginName1"]=data["loginName1"]
			ack["loginName2"]=data["loginName2"]
			local retMsg =cjson.encode(ack)
			sendMsg2ClientByPid(data["pid1"], retMsg)
			sendMsg2ClientByPid(data["pid2"], retMsg)

		elseif msg["type"]== MsgDef.REQTYPE.GIVEUP then
			local data = cjson.decode(msg)
			setPid2Sid(data["pid1"], msg["sid"])
			setPid2Sid(data["pid2"], msg["sid"])
			local ack= {}
			ack["type"]=3
			ack["data1"]=data["data1"]
			ack["data2"]=data["data2"]
			ack["loginName1"]=data["loginName1"]
			ack["loginName2"]=data["loginName2"]
			local retMsg =cjson.encode(ack)
			sendMsg2ClientByPid(data["pid1"], retMsg)
			sendMsg2ClientByPid(data["pid2"], retMsg)
		end
	end
end

---投降
function giveUp(msg)

		local id1, data_str1 = requestPlayerDBData(msg["loginName1"])
		local id2, data_str2 = requestPlayerDBData(match_(msg["loginName2"]))
		local data1 = cjson.decode(data_str1)
		local data2 = cjson.decode(data_str2)
		local ack={}
		ack["sid"]=msg["sid"]
		ack["loginName1"]=msg["loginName1"]
		ack["loginName2"]=match_(msg["loginName2"])
		ack["pid1"]=data1["pid"]
		ack["pid2"]=data2["pid"]
		ack["type"]=3
		local retMsg =cjson.encode(ack)
		sendData(ack)
end
-- local gameSerial = 0
-- function createGameEntity(msg)
-- 	gameSerial = gameSerial + 1
-- 	newGame = GameEntity.new()
-- 	newGame:init(gameSerial, msg)
-- 	print("xxxxxxxxxxxxxxxxxxxx")
-- end

function processGameMsg()
	local msgStr = recvGameMsg()
	if (msgStr == nil or msgStr == '') then
		return
	end
	local msg = cjson.decode(msgStr)
	print(msg["loginName1"])
	if (msg["type"] == MsgDef.REQTYPE.HANDLE) then

		handleData(handle_[1])
		handlequeue(msg)
	elseif  (msg["type"] == MsgDef.REQTYPE.STARTGAME) then
		match_[msg["loginName1"]]=msg["loginName2"]
		initGameData(msg)
	elseif  (msg["type"] == MsgDef.REQTYPE.GIVEUP) then
		initGameData(msg)
	end

end

function handlequeue(msg)
	table.remove(handle_, 1)
	table.insert(handle_,msg)
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
		print(1)
		if loopTimer:countingTimer() then
			update()
		end
		msSleep(30)
	end
end

xpcall(main, __G__TRACKBACK__)
