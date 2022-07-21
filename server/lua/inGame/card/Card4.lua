--[[
    Card4.lua
    卡牌4
    描述：卡牌4的定义
    编写：李昊
    修订：周星宇
    检查：张昊煜
]]

local Bullet = require("inGame.bullet.Bullet")

local Card4 = {
    x_ = nil,
    y_ = nil,
    x1_ = nil,
    y1_ = nil,
    id_ = nil,
    atk_ = nil,--攻击力
    atkEnhance_ = nil,--强化一级加的攻击力
    state_ = {},--buff数组
    cha_ = 5,--暴击率5%
    chr_ = 2,--暴击伤害200%
    fireCd_ = nil,
    player_ = nil,
    skillValue_ = nil,
    skillEnhance_ = nil,
    enhanceLevel_ = 0,-- 强化等级
    starLevel_ = 1,--合成等级
    time_ = nil,--攻击的时间
    size_ =  nil,
    pos_ = nil,
}

--[[
    new函数
    @param player
    @return card1
]]
function Card4:new(player,x,y,x1,y1,id,pos,starLevel)
    local card = {}
    self.__index = self
    setmetatable(card,self)
    card:init(player,x,y,x1,y1,id,pos,starLevel)
    return card
end

--[[
    init函数
    @param player
    @return none
]]
function Card4:init(player,x,y,x1,y1,id,pos,starLevel)
    self.size_ = 4
    self.x_ = x
    self.y_ = y
    self.x1_ = x1
    self.y1_ = y1
    self.id_ = id
    self.player_ = player
    local data = self.player_.cardGroup_[1][self.size_..""]
    self.atk_ = data.atk
    self.atkEnhance_ = data.atkDelta
    self.state_ = {}
    self.cha_ = 5
    self.chr_ = 2
    self.fireCd_ = data.fireCd
    self.player_ = player
    self.time_ = 0
    self.size_ = 4
    self.pos_ = pos
    self.enhanceLevel_ = self.player_.cardEnhanceLevel_[self.size_]
    self.starLevel_ = starLevel
    self.skillValue_ = data.skillOne
    self.skillValueEnhance_ = data.skillOneDelta
    self:setStarLevel()
    for i = 1,self.enhanceLevel_ -1 do
        self:enhance()
    end
end

--[[
    强化
    @param none
    @return none
]]
function Card4:enhance()
    self.enhanceLevel_= self.enhanceLevel_ + 1
    self.atk_ = self.atk_ + self.atkEnhance_
    self.skillValue_ = self.skillValue_ + self.skillValueEnhance_
end

function Card4:setStarLevel()
    self.fireCd_ = self.fireCd_/self.starLevel_
end

--[[
    getX
]]
function Card4:getX()
    return self.x_
end

function Card4:getY()
    return self.y_
end

function Card4:getId()
    return self.id_
end

function Card4:getSize()
    return self.size_
end

function Card4:getEnhanceLevel()
    return self.enhanceLevel_
end

--[[
    attack攻击函数
]]
function Card4:attack()

     -- 攻击场上血量最高的怪物，对BOSS造成双倍伤害
     if #self.player_.enemy_ == 0 then
        return
    end

    local enemy
    local isBoss = false

    if self.player_.boss_ == nil then
        -- 寻找场上血量最高的怪物
        local maxHp = -1
        local maxHpEnemy
        for index, value in ipairs(self.player_.enemy_) do
            if value.hp_ > maxHp then
                maxHp = value.hp_
                maxHpEnemy = value
            end
        end
        enemy = maxHpEnemy
    else
        enemy = self.player_.boss_
        isBoss = true
    end

    -- for k, v in pairs(self.player_.enemy_) do
    --     if enemy.time_ > self.player_.enemy_[k].time_ then
    --         enemy = self.player_.enemy_[k]
    --     end
    -- end

    local hurt = self.atk_

    local isCha = false
    if math.random(100) <= 5 then
        hurt = hurt*self.chr_
        isCha = true
    end

    -- 对BOSS造成双倍伤害
    if isBoss then
        hurt = hurt*2
    end

    local bullet = Bullet:new(enemy,self.x_,self.y_,self.x1_,self.y1_,hurt,isCha,self.player_:getBulletId(),self.player_,4,nil)
    table.insert(self.player_.bullet_,bullet)

end

--[[
    attack攻击函数
]]
function Card4:destroy()
    self.player_:removeCard(self)
    self.player_.cardPos_[self.pos_] = 0
end

--[[
    update
]]
function Card4:update(dt)
    
    self.time_ = self.time_ - dt
    if self.time_ <= 0 then
        self:attack()
        self.time_ = self.fireCd_*1000
    end

end

return Card4