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
local towers_ = {}

--背包列表
local packs = {}

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

    towers_ = {
        tower_1, tower_2, tower_3, tower_4, tower_5, tower_6, tower_7, tower_8, tower_9, tower_10,
        tower_11, tower_12, tower_13, tower_14, tower_15, tower_16, tower_17, tower_18, tower_19, tower_20
    }
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
function OutgameData:getGold()
    return self.glod
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
function OutgameData:getDiamond()
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
    获取塔

    @parme none

    @return none
]]

function OutGameData:getTower()
    local tower = towers_[3]
    self:addTowerTOPacks(tower, 20)
end

--[[--
    把塔添加至背包

    @parm tower 类型：object
    @parm tower 类型：number

    return none
]]
function OutGameData:addTowerTOPacks(tower, num)
    for k, v in pairs(packs) do
        if tower.getTowerId() == v.getTowerId() then
            packs[k].setTowerNumber(num)
            return
        end
    end
    local packItem = PackItem.new(tower, num, 1)
    packs[#packs + 1] = packItem
end

--[[
    塔升级

    @parm index 类型：number

    @return none
]]
function OutgameData:towerLevelUp(index)
    local level = packs[index].getLevel() + 1 -- 当前塔的等级
    local rarity = packs[index].getTower().getTowerRarity() -- 当前塔的稀有度
    local needGold = ConstDef.LEVEL_UP_NEED_GOLD[level][rarity]
    local needCard = ConstDef.LEVEL_UP_NEED_CARD[level][rarity]
    if needGold > self.gold then
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