--[[--
    GameEntity.lua
    Game实体对象定义
]]

local cjson = require "cjson"
local MsgDef = require("lua.MsgDef")
local Player = require("lua.Game.Player")
local LogDef = require("lua.LogDef")
local Timer  = require("lua.Timer")
GameEntity = {
	serialNumber = 0,
	players = {},
	severframe = 0,
	boss = 0,
	gameflag = false,
	handleframe={},
	gameTime=180000
}

GameEntity.__index = GameEntity

GameEntity.new = function()
	local self = {}
	setmetatable(self, GameEntity)
	self.serialNumber = 0
	self.severframe = 0
	self.players={}
	self.player1req=false
	self.player2req=false
	self.boss= 0
	self.gameflag=false
	self.handle ={
		create={},
		compose={},
		upgrade={},
	}
	self.loopTimer=Timer.new()
	self.loopTimer:beginTimer(15)
	self.handleframe={}
	self.gameTime=180000
	self.waitTime = 48 --三帧等待回应延迟
	self.waitTick = 0
	return self
end

GameEntity.init = function(self, serial, msg)
	self.serialNumber = serial
	self:addPlayer(msg)
	print("init game entity "..serial)
end

GameEntity.addPlayer = function(self, msg)
	local player1 = Player.new()
	local player2 = Player.new()
	player1:init(msg["pid1"],msg["data1"]["nick"],msg["data1"]["towerArray"][1])
	player2:init(msg["pid2"],msg["data2"]["nick"],msg["data2"]["towerArray"][1])
	self.players[1] = player1
	self.players[2] = player2
	self:sendStartGameAck2Client(msg["pid1"],msg["data1"],msg["data2"])
	self:sendStartGameAck2Client(msg["pid2"],msg["data1"],msg["data2"])
end

GameEntity.sendStartGameAck2Client = function(self, pid,data1,data2)
	local ack = {};
	ack["type"] = MsgDef.ACKTYPE.STARTGAME
	ack["pid"] = pid
	ack["data1"]=data1
	ack["data2"]=data2
	ack["serialNumber"]=self.serialNumber
	ack["random"]=getTickCount()
	local retMsg = cjson.encode(ack)
	sendMsg2ClientByPid(pid, retMsg)
end
GameEntity.setBoss = function (self,msg)
	self.boss=self.boss+1
	if self.boss== 2 then
		self:sendBossTrueAck2Client()
		self.gameflag=true
	end
end
GameEntity.gameOver = function (self,winname,losename,msg)
	local ack = {}
	ack["type"]=MsgDef.ACKTYPE.GAMEOVER
	ack["pid"]=msg["pid"]
	ack["win_name"]=winname
	ack["lose_name"]=losename
	ack["sd"]=msg["sd"]
	ack["serialNumber"]=self.serialNumber
	print("进行游戏结算处理")
	local retMsg = cjson.encode(ack)
	sendMsg2ClientByPid(msg["pid"], retMsg)
end
GameEntity.playerSurrender = function (self,msg)
	self.gameflag=false
	if msg["pid"]==self.players[1]:getPid() then
		self:gameOver(self.players[2]:getName(),self.players[1]:getName(),msg)
	else
		self:gameOver(self.players[1]:getName(),self.players[2]:getName(),msg)
	end
end
GameEntity.sendWinPlayer = function (self,winpid,losepid,msg)

end
GameEntity.sendLosePlayer = function (self,pid,msg)

end
GameEntity.lifeChange = function (self,msg)
	if msg["pid"]==self.players[1]:getPid() then
		if self.players[2]:lifeChange(msg["number"])==0 then
			local req={
				serialNumber=self.serialNumber,
				pid=self.players[1]:getPid(),
				sd=150
			}
			self:gameOver(self.players[1]:getName(),self.players[2]:getName(),req)
		end
	else
		if self.players[1]:lifeChange(msg["number"])==0 then
			local req={
				serialNumber=self.serialNumber,
				pid=self.players[2]:getPid(),
				sd=150
			}
			self:gameOver(self.players[2]:getName(),self.players[1]:getName(),req)
		end
	end

	local ack = {}
	ack["type"]=MsgDef.ACKTYPE.LIFECHANGE
	ack["pid"]=msg["pid"]
	ack["number"]=msg["number"]
	local retMsg = cjson.encode(ack)
	sendMsg2ClientByPid(self.players[1]:getPid(), retMsg)
	sendMsg2ClientByPid(self.players[2]:getPid(), retMsg)


end
GameEntity.towerCreate = function (self,msg)
	local i = #self.handle["create"]+1
	self.handle["create"][i]=msg["info"]
	self.handle["create"][i]["pid"]=msg["pid"]
end
GameEntity.gamePlay = function (self,msg)
	if msg["pid"]==self.players[1]:getPid() then
		self.player1req=true
		if msg["handle"]["create"] then
			msg["handle"]["create"]["id"]=math.random(5)
			self.handle["create"][#self.handle["create"]+1] = msg["handle"]["create"]
		end
		if msg["handle"]["compose"] then
			msg["handle"]["compose"]["id"]=math.random(5)
			self.handle["compose"][#self.handle["compose"]+1] = msg["handle"]["compose"]
		end
		if msg["handle"]["upgrade"] then
			self.handle["upgrade"][#self.handle["upgrade"]+1] = msg["handle"]["upgrade"]
		end
	else
		self.player2req=true
		if msg["handle"]["create"] then
			msg["handle"]["create"]["id"]=math.random(5)
			self.handle["create"][#self.handle["create"]+1] = msg["handle"]["create"]
		end
		if msg["handle"]["compose"] then
			msg["handle"]["compose"]["id"]=math.random(5)
			self.handle["compose"][#self.handle["compose"]+1] = msg["handle"]["compose"]
		end
		if msg["handle"]["upgrade"] then
			self.handle["upgrade"][#self.handle["upgrade"]+1] = msg["handle"]["upgrade"]
		end
	end
end
GameEntity.sendBossTrueAck2Client = function (self)
	local ack = {};
	ack["type"] = MsgDef.ACKTYPE.BOSSTRUE
	ack["boss"] = 4
	self.severframe=1
	local retMsg = cjson.encode(ack)
	sendMsg2ClientByPid(self.players[1]:getPid(), retMsg)
	sendMsg2ClientByPid(self.players[2]:getPid(), retMsg)
end
GameEntity.setSerialNumber = function(self, serial)
	self.serialNumber = serial
end
GameEntity.setPlayerUpdataReq = function(self, pid)
	if self.players[1]:getPid()==pid then
		self.player1req=true
	else
		self.player2req=true
	end
end
GameEntity.update = function(self)
	if self.gameflag==false then
		return
	end
	local flag,dt=self.loopTimer:countingTimer()
	if flag==false then
		return
	end
	self.waitTick=self.waitTick+dt
	if self.waitTick<self.waitTime and (self.player1req==false or self.player2req==false) then
		return
	end
	local ack = {};
	ack["time"]=self.gameTime or {}
	ack["dt"] = dt
	ack["severframe"]=self.severframe
	ack["handle"] =self.handle
	self:sendGamePlayerAck2Client(self.players[1]:getPid(),ack)
	self:sendGamePlayerAck2Client(self.players[2]:getPid(),ack)
	self.handleframe[self.severframe]=ack
	--状态初始化
	self.player1req=false
	self.player2req=false
	self.handle ={
		create={},
		compose={},
		upgrade={},
	}
	self.waitTick=0
	self.gameTime=self.gameTime-dt
	self.severframe=self.severframe+1
end

GameEntity.sendGamePlayerAck2Client = function(self, pid,oldack)
	local ack ={}
	ack["type"] = MsgDef.ACKTYPE.GAMEPLAY
	ack["dt"]=oldack["dt"]
	ack["severframe"]=oldack["severframe"]
	ack["handle"]=oldack["handle"]
	ack["time"]=oldack["time"]
	ack["pid"]=pid
	local retMsg = cjson.encode(ack)
	sendMsg2ClientByPid(pid, retMsg)
end
return GameEntity
