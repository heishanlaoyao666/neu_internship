--[[--
    Player.lua
    Game中Player对象定义
]]

Player = {
	pid = 0,
	nick = "",
	hp = 0,
}

Player.__index = Player

Player.new = function()
	local self = {}
	setmetatable(self, Player)
	self.pid = 0
	self.nick = ""
	return self
end

Player.init = function(self, pid, nick, hp)
	local self = {}
	setmetatable(self, Player)
	self.pid = pid
	self.nick = nick
	self.hp = hp
	return self
end

return Player