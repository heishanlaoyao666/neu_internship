--[[
    PlayerData.lua
    玩家信息总文件
    描述：存放信息、名字、账号、积分等
    编写：李昊
    修订：周星宇
    检查：张昊煜
]]

local PlayerData = {}
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

local name_ = "none" -- 类型string ，名字 默认值
local password_ = "none" -- 类型string，密码，默认值
local id_ = "000000" -- 类型string ，账号 默认值
local integral_ = 0 -- 类型number ，积分 默认值
local headPortrait_ = "image/lobby/top/default_avatar.png" -- 类型string，头像 -- 默认值
local gold_ = 0 -- 类型number，金币 默认值
local diamond_ = 0 -- 类型number，钻石 默认值
local ladderAward_ = {} -- 类型table，天梯奖励领取情况

local cardGroup_ = {} -- 类型card，所有卡牌 默认值
local fightGroupIndex_ = 1 -- 类型number，玩家出战用的卡组索引 默认值
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

    @param none

    @return string 名字
]]
function  PlayerData:getName()
    return name_
end

--[[--
    设置密码

    @param string 需要设置的密码

    @return none
]]
function  PlayerData:setPassword(password)
    password_ = password
end

--[[--
    获取密码

    @param none

    @return string 密码
]]
function  PlayerData:getPassword()
    return password_
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

   @param none

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

   @param none

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

   @param none

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
   获取天梯奖励表

   @param none

   @return number
]]
function  PlayerData:getLadderAward()
    return ladderAward_
end

--[[--
    设置天梯奖励领取情况

    @param index number 待设置的索引
    @param ifGot boolean 是否已经获得

    @return none
]]
function  PlayerData:setIfGot(index, ifGot)
    ladderAward_[index] = ifGot
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
   通过卡牌ID获取卡牌

   @param 卡牌的id

   @return card 卡牌
]]
function  PlayerData:getCardById(id)
    for i = 1, #cardGroup_ do
        if cardGroup_[i]:getId() == id then
            return cardGroup_[i]
        end
    end
   return nil
end

--[[--
   通过卡牌稀有度获取卡牌

   @param 卡牌的稀有度

   @return cards 卡牌组
]]
function  PlayerData:getCardsByRarity(rarity)
    local temp = {}
    for i = 1, #cardGroup_ do
        if cardGroup_[i]:getRarity() == rarity then
            table.insert(temp, cardGroup_[i])
        end
    end
    return temp
end

--[[--
   获取所有卡牌

   @param 

   @return cards 所有卡牌
]]
function  PlayerData:getAllCards()
    return cardGroup_
 end

--[[--
    获取卡组

    @param none

    @return cards 卡牌组
]]
function  PlayerData:getCardGroup()
    return cardGroup_
end

--[[--
    获取所有已获得卡牌

    @param none

    @return cards 卡牌组
]]
function  PlayerData:getObtainedCardGroup()

    local obtainedCardGroup = {}

    for i=1, #cardGroup_ do
        if cardGroup_[i]:ifCardObtained() then
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
        if not cardGroup_[i]:ifCardObtained() then
            table.insert(notObtainCardGroup, cardGroup_[i])
        end
    end

    return notObtainCardGroup
end

--[[--
   获取战斗卡牌组索引

   @param none

   @return number
]]
function  PlayerData:getFightCardGroupIndex()
    return fightGroupIndex_
end

--[[--
    设置战斗卡牌组索引

    @param index number

    @return none
]]
function  PlayerData:setFightCardGroupIndex(index)
    fightGroupIndex_ = index
end

--[[--
   获取战斗卡牌组

   @param none

   @return number
]]
function  PlayerData:getFightCardGroup()
    if fightGroupIndex_ == 1 then
        return currentGroupOne_
    elseif fightGroupIndex_ == 2 then
        return currentGroupTwo_
    elseif fightGroupIndex_ == 3 then
        return currentGroupThree_
    end
end

--[[--
   获取当前第index个阵容

   @param index

   @return cards
]]
function  PlayerData:getCurrentCardGroup(index)
    if index == 1 then
        return currentGroupOne_
    elseif index == 2 then
        return currentGroupTwo_
    elseif index == 3 then
        return currentGroupThree_
    end
end

--[[--
   设置当前第index个阵容

   @param index
   @param cards

   @return none
]]
function  PlayerData:setCurrentCardGroup(index, cards)
    if index == 1 then
        currentGroupOne_ = cards
    elseif index == 2 then
        currentGroupTwo_ = cards
    elseif index == 3 then
        currentGroupThree_ = cards
    end
end

--[[--
   修改第index个阵容的第no张卡牌

   @param index
   @param no
   @param card

   @return cards
]]
function  PlayerData:modifyCurrentCardGroup(index, no, card)
    if index == 1 then
        currentGroupOne_[no] = card
    elseif index == 2 then
        currentGroupTwo_[no] = card
    elseif index == 3 then
        currentGroupThree_[no] = card
    end
end

--- 计算逻辑

--[[--
   卡牌升级

   @param id number 卡牌ID

   @return number 状态码

   0 - success
   1 - fail - 卡牌不足
   2 - fail - 金币不足
   3 - fail - 卡牌和金币均不足
]]
function  PlayerData:upgradeCard(id)
    local card = self:getCardById(id)
    if card:getRequireCardNum() <= card:getNum() and
            card:getRequireGoldNum() <= gold_ then
        card:setNum(card:getNum() - card:getRequireCardNum())
        gold_ = gold_ - card:getRequireGoldNum()
        card:setLevel(card:getLevel()+1)
        return 0
    elseif card:getRequireGoldNum() <= gold_ then
        return 1 -- 卡牌不足
    elseif card:getRequireCardNum() <= card:getNum() then
        return 2 -- 金币不足
    else
        return 3 -- 卡牌与金币均不足
    end
end

--[[--
   购买卡牌

   @param id number 卡牌ID
   @param pieceNum 碎片数量
   @param cost 花费

   @return number 状态码

   0 - success
   1 - fail - 金币不足
]]
function  PlayerData:purchaseCard(id, pieceNum, cost)
    local card = self:getCardById(id)
    if cost <= gold_ then
        card:setNum(card:getNum() + pieceNum)
        gold_ = gold_ - cost
        return 0
    else
        return 1 -- 金币不足
    end
end

--[[--
   购买宝箱

   @param cost 钻石花费
   @param boxCards
   boxCards = {
       gold = 1000,
       cards = {
           {
               cardId = 1,
               pieceNum = 100
           },
           {
               ...
           }
       }
   }

   @return number 状态码

   0 - success
   1 - fail - 钻石不足
]]
function  PlayerData:purchaseBox(cost, boxCards)


    if cost <= diamond_ then
        local gold = boxCards.gold
        local cards = boxCards.cards

        for i = 1, #cards do
            local card = self:getCardById(cards[i].cardId)
            card:setNum(card:getNum()+cards[i].pieceNum)
        end
        gold_ = gold_ + gold
        diamond_ = diamond_ - cost
        return 0
    else
        return 1 -- 钻石不足
    end
end

--[[--
   获得总暴击伤害

   @param none

   @return number
]]
function  PlayerData:getCriticalDamage()
    local res = 0
    local cardGroup = self:getObtainedCardGroup()
    for i = 1, #cardGroup do
        res = res + cardGroup[i]:getLevel()*3
    end
    return res
end

--[[--
   领取金币

   @param num

   @return none
]]
function  PlayerData:obtainGold(num)
    gold_ = gold_ + num
end

--[[--
   领取钻石

   @param num

   @return none
]]
function  PlayerData:obtainDiamond(num)
    diamond_ = diamond_ + num
end

--[[
    init
    从服务器和本地文件读取卡片完善信息

    @param none

    @return none
]]
function PlayerData:initCard()
    print("began init card")

    for i = 1, 20 do
        local card = Card[i].new(0,0)
        cardGroup_[i] = card
    end

    for i = 1, 5 do
        currentGroupOne_[i] = cardGroup_[i]
        currentGroupTwo_[i] = cardGroup_[i]
        currentGroupThree_[i] = cardGroup_[i]
    end

    print("end init card")
end

--[[
    将玩家卡组转换成服务器可以存储的格式

    @param none

    @return none
]]
function PlayerData:transCardGroup()
    -- 加载卡组信息
    local cardGroup = {}
    for i = 1, 20 do
        local index = string.format("%d", i)
        cardGroup[index] = {
            pieceNum = cardGroup_[i]:getNum(),
            level = cardGroup_[i]:getLevel(),
            intensify = cardGroup_[i]:getIntensify()
        }
    end
    return cardGroup
end

--[[
    将当前卡组1转换成服务器可以存储的格式

    @param none

    @return none
]]
function PlayerData:transCurrentGroupOne()
    local currentGroupOne = {}
    for i = 1, 5 do
        local index = string.format("%d", i)
        currentGroupOne[index] = currentGroupOne_[i]:getId()
    end
    return currentGroupOne
end

--[[
    将当前卡组2转换成服务器可以存储的格式

    @param none

    @return none
]]
function PlayerData:transCurrentGroupTwo()
    local currentGroupTwo = {}
    for i = 1, 5 do
        local index = string.format("%d", i)
        currentGroupTwo[index] = currentGroupTwo_[i]:getId()
    end
    return currentGroupTwo
end

--[[
    将当前卡组3转换成服务器可以存储的格式

    @param none

    @return none
]]
function PlayerData:transCurrentGroupThree()
    local currentGroupThree = {}
    for i = 1, 5 do
        local index = string.format("%d", i)
        currentGroupThree[index] = currentGroupThree_[i]:getId()
    end
    return currentGroupThree
end

--[[
    将天梯奖励转换成服务器可以存储的格式

    @param none

    @return none
]]
function PlayerData:transLadderAward()
    local ladderAward = {}
    for i = 1, 10 do
        local index = string.format("%d", i)
        ladderAward[index] = ladderAward_[i]
    end
    return ladderAward
end

return PlayerData