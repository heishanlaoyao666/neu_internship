---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by Zoybzo.
--- DateTime: 2022-07-05 16:18
---
local OutGameData = {}
--local
local ConstDef = require("app.def.ConstDef")
local EventDef = require("app.def.EventDef")
local EventManager = require("app.manager.EventManager")
local UserInfo = require("app.data.UserInfo")
local Shop = require("app.data.Shop")
local TestDataFactory = require("app.test.TestDataFactory")


local Factory = require("src/app/utils/Factory.lua")
local TowerDef = require("src/app/def/TowerDef.lua")
local Log = require("src/app/utils/Log.lua")

--网络部分
local OutGameMsgController = require("app.network.OutGameMsgController")
local MsgDef = require("app.def.MsgDef")
local TableUtil = require("app.utils.TableUtil")

--
local _userInfo
local _coinShop
local _diamondShop
local _treasureBoxRewardWinningRate
local _isAlive
--
---测试时用这个
function OutGameData:init()

    --连接到服务器
    -- OutGameMsgController:connect()
    -- self:register()

    -- TODO 如果在这里调用init就会出错，但是直接get是没有问题的
    _userInfo = UserInfo:getInstance()
    Log.i("OutGameData:init: " .. tostring(_userInfo == nil))
    --self:initUserInfo()
    _coinShop = TestDataFactory:getTestCoinShop()
    --self:initCoinShop()
    Log.i("OutGameData:init: " .. tostring(_coinShop == nil))
    _diamondShop = TestDataFactory:getTestDiamondShop()
    --self:initDiamondShop()
    Log.i("OutGameData:init: " .. tostring(_diamondShop == nil))
    self:initTreasureBoxRewardWinningRate()

    OutGameMsgController:init("127.0.0.0", 33333, 2)
    OutGameMsgController:connect()
    self:register()
    self:initUserInfo()
    self:initCoinShop()
    self:initDiamondShop()
    self:initTreasureBoxRewardWinningRate()
end

-- 调用 OutGameData:getTreasureBoxRewardWinningRate()[ConstDef.TREASUREBOX_RARITY.R][ConstDef.TREASUREBOX_REWARD.R]
function OutGameData:getTreasureBoxRewardWinningRate()
    if _treasureBoxRewardWinningRate == nil then
        self:initTreasureBoxRewardWinningRate()
    end
    return _treasureBoxRewardWinningRate
end



--function OutGameData:init()
--    --连接到服务器
--    -- OutGameMsgController:connect()
--    -- self:register()
--    --_userInfo = self:initUserInfo()
--    Log.i("OutGameData:init: " .. tostring(_userInfo == nil))
--    self:initUserInfo()
--    --_coinShop = TestDataFactory:getTestCoinShop()
--    --self:initCoinShop()
--    Log.i("OutGameData:init: " .. tostring(_coinShop == nil))
--    _diamondShop = TestDataFactory:getTestDiamondShop()
--    --self:initDiamondShop()
--    Log.i("OutGameData:init: " .. tostring(_diamondShop == nil))
--    self:initTreasureBoxRewardWinningRate()
--
--    -- OutGameMsgController:init("127.0.0.0", 33333, 2)
--    -- OutGameMsgController:connect()
--    -- self:register()
--end

-- 调用 OutGameData:getTreasureBoxRewardWinningRate()[ConstDef.TREASUREBOX_RARITY.R][ConstDef.TREASUREBOX_REWARD.R]
function OutGameData:getTreasureBoxRewardWinningRate()
    if _treasureBoxRewardWinningRate == nil then
        self:initTreasureBoxRewardWinningRate()
    end
    return _treasureBoxRewardWinningRate
end



function OutGameData:initTreasureBoxRewardWinningRate()
    -- TODO 感觉这个数据可能很少会发生变动，但是也不排除后续更新的可能
    _treasureBoxRewardWinningRate = {
        {
            -- 普通宝箱的没有找到

            { {}, {} },
            { {}, {} },
            { {}, {} },
            { {}, {} },
            { {}, {} },

            { {0}, {0} },
            { {0}, {0} },
            { {0}, {0} },
            { {0}, {0} },
            { {0}, {0} },

            { 0, 0 },
            { 0, 0 },
            { 0, 0 },
            { 0, 0 },
            { 0, 0 },
        },
        {
            { 130, 130 },
            { 40, 40 },
            { 7, 7 },
            { 0, 1 },
            { 1230, 1230 }
        },
        {
            { 139, 139 },
            { 36, 6 },
            { 7, 7 },
            { 0, 1 },
            { 1280, 1280 }
        },
        {
            { 187, 187 },
            { 51, 51 },
            { 21, 21 },
            { 1, 1 },
            { 3040, 3040 }
        }
    }
end

-- -测试的时候就用下面这三个函数
function OutGameData:initDiamondShop()
    _diamondShop = TestDataFactory:getTestDiamondShop()
end

function OutGameData:initCoinShop()
    _coinShop = TestDataFactory:getTestCoinShop()
end

function OutGameData:initUserInfo()
    _userInfo = UserInfo:getInstance()
    _userInfo:testData()
end

function OutGameData:register()

end

---测试的时候就用下面这三个函数
--function OutGameData:initDiamondShop()
--    _diamondShop = TestDataFactory:getTestDiamondShop()
--end
--
--function OutGameData:initCoinShop()
--    _coinShop = TestDataFactory:getTestCoinShop()
--end
--
--function OutGameData:initUserInfo()
--    _userInfo = UserInfo:getInstance()
--end

function OutGameData:register()

    ---这一部分是同步和初始化函数
    OutGameMsgController:registerListener(MsgDef.ACKTYPE.LOBBY.USERINFO_INIT,
        handler(self, self.initUserInfo))
    OutGameMsgController:registerListener(MsgDef.ACKTYPE.LOBBY.DIAMONDSHOP_INIT,
        handler(self, self.initDiamondShop))
    OutGameMsgController:registerListener(MsgDef.ACKTYPE.LOBBY.COINSHOP_INIT,
        handler(self, self.initCoinShop))
    OutGameMsgController:registerListener(MsgDef.ACKTYPE.LOBBY.USERINFO_DS,
        handler(self, self.userInfoDS))
    OutGameMsgController:registerListener(MsgDef.ACKTYPE.LOBBY.DIAMONDSHOP_DS,
        handler(self, self.diamondShopDS))
    OutGameMsgController:registerListener(MsgDef.ACKTYPE.LOBBY.COINSHOP_DS,
        handler(self, self.coinShopDS))

    ---这一部分是代表事件的函数
    OutGameMsgController:registerListener(MsgDef.ACKTYPE.LOBBY.CARD_COLLECT,
        handler(self, self.addCard))
    OutGameMsgController:registerListener(MsgDef.ACKTYPE.LOBBY.CARD_ATTRIBUTE_CHANGE,
        handler(self, self.changeCardAttribute))
    OutGameMsgController:registerListener(MsgDef.ACKTYPE.LOBBY.ASSERT_CHANGE,
        handler(self, self.assertChange))

    OutGameMsgController:registerListener(MsgDef.ACKTYPE.LOBBY.CARD_COLLECT,
        handler(self, self.addCard))
    OutGameMsgController:registerListener(MsgDef.ACKTYPE.LOBBY.CARD_ATTRIBUTE_CHANGE,
        handler(self, self.changeCardAttribute))
    OutGameMsgController:registerListener(MsgDef.ACKTYPE.LOBBY.ASSERT_CHANGE,
        handler(self, self.assertChange))

end

--[[--
    @description 本地同步来自服务器userinfo的数据
    @param msg type:table, 由服务器发送的消息
]]
function OutGameData:userInfoDS(msg)
    TableUtil:toUserInfo(msg.userInfo)
end

--[[--
    @description 本地同步来自服务器userinfo的数据
    每一次同步都会弃用原来的数据,会造成资源浪费
    @param msg type:table, 由服务器发送的消息
]]
function OutGameData:coinShopDS(msg)
    _coinShop = TableUtil:toShop(msg.coinShop)
end

--[[--
    @description 本地同步来自服务器userinfo的数据
    每一次同步都会弃用原来的数据,会造成资源浪费
    @param msg type:table, 由服务器发送的消息
]]
function OutGameData:diamondShopDS(msg)
    _diamondShop = TableUtil:toShop(msg.diamondShop)
end

function OutGameData:update(dt)
    ---在这里,进行计时，每隔一段时间进行发送消息进行数据同步
    ---同时隔一段事件发送心跳消息，确认在线
end

--function OutGameData:initDiamondShop(msg)
--    _diamondShop = TableUtil:toShop(msg.diamondShop)
--end
--
--function OutGameData:initCoinShop(msg)
--    _coinShop = TableUtil:toShop(msg.coinShop)
--end
--
--function OutGameData:initUserInfo(msg)
--    TableUtil:toUserInfo(msg.userInfo)
--end

--[[--
    @description 接受来自服务器的消息，确定新增的卡片,并将数据同步至本地数据
    这个函数可以一口气增加大量卡片
    但是目前card中尚无卡片数量的属性,所以暂时不写
    @msg, type:table 来自服务器的消息
    @return none
]]
function OutGameData:addCard(msg)
    local msgCards = msg.userInfo.cardList
    local cardList = _userInfo:getUserInfoCardList()
    for i = 1, #msgCards do
        local isExist = false
        local cardTable = msgCards[i]
        for j = 1, #cardList do
            if cardList[j].cardId_ == cardTable.cardId then
                isExist = true
                cardList[j]:addCardAmount(cardTable.cardAmount)
            end
        end
        if not isExist then
            local srcCard = TableUtil:toCard(cardTable)
            table.insert(cardList, srcCard)
        end
    end
end

--[[--
    @description 确认来自服务器的消息，将数据同步至本地数据
    这个里面应该保存由表示修改属性后card的对象,用该对象替换当前对象
    一次可以修改多个(但是会导致时间复杂度大幅度上升,因为需要遍历整个
    cardList,不建议,数组类型,内部没有特别的结构,决定了算法的上限),
    这里一共需要修改队伍数据和卡片列表的数据
    这个函数也可以用于增加卡片
    @msg type:table 来自服务器的消息
]]
function OutGameData:changeCardAttribute(msg)
    local msgCards = msg.userInfo.cardList
    local cardList = _userInfo:getUserInfoCardList()
    local teams = _userInfo:getBattleTeam().team_
    for i = 1, #msgCards do
        ---替换的数据
        local srcCard = TableUtil:toCard(msgCards[i])
        ---被替换数据的id
        local desIndex = nil
        for i = 1, #cardList do
            if srcCard.cardId_ == cardList[i].cardId_ then
                desIndex = i
            end
        end
        if desIndex then
            ---去除原来的,替换新的,为什么不修改原来的,
            ---因为这样代码简单,后面有时间就这样优化
            table.remove(cardList, desIndex)
            table.insert(cardList, srcCard)
        else
            ---desIndex是nil
            ---所以新增卡片
            ---验证合法性,这个值暂时先这样,如果有完善的常量表明这个,就修改
            if srcCard.cardId_ < 1 or srcCard.cardId_ > 20 then
                Log.e("the param cardId is illegal in msg.userInfo.cardList[?]")
            else
                table.insert(cardList, srcCard)
            end
        end
        for i = 1, #teams do
            desIndex = nil
            for j = 1, #teams[i] do
                if teams[i][j].cardId_ == srcCard.cardId_ then
                    desIndex = j
                end
            end
            if desIndex then
                table.remove(teams[i], desIndex)
                table.insert(teams[i], srcCard)
            end
        end
    end
end

--[[--
    @description 将购买的商品的数据同步至本地
    这是用户购买的卡片的列表

    msg中需要由userInfo属性，userInfo中需要有coinAmount和diamondAmount
    以及cardList属性

    以开宝箱为例， 在用户购买宝箱后，将开出的奖励和金币钻石的变化后的值传给服务器，服务器将数据确认保存后
    再将数据传回本地，确保本地数据和服务器统一
    另一方面，这个函数的运行要再奖励显示界面之前，不能显示奖励之后再传递消息给服务器

    其他同理

    @msg type:table 来自服务器的数据
]]
function OutGameData:purchaseCommodity(msg)
    --将金币变化后的值更新
    _userInfo:setUserInfoCoinAmount(msg.userInfo.coinAmount)
    _userInfo:setUserInfoDiamondAmount(msg.userInfo.diamondAmount)

    --将卡片数据合并至userInfo中
    local msgCards = msg.userInfo.cardList
    local cardList = _userInfo:getUserInfoCardList()
    for i = 1, #msgCards do
        local isExist = false
        local cardTable = msgCards[i]
        for j = 1, #cardList do
            if cardList[j].cardId_ == cardTable.cardId then
                isExist = true
                cardList[j]:addCardAmount(cardTable.cardAmount)
            end
        end
        if not isExist then
            local srcCard = TableUtil:toCard(cardTable)
            table.insert(cardList, srcCard)
        end
    end
end

--[[--
    @description 将金币和钻石的变化后的数据同步至本地
    msg中需要有userInfo属性，userInfo属性中必须有coinAmount和diamondAmount
    @msg type：table 来自服务器的数据
]]
function OutGameData:assertChange(msg)
    _userInfo:setUserInfoCoinAmount(msg.userInfo.coinAmount)
    _userInfo:setUserInfoDiamondAmount(msg.userInfo.diamondAmount)
end

--[[--
    @description:该函数用于修改用户天梯的奖杯数
    该函数同时负责天梯奖励的解锁进度,保证数据同步
    对消息的要求是只需要传回奖杯数就可以,但是再服务器那边也必须同步天梯奖励
]]
function OutGameData:trophyChange(msg)
    local amount = msg.userInfo.trophyAmount
    _userInfo:setUserInfoTrophyAmount(amount)
    local ladderList = _userInfo:getUserInfoLadder():getLadderList()
    for i = 1, #ladderList do
        if amount > ladderList[i].trophyCondition_ then
            ladderList[i]:setLocked(true)
        end
    end
end

--[[--
    @description:该函数用于领取奖励后同步本地数据
    这个函数和上面的购买商品的函数是几乎一模一样,除了增加了修改天梯数据的部分
]]
function OutGameData:receiveReward(msg)
    _userInfo:setUserInfoCoinAmount(msg.userInfo.coinAmount)
    _userInfo:setUserInfoDiamondAmount(msg.userInfo.diamondAmount)
    --将卡片数据合并至userInfo中
    local msgCards = msg.userInfo.cardList
    local cardList = _userInfo:getUserInfoCardList()
    for i = 1, #msgCards do
        local isExist = false
        local cardTable = msgCards[i]
        for j = 1, #cardList do
            if cardList[j].cardId_ == cardTable.cardId then
                isExist = true
                cardList[j]:addCardAmount(cardTable.cardAmount)
            end
        end
        if not isExist then
            local srcCard = TableUtil:toCard(cardTable)
            table.insert(cardList, srcCard)
        end
    end

    ---由于reward并没有明确的主码,所以用trophyAmount作为主码,将
    ---trophyAmount匹配的对象领取状态修改
    local ladderTable = msg.userInfo.ladder.ladderList
    local ladderList = _userInfo:getUserInfoLadder():getLadderList()
    for i = 1, #ladderTable do
        for j = 1, #ladderList do
            if ladderList[j].trophyCondition_ ==
                ladderTable[i].trophyCondition then
                ladderList[j].trophyCondition_ = true
            end
        end
    end
end

--[[--
    @description: 同步队伍数据
    玩家修改队伍信息后同步
]]
function OutGameData:modifyBattleTeam(msg)
    _userInfo:setUserInfoBattleTeam(TableUtil
        :toBattleTeam(msg.userInfo.battleTeam))

end

-- 不太确定函数返回的是引用还是复制的值，所以调用的时候还是先调用这个再用别的
function OutGameData:getUserInfo()
    if _userInfo == nil then
        self:initUserInfo()
    end
    return _userInfo
end

function OutGameData:getCoinShop()
    if _coinShop == nil then
        self:initCoinShop()
    end
    return _coinShop
end

function OutGameData:getDiamondShop()
    if _diamondShop == nil then
        self:initDiamondShop()
    end
    return _diamondShop
end

--[[--
    @description:这个函数用于随机生成奖励
    @param type:宝箱的类型，
    @return type:table table的结构如下,
    {
        {cardId = 1, number = 23, rarity = "R"},
        {cardId = 1, number = 23, rarity = "R"},
        {cardId = 1, number = 23, rarity = "SR"},
        {cardId = 1, number = 23, rarity = "SSR"},
        {cardId = 1, number = 23, rarity = "SSR"},
        coinNum = 2333
    }包括coinNum和一个数组，数组长度小于等于8

    之所以只有这么点属性，是因为这些属性足够表示出一个刚从宝箱开出来的卡片，
    同时将这样的消息传递给服务器时，传递的消息也比较少

]]
function OutGameData:openTreasureBox(rewardType)
    ---算法暂时先这样，后面再再根据更具体的要求完善
    --local rewardData = self:getTreasureBoxRewardWinningRate()[rewardType]
    math.randomseed(os.time())
    local res = Factory:getChestRewardModel()
    local rArray = TableUtil:clone(TowerDef.TOWER_R_IDLIST)
    local srArray = TableUtil:clone(TowerDef.TOWER_SR_IDLIST)
    local ssrArray = TableUtil:clone(TowerDef.TOWER_SSR_IDLIST)
    local urArray = TableUtil:clone(TowerDef.TOWER_UR_IDLIST)
    for i = 1, 8 do
        if res[i].rarity == "R" then
            local removeIndex = math.random(1, #rArray)
            res[i].cardId = rArray[removeIndex]
            table.remove(rArray, removeIndex)
            res[i].number = math.random(30, 50)
        elseif res[i].rarity == "SR" then
            local removeIndex = math.random(1, #srArray)
            res[i].cardId = srArray[removeIndex]
            table.remove(srArray, removeIndex)
            res[i].number = math.random(7, 13)
        elseif res[i].rarity == "SSR" then
            local removeIndex = math.random(1, #ssrArray)
            res[i].cardId = ssrArray[removeIndex]
            table.remove(ssrArray, removeIndex)
            res[i].number = math.random(7, 13)
        elseif res[i].rarity == "UR" then
            local removeIndex = math.random(1, #urArray)
            res[i].cardId = urArray[removeIndex]
            table.remove(urArray, removeIndex)
            res[i].number = math.random(0, 1)
        end
    end
    res.coinNum = 2333
    return res
end

return OutGameData
