--[[
    Card5.lua
    卡牌1
    描述：卡牌1的定义
    编写：李昊
    修订：周星宇
    检查：张昊煜
]]


local Card5 = {
    x_ = nil,
    y_ = nil,
    id_ = nil,
    atk = nil,
    atkEnhance_ = nil,
    state_ = {},--buff数组
    cha_ = 5,
    chr_ = 200,
    fireCd_ = nil,
    player_ = nil,
    skillValue_ = nil,
    skillEnhance_ = nil,
    enhanceLevel_ = 0,
    time_ = nil,--攻击的时间
}

--[[
    new函数
    @param player
    @return card5
]]
function Card5:new(player,x,y,id)
    local card = {}
    self.__index = self
    setmetatable(card,self)
    card:init(player)
    return card
end

--[[
    init函数
    @param player
    @return none
]]
function Card5:init(player,x,y,id)
    self.x_ = x
    self.y_ = y
    self.id_ = id
    self.atk = 20
    self.atkEnhance_ = 10
    self.state_ = {}
    self.cha_ = 5
    self.chr_ = 200
    self.fireCd_ = 0.8
    self.player_ = player
    self.time_ = 0
end

--[[
    强化
    @param none
    @return none
]]
function Card5:enhance()
    self.enhanceLevel_= self.enhanceLevel_ + 1
    self.atk = self.atk + self.atkEnhance_
    self.fireCd_ = self.fireCd_*(self.enhanceLevel_ - 1)/self.enhanceLevel_
end

--[[
    attack攻击函数
]]
function Card5:attack()
end

--[[
    update
]]
function Card5:update(dt)
    self.time_ = self.time_ - dt
    if self.time_ <= 0 then
        self:attack()
        self.time_ = self.fireCd_
    end
end
