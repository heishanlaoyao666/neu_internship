--[[--
    player.lua
    玩家对象定义
]]

Player = {
	pid = 0,
	nick = "",
	loginName = "",
	sid = 0,
}

Player.__index = Player

Player.new = function()
	local self = {}
	setmetatable(self, Player)
	self.pid = 0
	self.nick = ""
	self.loginName = ""
	return self
end

Player.setPid = function(self, pid)
	self.pid = pid
end

Player.setNick = function(self, nick)
	self.nick = nick
end

Player.setLoginName = function(self, loginName)
	self.loginName = loginName
end

Player.setSid = function(self, sid)
	self.sid = sid
end

return Player