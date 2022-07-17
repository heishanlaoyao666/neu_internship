--[[
    Lobby.lua
    描述：服务端大厅模块
    编写：
    修订：
    检查：
]]

local cjson = require "cjson"
local Timer = require("lua.Timer")
local MsgDef = require("lua.MsgDef")
local Utils = require("lua.Utils")
local LobbyData = require("lua.LobbyData")
local StoreData = require("lua.StoreData")

--[[
    Lobby模块的初始化函数，拷贝自原始的服务端框架

    @param none

    @return none
]]
function initLobbyModule()
	--init lobby module here
	print("init lobby module succeed")
	print("lobby good job bro.")
	slog("./log/start_info", "init lobby module succ")
end

--[[
    处理登录游戏的函数

    @param msg

    @return none
]]
function handleEnterGame(msg)
	LobbyData:addPlayer(msg["nick"])
end

--[[
    处理退出游戏的函数

    @param msg

    @return none
]]
function handleQuitGame(msg)
	LobbyData:removePlayer(msg["nick"])
end

--[[
    处理登录消息的函数

    @param msg

    @return none
]]
function handleLogin(msg)
    print('in login')
    local _, data_str = Utils.requestPlayerDBDataNow(msg["nick"])
    local data = cjson.decode(data_str)
    if data ~= nil and data["pwd"] ~= nil and data["pwd"] == msg["pwd"] and (not LobbyData:ifOnLine(msg["nick"])) then
		print("login ok")
		local resp = {}
		resp["type"] = MsgDef.ACK_TYPE.LOGIN_SUCCEED
		resp["pid"] = data["pid"]
		resp["nick"] = data["nick"]
		resp["pwd"] = data["pwd"]
		local retMsg = cjson.encode(resp)
		sendMsg2ClientBySid(msg["sid"], retMsg)
    else
        print("login fail")
        local resp = {}
        resp["type"] = MsgDef.ACK_TYPE.LOGIN_FAIL
        resp["pid"] = -1
        local retMsg = cjson.encode(resp)
        sendMsg2ClientBySid(msg["sid"], retMsg)
    end
end

--[[
    处理注册消息的函数

    @param msg

    @return none
]]
function handleRegister(msg)
    print('in register')
    local id, data_str = Utils.requestPlayerDBDataNow(msg["nick"])

    if id == nil and data_str == nil then
        local pid = Utils.getNewPid()
        Utils.saveAccount(msg["nick"], pid)
        local _, temp = Utils.requestPlayerDBDataNow("initialPlayer")
		local player = cjson.decode(temp)
        player.pid = pid
        player.pwd = msg["pwd"]
        player.nick = msg["nick"]
        Utils.savePlayerDBDataNow(pid, cjson.encode(player))
        local resp = {}
        resp["type"] = MsgDef.ACK_TYPE.REGISTER_SUCCEED
        resp["pid"] = pid
        resp["nick"] = msg["nick"]
        resp["pwd"] = msg["pwd"]
        local retMsg = cjson.encode(resp)
        sendMsg2ClientBySid(msg["sid"], retMsg)
    else
        local resp = {}
        resp["type"] = MsgDef.ACK_TYPE.REGISTER_FAIL
        resp["pid"] = -1
        local retMsg = cjson.encode(resp)
        sendMsg2ClientBySid(msg["sid"], retMsg)
    end
end

--[[
    接收商店所有信息

    @param msg

    @return none
]]
function handleSendStoreData(msg)
	local resp = {};
	resp["type"] = MsgDef.ACK_TYPE.STORE_DATA_SEND_SUCCEED
	resp["data"] = StoreData.goldStoreCards_
	local retMsg = cjson.encode(resp)
	sendMsg2ClientBySid(msg["sid"], retMsg)
end

--[[
    发送用户所有信息

    @param msg

    @return none
]]
function handleSendPlayerData(msg)

	print("发送用户信息！")

	local _, data_str = Utils.requestPlayerDBDataNow(msg["nick"])
	local data = cjson.decode(data_str)

	local resp = {};
	resp["type"] = MsgDef.ACK_TYPE.PLAYER_DATA_SEND_SUCCEED
	resp["data"] = data
	local retMsg = cjson.encode(resp)
	sendMsg2ClientBySid(msg["sid"], retMsg)
end

--[[
    接收用户所有信息

    @param msg

    @return none
]]
function handleRecPlayerData(msg)
	local id, _ = Utils.requestPlayerDBDataNow(msg["nick"])
	Utils.savePlayerDBDataNow(id, cjson.encode(msg))

	local resp = {};
	resp["type"] = MsgDef.ACK_TYPE.PLAYER_DATA_REC_SUCCEED
	resp["data"] = "Sync Succeed!"
	local retMsg = cjson.encode(resp)
	sendMsg2ClientBySid(msg["sid"], retMsg)
end

--[[
    接收用户的开始匹配的信息

    @param msg

    @return none
]]
function handleStartMapping(msg)

	if LobbyData.mappingQueue:isQueueEmpty() then -- 目前队列为空
		LobbyData.mappingQueue:enQueue(msg)
	else -- 转发消息
		local playerOneMsg = LobbyData.mappingQueue:deQueue()
		local playerTwoMsg = msg

		local sidOne = playerOneMsg["sid"]
		local sidTwo = playerTwoMsg["sid"]

		local retMsg = {}
		retMsg["data"] = {
			playerOneMsg,
			playerTwoMsg
		}
		retMsg["type"] = MsgDef.REQ_TYPE.SETUP_CONNECTION

		sendMsg2Game(cjson.encode(retMsg)) -- 将消息转发到Game模块

		-- 发送匹配成功消息到客户端
		local respOne = {};
		respOne["type"] = MsgDef.ACK_TYPE.MAPPING_SUCCEED
		respOne["data"] = "Sync Succeed!"
		local retMsgOne = cjson.encode(respOne)
		sendMsg2ClientBySid(sidOne, retMsgOne)

		local respTwo = {};
		respTwo["type"] = MsgDef.ACK_TYPE.MAPPING_SUCCEED
		respTwo["data"] = "Sync Succeed!"
		local retMsgTwo = cjson.encode(respTwo)
		sendMsg2ClientBySid(sidTwo, retMsgTwo)
	end

end

--[[
    接收用户的终止匹配的信息

    @param msg

    @return none
]]
function handleEndMapping(msg)
	if not LobbyData.mappingQueue:isQueueEmpty() then -- 目前队列为空
		LobbyData.mappingQueue:deQueue()
	end
end

--[[
    主循环里处理所有发到服务端消息的函数
	注意：发往Game模块的消息也会先在这里接收到，如果需要在Game模块处理，则需要主动转发到Game模块

    @param none

    @return none
]]
function update()
	local msgStr = recvLobbyMsg()
	if (msgStr == nil or msgStr == '') then
		return
	end
	local msg = cjson.decode(msgStr)
	-- 在这里按消息类型处理不同的消息
	if (msg["type"] == MsgDef.REQ_TYPE.LOGIN) then --登录
		handleLogin(msg)
    elseif (msg["type"] == MsgDef.REQ_TYPE.REGISTER) then -- 注册
        handleRegister(msg)
	elseif (msg["type"] == MsgDef.REQ_TYPE.ENTER_GAME) then -- 登陆游戏
		handleEnterGame(msg)
	elseif (msg["type"] == MsgDef.REQ_TYPE.QUIT_GAME) then -- 退出游戏
		handleQuitGame(msg)
	elseif (msg["type"] == MsgDef.REQ_TYPE.SEND_PLAYER_DATA) then -- 客户端发送用户数据
		handleSendPlayerData(msg)
	elseif (msg["type"] == MsgDef.REQ_TYPE.REC_PLAYER_DATA) then -- 客户端接受用户数据
		handleRecPlayerData(msg)
	elseif (msg["type"] == MsgDef.REQ_TYPE.START_MAPPING) then -- 开始匹配
		handleStartMapping(msg)
	elseif (msg["type"] == MsgDef.REQ_TYPE.END_MAPPING) then -- 终止匹配
		handleEndMapping(msg)
	elseif (msg["type"] == MsgDef.REQ_TYPE.SEND_STORE_DATA) then -- 客户端接收商店数据
		handleSendStoreData(msg)
	elseif (msg["type"] == MsgDef.REQ_TYPE.CREATE_TOWER) then
		sendMsg2Game(cjson.encode(msg))
	elseif (msg["type"] == MsgDef.REQ_TYPE.UPGRADE_TOWER) then
		sendMsg2Game(cjson.encode(msg))
	elseif (msg["type"] == MsgDef.REQ_TYPE.ENFORCE_TOWER) then
		sendMsg2Game(cjson.encode(msg))
	end
end

--[[
    Lobby模块的入口函数，拷贝自原始的服务端框架

    @param none

    @return none
]]
function main()
	initLobbyModule()

	StoreData:init()

	local loopTimer = Timer.new()
	loopTimer:beginTimer(50)
	while true do
		-- 时间
		local time = os.date("*t")

		if time.hour == 23 and time.min == 59 and time.sec == 55 then
			StoreData:refreshGoldStoreCards()
		end

		if loopTimer:countingTimer() then
			update()
		end
		msSleep(10)
	end
end

xpcall(main, Utils.__G__TRACKBACK__)