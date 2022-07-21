--[[--
    player.lua
]]

Player = {
	pid = 0,
	loginName = "",
	passWord = "",
	matching=0,
	nick="",
	financeData={
		gold=0,
		diamond=0,
	},
	towerData={
		tower={},--tower[塔的种类]={塔的数量，塔的等级}
	},
	achieveData={
		trophyAmount=0,
		rankObjectAmount={},--22个天梯物品获取状态信息（1未达到奖杯数要求，2达到奖杯数要求并未开启过，3开启过）
		rankObject={},--rankObject[天梯物品的种类]={状态信息}

	},
	lineupData={
		lineup={},--这是当前选择的阵容，就用1，2，3分别表示,lineup[编号]={塔的种类【1~5,6~10,11~15分别为三个阵容，】}
	},
	otherData={
		headPortrait="",
	},
	sid = 0,
}


Player.__index = Player

Player.new = function()
	local self = {}
	setmetatable(self, Player)
	self.nick=""
	self.pid = 0
	self.passWord = ""
	self.loginName = ""
	self.matching=0
	self.financeData={
		gold=0,
		diamond=0,
	}
	self.towerData={
		tower={},--tower[塔的种类]={塔的数量，塔的等级}
	}
	self.achieveData={
		trophyAmount=0,
		rankObjectAmount=0,--22个天梯物品获取状态信息（1未达到奖杯数要求，2达到奖杯数要求并未开启过，3开启过）
		rankObject={},--rankObject[天梯物品的种类]={状态信息}
	}
	self.lineupData={
		lineup={},--这是当前选择的阵容，就用1，2，3分别表示,lineup[编号]={塔的种类【1~5,6~10,11~15分别为三个阵容，】}
	}
	self.otherData={
		headPortrait="",
	}
	return self
end

Player.setPid = function(self, pid)
	self.pid = pid
end

Player.setNick = function(self, nick)
	self.nick = nick
end
Player.setPassWord = function(self, passWord)
	self.passWord = passWord
end

Player.setLoginName = function(self, loginName)
	self.loginName = loginName
end

Player.setMatching = function(self, matching)
	self.matching = matching
end

Player.setSid = function(self, sid)
	self.sid = sid
end

Player.setFinanceData=function(self,financeData)
	self.financeData=financeData
end

Player.setTowerData=function(self,towerData)
	self.towerData=towerData
end

Player.setAchieveData=function(self,achieveData)
	self.achieveData=achieveData
end

Player.setLineupData=function(self,lineupData)
	self.lineupData=lineupData
end

Player.setotherData=function(self,otherData)
	self.otherData=otherData
end










return Player



