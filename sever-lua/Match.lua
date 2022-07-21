--[[--
    Matach.lua
    全局唯一
]]

Matach = {
}

Matach.__index = Matach

local SIGN = {
    MATCK =1,--匹配中
    GAME = 2,--游戏中
    OVER = 3,--游戏结束
}

Matach.init = function()
	print("初始化")
    local self = {}
    self.rooms ={}
	setmetatable(self, Matach)
	return self
end
--房间创建
Matach.roomCreate = function(self,roomid)
	local room ={
        player1=nil,
        player2=nil,
        sign=SIGN.MATCK,
        id =roomid,
    }
    return room
end
--玩家匹配入口
Matach.playerJoin = function(self, name)
    for i = 1, #self.rooms do
        if self.rooms[i].sign==SIGN.MATCK then
            return self:gameMatch(name)
        end
    end
    self.rooms[#self.rooms+1] = self:roomCreate(#self.rooms+1)
    print("一位战士进入了比赛")
    return self:gameMatch(name)
end

Matach.gameMatch = function(self, name)
	for i = 1, #self.rooms do
        if self.rooms[i].sign==SIGN.MATCK then
            if self.rooms[i].player1== nil then
                self.rooms[i].player1=name
                print(self.rooms[i].player1)
                return nil,nil
            end
            if self.rooms[i].player2== nil then
                self.rooms[i].player2=name
                self.rooms[i].sign=SIGN.GAME
                --开赛
                print(self.rooms[i].player1.."和"..self.rooms[i].player2.."进行比赛")
                return self.rooms[i].player1,self.rooms[i].player2,self.rooms[i].id
            end
        end
    end
end
Matach.cancelMatch = function(self, name)
	for i = 1, #self.rooms do
        if self.rooms[i].sign==SIGN.MATCK then
            if self.rooms[i].player1== name then
                self.rooms[i].player1=nil
            end
        end
    end
end
Matach.gameOver = function(self, number)
	self.rooms[number].player1=nil
    self.rooms[number].player2=nil
    self.rooms[number].sign=SIGN.OVER
end

Matach.setSid = function(self, sid)
	self.sid = sid
end

Matach.update = function(self)
	for i = 1, #self.rooms do
        if self.rooms[i].sign==SIGN.OVER then
            self.rooms[i].player1=nil
            self.rooms[i].player2=nil
            self.rooms[i].sign=SIGN.MATCK
        end
    end
end
return Matach