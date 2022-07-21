--[[
    Card5.lua
    卡牌5
    描述：卡牌5的定义
    编写：李昊
    修订：周星宇
    检查：张昊煜
]]

local Bullet = require("inGame.bullet.Bullet")

local Card5 = {
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
function Card5:new(player,x,y,x1,y1,id,pos,starLevel)
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
function Card5:init(player,x,y,x1,y1,id,pos,starLevel)
    self.size_ = 5
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
    self.fireCdBase_ = self.fireCd_
    for i = 1,self.enhanceLevel_ -1 do
        self:enhance()
    end
    -- self.skillValue_ = 120
    -- self.skillValueEnhance_ = 40
    self.stage_ = 1
    self.stage1to2Time_ = 6
    self.stage2to3Time_ = 4
    self.stage3to1Time_ = 1
    self.stageTime_ = self.stage1to2Time_ * 1000
    -- 共有三个阶段，6秒后变身二阶段，攻速大幅度加强，
    -- 四秒后变身三阶段，攻速与二阶段相同，每次攻击必定暴击，三阶段维持一秒
end

--[[
    强化
    @param none
    @return none
]]
function Card5:enhance()
    self.enhanceLevel_= self.enhanceLevel_ + 1
    self.atk_ = self.atk_ + self.atkEnhance_
    self.skillValue_ = self.skillValue_ + self.skillValueEnhance_
end

function Card5:setStarLevel()
    self.fireCd_ = self.fireCd_/self.starLevel_
end

--[[
    getX
]]
function Card5:getX()
    return self.x_
end

function Card5:getY()
    return self.y_
end

function Card5:getId()
    return self.id_
end

function Card5:getSize()
    return self.size_
end

function Card5:getEnhanceLevel()
    return self.enhanceLevel_
end

--[[
    attack攻击函数
]]
function Card5:attack()

    if #self.player_.enemy_ == 0 then
        return
    end

    local enemy

    if self.player_.boss_ == nil then
        enemy = self.player_.enemy_[1]
    else
        enemy = self.player_.boss_
    end

    for k, v in pairs(self.player_.enemy_) do
        if enemy.time_ > self.player_.enemy_[k].time_ then
            enemy = self.player_.enemy_[k]
        end
    end

    local hurt = self.atk_

    local isCha = false
    -- 变身三阶段时，每次攻击必定暴击
    if self.stage_ == 3 then
        hurt = hurt*self.chr_
        isCha = true
    elseif math.random(100) <= 5 then
        hurt = hurt*self.chr_
        isCha = true
    end

    local bullet = Bullet:new(enemy,self.x_,self.y_,self.x1_,self.y1_,hurt,isCha,self.player_:getBulletId(),self.player_,5,nil)
    table.insert(self.player_.bullet_,bullet)

end

--[[
    attack攻击函数
]]
function Card5:destroy()
    self.player_:removeCard(self)
    self.player_.cardPos_[self.pos_] = 0
end

--[[
    update
]]
function Card5:update(dt)
    
    self.time_ = self.time_ - dt
    if self.time_ <= 0 then
        self:attack()
        self.time_ = self.fireCd_*1000
    end

    -- 共有三个阶段，6秒后变身二阶段，攻速大幅度加强，
    -- 四秒后变身三阶段，攻速与二阶段相同，每次攻击必定暴击，三阶段维持一秒
    self.stageTime_ = self.stageTime_ - dt
    if self.stageTime_ <= 0 then
        -- 时间到，进行变身
        -- print("TIME UP")
        -- print(self.stage_, self.stageTime_)
        if self.stage_ == 1 then
            self.stage_ = 2
            self.stageTime_ = self.stage2to3Time_ * 1000
            self.fireCdBase_ = self.fireCd_ -- 把当前的正常fireCd先存住
            self.fireCd_ = 0.1 -- 进入阶段二，攻速大幅度加强
        elseif self.stage_ == 2 then
            self.stage_ = 3
            self.stageTime_ = self.stage3to1Time_ * 1000
        elseif self.stage_ == 3 then
            self.stage_ = 1
            self.stageTime_ = self.stage1to2Time_ * 1000
            self.fireCd_ = self.fireCdBase_ -- 进入阶段一，一阶段攻速保持正常
        end
    end

end

return Card5