--[[
    Player.lua
    玩家信息类
    描述：用于信息通信，把服务器里面的东西传到客户端
    编写：李昊
]]

local Card1 = require("lua.inGame.card.Card1")
local Card2 = require("lua.inGame.card.Card2")
local Card3 = require("lua.inGame.card.Card3")
local Card4 = require("lua.inGame.card.Card4")
local Card5 = require("lua.inGame.card.Card5")

local Utils = require("lua.Utils")

local Card = {
    Card1,Card2,Card3,Card4,Card5
}

local Enemy = require("lua.inGame.Enemy")
local EnemyDef = require("lua.inGame.def.EnemyDef")
local CardDef = require("lua.inGame.def.CardDef")
local Boss = require("lua.inGame.boss.boss")

Player = {
    gameData_ = nil,--玩家对应的gameData

    hp_ =  nil, --血量值 number 
    sp_ =  nil, --sp值 number 
    id_ = nil, -- id number
    name_ = nil, --名字 string
    level_ = nil,
    createSp_ = nil,
    EnhanceSp_ = nil,

    enemyTime_ = 1, --生成敌人的间隔时间

    bullet_ = {}, --子弹实体
    enemy_ = {}, --敌人实体
    card_ = {}, --生成的防御塔实体

    createEnemyFrequency_ = nil, --生成敌人的时间间隔
    createEnemy_ = {}, --待生成的敌人
    deleteEnemy_ = {},--待删除敌人
    enemyId_ = 0,

    cardGroup_ = {}, --出战组
    deleteCard_ = {},
    cardId_ = nil,
    cardPos_ = {},
    cardEnhanceLevel_ = {},

    bulletGroup_ = {},
    bulletId_ = nil,
    deleteBullet_ = {},

    boss_ = nil,
    bossId_ = 0,
    deleteBoss_ = false,
}

--[[
    new函数
    @param none
    @return none
]]
function Player:new(gameData,id,data)
    local player = {}
    self.__index = self
    setmetatable(player,self)
    player:init(gameData,id,data)
    return player
end

--[[
    注册信息函数

    @param none

    @return none
]]
function Player:init(gameData,id,data)

    self.gameData_ = gameData
    self.name_ = data["nick"]
    self.id_ = id
    self.level_ = 1
    self.hp_ = 3 --血量值 number 
    self.sp_ = 10000 --sp值 number 
    self.createSp_ = CardDef.CREATE_CARD_SP
    self.enhanceSp_ = {CardDef.CARD_ENHANCE[1],CardDef.CARD_ENHANCE[1],
    CardDef.CARD_ENHANCE[1],CardDef.CARD_ENHANCE[1],CardDef.CARD_ENHANCE[1]}

    self.enemyTime_ = 0 --生成敌人的时间

    self.bullet_ = {} --子弹实体
    self.enemy_ = {} --敌人实体
    self.card_ = {} --生成的防御塔实体

    self.createEnemyFrequency_ = EnemyDef.FREQUENCY_TIME --生成敌人的时间间隔
    self.enemyId_ = 0
    self.createEnemy_ = {} --待生成的敌人
    self.deleteEnemy_ = {}

    self.cardId_ = 0
    self.deleteCard_ = {}
    self.cardGroup_ = {data["cards"]}
    self.cardPos_ = {}
    for i = 1,15 do
        self.cardPos_[i] = 0
    end
    self.cardEnhanceLevel_ = {}
    for i = 1,5 do
        self.cardEnhanceLevel_[i] = 1
    end

    self.bulletId_ = 0
    self.deleteBullet_ = {}

    self.boss_ = nil
    self.bossId_ = 0
    self.deleteBoss_ = false

end

function Player:resetPlayer(enemy)
    self.gameData_:resetPlayer(self.id_,enemy)
end

--[[
    怪物攻击函数
    @param num 伤害值
    @return none 
]]
function Player:attack(attack)
    self.hp_ = self.hp_ - attack
end

function Player:getBulletId()
    self.bulletId_ = self.bulletId_ +1
    return self.bulletId_ 
end

--[[
    创建敌人实体
    @param hp,sp,num
    @return 数据
]]
function Player:createEnemy(hp,sp,num)
    table.insert(self.createEnemy_,{hp = hp,sp = sp,num = num})
end

--[[
    随机选取card位置
]]
function Player:randomCardPos()

    local pos = math.random(15)
    if self.cardPos_[pos] == 1 then
        return self:randomCardPos()
    else
        return pos
    end
end

function Player:enhanceCard(msg)
    local cardEnhanceLevel = self.cardEnhanceLevel_[msg["size"]]
    cardEnhanceLevel = cardEnhanceLevel + 1
    if CardDef.CARD_ENHANCE[cardEnhanceLevel] <= self.sp_ then
    else
        self.cardEnhanceLevel_[msg["size"]] = self.cardEnhanceLevel_[msg["size"]] + 1
        for k , v in pairs(self.card_) do
            if v.size_ == msg["size"] then
                v:enhance()
            end
        end
        self.sp_ = self.sp_ - CardDef.CARD_ENHANCE[cardEnhanceLevel]
    end
end

function Player:compoundCard(msg)

    local card1,card2
    for k,v in pairs(self.card_) do
        if msg["pos2"].x == v.x_ and msg["pos2"].y == v.y_ then
            card2 = v
        end
    end
    if card2 == nil then
        return
    end

    for i = 1,15 do
        if math.ceil(CardDef.POS_DOWN[i].X - msg["pos1"][1]) < 40 
        and math.ceil(CardDef.POS_DOWN[i].Y - msg["pos1"][2]) < 40 then
            if self.cardPos_[i] == 1 then
                for k,v in pairs(self.card_) do
                    if v.pos_ == i then
                        card1 = v
                    end
                end
            end
        end
    end

    if card1 == nil then
        return
    end

    if card1 == card2 then
        return
    end

    if card1.size_ == card2.size_ and card1.starLevel_ == card2.starLevel_ then

        local size = math.random(5)

        local isEmpty = false
        for i = 1,15 do 
            if self.cardPos_[i] == 0 then
                isEmpty = true
            end
        end
        if isEmpty then
        else
            return
        end

        local pos = self:randomCardPos()
        local x,y,x1,y1
        x = CardDef.POS_DOWN[pos].X
        y = CardDef.POS_DOWN[pos].Y
        x1 = CardDef.POS_UP[pos].X
        y1 = CardDef.POS_UP[pos].Y
        self.cardId_ = self.cardId_ + 1
        local card = Card1:new(self,x,y,x1,y1,self.cardId_,pos,card1.starLevel_ + 1)
        self.cardPos_[pos] = 1
        self.card_[card.id_..""] = card
        card1:destroy()
        card2:destroy()
    end

end

--[[
    创建boss
]]
function Player:createBoss(size)
    local hp = 0
    for k,v in pairs(self.enemy_) do
        hp = v:getHp() + hp
    end
    self.enemy_ = {}
    hp = hp*0.5 + 50000*self.gameData_:getBossFrequency()
    self.bossId_ = self.bossId_ + 1
    local id = self.bossId_ 
    local sp = self.gameData_:getBossFrequency()*100
    self.boss_ = Boss:new(self,id,hp,sp,size)
end

function Player:removeBoss(size)
    self.deleteBoss_ = true
end

--[[
    创建card实体
    @param hp,sp,num
    @return 数据
]]
function Player:createCard()

    if self.sp_ < self.createSp_ then
        return
    end
    local size = math.random(5)
    local isEmpty = false

    for i = 1,15 do 
        if self.cardPos_[i] == 0 then
            isEmpty = true
        end
    end

    if isEmpty then
    else
        return
    end

    local pos = self:randomCardPos()

    local x,y,x1,y1
    x = CardDef.POS_DOWN[pos].X
    y = CardDef.POS_DOWN[pos].Y
    x1 = CardDef.POS_UP[pos].X
    y1 = CardDef.POS_UP[pos].Y

    self.cardId_ = self.cardId_ + 1

    local card = Card1:new(self,x,y,x1,y1,self.cardId_,pos,1)

    self.cardPos_[pos] = 1

    self.card_[card.id_..""] = card

    self.sp_ = self.sp_ - self.createSp_

    self.createSp_ = self.createSp_ + CardDef.CREATE_CARD_SP

end

--[[
    删除card实例
]]
function Player:removeCard(card)
    for k,v in pairs(self.card_) do
        if self.card_[k] == card then
                table.insert(self.deleteCard_, k)
            return
        end
    end
end

--[[
    删除子弹
]]
function Player:removeBullet(bullet)
    for k,v in pairs(self.bullet_ ) do
        if self.bullet_[k] == bullet then
                table.insert(self.deleteBullet_, k)
            return
        end
    end
end

--[[
    删除敌人实体

    @param dt  data 

    @return 数据

]]
function Player:removeEnemy(enemy)
    for k,v in pairs(self.enemy_ ) do
        if self.enemy_[k] == enemy then
                table.insert(self.deleteEnemy_, k)
            return
        end
    end
end

--[[
    帧刷新，游戏数据处理
    @param dt  data 
    @return 数据
]]
function Player:update(dt)
    
    self.enemyTime_ = self.enemyTime_ - dt
    local requireDelete = {}

    if self.enemyTime_ <= 0 then
        --创建敌人
        for i,v in pairs (self.createEnemy_) do
            self.enemyId_ = self.enemyId_ + 1
            local enemy = Enemy:new(self, self.enemyId_, self.createEnemy_[i].hp, self.createEnemy_[i].sp)
            self.createEnemy_[i].num = self.createEnemy_[i].num -1
            table.insert(self.enemy_,enemy)
            if self.createEnemy_[i].num == 0 then
                self.createEnemy_[i] = nil
            end
        end

        for i = 1,#requireDelete do
            table.remove(self.createEnemy_,i)
        end

        self.enemyTime_ = EnemyDef.FREQUENCY_TIME

    end

    --敌人帧循环
    for k, v in pairs(self.enemy_) do
        self.enemy_[k]:update(dt)
    end

    --删除敌人队列
    for k, v in pairs(self.deleteEnemy_) do
        table.remove(self.enemy_,v)
        table.remove(self.deleteEnemy_,k)
    end

    --运行card
    for k, v in pairs(self.card_) do
        self.card_[k]:update(dt)
    end

    --删除card
    for k, v in pairs(self.deleteCard_) do
        -- print("del", k)
        -- self.card_[v] = nil
        if self.card_[v] ~= nil then
            self.card_[v] = nil
        end
        table.remove(self.deleteCard_,k)

    end

    --运行子弹
    for k, v in pairs(self.bullet_) do
        v:update(dt)
    end

    for k, v in pairs(self.deleteBullet_) do
        table.remove(self.bullet_,v)
        if self.card_[v] ~= nil then
            self.card_[v] = nil
        end
        table.remove(self.deleteBullet_,k)
    end

    if self.boss_ == nil then
    else
        self.boss_:update(dt)
    end

    if self.deleteBoss_ then
        self.boss_ = nil
        self.deleteBoss_ = false
    end

    --返回信息table
    local info = {}
    local enemy = {}
    local card = {}
    local bullet = {}
    local boss = nil
    local enhance = {}

    local enemy1 = {}
    local card1 = {}
    local bullet1 = {}
    local boss1 = nil

    for k, v in pairs(self.cardEnhanceLevel_) do
        enhance[k] = {
            sp = CardDef.CARD_ENHANCE[v+1]
        }
    end
    

    info[1] = {sp = self.sp_,hp = self.hp_,createSp = self.createSp_,
        enemy = enemy, card = card, bullet = bullet, boss = boss,enhance = enhance}
    info[2] = {sp = self.sp_,hp = self.hp_,createSp = self.createSp_,
        enemy = enemy1, card = card1, bullet = bullet1, boss = boss1}

    --返回敌人信息
    for k, v in pairs(self.enemy_) do
        info[1].enemy[k] = {
            id = self.enemy_[k]:getId(), x = self.enemy_[k]:getX(), 
            y = self.enemy_[k]:getY(), hp = self.enemy_[k]:getHp(),
            state = self.enemy_[k]:getState(),
        }
        info[2].enemy[k] = {
            id = self.enemy_[k]:getId(), x = self.enemy_[k].x1_, 
            y = self.enemy_[k].y1_, hp = self.enemy_[k]:getHp(),
            state = self.enemy_[k]:getState(),
        }
    end

    --返回card信息
    for k, v in pairs(self.card_) do
        info[1].card[k] = {
            x = self.card_[k]:getX(),  y = self.card_[k]:getY(),
            id = self.card_[k]:getId(), size = self.card_[k]:getSize(),
            enhanceLevel = self.card_[k]:getEnhanceLevel(),starLevel = self.card_[k].starLevel_ 
        }
        info[2].card[k] = {
            x = self.card_[k].x1_,  y = self.card_[k].y1_,
            id = self.card_[k]:getId(), size = self.card_[k]:getSize(),
            enhanceLevel = self.card_[k]:getEnhanceLevel(),starLevel = self.card_[k].starLevel_ 
        }
    end

    --返回bullet信息
    for k, v in pairs(self.bullet_) do
        info[1].bullet[k] = {
            x = self.bullet_[k]:getX(),  y = self.bullet_[k]:getY(),
            id = self.bullet_[k]:getId(),size = self.bullet_[k]:getSize(),
        }
        info[2].bullet[k] = {
            x = self.bullet_[k].x1_,  y = self.bullet_[k].y1_,
            id = self.bullet_[k]:getId(),size = self.bullet_[k]:getSize(),
        }
    end



    if self.boss_ == nil then
    else
        info[1].boss = {
            x = self.boss_:getX(), y = self.boss_:getY(),
            hp = self.boss_:getHp(), id = self.boss_:getId(),
            size = self.boss_:getSize(),state = self.boss_:getState(),
        }
        info[2].boss = {
            x = self.boss_.x1_, y = self.boss_.y1_,
            hp = self.boss_:getHp(), id = self.boss_:getId(),
            size = self.boss_:getSize(),state = self.boss_:getState(),
        }
    end

    return info

end

return Player