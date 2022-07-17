--[[
    Bullet.lua
    子弹
    描述：子弹的定义
    编写：李昊
]]

local Hurt = require("inGame.hurt.Hurt")

local Bullet =  {
    x_ = nil,
    y_ = nil,
    x1_ = nil,
    y1_ = nil,
    enemy_ = nil,
    hurt_ = nil,
    isCha_ = nil,--是否暴击
    speed_ =nil,
    id_ = nil,
    player_ = nil,
    size_ = nil,
    state_ = nil,
}

--[[
    new函数
    @param enemy,x,y,hurt,isCha
    @return Bullet
]]
function Bullet:new(enemy,x,y,x1,y1,hurt,isCha,id,player,size,state)
    local bullet = {}
    self.__index = self
    setmetatable(bullet,self)
    bullet:init(enemy,x,y,x1,y1,hurt,isCha,id,player,size,state)
    return bullet
end

--[[
    init函数
    @param enemy,x,y,hurt,isCha
    @return none
]]
function Bullet:init(enemy,x,y,x1,y1,hurt,isCha,id,player,size,state)
    self.x_ = x
    self.y_ = y
    self.x1_ = x1
    self.y1_ = y1
    self.id_ = id
    self.enemy_ = enemy
    self.hurt_ = hurt
    self.isCha_ = isCha
    self.speed_ = 400 --每秒100像素
    self.player_ =  player
    self.size_ = size
    self.state_ = state
end

function Bullet:move(dt)

    if self.enemy_ == nil then
        self:destroy()
        return
    end

    local x = self.enemy_:getX() - self.x_
    local y = self.enemy_:getY() - self.y_
    if  x < 10 and x > -10 and y < 10 and y > -10 then 
        self:attack()
    end
    local z =  math.sqrt(x*x+y*y)
    self.x_ = self.x_ + x/z*self.speed_*dt/1000
    self.y_ = self.y_ + y/z*self.speed_*dt/1000

    local x1 = self.enemy_.x1_ - self.x1_
    local y1 = self.enemy_.y1_ - self.y1_
    local z1 =  math.sqrt(x1*x1+y1*y1)
    self.x1_ = self.x1_ + x1/z1*self.speed_*dt/1000
    self.y1_ = self.y1_ + y1/z1*self.speed_*dt/1000

end

function Bullet:getX()
    return self.x_
end

function Bullet:getY()
    return self.y_
end

function Bullet:getId()
    return self.id_
end

function Bullet:getSize()
    return self.size_
end

function Bullet:attack()

    if self.enemy_ == nil or self.enemy_.hp_ < 0 then
    else
        local color
        if self.isCha_ then
            color = 1
        else
            color = 2
        end
        local hurt = Hurt:new(self.player_,self.hurt_, self.x_, self.y_,self.x1_, self.y1_, color,self.player_.gameData_)
        table.insert(self.player_.gameData_.hurt_,hurt)

        self.enemy_.hp_ = self.enemy_.hp_ - self.hurt_
        self.state_.enemy_ = self.enemy_ 
        table.insert(self.enemy_.state_,self.state_)
    end
    self:destroy()
end

function Bullet:destroy()
    self.player_:removeBullet(self)
end

function Bullet:update(dt)
    self:move(dt)
end

return Bullet