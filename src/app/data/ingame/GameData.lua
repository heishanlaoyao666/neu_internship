--[[--
    GameData.lua
    游戏战斗战斗数据
]]

local GameData = {}

--local OutGameData = require("app.data.outgame.OutGameData.lua")
local Tower = require("app.data.outgame.Tower")
local FightingTower = require("app.data.ingame.FightingTower")
local Monster = require("app.data.ingame.Monster")
local Bullet = require("app.data.ingame.Bullet")
local ConstDef = require("app.def.ingame.ConstDef")

local myTowers_ = {} -- 我阵容的塔
local enemyTowers_ = {} -- 敌方阵容的塔
local indexTable_ = {} -- 塔的位置
local indexs_ = {} -- 塔有可能生成的下标
local monsters_ = {} --小怪
local eliteMonsters_ = {} -- 精英怪
local fightingTowers_ = {} -- 塔数组
local bullets_ = {} -- 子弹数组
local shootTick_ = {} -- 记录射击时间间隔

local enhanceNeedSp_ = {} -- 塔强化需要的sp
local enhanceLevel_ = {} -- 塔强化的等级


function GameData:init()
    self.sumTime_ = 0 -- 记录总时间
    self.time_ = 0 -- 记录上传刷怪时间
    self.creatTime_ =1 -- 刷怪的时间间隔
    self.creatMonsterTimeSpacing_ = 10 -- 记录间隔时间
    self.creatMonsterTime_ = 10 -- 刷怪波数间隔
    self.bossTime_ = ConstDef.BOSS_CREAT_TIME[1] -- boss出现时间记录
    self.health_ = 100 -- 怪物血量
    self.healthSpacing_ = 100 -- 血量间距
    self.monsterNum_ = 2 -- 一开始刷怪的数量
    self.stage_ = 1 -- 阶段

    self.myPoint_ = 3 -- 我的血量
    self.enemypoint_ = 3 -- 敌人的血量

    self.sumSp_ = 1000 -- 总的sp
    self.needSp_ = 10 -- 生成塔需要的sp
    self.getSp_ = 10 -- 杀死敌人可以获得的sp

    self.maxHealthMonster_ = nil -- 最高血量的敌人
    self.randomMonster_ = nil -- 随机选择的敌人

    indexTable_ = {{160, 528}, {260, 528}, {359, 528}, {458, 528}, {556, 528},
                   {160, 431}, {260, 431}, {359, 431}, {458, 431}, {556, 431},
                   {160, 338}, {260, 338}, {359, 338}, {458, 338}, {556, 338}}
    indexs_ = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11 ,12 , 13, 14, 15}

    for i = 1, 5 do
        enhanceNeedSp_[i] = ConstDef.ENHANCE_NEED_SP[1]
        enhanceLevel_[i] = 1
    end
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

    @return self.enemypoint_, 类型：number
]]
function GameData:getEnemyPoint()
    return self.enemypoint_
end

--[[--
    获取总的sp数

    @parm none

    @return self.sumSp_, 类型：number
]]
function GameData:getSumSp()
    return self.sumSp_
end

--[[--
    增加总的sp数

    @parm n, 类型：number

    @return none
]]
function GameData:addSumSp(n)
    self.sumSp_ = self.sumSp_ + n
end

--[[--
    获取生成塔需要的sp

    @parm none

    @return self.needSp_, 类型：number
]]
function GameData:getNeedSp()
    return self.needSp_
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
    随机生成塔

    @parm none

    @return none
]]
function GameData:generateTower()
    if self.sumSp_ > self.needSp_ then
        self.sumSp_ = self.sumSp_ - self.needSp_
        self.needSp_ = self.needSp_ + 10
    end
end

--[[--
    获取我方塔的阵容

    @parm none

    @return myTowers_, 类型：table
]]
function GameData:getMyTowers()
    local tower_1 = Tower.new(1, 1, 1, "tower_1", "使被攻击目标得到“灼烧”状态。灼烧：造成两次额外伤害。",
    "前方", 20, 3, 10, 0.8, 0.01, "额外伤害",4,20, 3, 20, nil,nil,nil)
    local tower_2 = Tower.new(2, 3, 1, "tower_2", "使星级数个怪物受到伤害。",
    "前方", 20, 5, 10, 0.8, nil, "额外伤害",4,50, 4, 40, nil,nil,nil)
    local tower_3 = Tower.new(3, 2, 1, "tower_3","使星级数个怪物受到伤害。",
    "前方", 40, 8, 20, 0.8, 0.01, "额外伤害",4 ,120, 24, 40, nil,nil, nil)
    local tower_4 = Tower.new(4, 1, 1, "tower_4","攻击生命值最高的怪物,对BOSS造成双倍伤害。",
    "最大血量", 100, 10, 100, 1, nil, nil,nil, nil, nil, nil, nil,nil, nil)
    local tower_5 = Tower.new(5, 4, 1, "tower_5","每隔一段时间可以在三个形态之间切换，二形态攻速大幅度加强，三形态攻击必定暴击。",
    "前方", 20, 3, 30, 0.6, nil, "初次变身时间", 3,6, nil, nil, "二次变身时间",5,4)

    myTowers_ = {tower_1, tower_2, tower_3, tower_4, tower_5}
    return myTowers_
end

--[[--
    获取敌方塔的阵容

    @parm none

    @return 类型：table
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

    @parm none

    @return none
]]
function GameData:creatTower()
    if #indexs_ ~= 0 and self.sumSp_ >= self.needSp_ then
        math.randomseed(os.time())
        local indexTower = math.random(1, 5)
        local tower = myTowers_[indexTower]
        local index = math.random(1, #indexs_)
        local fightingTower = FightingTower.new(tower, indexTable_, indexs_[index], 1)
        table.remove(indexs_, index)
        fightingTowers_[#fightingTowers_ + 1] = fightingTower
        self.sumSp_ = self.sumSp_ - self.needSp_
        self.needSp_ = self.needSp_ + 10
    end
end

--[[--
    获取该位置的塔

    @parm x 类型：number
    @parm y 类型：number

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

    @return boolean
]]
function GameData:isValidTouch(tower, x, y)
    return tower:isContain(x, y)
end

--[[--
    移动我方塔

    @parm x 类型：number
    @parm y 类型：number
    @parm tower 类型：object

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
    融合塔

    @parm tower1 类型：FightingTower
    @parm tower2 类型：FightingTower

    @return none
]]
function GameData:mergingFightingTower(tower1, tower2)
    local index = tower1:getIndex()
    table.insert(indexs_, index)
    tower1:destory()
    index = tower2:getIndex()
    local star = tower2:getStar() + 1
    tower2:destory()
    math.randomseed(os.time())
    local indexTower = math.random(1, 5)
    local tower = myTowers_[indexTower]
    local fightingTower = FightingTower.new(tower, indexTable_, index, star)
    fightingTowers_[#fightingTowers_ + 1] = fightingTower
end

--[[--
    获取塔原来的位置

    @parm tower 类型：fightingTower

    @return table
]]
function GameData:getTowerIndex(tower)
    return indexTable_[tower:getIndex()]
end

--[[--
    生成小怪

    @parm none

    @return none
]]
function GameData:monster()
    local monster = Monster.new(self.health_, 1)
    monsters_[#monsters_ + 1] = monster
end

--[[--
    刷怪

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function GameData:creatMonster(dt)
    --记录总时间
    self.sumTime_ = self.sumTime_ + dt
    self.time_ = self.time_ + dt

    --更新数量与时间间隔
    if self.monsterNum_ == 0 and self.sumTime_ > self.creatMonsterTimeSpacing_ then
        self.monsterNum_ = 4
        self.creatMonsterTimeSpacing_ = self.creatMonsterTimeSpacing_ + self.creatMonsterTime_
        self.time_ = self.creatTime_
        self.health_ = self.health_ + self.healthSpacing_
    end

    --刷怪
    if self.monsterNum_ > 0 and self.time_ >= self.creatTime_ then
        self.time_ = self.time_ - self.creatTime_
        self.monsterNum_ = self.monsterNum_ - 1
        self:monster()
    end

    --阶段更新
    if self.sumTime_ > self.bossTime_ then
        if self.stage_ < 4 then
            self.stage_ = self.stage_ + 1
        end
        self.bossTime_ = self.bossTime_ + ConstDef.BOSS_CREAT_TIME[self.stage_]
        --第一阶段做特殊处理
        if self.healthSpacing_ == 100 then
            self.healthSpacing_ = 0
        end
        self.healthSpacing_ = self.healthSpacing_ + 700
        self.health_ = self.healthSpacing_
        self.getSp_ = self.getSp_ + 10
    end
end

--[[--
    生成精英怪

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function GameData:creatEliteMonster(dt)
    local eliteMonsters = Monster.new(100, 2)
    eliteMonsters_[#eliteMonsters_ + 1] = eliteMonsters
end

--[[--
    生成子弹

    @parm fightingTower 类型：fightingTower

    @return none
]]
function GameData:creatBullet(fightingTower)
    local target = fightingTower:getTower():getAtkTarget()
    if target == "前方" then
        if monsters_[1] ~= nil then
            local bullet = Bullet.new(fightingTower:getX(), fightingTower:getY(),fightingTower,
            monsters_[1])
            bullets_[#bullets_ + 1] = bullet
        end
    elseif target == "最大血量" then
        if self.maxHealthMonster_ ~= nil then
            local bullet = Bullet.new(fightingTower:getX(), fightingTower:getY(),fightingTower,
            self.maxHealthMonster_)
            bullets_[#bullets_ + 1] = bullet
        end
    elseif target == "随机敌人" then
        if self.randomMonster_ ~= nil then
            local bullet = Bullet.new(fightingTower:getX(), fightingTower:getY(),fightingTower,
            self.randomMonster_)
            bullets_[#bullets_ + 1] = bullet
        end
    end
end

--[[
    射击

    @param dt 类型：number，帧间隔，单位秒
    @parm fightingTower 类型：fightingTower， 发射的塔

    @return none
]]
function GameData:shoot(dt, fightingTower)
    if shootTick_[fightingTower] == nil then
        shootTick_[fightingTower] = 0
    end
    shootTick_[fightingTower] = shootTick_[fightingTower] + dt
    local cd = fightingTower:getTower():getTowerFireCd()/fightingTower:getStar()
    if shootTick_[fightingTower] > cd then
        shootTick_[fightingTower] = shootTick_[fightingTower] - cd

        self:creatBullet(fightingTower)
    end
end

--[[--
    子弹碰撞检测

    @param bullets 类型：Bullet数组
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

    @param bullet 类型：Bullet
    @parm monster 类型： Monster

    @return none
]]
function GameData:setState(monster, bullet)
    local id = bullet:getId()
    local val = bullet:getFightingTower():getTower():getSkill1Value()
    if id == 1 then
        monster:setBurning(1, val)
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

    @param monster 类型：Monster，怪物
    @param bullet 类型：Bullet，子弹

    @return none
]]
function GameData:hitMonster(monster, bullet)
    bullet:destory()
    monster:hurt(bullet:getHurt())
    if monster:getHealth() <= 0 then
        monster:destory()
        self.sumSp_ = self.sumSp_ + self.getSp_
    end
end

--[[--
    基地收到攻击

    @parm none

    @return none
]]
function GameData:baseInjured()
    for i = 1, #monsters_ do
        if monsters_[i]:getX() >= ConstDef.MONSTER_RIGHT and monsters_[i]:getY() <= ConstDef.MONSTER_BOTTOM then
            if self.myPoint_ > 0 then
                self.myPoint_ = self.myPoint_ - 1
            end
            monsters_[i]:destory()
        end
    end
end

--[[--
    塔强化

    @parm index 类型：number, 强化塔的位置

    @return none
]]
function GameData:enhance(index)
    if self.sumSp_ < enhanceNeedSp_[index] or enhanceLevel_[index] >= 4 then
        return
    else
        self.sumSp_ = self.sumSp_ - enhanceNeedSp_[index]
        enhanceLevel_[index] = enhanceLevel_[index] + 1
        enhanceNeedSp_[index] = ConstDef.ENHANCE_NEED_SP[enhanceLevel_[index]]
    end
    local id = myTowers_[index]:getTowerId()
    for i = 1, #myTowers_ do
        if myTowers_[i]:getTowerId() == id then
            myTowers_[i]:atkEnhance()
            myTowers_[i]:valueEnhance()
        end
    end
    for i = 1, #fightingTowers_ do
        if fightingTowers_[i]:getTower():getTowerId() == id then
            fightingTowers_[i]:getTower():atkEnhance()
            fightingTowers_[i]:getTower():valueEnhance()
        end
    end
end

--[[--
    帧刷新

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function GameData:update(dt)
    local destoryFightingTowers = {} -- 即将被销毁的塔
    local destoryBullets = {} -- 即将被销毁的子弹
    local destoryMonsters = {} -- 即将被销毁的怪物

    self.time_ = self.time_ + dt

    --刷怪
    self:creatMonster(dt)

    --基地受伤检测
    self:baseInjured()

    --射击
    for i = 1, #fightingTowers_ do
        self:shoot(dt, fightingTowers_[i])
    end

    --记录即将被销毁塔
    for i = 1, #fightingTowers_ do
        local fightingTower = fightingTowers_[i]
        if fightingTower:isDeath() then
            destoryFightingTowers[#destoryFightingTowers + 1] = fightingTower
        end
    end

    --销毁塔
    for i = #destoryFightingTowers, 1, -1 do
        for j = #fightingTowers_, 1, -1 do
            if fightingTowers_[j] == destoryFightingTowers[i] then
                shootTick_[fightingTowers_[j]] = nil
                table.remove(fightingTowers_, j)
            end
        end
    end

    --获取随机的怪
    math.randomseed(os.time())
    if self.randomMonster_ == nil then
        self.randomMonster_ = monsters_[math.random(1, #monsters_)]
    end

    --记录即将被销毁的小怪
    for i = 1, #monsters_ do
        local monster = monsters_[i]
        monster:update(dt)
        --寻找血量最高的怪
        if self.maxHealthMonster_ == nil or self.maxHealthMonster_:getHealth() < monster:getHealth() then
            self.maxHealthMonster_ = monster
        end
        if monster:isDeath() then
            destoryMonsters[#destoryMonsters + 1] = monster
            --检测血量最高的怪是否死亡
            if monster == self.maxHealthMonster_ then
                self.maxHealthMonster_ = nil
            end
            --检测随机的怪是否死亡
            if monster == self.randomMonster_ then
                self.randomMonster_ = nil
            end
        else
            self:checkCollider(monster, bullets_)
        end
    end

    --销毁小怪
    for i = #destoryMonsters, 1, -1 do
        for j = #monsters_, 1, -1 do
            if monsters_[j] == destoryMonsters[i] then
                table.remove(monsters_, j)
            end
        end
    end

    --精英怪刷新
    for i = 1, #eliteMonsters_ do
        eliteMonsters_[i]:update(dt)
    end

    --记录即将销毁子弹与子弹刷新
    for i = 1, #bullets_ do
        local bullet = bullets_[i]
        bullet:update(dt)
        if bullet:isDeath() then
            destoryBullets[#destoryBullets + 1] = bullet
        end
    end

    --销毁子弹
    for i = #destoryBullets, 1, -1 do
        for j = #bullets_, 1, -1 do
            if bullets_[j] == destoryBullets[i] then
                table.remove(bullets_, j)
            end
        end
    end
end

return GameData