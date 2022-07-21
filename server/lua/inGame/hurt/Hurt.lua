

local id = 0

local Hurt = {
    num_ = nil,
    color_ = nil,
    x_ = nil,
    y_ = nil,
    x1_ = nil,
    y1_ = nil,
    speed_ = 25,
    time_ = nil,
    gameData_ = nil,
    id_ = 0,
    player_ = nil,
}

function Hurt:new(player,num,x,y,x1,y1,color,gameData)
    local hurt = {}
    self.__index = self
    setmetatable(hurt,self)
    hurt:init(player,num,x,y,x1,y1,color,gameData)
    return hurt
end

function Hurt:init(player,num,x,y,x1,y1,color,gameData)
    self.x_ = x
    self.y_ = y
    self.x1_ = x1
    self.y1_ = y1
    self.num_ = num
    self.color_ = color
    self.time_ = 500
    self.gameData_ = gameData
    id = id + 1
    self.id_ = id 
    self.player_ = player
end

function Hurt:destroy()
    self.gameData_:removeHurt(self)
end

function Hurt:update(dt)
    self.time_ = self.time_ - dt
    if self.time_ <= 0 then
        self:destroy()
        return
    end
    self.x_ = self.x_ - self.speed_*dt/1000
    self.y_ = self.y_ + self.speed_*dt*1.5/1000

    self.x1_ = self.x1_ - self.speed_*dt/1000
    self.y1_ = self.y1_ + self.speed_*dt*1.5/1000
end

return Hurt