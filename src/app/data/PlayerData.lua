--[[
    PlayerData.lua
    玩家信息总文件
    描述：存放信息、名字、账号、积分等
    编写：李昊
    修订：周星宇
    检查：张昊煜
]]

local PlayerData = {}
local PlayerDef = require("src.app.def.PlayerDef")

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

local RequestManager = {}

local name_ = "none" -- 类型string ，名字 默认值
local id_ = "000000" -- 类型string ，账号 默认值
local integral_ = 0 -- 类型number ，积分 默认值
local headPortrait_ = PlayerDef.AVATAR.DEFAULT -- 类型string，头像 -- 默认值
local gold_ = 0 -- 类型number，金币 默认值
local diamond_ = 0 -- 类型number，钻石 默认值
local ladderAward_ = {} -- 类型table，天梯奖励领取情况

local cardGroup_ = {} -- 类型card，玩家拥有的卡组 默认值
local fightGroup_ = {} -- 类型card，玩家出战用的卡组 默认值

local currentGroupOne_ = {} -- 当前阵容1
local currentGroupTwo_ = {} -- 当前阵容2
local currentGroupThree_ = {} -- 当前阵容3

--[[--
    初始化

    @param none 初始化

    @return none
]]
function  PlayerData:init()
    self:initCard()
    self:initPlayerData()
end

--[[--
    设置名字

    @param string 需要设置的名字

    @return none
]]
function  PlayerData:setName(name)
     name_ = name
end

--[[--
    获取名字

    @param string 需要设置的名字

    @return name 名字
]]
function  PlayerData:getName()
    return name_
end

--[[--
    设置id

    @param string 需要设置的id

    @return none
]]
function  PlayerData:setId(id)
    id_ = id
end

--[[--
   获取id

   @param string 需要设置的id

   @return string id
]]
function  PlayerData:getId()
   return id_
end

--[[--
    设置积分

    @param number 需要设置的积分

    @return none
]]
function  PlayerData:setIntegral(integral)
    integral_ = integral
end

--[[--
   获取积分

   @param number 需要设置的积分

   @return number 积分
]]
function  PlayerData:getIntegral()
   return integral_
end

--[[--
    设置头像

    @param string 需要设置的头像

    @return none
]]
function  PlayerData:setHeadPortrait(headPortrait)
    headPortrait_ = headPortrait
end

--[[--
   获取头像

   @param string 需要设置的头像

   @return string 头像
]]
function  PlayerData:getHeadPortrait()
   return headPortrait_
end

--[[--
    设置金币数量

    @param string 需要设置的金币数量

    @return none
]]
function  PlayerData:setGold(gold)
    gold_ = gold
end

--[[--
   获取金币数量

   @param none

   @return number 金币数量
]]
function  PlayerData:getGold()
   return gold_
end

--[[--
    设置钻石数量

    @param string 需要设置的钻石数量

    @return none
]]
function  PlayerData:setDiamond(diamond)
    diamond_ = diamond
end

--[[--
   获取钻石数量

   @param none

   @return number 钻石数量
]]
function  PlayerData:getDiamond()
   return diamond_ 
end

--[[--
    设置天梯奖励领取情况

    @param number 待设置的索引

    @return none
]]
function  PlayerData:setIfGot(index)
    ladderAward_[index] = true
end

--[[--
   获取天梯奖励领取情况

   @param 待获取的索引

   @return boolean 是否已被领取
]]
function  PlayerData:getIfGot(index)
    return ladderAward_[index]
end

--[[--
   获取卡牌

   @param 卡牌的id  CardDef.CARD_Id

   @return card 卡牌
]]
function  PlayerData:getCard(id)
   return cardGroup_[id]
end

--[[--
   获取卡牌组

   @param 

   @return cards 卡牌组
]]
function  PlayerData:getAllCard()
    return cardGroup_
 end

--[[--
    设置战斗卡牌

    @param cardNameGroup  CardDef.CARD_Id的表 例如{"card","card","card","card","card"}

    @return none
]]
function  PlayerData:setFightCardGroup(cards)
    fightGroup_ = cards
end

--[[--
    获取所有已获得卡牌

    @param none

    @return cards 卡牌组
]]
function  PlayerData:getObtainedCardGroup()

    local obtainedCardGroup = {}

    for i=1, #cardGroup_ do
        if cardGroup_[i]:getNum() > 0 then -- 如果拥有碎片数量大于0
            table.insert(obtainedCardGroup, cardGroup_[i])
        end
    end

    return obtainedCardGroup
end

--[[--
    获取所有未获得卡牌

    @param none

    @return cards 卡牌组
]]
function  PlayerData:getNotObtainCardGroup()

    local notObtainCardGroup = {}

    for i=1, #cardGroup_ do
        if cardGroup_[i]:getNum() == 0 then -- 如果拥有碎片数量等于0
            table.insert(notObtainCardGroup, cardGroup_[i])
        end
    end

    return notObtainCardGroup
end

--[[--
   获取战斗卡牌信息

   @param n number 第几个

   @return card 
]]
function  PlayerData:getCardFromFightCardGroup(n)
    return fightGroup_[n]
end

--[[--
   获取战斗卡牌信息

   @param none

   @return cardGroup 
]]
function  PlayerData:getFightCardGroup()
    return fightGroup_
end

--[[--
   获取当前阵容1

   @param none

   @return cards
]]
function  PlayerData:getCurrentCardGroupOne()
    return currentGroupOne_
end

--[[--
   设置当前阵容1

   @param cards

   @return none
]]
function  PlayerData:setCurrentCardGroupOne(cards)
    currentGroupOne_ = cards
end

--[[--
   获取当前阵容2

   @param none

   @return cards
]]
function  PlayerData:getCurrentCardGroupTwo()
    return currentGroupTwo_
end

--[[--
   设置当前阵容2

   @param cards

   @return none
]]
function  PlayerData:setCurrentCardGroupTwo(cards)
    currentGroupTwo_ = cards
end

--[[--
   获取当前阵容3

   @param none

   @return cards
]]
function  PlayerData:getCurrentCardGroupThree()
    return currentGroupThree_
end

--[[--
   设置当前阵容3

   @param cards

   @return none
]]
function  PlayerData:setCurrentCardGroupThree(cards)
    currentGroupThree_ = cards
end

--[[
    init
    从服务器和本地文件读取卡片完善信息

    @param none

    @return none
]]
function PlayerData:initCard()
    print("began init card")
    for i = 1, 10 do
        local card = Card[i].new(0,0)
        card:setNum(50)--从服务器获取
        card:setLevel(9)--从服务器获取
        card:setIntensify(0)--从服务器获取
        cardGroup_[i] = card
    end

    for i = 11, 20 do
        local card = Card[i].new(0,0)
        card:setNum(0)--从服务器获取
        card:setLevel(1)--从服务器获取
        card:setIntensify(0)--从服务器获取
        cardGroup_[i] = card
    end

    for i = 1, 5 do
        local card = Card[i].new(0,0)
        card:setNum(50)--从服务器获取
        card:setLevel(9)--从服务器获取
        card:setIntensify(0)--从服务器获取
        fightGroup_[i] = card
    end

    for i = 1, 5 do
        local card = Card[i].new(0,0)
        card:setNum(50)--从服务器获取
        card:setLevel(9)--从服务器获取
        card:setIntensify(0)--从服务器获取
        currentGroupOne_[i] = card
    end

    for i = 6, 10 do
        local card = Card[i].new(0,0)
        card:setNum(50)--从服务器获取
        card:setLevel(9)--从服务器获取
        card:setIntensify(0)--从服务器获取
        currentGroupTwo_[i-5] = card
    end

    for i = 11, 15 do
        local card = Card[i].new(0,0)
        card:setNum(50)--从服务器获取
        card:setLevel(9)--从服务器获取
        card:setIntensify(0)--从服务器获取
        currentGroupThree_[i-10] = card
    end

    print("end init card")
end

--[[
    init
    从服务器和本地文件读取完善玩家信息

    @param none

    @return none
]]
function PlayerData:initPlayerData()
    name_ = "player"--从服务器获取
    id_ = "000001" --从服务器获取
    integral_ = 1000 --从服务器获取
    headPortrait_ = "???" --从服务器获取
    gold_ = 10 --从服务器获取
    diamond_ = 10 --从服务器获取
    integral_ = 325

    for i = 1, 10 do --初始化天梯奖励
        ladderAward_[i] = false
    end
end

return PlayerData