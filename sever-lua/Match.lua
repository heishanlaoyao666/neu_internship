--[[--
    Matach.lua
    ȫ��Ψһ
]]

Matach = {
}

Matach.__index = Matach

local SIGN = {
    MATCK =1,--ƥ����
    GAME = 2,--��Ϸ��
    OVER = 3,--��Ϸ����
}

Matach.init = function()
	print("��ʼ��")
    local self = {}
    self.rooms ={}
	setmetatable(self, Matach)
	return self
end
--���䴴��
Matach.roomCreate = function(self,roomid)
	local room ={
        player1=nil,
        player2=nil,
        sign=SIGN.MATCK,
        id =roomid,
    }
    return room
end
--���ƥ�����
Matach.playerJoin = function(self, name)
    for i = 1, #self.rooms do
        if self.rooms[i].sign==SIGN.MATCK then
            return self:gameMatch(name)
        end
    end
    self.rooms[#self.rooms+1] = self:roomCreate(#self.rooms+1)
    print("һλսʿ�����˱���")
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
                --����
                print(self.rooms[i].player1.."��"..self.rooms[i].player2.."���б���")
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