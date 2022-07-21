--[[
    GamePlayer.lua
    玩家信息类 用户端
    描述：用于信息通信，每一帧接受服务器信息，然后更改里面信息，再由本地渲染
    编写：李昊
]]

local GamePlayer = class("GamePlayerData")
local Enemy = require("src.app.data.enemy.Enemy")

local Card1 = require("src.app.data.card.Card1") 
local Card2 = require("src.app.data.card.Card2") 
local Card3 = require("src.app.data.card.Card3") 
local Card4 = require("src.app.data.card.Card4") 
local Card5 = require("src.app.data.card.Card5") 
local Card6 = require("src.app.data.card.Card6") 
local Card7 = require("src.app.data.card.Card7") 
local Card8 = require("src.app.data.card.Card8") 
local Card9 = require("src.app.data.card.Card9") 
local Card10 = require("src.app.data.card.Card10") 
local Card11 = require("src.app.data.card.Card11") 
local Card12 = require("src.app.data.card.Card12")
local Card13 = require("src.app.data.card.Card13")
local Card14 = require("src.app.data.card.Card14")
local Card15 = require("src.app.data.card.Card15")
local Card16 = require("src.app.data.card.Card16")
local Card17 = require("src.app.data.card.Card17")
local Card18 = require("src.app.data.card.Card18")
local Card19 = require("src.app.data.card.Card19")
local Card20 = require("src.app.data.card.Card20")

local Card = {
    Card1,Card2,Card3,Card4,Card5,
    Card6,Card7,Card8,Card9,Card10,
    Card11,Card12,Card13,Card14,Card15,
    Card16,Card17,Card18,Card19,Card20,
}

local Bullet = require("src.app.data.Bullet")

local Boss = require("src.app.data.Boss")

--[[
    构造函数

    @param none

    @return none
]]
function GamePlayer:ctor(id)
    self.id_ = id
    self.hp_ = 0 -- number 
    self.sp_ = 0 --number 
    self.createSp_ = 0 --number

    self.bullet_ = {} --子弹实体
    self.enemy_ = {} --敌人实体
    self.card_ = {} --生成的防御塔实体
    self.boss_ = nil
end

function GamePlayer:getHp()
    return self.hp_
end

function GamePlayer:getSp()
    return self.sp_
end

function GamePlayer:getCreateSp()
    return self.createSp_
end

--[[
    帧刷新
    @param dt data 数据处理
    @return none
    数据设计

    暂时 data = {
        hp = num,
        sp = num,
        enemy = {{x,y,hp,id}},
    } 
]]
function GamePlayer:update(data)

    print("----- player update -----")

    self.hp_ = data.hp
    self.sp_ = data.sp
    self.createSp_ = data.createSp


    --敌人处理
    for i = 1,#data.enemy do

        if  self.enemy_[data.enemy[i].id] == nil then
            print("----- create enemy -----")
            self.enemy_[data.enemy[i].id] = Enemy.new(data.enemy[i].x,data.enemy[i].y,data.enemy[i].id,data.enemy[i].hp)
        else
            self.enemy_[data.enemy[i].id]:update(data.enemy[i])
        end
    end

    for  i, v in pairs(self.enemy_) do
        local isDestroy = true
        for j = 1,#data.enemy do
            if self.enemy_[i]:getId() == data.enemy[j].id then
                isDestroy = false
            end
        end
        if isDestroy then
            self.enemy_[i]:destroy()
            self.enemy_[i] = nil
            break
        end
    end

    --card处理
    for i,v in pairs (data.card) do
        if  self.card_[data.card[i].id] == nil then
            self.card_[data.card[i].id] = Card[data.card[i].size].
            new(data.card[i].x,data.card[i].y,data.card[i].id,
            data.card[i].enhanceLevel,data.card[i].starLevel)
            self.card_[data.card[i].id]:setNum(1)
        else
            self.card_[data.card[i].id]:update(data.card[i])
        end
    end

    for i, v in pairs(self.card_) do
        local isDestroy = true
        for j , v in pairs(data.card) do
            if self.card_[i]:getTh() == data.card[j].id then
                isDestroy = false
                break
            end
        end
        if isDestroy then
            self.card_[i]:destroy()
            self.card_[i] = nil
            break
        end
    end

     --bullet处理
     for i = 1,#data.bullet do
        if  self.bullet_[data.bullet[i].id] == nil then
            self.bullet_[data.bullet[i].id] = 
                Bullet.new(data.bullet[i].x,data.bullet[i].y,data.bullet[i].size,data.bullet[i].id)
        else
            self.bullet_[data.bullet[i].id]:update(data.bullet[i])
        end
    end

    for i, v in pairs(self.bullet_) do
        local isDestroy = true
        for j = 1,#data.bullet do
            if self.bullet_[i]:getId() == data.bullet[j].id then
                isDestroy = false
                break
            end
        end
        if isDestroy then
            self.bullet_[i]:destroy()
            self.bullet_[i] = nil
            break
        end
    end

    --boss处理
    if data.boss == nil then 
        if self.boss_ == nil then
        else
            self.boss_:destroy()
            self.boss_ = nil
        end
    else
        if self.boss_ == nil then
            self.boss_ = Boss.new(data.boss.x,data.boss.y,data.boss.id,data.boss.hp)
        else
            self.boss_:update(data.boss)
        end
    end
    
end

return GamePlayer