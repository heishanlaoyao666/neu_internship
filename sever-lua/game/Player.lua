--[[--
    Player.lua
    GameÕÊº“¿‡
]]

Player = {
	pid = 0,
	name = "",
	life = 0,
	towerarray =nil
}

Player.__index = Player

Player.new = function()
	local self = {}
	setmetatable(self, Player)
	self.pid = 0
	self.name = ""
	self.towerarray=nil
	self.life = 3
	return self
end

Player.init = function(self, pid, nick,towerarray)
	self.pid = pid
	self.name = nick
	self.life = 3
	self.towerarray=towerarray
end
Player.getPid = function (self)
	local pid = self.pid
	return pid
end
Player.getName = function (self)
	return self.name
end
Player.lifeChange = function (self,number)
	self.life=self.life-number
	if self.life<0 then
		self.life=0
	end
	return self.life
end

return Player