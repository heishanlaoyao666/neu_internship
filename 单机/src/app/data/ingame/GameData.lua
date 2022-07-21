--[[--
    GameData.lua
    游戏战斗战斗数据
]]

local GameData = {}

local OutGameData = require("app.data.outgame.OutGameData")
local Tower = require("app.data.outgame.Tower")
local FightingTower = require("app.data.ingame.FightingTower")
local Monster = require("app.data.ingame.Monster")
local Bullet = require("app.data.ingame.Bullet")
local ConstDef = require("app.def.ingame.ConstDef")
local EventDef = require("app.def.EventDef")
local EventManager = require("app.manager.EventManager")

local myTowers_ = {} -- 我阵容的塔
local enemyTowers_ = {} -- 敌方阵容的塔

local indexTable_ = {} -- 我方塔的位置
local indexs_ = {} -- 塔有可能生成的下标
local enemyIndexTable_ = {} -- 敌方塔的位置
local enemyIndexs_ = {} -- 敌方塔有可能生成的下标

local monsters_ = {} -- 我方小怪
local enemyMonsters_ = {} -- 敌方小怪

local fightingTowers_ = {} -- 塔数组
local enemyFightingTowers_ = {} -- 敌方塔数组

local bullets_ = {} -- 子弹数组
local enemyBullets_= {} -- 敌方子弹数组

local shootTick_ = {} -- 记录射击时间间隔
local enemyShootTick_ = {} -- 记录敌方的射击时间

local enhanceNeedSp_ = {} -- 塔强化需要的sp
local enhanceLevel_ = {} -- 塔强化的等级

local enemyEnhanceNeedSp_ = {} -- 敌人塔强化需要的sp
local enemyEnhanceLevel_ = {} -- 敌人塔强化的等级

local countTower_6_ = {} -- 敌我双方塔6数量记录

local spacialMonster_ = {} -- 记录特殊目标, 第一个为血量最高，第二个为随机
local enemySpacialMonster_ = {} -- 敌方记录特殊目标, 第一个为血量最高，第二个为随机

local mySp_ = {} -- 记录sp， 第一个为总的sp，第二个为合成塔需要的sp
local enemySp_ = {} -- 记录sp， 第一个为总的sp，第二个为合成塔需要的sp

local monsterIsAcc_ = {0, 0} -- 怪物是否加速

local myBoss_ = {}
local enemyBoss_ = {}

local num_ = {} -- 记录boss召唤数

local myTrophyNum_ = 0
local enemyTrophyNum_ = 0

--当前帧的操作
local data_ = {
    0, -- 生成塔 0/1
    {0, 0}, -- 合成塔 {0，0}
    0, -- 强化塔 1
    0, --投降 0/1
    0, -- 随机种子
}

local enemyData_ = {
    0, -- 生成塔 0/1
    {0, 0}, -- 合成塔 {0，0}
    0, -- 强化塔 1
    0, --投降 0/1
    0, -- 随机种子
}

math.randomseed(data_[5])

--[[--
    退出时数据清理

    @parm none

    @return none
]]
function GameData:exit()
    for i = 1, #monsters_ do
        monsters_[i]:destory()
    end
    for i = 1, #enemyMonsters_ do
        enemyMonsters_[i]:destory()
    end
    for i = 1, #fightingTowers_ do
        fightingTowers_[i]:destory()
    end
    for i = 1, #enemyFightingTowers_ do
        enemyFightingTowers_[i]:destory()
    end
    for i = 1, #bullets_ do
        bullets_[i]:destory()
    end
    for i = 1, #enemyBullets_ do
        enemyBullets_[i]:destory()
    end
    for i = 1, #myBoss_ do
        myBoss_[i]:destory()
    end
    for i = 1, #enemyBoss_ do
        enemyBoss_[i]:destory()
    end

    self:init()
end

--[[--
    初始化

    @parm none

    @return none
]]
function GameData:init()
    self.gameState_ = nil

    self.sumTime_ = 0 -- 记录总时间
    self.time_ = 0 -- 记录刷怪时间
    self.createTime_ =1 -- 刷怪的时间间隔
    self.createMonsterTimeSpacing_ = 10 -- 记录间隔时间
    self.createMonsterTime_ = 10 -- 刷怪波数间隔
    self.bossTime_ = ConstDef.BOSS_CREATE_TIME[1] -- boss出现时间记录
    self.health_ = 100 -- 怪物血量
    self.healthSpacing_ = 100 -- 血量间距
    self.monsterNum_ = 2 -- 一开始刷怪的数量
    self.stage_ = 1 -- 阶段

    self.myPoint_ = 3 -- 我的血量
    self.enemyPoint_ = 3 -- 敌人的血量

    self.getSp_ = 10 -- 杀死怪物可以获得的sp

    self.myBossTimes_ = 0
    self.enemyBossTimes_ = 0

    self.nextBossId_ = math.random(1, 4)

    mySp_ = {100, 10}
    enemySp_ = {100, 10}
    num_ = {0, 0} -- 记录boss召唤数
    spacialMonster_ = {0, 0} -- 记录特殊目标, 第一个为血量最高，第二个为随机
    enemySpacialMonster_ = {0, 0} -- 敌方记录特殊目标, 第一个为血量最高，第二个为随机
    countTower_6_ = {0, 0} -- 敌我双方塔6数量记录
    monsterIsAcc_ = {0, 0} -- 怪物是否加速


    indexTable_ = {{160, 528}, {260, 528}, {359, 528}, {458, 528}, {556, 528},
                   {160, 431}, {260, 431}, {359, 431}, {458, 431}, {556, 431},
                   {160, 338}, {260, 338}, {359, 338}, {458, 338}, {556, 338}}
    indexs_ = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11 ,12 , 13, 14, 15}

    enemyIndexTable_ = {
        {551, 843}, {453, 843}, {354, 843}, {255, 843}, {155, 843},
        {551, 936}, {453, 936}, {354, 936}, {255, 936}, {155, 936},
        {551, 1028}, {453, 1028}, {354, 1028}, {255, 1028}, {155, 1028}
    }
    enemyIndexs_ = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15}

    for i = 1, 5 do
        enhanceNeedSp_[i] = ConstDef.ENHANCE_NEED_SP[1]
        enhanceLevel_[i] = 1
    end

    myTowers_ = {}
    for i=1,5 do
        myTowers_[i]=OutGameData:getCurrentTower(i)
    end
    --敌方阵容
    local tower_6 = Tower.new(6, 4, 1, "tower_6","当场上有1,4,9个该种类防御塔时,攻速加强，同时造成额外伤害。",
    "前方", 35, 5, 11, 1.2, nil, "额外伤害", 4,35, 5, 10.5, nil, nil,nil)
    local tower_7 = Tower.new(7, 1, 1,"tower_7", "攻击时攻速获得提高。",
    "前方", 20, 3, 15, 0.45, nil, "攻速加强", 9,0.1, 0.02, nil, nil,nil, nil)
    local tower_8 = Tower.new(8, 3, 1,"tower_8", "每合成一次，获得攻击力加成。",
    "前方", 10, 10, 10, 1, nil, "攻击力加成", 1,20, 1, nil, nil,nil,nil)
    local tower_9 = Tower.new(9, 1, 1,"tower_9","攻击时有概率直接杀死怪物,对BOSS无效。",
    "随机敌人", 20, 4, nil, 1.2, nil, "攻击致死概率",7, 0.02, 0.002, 0.005, nil,nil, nil)
    local tower_10 = Tower.new(10, 2, 1, "tower_10","使被攻击目标得到“中毒”状态。中毒：每秒造成额外伤害。",
    "随机敌人", 30, 2, 10, 1.3, nil, "额外伤害", 4,50, 5, 20, nil, nil,nil)

    enemyTowers_ = {tower_6, tower_7, tower_8, tower_9, tower_10}

    --[[
        --获取双方塔阵容(联机)
        local myTowerData = f()
        --获取我方
        for i = 1, 5 do
            local tower = Tower.new(myTowerData[1], myTowerData[2], myTowerData[3], myTowerData[4], myTowerData[5],
            myTowerData[6], myTowerData[7], myTowerData[8], myTowerData[9], myTowerData[10], myTowerData[11],
            myTowerData[12], myTowerData[13], myTowerData[14], myTowerData[15], myTowerData[16], myTowerData[17],
            myTowerData[18], myTowerData[19])
            tower:setLevel(myTowerData[20])
            myTower_[i] = tower
        end
        获取敌方
        local enemyTowerData = f()
        for i = 1, 5 do
            local tower = Tower.new(enemyTowerData[1], enemyTowerData[2], enemyTowerData[3], enemyTowerData[4], enemyTowerData[5],
            enemyTowerData[6], enemyTowerData[7], enemyTowerData[8], enemyTowerData[9], enemyTowerData[10], enemyTowerData[11],
            enemyTowerData[12], enemyTowerData[13], enemyTowerData[14], enemyTowerData[15], enemyTowerData[16], enemyTowerData[17],
            enemyTowerData[18], enemyTowerData[19])
            tower:setLevel(enemyTowerData[20])
            enemyTower_[i] = tower
        end

        获取我方奖杯数
        myTrophyNum_ = f()
        获取敌方奖杯数
        enemyTrophyNum_ = f()
    ]]

    --塔12技能
    for i = 1, #myTowers_ do
        if myTowers_[i]:getTowerId() == 12 then
            local index = math.random(1, #enemyTowers_)
            myTowers_[i] = enemyTowers_[index]
            break
        end
    end
    for i = 1, #enemyTowers_ do
        if enemyTowers_[i]:getTowerId() == 12 then
            local index = math.random(1, #myTowers_)
            enemyTowers_[i] = myTowers_[index]
            break
        end
    end
end

--[[--
    联机，获取奖杯数

    @parm i 类型：number

    @return none
]]
function GameData:getTrophyNum(i)
    if i == 1 then
        --获取我方奖杯数
        --myTrophyNum_ = f()
        return myTrophyNum_
    elseif i == 2 then
        --获取敌方奖杯数
        --enemyTrophyNum_ = f()
        return enemyTrophyNum_
    end
end

--[[--
    失败惩罚

    @parm none

    @return table
]]
function GameData:defeatReward()
    return {{-10, 0, 0}, {-100, 0, 0}, 0}
end

--[[--
    胜利奖励

    @parm none

    @return table
]]
function GameData:victoryReward()
    return {{10, 0, 0}, {100, 0, 0}, 5}
end

--[[--
    认输

    @parm none

    @return none
]]
function GameData:defeat()
    data_[4] = 1
end

--[[--
    胜利

    @parm none

    @return none
]]
function GameData:victory()
    data_[4] = 2
end

--[[--
    设置游戏状态

    @param state 类型：number，游戏状态

    @return none
]]
function GameData:setGameState(state)
    self.gameState_ = state
    EventManager:doEvent(EventDef.ID.GAMESTATE_CHANGE, state)
end

--[[--
    获取游戏是否进行

    @parm none

    @return 类型：boolen
]]
function GameData:isPlaying()
    return self.gameState_ == ConstDef.GAME_STATE.ADMIT_DEFEAT or
    self.gameState_ == ConstDef.GAME_STATE.PLAY
end

--[[--
    判断是否boss选择

    @parm none

    @return 类型：boolen
]]
function GameData:isChoose()
    return self.gameState_ == ConstDef.GAME_STATE.CHOOSE_BOOS
end

--[[--
    返回游戏是否胜利

    @parm none

    @return 类型：boolen
]]
function GameData:isVictory()
    return self.gameState_ == ConstDef.GAME_STATE.SETTLEMENT_VICTORY
end

--[[--
    获取我的血量

    @parm none

    @return self.myPoint_, 类型：number
]]
function GameData:getMyPoint()
    return self.myPoint_
end

--[[--
    获取敌人的血量

    @parm none

    @return self.enemyPoint_, 类型：number
]]
function GameData:getEnemyPoint()
    return self.enemyPoint_
end

--[[--
    获取总的sp数

    @parm none

    @return mySp_[1], 类型：number
]]
function GameData:getSumSp()
    return mySp_[1]
end

--[[--
    增加总的sp数

    @parm n, 类型：number

    @return none
]]
function GameData:addSumSp(n)
    mySp_[1] = mySp_[1] + n
end

--[[--
    获取生成塔需要的sp

    @parm none

    @return self.needSp_, 类型：number
]]
function GameData:getNeedSp()
    return mySp_[2]
end

--[[--
    获取强化塔需要的sp

    @parm none

    @return 类型：table
]]
function GameData:getEnhanceNeedSp()
    return enhanceNeedSp_
end

--[[--
    获取我方塔的阵容

    @parm none

    @return myTowers_, 类型：table
]]
function GameData:getMyTowers()
    return myTowers_
end

--[[--
    获取敌方塔的阵容

    @parm none

    @return myTowers_, 类型：table
]]
function GameData:getEnemyTowers()
    return enemyTowers_
end

--[[--
    获取塔数组

    @parm none

    @return 类型：table
]]
function GameData:getTowers()
    return fightingTowers_
end

--[[--
    随机生成塔

    @parm towers 类型：table

    @return none
]]
function GameData:createTower(towers, indexTable, indexs, fightingTowers, sp)
    if #indexs ~= 0 and sp[1] >= sp[2] then
        local indexTower = math.random(1, 5)
        local tower = towers[indexTower]
        local index = math.random(1, #indexs)
        local fightingTower = FightingTower.new(tower, indexTable, indexs[index], 1)
        table.remove(indexs, index)
        fightingTowers[#fightingTowers + 1] = fightingTower
        sp[1] = sp[1] - sp[2]
        sp[2] = sp[2] + 10
    end
end

--[[--
    我方随机塔生成操作,对外提供接口

    @parm none

    @return none
]]
function GameData:createMyTower()
    data_[1] = 1
end


--[[--
    获取该位置的塔

    @parm x 类型：number
    @parm y 类型：number
    @parm tower 类型：fightingTower

    @return FightingTower
]]
function GameData:getFightingTowerByIndex(x, y, tower)
    for key, value in pairs(fightingTowers_) do
        if self:isValidTouch(value, x, y) then
            if value ~= tower then
                return fightingTowers_[key]
            end
        end
    end
    return nil
end

--[[--
    位置是否在我方塔有效范围（判定能否点击）

    @parm x 类型：number
    @parm y 类型：number
    @parm tower 类型：fightingTower

    @return boolean
]]
function GameData:isValidTouch(tower, x, y)
    return tower:isContain(x, y)
end

--[[--
    移动我方塔

    @parm x 类型：number
    @parm y 类型：number
    @parm tower 类型：fightingTower

    @return none
]]
function GameData:moveTo(x, y, tower)
    if x > display.right or x < display.left or y > display.top or y < display.bottom then
        local index = GameData:getTowerIndex(tower)
        local index_x, index_y = index[1], index[2]
        x, y = index_x, index_y
    end
        tower:setX(x)
        tower:setY(y)
end

--[[--
    融合塔对外接口

    @parm fightingTower1 类型：FightingTower
    @parm fightingTower2 类型：FightingTower

    @return none
]]
function GameData:merging(fightingTower1, fightingTower2)
    data_[2][1] = fightingTower1:getIndex()
    data_[2][2] = fightingTower2:getIndex()
end

--[[--
    融合塔，塔8，11, 13, 14, 15，17技能

    @parm fightingTower1 类型：FightingTower
    @parm fightingTower2 类型：FightingTower
    @parm type 类型：number

    @return none
]]
function GameData:mergingFightingTower(index_1, index_2, towers, fightingTowers, type, enemyMonsters,
    enemyFightingTowers, sp, indexs)
    local fightingTower1, fightingTower2 = nil, nil
    for i = 1, #fightingTowers do
        if fightingTowers[i]:getIndex() == index_1 then
            fightingTower1 = fightingTowers[i]
        elseif fightingTowers[i]:getIndex() == index_2 then
            fightingTower2 = fightingTowers[i]
        end
    end

    local index_x, index_y = 0, 0
    if type == 1 then
        index_x, index_y = ConstDef.ENEMY_MONSTER_INDEX_X, ConstDef.ENEMY_MONSTER_INDEX_Y
    elseif type == 2 then
        index_x, index_y = ConstDef.MONSTER_INDEX_X, ConstDef.MONSTER_INDEX_Y
    end

    -- 攻击加成
    if fightingTower1:getTower():getTowerId() == 8 or fightingTower2:getTower():getTowerId() == 8 then
        local val = fightingTower1:getTower():getSkill1Value()
        for i = 1, #towers do
            if towers[i]:getTowerId() == 8 then
                towers[i]:atkEnhance(val)
            end
        end
        for i = 1, #fightingTowers do
            if fightingTowers[i]:getTower():getTowerId() == 8 then
                fightingTowers[i]:getTower():atkEnhance(val)
            end
        end
    --合成时在对方玩家区域召唤一个特殊怪，使该区域的所有怪物加速
    elseif fightingTower1:getTower():getTowerId() == 11 or fightingTower2:getTower():getTowerId() == 11 then
        local enemyMonster = Monster.new(index_x, index_y, self.health_, 1, 0)
        enemyMonster:setSpecial()
        enemyMonsters[#enemyMonsters + 1] = enemyMonster
        if monsterIsAcc_[type] == 0 then
            monsterIsAcc_[type] = 1
            for i = 1, #enemyMonsters do
                enemyMonsters[i]:setSpeed(1)
            end
        end
    --合成时随机降低一个敌方防御塔的星级
    elseif fightingTower1:getTower():getTowerId() == 13 or fightingTower2:getTower():getTowerId() == 13 then
        if type == 1 then
            local index = math.random(1, #enemyFightingTowers)
            self:descendingStars(enemyFightingTowers[index])
        end
    -- 复制塔
    elseif fightingTower1:getTower():getTowerId() == 14 then
        local index = fightingTower1:getIndex()
        fightingTower1:destory()
        local star = fightingTower2:getstar()
        local tower = fightingTower2:getTower()
        local fightingTower = FightingTower.new(tower, indexTable_, index, star)
        fightingTowers[#fightingTowers + 1] = fightingTower
        return -- 合成后保持原来的塔，无需往下进行
    --合成获得sp
    elseif fightingTower1:getTower():getTowerId() == 15 or fightingTower2:getTower():getTowerId() == 15 then -- 获得sp
        if fightingTower1:getTower():getTowerId() == 15 then
            sp[1] = sp[1] + 80 * fightingTower1:getstar()
        end
        if fightingTower2:getTower():getTowerId() == 15 then
            sp[1] = sp[1] + 80 * fightingTower2:getstar()
        end
    --合成不改变种类
    elseif fightingTower1:getTower():getTowerId() == 15 then
        fightingTower1:starUp()
        fightingTower2:destory()
        return
    end
    local index = fightingTower1:getIndex()
    table.insert(indexs, index)
    fightingTower1:destory()
    index = fightingTower2:getIndex()
    local star = fightingTower2:getStar() + 1
    fightingTower2:destory()
    local indexTower = math.random(1, 5)
    local tower = towers[indexTower]
    local fightingTower = FightingTower.new(tower, indexTable_, index, star)
    fightingTowers[#fightingTowers + 1] = fightingTower
end

--[[--
    降低塔星级,塔15技能

    @parm fightingTower 类型：FightingTower

    @return none
]]
function GameData:descendingStars(fightingTower)
    if fightingTower:getTower():getTowerId() == 15 then
        mySp_[1] = mySp_[1] + 80
    end
    fightingTower:starDown() 
end

--[[--
    获取塔原来的位置

    @parm tower 类型：fightingTower

    @return table
]]
function GameData:getTowerIndex(tower)
    return indexTable_[tower:getIndex()]
end

function GameData:enhance(index)
    data_[3] = index
end

--[[--
    塔强化

    @parm index 类型：number, 强化塔的位置

    @return none
]]
function GameData:enhanceTower(index, towers, fightingTowers, enhanceNeedSp, enhanceLevel, sp)
    print("强化".. index)
    if mySp_[1] < enhanceNeedSp[index] or enhanceLevel[index] >= 4 then
        return
    else
        sp[1] = sp[1] - enhanceNeedSp[index]
        enhanceLevel[index] = enhanceLevel[index] + 1
        enhanceNeedSp[index] = ConstDef.ENHANCE_NEED_SP[enhanceLevel[index]]
    end
    local id = towers[index]:getTowerId()
    for i = 1, #towers do
        if towers[i]:getTowerId() == id then
            towers[i]:atkEnhance()
            towers[i]:valueEnhance()
        end
    end
    for i = 1, #fightingTowers do
        if fightingTowers[i]:getTower():getTowerId() == id then
            fightingTowers[i]:getTower():atkEnhance()
            fightingTowers[i]:getTower():valueEnhance()
        end
    end
end

--[[--
    生成小怪

    @parm none

    @return none
]]
function GameData:monster(health)
    local monster = Monster.new(ConstDef.MONSTER_INDEX_X, ConstDef.MONSTER_INDEX_Y, health, 1, 0)
    monsters_[#monsters_ + 1] = monster
end

--[[--
    敌人生成小怪

    @parm none

    @return none
]]
function GameData:enemyMonster(health)
    local enemyMonster = Monster.new(ConstDef.ENEMY_MONSTER_INDEX_X, ConstDef.ENEMY_MONSTER_INDEX_Y, health, 1, 0)
    enemyMonsters_[#enemyMonsters_ + 1] = enemyMonster
end

--[[--
    获得下个boss的id

    @parm none

    @return 类型：number
]]
function GameData:getNextBossId()
    return self.nextBossId_
end

--[[--
    boss生成

    @parm id 类型：number, 区分boss类型

    @return none
]]
function GameData:boss(id)
    self.myBossTimes_ = self.myBossTimes_ + 1
    local health = 0
    for i = 1, #monsters_ do
        health = health + monsters_[i]:getHealth()
    end
    for i = 1, #monsters_ do
        monsters_[i]:destory()
    end
    health = 5000 * self.myBossTimes_ + 0.5 * health
    myBoss_[1] = Monster.new(ConstDef.MONSTER_INDEX_X, ConstDef.MONSTER_INDEX_Y, health, 3, id)
    self:bossSkill(id, fightingTowers_, myTowers_, indexTable_)
end

--[[--
    敌方boss生成

    @parm id 类型：number, 区分boss类型

    @return none
]]
function GameData:enemyBoss(id)
    self.enemyBossTimes_ = self.enemyBossTimes_ + 1
    local health = 0
    for i = 1, #enemyMonsters_ do
        health = health + enemyMonsters_[i]:getHealth()
    end
    for i = 1, #enemyMonsters_ do
        enemyMonsters_[i]:destory()
    end
    health = 5000 * self.enemyBossTimes_ + 0.5 * health
    enemyBoss_[1] = Monster.new(ConstDef.ENEMY_MONSTER_INDEX_X, ConstDef.ENEMY_MONSTER_INDEX_Y, health, 3, id)
    self:bossSkill(id, enemyFightingTowers_, enemyTowers_, enemyIndexTable_)
end

--[[--
    boss技能

    @parm id 类型：number

    @return none
]]
function GameData:bossSkill(id, fightingTowers, towers, indexTable)
    if id == 1 then
        for i = 1, #fightingTowers do
            local index = fightingTowers[i]:getIndex()
            local star = fightingTowers[i]:getStar()
            fightingTowers[i]:destory()
            local indexTower = math.random(1, 5)
            local tower = towers[indexTower]
            local fightingTower = FightingTower.new(tower, indexTable, index, star)
            fightingTowers[#fightingTowers + 1] = fightingTower
        end
    elseif id == 3 then
        for i = 1, #fightingTowers do
            self:descendingStars(fightingTowers[i])
        end
    end
end

--[[--
    获得boss生成剩余时间

    @parm none

    @return string
]]
function GameData:bossTime()
    local time = self.bossTime_ - self.sumTime_
    local f = math.modf(time / 60)
    if f < 10 then
        f = "0"..f
    end
    local s = math.modf(time % 60)
    if s < 10 then
        s = "0"..s
    end
    return tostring(f .. " : " .. s)
end

--[[--
    刷怪

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function GameData:createMonster(dt)
    if #myBoss_ == 0 and #enemyBoss_ == 0 then
        --记录总时间
        self.sumTime_ = self.sumTime_ + dt
        self.time_ = self.time_ + dt
        --更新数量与时间间隔
        if self.monsterNum_ == 0 and self.sumTime_ > self.createMonsterTimeSpacing_ then
            self.monsterNum_ = 4
            self.createMonsterTimeSpacing_ = self.createMonsterTimeSpacing_ + self.createMonsterTime_
            self.time_ = self.createTime_
            self.health_ = self.health_ + self.healthSpacing_
        end

        --刷怪
        if self.monsterNum_ > 0 and self.time_ >= self.createTime_ then
            self.time_ = self.time_ - self.createTime_
            self.monsterNum_ = self.monsterNum_ - 1
            self:monster(self.health_)
            self:enemyMonster(self.health_)
        end
    end

    --阶段更新与boss出现
    if self.sumTime_ > self.bossTime_ then
        if self.stage_ < 4 then
            self.stage_ = self.stage_ + 1
        end
        self.bossTime_ = self.bossTime_ + ConstDef.BOSS_CREATE_TIME[self.stage_]
        --第一阶段做特殊处理
        if self.healthSpacing_ == 100 then
            self.healthSpacing_ = 0
        end
        self.healthSpacing_ = self.healthSpacing_ + 700
        self.health_ = self.healthSpacing_
        self.getSp_ = self.getSp_ + 10

        if #myBoss_ == 0 and #enemyBoss_ == 0 then
            self:boss(self.nextBossId_)
            self:enemyBoss(self.nextBossId_)
        end
    end
end

--[[--
    生成子弹

    @parm fightingTower 类型：fightingTower
    @parm monsters 类型：table，存放怪物
    @parm bullets 类型：table，存放子弹
    @parm spacialMonster 类型：table，存放特殊目标

    @return none
]]
function GameData:createBullet(fightingTower, monsters, bullets, spacialMonster, boss)
    if #boss ~= 0 then
        local bullet = Bullet.new(fightingTower:getX(), fightingTower:getY(),fightingTower,
            boss[1])
            bullets[#bullets + 1] = bullet
        return
    end
    local target = fightingTower:getTower():getAtkTarget()
    if target == "前方" then
        if monsters[1] ~= nil then
            local bullet = Bullet.new(fightingTower:getX(), fightingTower:getY(),fightingTower,
            monsters[1])
            bullets[#bullets + 1] = bullet
        end
    elseif target == "最大血量" then
        if spacialMonster[1] ~= 0 then
            local bullet = Bullet.new(fightingTower:getX(), fightingTower:getY(),fightingTower,
            spacialMonster[1])
            bullets[#bullets + 1] = bullet
        end
    elseif target == "随机敌人" then
        if spacialMonster[2] ~= 0 then
            local bullet = Bullet.new(fightingTower:getX(), fightingTower:getY(),fightingTower,
            spacialMonster[2])
            bullets[#bullets + 1] = bullet
        end
    end
end

--[[
    射击

    @parm dt 类型：number，帧间隔，单位秒
    @parm shootTick 类型：table，存放射击时间间隔
    @parm fightingTower 类型：fightingTower
    @parm monsters 类型：table，存放怪物
    @parm bullets 类型：table，存放子弹
    @parm spacialMonster 类型：table，存放特殊目标

    @return none
]]
function GameData:shoot(dt, shootTick, fightingTower, monsters, bullets, spacialMonster, boss)
    if fightingTower:getCanShoot() == 1 then
        if shootTick[fightingTower] == nil then
            shootTick[fightingTower] = 0
        end
        shootTick[fightingTower] = shootTick[fightingTower] + dt
        local cd = fightingTower:getTower():getTowerFireCd() * fightingTower:getFireCd()/fightingTower:getStar()
        if shootTick[fightingTower] > cd then
            shootTick[fightingTower] = shootTick[fightingTower] - cd
            self:createBullet(fightingTower, monsters, bullets, spacialMonster, boss)
        end
    end
end

--[[--
    子弹碰撞检测

    @parm bullets 类型：Bullet数组
    @parm monster 类型： Monster

    @return none
]]
function GameData:checkCollider(monster, bullets)
    for i = 1, #bullets do
        local bullet = bullets[i]
        if not bullet:isDeath() then
            if monster:isCollider(bullet) then
                self:hitMonster(monster, bullet)
                self:setState(monster, bullet)
                break
            end
        end
    end
end

--[[--
    赋予特殊状态

    @parm bullet 类型：Bullet
    @parm monster 类型： Monster

    @return none
]]
function GameData:setState(monster, bullet)
    --boss4 不受影响
    if monster:getId() == 4 then
        return
    end

    local id = bullet:getId()
    local tower = bullet:getFightingTower()
    local val = bullet:getFightingTower():getTower():getSkill1Value()
    local star =  bullet:getFightingTower():getStar()

    if id == 1 then
        monster:setBurning(1, val)
    elseif id == 2 then
        if star >= #monsters_ - 1 then
            for i = 2 , #monsters_ do
                monsters_[i]:hurt(val)
            end
        else
            for i = 2, star do
                monsters_[i]:hurt(val)
            end
        end
    elseif id == 3 then
        local mark = tower:countShoot()
        if mark % 5 == 0 then
            monster:hurt(val)
        end
    elseif id == 6 then
        if countTower_6_ == 1 then
            monster:hurt(val)
            tower:setFireCd(0.1)
        elseif countTower_6_ == 4 then
            monster:hurt(2 * val)
            tower:setFireCd(0.1)
            tower:setFireCd(0.1)
        elseif countTower_6_ == 9 then
            monster:hurt(3 * val)
            tower:setFireCd(0.1)
            tower:setFireCd(0.1)
            tower:setFireCd(0.1)
        else
            tower:setFireCd(0) -- 重置攻速
        end
    elseif id == 7 then
        local mark = tower:countShoot()
        if mark <= 10 then
            tower:setFireCd(val)
        end
    elseif id == 9 then
        local randomNum = math.random(1, 100)
        if val * 100 > randomNum then
            monster:destory()
        end
    elseif id == 10 then
        monster:setPoisoning(1, val)
    elseif id == 18 then
        monster:setFrail(1, val)
    elseif id == 20 then
        monster:setConfusion(1, val)
    end
end

--[[--
    命中怪物

    @parm monster 类型：Monster，怪物
    @parm bullet 类型：Bullet，子弹

    @return none
]]
function GameData:hitMonster(monster, bullet)
    local hurt = bullet:getHurt()
    local hit = OutGameData:getRatio() / 100
    local hitChange = bullet:getFightingTower():getHitChance() * 100
    local randomNum = math.random(1, 100)
    if randomNum <= hitChange then
        hurt = hurt * hit
    end
    --塔4对boss造成两倍伤害
    if bullet:getId() == 4 and monster:getType() == 3 then
        hurt = 2 * hurt
    end
    bullet:destory()
    monster:hurt(hurt)
    if monster:getHealth() <= 0 then
        local health = monster:getFullhealth()
        if monster:getY() < 700 and monster:getType() == 1 then
            mySp_[1] = mySp_[1] + self.getSp_
            self:enemyMonster(health)
        elseif monster:getType() == 1 then
            enemySp_[1] = enemySp_[1] + self.getSp_
            self:monster(health)
        end
        monster:destory()
    end
end

--[[--
    基地收到攻击

    @parm none

    @return none
]]
function GameData:baseInjured()
    -- 我方
    for i = 1, #monsters_ do
        if monsters_[i]:getX() >= ConstDef.MONSTER_RIGHT
        and monsters_[i]:getY() <= ConstDef.MONSTER_BOTTOM then
            if self.myPoint_ > 0 then
                self.myPoint_ = self.myPoint_ - 1
            end
            monsters_[i]:destory()
            print("1")
            EventManager:doEvent(EventDef.ID.HURT)
        end
    end

    for i = 1, #myBoss_ do
        if myBoss_[i]:getX() >= ConstDef.MONSTER_RIGHT
        and myBoss_[i]:getY() <= ConstDef.MONSTER_BOTTOM then
            if self.myPoint_ > 1 then
                self.myPoint_ = self.myPoint_ - 2
            else
                self.myPoint_ = self.myPoint_ - 1
            end
            myBoss_[i]:destory()
            print("2")
            EventManager:doEvent(EventDef.ID.HURT)
        end
    end

    -- 敌方
    for i = 1, #enemyMonsters_ do
        if enemyMonsters_[i]:getX() <= ConstDef.ENEMY_MONSTER_LEFT
        and enemyMonsters_[i]:getY() >= ConstDef.ENEMY_MONSTER_TOP then
            if self.enemyPoint_ > 1 then
                self.enemyPoint_ = self.enemyPoint_ - 2
            else
                self.enemyPoint_ = self.enemyPoint_ - 1
            end
            enemyMonsters_[i]:destory()
            print("3")
            EventManager:doEvent(EventDef.ID.HURT)
        end
    end

    for i = 1, #enemyBoss_ do
        if enemyBoss_[i]:getX() <= ConstDef.ENEMY_MONSTER_LEFT
        and enemyBoss_[i]:getY() >= ConstDef.ENEMY_MONSTER_TOP then
            if self.enemyPoint_ > 1 then
                self.enemyPoint_ = self.enemyPoint_ - 2
            else
                self.enemyPoint_ = self.enemyPoint_ - 1
            end
            enemyBoss_[i]:destory()
            print("4")
            EventManager:doEvent(EventDef.ID.HURT)
        end
    end
end

--[[--
    记录和销毁怪物

    @param dt 类型：number，帧间隔，单位秒
    @parm monsters 类型：table, 存放怪物
    @parm spacialMonster 类型：table，存放特殊目标
    @parm bullets 类型：table, 存放子弹

    @return none
]]
function GameData:monstersDestory(dt, monsters, spacialMonster, bullets, boss, fightingTowers)
    if #boss ~= 0 then
        self:checkCollider(boss[1], bullets)
    end

    for i = 1, #boss do
        boss[i]:update(dt)
        if boss[i]:isDeath() then
            if boss[i]:getId() == 2 then
                for k = 1, #fightingTowers do
                    if fightingTowers[k]:getCanShoot() == 0 then
                        fightingTowers[k]:setCanShoot(1)
                    end
                end
            end
            table.remove(boss, i)
            if #myBoss_ == 0 and #enemyBoss_ == 0 then
                self.nextBossId_ = math.random(1, 4)
                GameData:setGameState(ConstDef.GAME_STATE.CHOOSE_BOOS)
            end
        end
    end

    local destoryMonsters = {} -- 即将被销毁的怪物

    -- 获取随机的怪的下标
    local index = math.random(1, #monsters)
    local tip = 0 -- 记录是否有特殊怪

    -- 记录即将被销毁的小怪
    for i = 1, #monsters do
        local monster = monsters[i]
        if monster:isDeath() and monster:isSpecial() then
            tip = 1
        end
        monster:update(dt)
        --寻找血量最高的怪
        if spacialMonster[1] == 0 or spacialMonster[1]:getHealth() < monster:getHealth() then
            spacialMonster[1] = monster
        end
        if spacialMonster[2] == 0 and i == index then
            spacialMonster[2] = monster
        end
        if monster:isDeath() then
            --检测血量最高的怪是否死亡
            if spacialMonster[1] ~= 0 and monster == spacialMonster[1] then
                spacialMonster[1] = 0
            end
            --检测随机的怪是否死亡
            if spacialMonster[2] ~= 0 and monster == spacialMonster[2] then
                spacialMonster[2] = 0
            end
            destoryMonsters[#destoryMonsters + 1] = monster
        else
            self:checkCollider(monster, bullets)
        end
    end

    --没有特殊怪，怪物速度恢复
    if tip == 0 then
        for i = 1, #monsters do
            monsters[i]:setSpeed(2)
        end
    end

    -- 销毁小怪
    for i = #destoryMonsters, 1, -1 do
        for j = #monsters, 1, -1 do
            if monsters[j] == destoryMonsters[i] then
                table.remove(monsters, j)
            end
        end
    end

end

--[[--
    记录和销毁子弹

    @param dt 类型：number，帧间隔，单位秒
    @parm bullets 类型：table，子弹数组

    @return none
]]
function GameData:bulletsDestory(dt, bullets)
    local destoryBullets = {} -- 即将被销毁的子弹
    -- 记录即将销毁子弹与子弹刷新
    for i = 1, #bullets do
        local bullet = bullets[i]
        bullet:update(dt)
        if bullet:isDeath() then
            destoryBullets[#destoryBullets + 1] = bullet
        end
    end

    -- 销毁子弹
    for i = #destoryBullets, 1, -1 do
        for j = #bullets, 1, -1 do
            if bullets[j] == destoryBullets[i] then
                table.remove(bullets, j)
            end
        end
    end
end

--[[--
    记录和销毁塔

    @parm fightingTowers 类型：table，塔数组
    @parm shootTick 类型：table，时间间隔数组

    @return none
]]
function GameData:fightingTowerDestory(fightingTowers, shootTick)
    local destoryFightingTowers = {} -- 即将被销毁的塔

    -- 记录即将被销毁塔
    for i = 1, #fightingTowers do
        if fightingTowers[i]:getStar() <= 0 then
            fightingTowers[i]:destory()
        end
        local fightingTower = fightingTowers[i]
        if fightingTower:isDeath() then
            destoryFightingTowers[#destoryFightingTowers + 1] = fightingTower
        end
    end

    -- 销毁塔
    for i = #destoryFightingTowers, 1, -1 do
        for j = #fightingTowers, 1, -1 do
            if fightingTowers[j] == destoryFightingTowers[i] then
                shootTick[fightingTowers[j]] = nil
                table.remove(fightingTowers, j)
            end
        end
    end
end

--[[--
    更新塔的内部计时器，塔5，塔6，塔16，塔19技能
    更新boss内部计时

    @param dt 类型：number，帧间隔，单位秒
    @parm fightingTowers 类型：table，塔数组
    @parm countTower_6 类型：table，敌我双方塔6数量记录，1为我方，2为敌方
    @parm j 类型：number，countTower_6下标
    @parm myTowers 类型：table
    @parm indexTable 类型：table
    @parm monsters 类型：table

    @return none
]]
function GameData:updateFightingTower(dt, fightingTowers, countTower_6, j, myTowers, indexTable, monsters, boss)
    for i = 1, #fightingTowers do
        local id = fightingTowers[i]:getTower():getTowerId()
        -- 变换形态
        if id == 5 then
            local t = fightingTowers[i]:updateTime(dt)
            if t > 6 and fightingTowers[i]:getSta() == 0 then
                fightingTowers[i]:setFireCd(0.1)
                fightingTowers[i]:setSta(1)
            elseif t > 10 and fightingTowers[i]:getSta() == 1 then
                fightingTowers[i]:setHitChance(1)
                fightingTowers[i]:setSta(2)
            elseif t > 11 then
                fightingTowers[i]:updateTime(-11)
                fightingTowers[i]:setFireCd(0)
                fightingTowers[i]:setHitChance(0.05)
                fightingTowers[i]:setSta(0)
            end
        -- 记录塔6数量
        elseif id == 6 then
            countTower_6[j] = countTower_6[j] + 1
        -- 自动升星，本质为合成
        elseif id == 16 then
            local t = fightingTowers[i]:updateTime(dt)
            if t >= 15 then
                fightingTowers[i]:updateTime(-15)
                local index = fightingTowers[i]:getIndex()
                table.insert(indexs_, index)
                fightingTowers[i]:destory()
                local star = fightingTowers[i]:getStar() + 1
                local indexTower = math.random(1, 5)
                local tower = myTowers[indexTower]
                local fightingTower = FightingTower.new(tower, indexTable, index, star)
                fightingTowers[#fightingTowers + 1] = fightingTower
            end
        -- 减速敌人，减速效果永久
        elseif id == 19 then
            local t = fightingTowers[i]:updateTime(dt)
            if t > 10 then
                fightingTowers[i]:updateTime(-10)
                local val = fightingTowers[i]:getTower():getSkill1Value()
                for k = 1, #monsters do
                    monsters[k]:setDecelerate(1, val)
                end
            end
        end
    end

    for i = 1, #boss do
        if boss[i]:getId() == 2 then
            local time = boss[i]:updateTime(dt)
            if time > 7 then
                boss[i]:updateTime(-7)
                local count = 0
                for k = 1, #fightingTowers do
                    if fightingTowers[k]:getCanShoot() == 1 then
                        fightingTowers[k]:setCanShoot(0)
                        count = count + 1
                        if count == 2 then
                            break
                        end
                    end
                end
            end
        elseif boss[i]:getId() == 3 then
            local time = boss[i]:updateTime(dt)
            if time > 1 then
                boss[i]:setSpeed(1)
            end
            if time > 2 then
                boss[i]:setSpeed(2)
                boss[i]:updateTime(-2)
            end
        elseif boss[i]:getId() == 4 then
            if boss[i]:getHealth() < boss[i]:getFullhealth() * 3 / 4 and boss[i]:getNum() == 0 then
                local time = boss[i]:updateTime(dt)
                if time > 0.5 then
                    boss[i]:updateTime(-0.5)
                    self:boss4(j)
                    num_[j] = num_[j] + 1
                    if num_[j] == 3 then
                        boss[i]:setNum(1)
                    end
                end
            elseif boss[i]:getHealth() < boss[i]:getFullhealth() * 2 / 4 and boss[i]:getNum() == 1 then
                local time = boss[i]:updateTime(dt)
                if time > 0.5 then
                    boss[i]:updateTime(-0.5)
                    self:boss4(j)
                    num_[j] = num_[j]+ 1
                    if num_[j]== 6 then
                        boss[i]:setNum(2)
                    end
                end
            elseif boss[i]:getHealth() < boss[i]:getFullhealth() * 1 / 4 and boss[i]:getNum() == 2 then
                local time = boss[i]:updateTime(dt)
                if time > 0.5 then
                    boss[i]:updateTime(-0.5)
                    self:boss4(j)
                    num_[j] = num_[j] + 1
                    if num_[j] == 9 then
                        boss[i]:setNum(3)
                        num_[j] = 0
                    end
                end
            end
        end
    end
end

--[[--
    boss4 技能

    @parm j 类型：number

    @return none
]]
function GameData:boss4(j)
    if j == 1 then
        self:monster(self.health_)
    elseif j == 2 then
        self:enemyMonster(self.health_)
    end
end


--[[--
    帧刷新

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function GameData:update(dt)
    self.time_ = self.time_ + dt

    -- 刷怪
    self:createMonster(dt)

    -- 基地受伤检测
    self:baseInjured()

    -- 敌方生成塔(单机)
    self:createTower(enemyTowers_, enemyIndexTable_, enemyIndexs_, enemyFightingTowers_, enemySp_)

    -- 记录和销毁怪物
    self:monstersDestory(dt, monsters_, spacialMonster_, bullets_, myBoss_, fightingTowers_) -- 我方
    self:monstersDestory(dt, enemyMonsters_, enemySpacialMonster_, enemyBullets_, enemyBoss_, enemyFightingTowers_) -- 敌方

    -- 记录和销毁子弹
    self:bulletsDestory(dt, bullets_) -- 我方
    self:bulletsDestory(dt, enemyBullets_) -- 敌方

    -- 记录和销毁塔
    self:fightingTowerDestory(fightingTowers_, shootTick_) -- 我方
    self:fightingTowerDestory(enemyFightingTowers_, enemyShootTick_) -- 敌方

    -- 更新塔的内部计时器，塔5，塔6，塔16，塔19技能
    -- 我方
    self:updateFightingTower(dt, fightingTowers_, countTower_6_, 1, myTowers_, indexTable_, monsters_, myBoss_)
    -- 敌方
    self:updateFightingTower(dt, enemyFightingTowers_, countTower_6_, 2, enemyTowers_,
    enemyIndexTable_, enemyMonsters_, enemyBoss_)

    -- 塔射击
    for i = 1, #fightingTowers_ do -- 我方
        self:shoot(dt, shootTick_, fightingTowers_[i], monsters_, bullets_, spacialMonster_, myBoss_)
    end
    for i = 1, #enemyFightingTowers_ do -- 敌方
        self:shoot(dt, enemyShootTick_, enemyFightingTowers_[i], enemyMonsters_, enemyBullets_,
        enemySpacialMonster_, enemyBoss_)
    end

    --[[
        联机

        上传
        f(data_)
        f(enemyData_)

        下载
        data_ = f()
        enemyData_ = f()
    ]]

    --我方操作(联机)
    if data_[1] == 1 then
        self:createTower(myTowers_, indexTable_, indexs_, fightingTowers_, mySp_)
    end
    if data_[2][1] ~= 0 then
        self:mergingFightingTower(data_[2][1], data_[2][2], myTowers_, fightingTowers_, 1, enemyMonsters_,
        enemyFightingTowers_, mySp_, indexs_)
    end
    if data_[3] ~= 0 then
        self:enhanceTower(data_[3], myTowers_, fightingTowers_, enhanceNeedSp_, enhanceLevel_, mySp_)
    end
    if data_[4] == 1 then
        data_[4] = 0 -- 认输
        self:setGameState(ConstDef.GAME_STATE.SETTLEMENT_DEFEAT)
    elseif data_[4] == 2 then
        data_[4] = 0 -- 认输
        self:setGameState(ConstDef.GAME_STATE.SETTLEMENT_VICTORY)
    end

    --敌方操作(联机)
    if enemyData_[1] == 1 then
        self:createTower(enemyTowers_, enemyIndexTable_, enemyIndexs_, enemyFightingTowers_, enemySp_)
    end
    if enemyData_[2][1] ~= 0 then
        self:mergingFightingTower(enemyData_[2][1], enemyData_[2][2], enemyTowers_, enemyFightingTowers_, 2, monsters_,
        fightingTowers_, enemySp_, enemyIndexs_)
    end
    if enemyData_[3] ~= 0 then
        self:enhanceTower(enemyData_[3], enemyTowers_, enemyFightingTowers_, enemyEnhanceNeedSp_, enemyEnhanceLevel_,
        enemySp_)
    end
    if enemyData_[4] == 1 then
        enemyData_[4] = 0 -- 认输
        self:setGameState(ConstDef.GAME_STATE.SETTLEMENT_VICTORY)
    elseif enemyData_[4] == 2 then
        enemyData_[4] = 0 -- 认输
        self:setGameState(ConstDef.GAME_STATE.SETTLEMENT_DEFEAT)
    end

    data_[1] = 0 -- 生成
    data_[2] = {0, 0} -- 融合
    data_[3] = 0 -- 强化

    enemyData_[1] = 0 -- 生成
    enemyData_[2] = {0, 0} -- 融合
    enemyData_[3] = 0 -- 强化


end

return GameData