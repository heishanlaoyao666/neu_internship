--[[
    Card2.lua
    卡牌2
    描述：卡牌2的定义
    编写：李昊
    修订：周星宇
    检查：张昊煜
]]

local Bullet = require("inGame.bullet.Bullet")

local Card2 = {
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
function Card2:new(player,x,y,x1,y1,id,pos,starLevel)
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
function Card2:init(player,x,y,x1,y1,id,pos,starLevel)
    self.size_ = 2
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
    self.size_ = 2
    self.pos_ = pos
    self.enhanceLevel_ = self.player_.cardEnhanceLevel_[self.size_]
    self.starLevel_ = starLevel
    self:setStarLevel()
    self.skillValue_ = data.skillOne
    self.skillValueEnhance_ = data.skillOneDelta
    for i = 1,self.enhanceLevel_ -1 do
        self:enhance()
    end
end

--[[
    强化
    @param none
    @return none
]]
function Card2:enhance()
    self.enhanceLevel_= self.enhanceLevel_ + 1
    self.atk_ = self.atk_ + self.atkEnhance_
    self.skillValue_ = self.skillValue_ + self.skillValueEnhance_
end

function Card2:setStarLevel()
    self.fireCd_ = self.fireCd_/self.starLevel_
end

--[[
    getX
]]
function Card2:getX()
    return self.x_
end

function Card2:getY()
    return self.y_
end

function Card2:getId()
    return self.id_
end

function Card2:getSize()
    return self.size_
end

function Card2:getEnhanceLevel()
    return self.enhanceLevel_
end

--[[
    attack攻击函数
]]
function Card2:attack()

    print("ssssssssssssssss card2 attack")
    print(self.id_)
    print(self.starLevel_)
    if self.starLevel_ == 2 then 
    end
     -- 每次攻击会对星级数个怪物造成伤害
    -- 一星打一个，两星打两个.......
    -- 对最前方怪物造成攻击力点伤害，对其余目标造成额外伤害
    if #self.player_.enemy_ == 0 then
        return
    end

    -- 这部分保持不动，因为无论如何这个塔都要攻击最前方的敌人
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
    if math.random(100) <= 5 then
        hurt = hurt*self.chr_
        isCha = true
    end
    
    local bullet = Bullet:new(enemy,self.x_,self.y_,self.x1_,self.y1_,hurt,isCha,self.player_:getBulletId(),self.player_,2,nil)
    table.insert(self.player_.bullet_,bullet)

    -- 其余目标
    print("card 2 star", self.starLevel_)
    if self.starLevel_ == 1 then
        return
    end

    print("card 2 attack others")
    local enemyArr = {}
    local i = 0



    for k, v in pairs(self.player_.enemy_) do
        local canCompareArr = {} -- canCompareArr =  self.player_.enemy_ - emenyArr - enemy
        -- 这部分在初始化canCompareArr
        for k, v in pairs(self.player_.enemy_) do
            local flag = false
            for j=1, #enemyArr do
                if self.player_.enemy_[k] == enemyArr[j] then
                    flag = true
                    break
                end
            end
            if flag == false and self.player_.enemy_[k] ~= enemy then
                -- 说明这个self.player_.enemy_[k]可以被比较
                -- 加入到canCompareArr中
                table.insert(canCompareArr, self.player_.enemy_[k])
            end
        end
        -- 在canCompareArr中找出距离最近的，加入到enemyArr中
        local enemyNearest = canCompareArr[1]
        for j=1,#canCompareArr do
            if canCompareArr[j].time_ < enemyNearest.time_ then
                enemyNearest = canCompareArr[j]
            end
        end
        table.insert(enemyArr, enemyNearest)
        i = i + 1 -- 要额外攻击的敌人数量+1
        -- 如果要额外攻击的敌人数量 >= 星级数 - 1，则跳出循环
        if i >= self.starLevel_-1 then
            break
        end
    end
   
    -- Utils.print_dump(self.player_.enemy_)

    -- if self.player_.boss_ == nil then
    --     for i=1, self.starLevel_-1 do
    --         -- table.insert(enemyArr, self.player_.enemy_[i])
    --         local enemy1  = {time_ = 100}
    --         for k, v in pairs(self.player_.enemy_) do
    --             if enemy.time_ > self.player_.enemy_[k].time_ then
    --                 table.insert(enemyArr, self.player_.enemy_[k])
    --             end
    --         end
    --     end
    -- else
    --     for i=1, self.starLevel_-1 do
    --         local enemy1 = self.player_.enemy_[1]
    --         for k, v in pairs(self.player_.enemy_) do
    --             if enemy1.time_ > self.player_.enemy_[k].time_ then
    --                 for k, v in pairs(enemyArr) do
    --                     if self.player_.enemy_[k] == v then
    --                         if enemyArr == v  then
    --                             enemy1 = self.player_.enemy_[k]
    --                             table.insert( enemyArr, enemy1)
    --                         end
    --                     end
    --                 end
    --             end
    --         end

    --     end
    -- end

    -- 对其余目标造成额外伤害
    local hurt1 = self.skillValue_

    for index, e in ipairs(enemyArr) do
        local isCha1 = false
        if math.random(100) <= 5 then
            hurt1 = hurt1*self.chr_
            isCha1 = true
        end
        -- print(e)
        -- print(enemy)
        local bullet1 = Bullet:new(e,self.x_,self.y_,self.x1_,self.y1_,hurt1,isCha1,self.player_:getBulletId(),self.player_,1,nil)
        table.insert(self.player_.bullet_,bullet1)
    end

    print("ssssssssssssssss card2 attack finish")

end

--[[
    attack攻击函数
]]
function Card2:destroy()
    self.player_:removeCard(self)
    self.player_.cardPos_[self.pos_] = 0
end

--[[
    update
]]
function Card2:update(dt)
    
    self.time_ = self.time_ - dt
    if self.time_ <= 0 then
        self:attack()
        self.time_ = self.fireCd_*1000
    end

end

return Card2