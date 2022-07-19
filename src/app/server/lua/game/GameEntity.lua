--[[--
    GameEntity.lua
    Game实体对象定义
]]

local cjson = require "cjson"
local MsgDef = require("lua.MsgDef")

local Player = require("lua.Game.Player")

GameEntity = {
	serialNumber = 0,
	players = {},
}

GameEntity.__index = GameEntity

GameEntity.new = function()
	local self = {}
	setmetatable(self, GameEntity)
	self.serialNumber = 0
	return self
end

GameEntity.init = function(self, serial, msg)
	self.serialNumber = serial
	self:addPlayer(msg)
	print("init game entity "..serial)
end

GameEntity.addPlayer = function(self, msg)
	local pid = msg["pid"]
	local nick = msg["nick"]
	local hp = msg["hp"]
	local player = Player.new()
	player:init(pid, nick, hp)
	self.players[pid] = player
	self:sendStartGameAck2Client(pid, hp)
end

GameEntity.sendStartGameAck2Client = function(self, pid, hp)
	local ack = {};
	ack["type"] = MsgDef.ACKTYPE.STARTGAME
	ack["playerid"] = pid
	if (hp == 0) then
		ack["maxhp"] = 10
	else
		ack["maxhp"] = hp
	end
	local retMsg = cjson.encode(ack)
	sendMsg2ClientByPid(pid, retMsg)
	print(retMsg)
end

GameEntity.setSerialNumber = function(self, serial)
	self.serialNumber = serial
end

return GameEntity
