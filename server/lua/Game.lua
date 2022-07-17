--[[
    Game.lua
    描述：服务端游戏模块
    编写：
    修订：
    检查：
]]

local cjson = require "cjson"
local GameData = require("inGame.GameData")
local MsgDef = require("lua.MsgDef")
local befTime_ = 0
local sidMap_ = {}
local gameData = nil
local Utils = require("lua.Utils")

--[[
    Game模块的初始化函数，拷贝自原始的服务端框架

    @param none

    @return none
]]
function initGameModule()
    --init game module here
    print("init game module succeed")
    gameData = GameData:new()
end

--[[
    主循环里处理所有发到Game模块消息的函数
	注意：如果需要在Game模块接收并处理消息，需要主动在Lobby模块里面将消息转发到Game模块

    @param dt

    @return none
]]
function update(dt)
    local msgStr = recvGameMsg()
    if msgStr == nil or msgStr == '' then
    else
        print("sssss shu ju chuan ru sssssssssss")
        local msg = cjson.decode(msgStr)
        Utils.print_dump(msg)
        if (msg["type"] == MsgDef.REQ_TYPE.SETUP_CONNECTION) then
            table.insert(sidMap_, msg["sid"])
            gameData:addPlayer(msg["data"],msg["sid"])
        elseif (msg["type"] == MsgDef.REQ_TYPE.CREATE_TOWER) then
            gameData:msgDispose(msg["data"],msg["sid"])
        elseif (msg["type"] == MsgDef.REQ_TYPE.UPGRADE_TOWER) then
            gameData:msgDispose(msg["data"],msg["sid"])
        elseif (msg["type"] == MsgDef.REQ_TYPE.ENFORCE_TOWER) then
            gameData:msgDispose(msg["data"],msg["sid"])
        end
    end

    local data = gameData:update(dt)
    if data == nil then
        return
    end
    print("sssss send msg ssssssssssssssss")
    for i =1,2 do
        local ack = {}
        ack["type"] = MsgDef.ACK_TYPE.GAME_SYNC
        ack["data"] = data[i].data
        local retMsg = cjson.encode(ack)
        sendMsg2ClientBySid(data[i].sid, retMsg)
    end
end

--[[
    Game模块的入口函数，拷贝自原始的服务端框架

    @param none

    @return none
]]
function main()
    print("----- game main -----")
    sidMap_ = {}
	initGameModule()
	while true do
		local curTime = getTickCount()
		update(curTime - befTime_)
		befTime_ = curTime
	end
end

xpcall(main, __G__TRACKBACK__)
