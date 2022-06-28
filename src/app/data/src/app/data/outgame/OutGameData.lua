--[[--
    OutGameData.lua
    游戏外数据文件，全局唯一
]]

local OutGameData = {}

local ConstDef = require("app.def.outgame.ConstDef")
local EventDef = require("app.def.outgame.EventDef")
local EventManager = require("app.manager.EventManager")
local Tower = require("app.data.outgame.Tower")
local PackItem = require("app.data.outgame.PackItem")

--塔数据列表
local towersOrdinary_ = {} -- 普通
local towersRarity_ = {} -- 稀有
local towersEpic_ = {} -- 史诗
local towersLegend_ = {} -- 传说

--背包列表
local packsOrdinary_ = {} --普通
local packsRarity_ = {} --稀有
local packsEpic_ = {} -- 史诗
local packsLegend_ = {} -- 传奇

--未收集
local unPacksOrdinary_ = {} --普通
local unPacksRarity_ = {} --稀有
local unPacksEpic_ = {} -- 史诗
local unPacksLegend_ = {} -- 传奇

--[[--
    初始化数据

    @param none

    @return none
]]
function OutGameData:init()
    self.gameState_  = ConstDef.GAME_STATE.LOAD
    self.gold = nil -- 金币数
    self.diamond = nil -- 砖石数

    self:initTower()
    self:initFinance()
end

--[[--
    初始化塔的数据

    @param none

    @return none
]]
function OutGameData:initTower()
    local tower_1 = Tower.new(1, 1, 1, "tower_1", "使被攻击目标得到“灼烧”状态。灼烧：造成两次额外伤害。",
    "前方", 20, 3, 10, 0.8, 0.01, "额外伤害", 20, 3, 20, nil, nil)
    local tower_2 = Tower.new(2, 3, 1, "tower_2", "使星级数个怪物受到伤害。",
    "前方", 20, 5, 10, 0.8, nil, "额外伤害", 50, 4, 40, nil, nil)
    local tower_3 = Tower.new(3, 2, 1, "使星级数个怪物受到伤害。",
    "前方", 40, 8, 20, 0.8, 0.01, "额外伤害", 120, 24, 40, nil, nil)
    local tower_4 = Tower.new(4, 1, 1, "攻击生命值最高的怪物,对BOSS造成双倍伤害。",
    "最大血量", 100, 10, 100, 1, nil, nil, nil, nil, nil, nil, nil)
    local tower_5 = Tower.new(5, 4, 1, "每隔一段时间可以在三个形态之间切换，二形态攻速大幅度加强，三形态攻击必定暴击。",
    "前方", 20, 3, 30, 0.6, nil, "初次变声时间", 6, nil, nil, "二次变身给时间",4)
    local tower_6 = Tower.new(6, 4, 1, "当场上有1,4,9个该种类防御塔时,攻速加强，同时造成额外伤害。",
    "前方", 35, 5, 11, 1.2, nil, "额外伤害", 35, 5, 10.5, nil, nil)
    local tower_7 = Tower.new(7, 1, 1, "攻击时攻速获得提高。",
    "前方", 20, 3, 15, 0.45, nil, "攻速加强", 0.1, 0.02, nil, nil, nil)
    local tower_8 = Tower.new(8, 3, 1, "每合成一次，获得攻击力加成。",
    "前方", 10, 10, 10, 1, nil, "攻击力加成", 20, 1, nil, nil)
    local tower_9 = Tower.new(9, 1, 1, "攻击时有概率直接杀死怪物,对BOSS无效。",
    "随机敌人", 20, 4, nil, 1.2, nil, "攻击致死概率", 0.02, 0.002, 0.005, nil, nil)
    local tower_10 = Tower.new(10, 4, 1, "使被攻击目标得到“中毒”状态。中毒：每秒造成额外伤害。",
    "随即敌人", 30, 2, 10, 1.3, nil, "额外伤害", 50, 5, 20, nil, nil)
    local tower_11 = Tower.new(11, 3, 2, "合成时在对方玩家区域召唤一个特殊怪，使该区域的所有怪物加速。",
    "前方", 10, 5, 10, 0.8, 0.02, "加速效果", 0.05, nil, nil, nil, nil)
    local tower_12 = Tower.new(12, 3, 2,"对战开始时，随机选择一种敌方防御塔，获得其属性及技能。",
    "前方", 30, nil, nil, 0.8, nil, nil, nil, nil, nil, nil, nil)
    local tower_13 = Tower.new(13, 4, 2, "合成时随机降低一个敌方防御塔的星级。",
    "前方", 10, 5, 10, 0.8, 0.02, nil, nil, nil, nil, nil, nil)
    local tower_14 = Tower.new(14, 2, 3, "复制任意相同星级的防御塔。",
    "前方", 10, 5, 10, 1, nil, nil, nil, nil, nil, nil, nil)
    local tower_15 = Tower.new(15, 2, 3, "合成或遭受攻击时获得能量。",
    "前方", 10, 10, 10, 1, nil, nil, nil, nil, nil, nil, nil)
    local tower_16 = Tower.new(16, 3, 3, "生成一段时间后，变成星级加一的随机防御塔。",
    "前方", 10, 5, 10, 2, nil, nil, nil, nil, nil, "成长时间", 15)
    local tower_17 = Tower.new(17, 3, 3, "可以和任意相同星级的防御塔合成，不改变防御塔种类。",
    "前方", 20, 5, 10, 1,  nil, nil, nil, nil, nil, nil, nil)
    local tower_18 = Tower.new(18, 1, 3, "使被攻击目标得到”脆弱“状态。脆弱：受到伤害提高。",
    "随机敌人", 30, 5, 10, 1, nil, "增伤效果", 0.1, 0.01, 0.05, nil, nil)
    local tower_19 = Tower.new(19, 4, 4, "每隔一段时间使本方半场所有敌人减速。",
    "前方", 60, 5, 20, 2, nil, "技能减速效果", nil, 0.005, 0.01, "技能发动时间", 10)
    local tower_20 = Tower.new(20, 1, 4, "使被攻击目标进入“混乱”状态。混乱：无法移动。",
    "随机敌人", 20, 5, 20, 1, 0.02, "技能持续时间", 2, 0.5, 0.5, "技能发动时间", 10)

    towersOrdinary_ = {tower_1, tower_4, tower_7, tower_9, tower_10, tower_18, tower_20, }
    unPacksOrdinary_ = {tower_1, tower_4, tower_7, tower_9, tower_10, tower_18, tower_20, }
    towersRarity_ = {tower_3, tower_14, tower_15, }
    unPacksRarity_ = {tower_3, tower_14, tower_15, }
    towersEpic_ = {tower_2, tower_8, tower_11, tower_12, tower_16, tower_17, }
    unPacksEpic_ = {tower_2, tower_8, tower_11, tower_12, tower_16, tower_17, }
    towersLegend_ = {tower_5, tower_6, tower_13, tower_19, }
    unPacksLegend_ = {tower_5, tower_6, tower_13, tower_19, }
end

--[[--
    初始化金融的数据

    @param none

    @return none
]]
function OutGameData:initFinance()
    self.gold = 1000000
    self.diamond = 100000
end

--[[--
    获取金币的数据

    @param none

    @return number
]]
function OutGameData:getGold()
    return self.gold
end

--[[--
    修改金币的数据

    @param n 类型：number 修改量

    @return none
]]
function OutGameData:setGold(n)
    self.gold = self.gold + n
end

--[[--
    获取钻石的数据

    @param none

    @return number
]]
function OutGameData:getDiamond()
    return self.diamond
end

--[[--
    修改钻石的数据

    @param n 类型：number 修改量

    @return none
]]
function OutGameData:setDiamond(n)
    self.diamond = self.diamond + n
end

--[[--
    金币商店

    @parm none

    @return pack 类型：table
]]
function OutGameData:goldShop()
    math.randomseed(os.time())
    local a = math.random(1, #towersOrdinary_) --数量：1 价格：360 gold
    local b = math.random(1, #towersOrdinary_) --数量：1 价格：360 gold
    local c = math.random(1, #towersOrdinary_) --数量：1 价格：360 gold
    local d = math.random(1, #towersRarity_) --数量：1 价格：600 gold
    local e = math.random(1, #towersEpic_) --数量：1 价格：1000 gold
    local packs = {towersOrdinary_[a], towersOrdinary_[b], towersOrdinary_[c], towersRarity_[d], towerEpic_[e]}
    return packs
end


--[[--
    普通宝箱， 价格150 diamond, 增加285 gold
    普通塔数量：一共38
    稀有塔数量：7
    史诗塔数量：1

    @parm none

    @return packs 类型：table
    @return packsNum 类型：table
]]

function OutGameData:ordinaryChests()
    math.randomseed(os.time())

    local a1 = math.random(1, #towersOrdinary_)
    local numA1 = math.random(16, 22)

    local a2 = math.random(1, #towersOrdinary_)
    while a2 == a1 do
        a2 = math.random(1, #towersOrdinary_)
    end
    local numA2 = 38 - numA1

    local b = math.random(1, #towersRarity_)

    local c = math.random(1, #towersEpic_)

    local packs = {towersOrdinary_[a1] , towersOrdinary_[a2], towersRarity_[b], towersEpic_[c], }
    local packsNum = {numA1, numA2, 7, 1}

    return packs, packsNum
end

--[[--
    稀有宝箱,  价格250 diamond, 增加456 gold
    普通塔数量：一共74
    稀有塔数量：14
    史诗塔数量：2

    @parm none

    @return packs 类型：table
    @return packsNum 类型：table
]]

function OutGameData:rarityChests()
    math.randomseed(os.time())

    local a1 = math.random(1, #towersOrdinary_)
    local numA1 = math.random(34, 40)

    local a2 = math.random(1, #towersOrdinary_)
    while a2 == a1 do
        a2 = math.random(1, #towersOrdinary_)
    end
    local numA2 = 74 - numA1

    local b = math.random(1, #towersRarity_)

    local c = math.random(1, #towersEpic_)

    local packs = {towersOrdinary_[a1] , towersOrdinary_[a2], towersRarity_[b], towersEpic_[c], }
    local packsNum = {numA1, numA2, 14, 2}

    return packs, packsNum
end

--[[--
    史诗宝箱, 价格750 diamond, 增加1280 gold
    普通塔数量：一共139
    稀有塔数量：一共36
    史诗塔数量：7
    传奇塔数量：0-1

    @parm none

    @return packs 类型：table
    @return packsNum 类型：table
]]
function OutGameData:epicChests()
    math.randomseed(os.time())

    local a1 = math.random(1, #towersOrdinary_)
    local numA1 = math.random(37, 43)

    local a2 = math.random(1, #towersOrdinary_)
    while a2 == a1 do
        a2 = math.random(1, #towersOrdinary_)
    end
    local numA2 = math.random(37, 43)

    local a3 = math.random(1, #towersOrdinary_)
    while a3 == a1 or a3 == a2 do
        a3 = math.random(1, #towersOrdinary_)
    end
    local numA3 = math.random(37, 43)

    local a4 = math.random(1, #towersOrdinary_)
    while a4 == a1 or a4 == a2 or a4 == a3 do
        a4 = math.random(1, #towersOrdinary_)
    end
    local numA4 = 139 - numA1 - numA2 -numA3

    local b1 = math.random(1, #towersRarity_)
    local numB1 = math.random(15, 21)

    local b2 = math.random(1, #towersRarity_)
    while b2 == b1 do
        b2 = math.random(1, #towersRarity_)
    end
    local numB2 = 36 - numB1

    local c1 = math.random(1, #towersEpic_)

    local d1 = math.random(1, #towersLegend_)
    local numD1 = math.random(1, 20)
    if numD1 > 19 then
        numD1 = 1
    else
        numD1 = 0
    end

    local packs = {towersOrdinary_[a1], towersOrdinary_[a2], towersOrdinary_[a3],
    towersOrdinary_[a4], towersRarity_[b1], towersRarity_[b2], towersEpic_[c1], towersLegend_[d1]}
    local packsNum = {numA1, numA2, numA3, numA4, numB1, numB2, 7, numD1}

    return packs, packsNum
end

--[[--
    传奇宝箱, 价格2500 diamond, 增加3040 gold
    普通塔数量：一共187
    稀有塔数量：一共51
    史诗塔数量：21
    传奇塔数量：1

    @parm none

    @return packs 类型：table
    @return packsNum 类型：table
]]
function OutGameData:legendChests()
    math.randomseed(os.time())

    local a1 = math.random(1, #towersOrdinary_)
    local numA1 = math.random(42, 48)

    local a2 = math.random(1, #towersOrdinary_)
    while a2 == a1 do
        a2 = math.random(1, #towersOrdinary_)
    end
    local numA2 = math.random(42, 48)

    local a3 = math.random(1, #towersOrdinary_)
    while a3 == a1 or a3 == a2 do
        a3 = math.random(1, #towersOrdinary_)
    end
    local numA3 = math.random(42, 48)

    local a4 = math.random(1, #towersOrdinary_)
    while a4 == a1 or a4 == a2 or a4 == a3 do
        a4 = math.random(1, #towersOrdinary_)
    end
    local numA4 = 187 - numA1 - numA2 -numA3

    local b1 = math.random(1, #towersRarity_)
    local numB1 = math.random(22, 28)

    local b2 = math.random(1, #towersRarity_)
    while b2 == b1 do
        b2 = math.random(1, #towersRarity_)
    end
    local numB2 = 51 - numB1

    local c1 = math.random(1, #towersEpic_)

    local d1 = math.random(1, #towersLegend_)

    local packs = {towersOrdinary_[a1], towersOrdinary_[a2], towersOrdinary_[a3],
    towersOrdinary_[a4], towersRarity_[b1], towersRarity_[b2], towersEpic_[c1], towersLegend_[d1]}
    local packsNum = {numA1, numA2, numA3, numA4, numB1, numB2, 21, 1}

    return packs, packsNum
end

--[[--
    为塔选择相应的背包,并从未收集图鉴移除

    @parm tower 类型：object
    @parm num 类型：number

    @return none
]]
function OutGameData:choosePacks(tower, num)
    local rarity = tower.getTowerRarity()
    if rarity == 1 then
        self:addTowerTOPacks(tower, num, packsOrdinary_, unPacksOrdinary_)
    elseif rarity == 2 then
        self:addTowerTOPacks(tower, num, packsRarity_, unPacksRarity_)
    elseif rarity == 3 then
        self:addTowerTOPacks(tower, num, packsEpic_, unPacksEpic_)
    elseif rarity == 4 then
        self:addTowerTOPacks(tower, num, packsLegend_, unPacksLegend_)
    end
end

--[[--
    把塔添加至相应的背包

    @parm tower 类型：object
    @parm num 类型：number
    @parm packs 类型：table

    @return none
]]
function OutGameData:addTowerTOPacks(tower, num, packs, unpacks)
    for k, v in pairs(packs) do
        if tower.getTowerId() == v.getTowerId() then
            packs[k].setTowerNumber(num)
            return
        end
    end
    local packItem = PackItem.new(tower, num)
    self:removeTowerTOPacks(tower, unpacks)
    packs[#packs + 1] = packItem
end

--[[--
    把塔从未收集图鉴移除

    @parm tower 类型：object
    @parm packs 类型：table

    @return none
]]
function OutGameData:removeTowerTOPacks(tower, packs)
    for k, v in pairs(packs) do
        if tower.getTowerId() == v.getTowerId() then
            table.remove(packs, k)
            return
        end
    end
end

--[[
    塔升级

    @parm packs 类型：table
    @parm index 类型：number

    @return none
]]
function OutGameData:towerLevelUp(packs, index)
    local level = packs[index].getLevel() + 1 -- 当前塔的等级
    local rarity = packs[index].getTower().getTowerRarity() -- 当前塔的稀有度
    local needGold = ConstDef.LEVEL_UP_NEED_GOLD[level][rarity]
    local needCard = ConstDef.LEVEL_UP_NEED_CARD[level][rarity]
    if needGold > self:getGold() then
        print("金币不足")
        return
    end
    if needCard > packs[index].getTowerNumber() then
        print("卡片不足")
        return
    end
    packs[index].towerLevelUp()
    packs[index].setTowerNumber(-needCard)
    self:setGold(-needGold)
    packs[index].getTower().AtkUpgrade()
    packs[index].getTower().FireCdUpgrade()
    packs[index].getTower().ValueUpgrade()
end

--[[--
    塔强化

    @parm packs 类型：table
    @parm index 类型：number

    @return none
]]
function OutGameData:towerEnhance(packs, index)
    if packs[index].getLevel() <= packs[index].getEnhanceLevel() then
        print("已经强化到当前最高等级")
    else
        packs[index].getTower().AtkEnhance()
        packs[index].getTower().ValueEnhance()
    end
end

--[[--
    获取已收集塔

    @parm none

    @return packsOrdinary_, packsRarity_, packsEpic_, packsLegend_ 类型：table,已收集背包
]]
function OutGameData:getCollected()
    return packsOrdinary_, packsRarity_, packsEpic_, packsLegend_
end

--[[--
    获取未收集塔

    @parm none

    @return unPacksLegend_, unPacksRarity_, unPacksEpic_, unPacksLegend_ 类型：table, 未收集背包
]]

function OutGameData:getUnCollected()
    return unPacksLegend_, unPacksRarity_, unPacksEpic_, unPacksLegend_
end

--[[--
    设置游戏状态

    @param state 类型：number，游戏状态

    @return none
]]
function OutGameData:setGameState(state)
    self.gameState_ = state
    EventManager:doEvent(EventDef.ID.GAMESTATE_CHANGE, state)
end

--[[--
    获取游戏状态

    @param none

    @return number
]]
function OutGameData:getGameState()
    return self.gameState_
end

return OutGameData