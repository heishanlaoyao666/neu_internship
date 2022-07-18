--[[--
    UserInfo.lua

    描述：玩家信息数据类
]]
local UserInfo = {}
local SendAck = require("server.SendAck")
local MsgDef = require("app.def.MsgDef")
local Log = require("app.util.Log")
local scheduler = require("framework.scheduler")

-- TODO 临时数据，仅默认玩家
UserInfo.userId_ = 10086
UserInfo.nickname_ = "黑山老妖"
UserInfo.trophy_ = 100
UserInfo.gold_ = 99999
UserInfo.diamond_ = 9999

UserInfo.spCount_ = 90000
UserInfo.spCost_ = 100

-- 塔的场地，一维数据，对应坐上至右下的15个塔位置，数组地址序号对应位置，其中的元素对应塔的id，0为无塔
UserInfo.fields_ = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, }

-- 塔数据，key为对象id，value为塔的具体数据，等级之类
UserInfo.towerMap_ = {}

-- 敌人数据，key为对象id，value为敌人具体数据，血量、状态之类
UserInfo.enemyMap_ = {}
UserInfo.enemyCount_ = 0
UserInfo.enemyGenCount_ = 10
UserInfo.enemyGenTime_ = 0
UserInfo.enemyGenGap_ = 0

-- 子弹数据
UserInfo.bulletMap_ = {} 

-- 获取运行时对象唯一标识
local id = 0 -- 对象id，运行时生成
function UserInfo.getId()
    id = id + 1
    if id > 99999999 then
        id = 1
    end

    return id
end

-- 获取随机塔位置
function UserInfo.getRandomPos()
    local leftFields = {}
    for i = 1, #UserInfo.fields_ do
        if UserInfo.fields_[i] == 0 then
            leftFields[#leftFields + 1] = i
        end
    end

    if #leftFields > 1 then
        return leftFields[math.random(1, #leftFields)]
    elseif #leftFields == 1 then
        return leftFields[1]
    else
        return 0
    end
end

-- 创建新塔
function UserInfo.genTower(pos)
    local id = UserInfo.getId()

    local tower = {
        id = id,
        towerId = 1, -- TODO 简单起见，生成1种
        pos = pos,
        level = 1, -- TODO
        fireTime = 0, -- TODO 简单处理，发射子弹的间隔
    }

    UserInfo.fields_[pos] = id
    UserInfo.towerMap_[id] = tower

    return tower
end

-- 创建敌人
function UserInfo.genEnemy()
    local id = UserInfo.getId()

    local enemy = {
        id = id,
        enemyId = 0, -- 小怪类型
        blood = 100, -- 血量
        speed = 6, -- 1单位/秒，每秒移动1个单位，总长度100，也即怪物从起点到终点需要100秒
        mile = 0, -- 已走过的历程，最大100，100即终点
    }

    UserInfo.enemyMap_[id] = enemy
    UserInfo.enemyCount_ = UserInfo.enemyCount_ + 1
    UserInfo.enemyGenCount_ = UserInfo.enemyGenCount_ - 1

    return enemy
end

-- 移除敌人
function UserInfo.delEnemy(id)
    UserInfo.enemyMap_[id] = nil
    UserInfo.enemyCount_ = UserInfo.enemyCount_ - 1
end

-- 发射子弹，注意，此处的id是对象id
function UserInfo.genBullet(towerId)
    local enemyIds = {}
    for enemyId, _ in pairs(UserInfo.enemyMap_) do
        enemyIds[#enemyIds + 1] = enemyId
    end

    if #enemyIds > 0 then
        local enemyId = enemyIds[math.random(1, #enemyIds)]
        local id = UserInfo.getId()
        local bullet = {
            id = id,
            bulletId = 1,
            towerId = towerId,
            enemyId = enemyId,
        }

        UserInfo.bulletMap_[id] = bullet

        return bullet
    else
        return nil
    end
end

-- 子弹命中敌人
function UserInfo.buletHit(buletId, enemyId)
    if not UserInfo.bulletMap_[buletId] then
        Log.e("bullet not exist, bulletId=", bulletId)
        return
    end

    UserInfo.bulletMap_[buletId] = nil

    local enemy = UserInfo.enemyMap_[enemyId]
    if not enemy then
        Log.e("enemy not exist, enemyId=", enemyId)
        return
    end

    enemy.blood = enemy.blood - 100
end

-- 帧刷新
local FIRE_THRESHOLD = 1 -- 发射子弹的阈值，单位：秒
function UserInfo.onUpdate(dt)
    -- 此处简单处理，500ms发射一次子弹
    local newBullets = {}
    for id, tower in pairs(UserInfo.towerMap_) do
        tower.fireTime = tower.fireTime + dt
        if tower.fireTime > FIRE_THRESHOLD then
            tower.fireTime = 0
            local bullet = UserInfo.genBullet(id)
            if bullet then
                newBullets[#newBullets + 1] = bullet
            end
        end
    end

    -- 通知客户端新增子弹
    if #newBullets > 0 then
        SendAck:send({
            type = MsgDef.ACK.GAME_BULLET_ADD,
            userId = UserInfo.userId_,

            newBullets = newBullets,
        })
    end

    -- 敌人移动处理
    local delEnemyIds = {}
    local syncEnemys = {}
    for id, enemy in pairs(UserInfo.enemyMap_) do
        enemy.mile = enemy.mile + enemy.speed * dt

        local isDead = false
        if enemy.mile >= 100 then
            -- 检查跑过终点
            delEnemyIds[#delEnemyIds + 1] = id
            isDead = true
        end

        if enemy.blood <= 0 then
            -- 检查血量
            delEnemyIds[#delEnemyIds + 1] = id
            isDead = true
        end

        if not isDead then
            syncEnemys[#syncEnemys + 1] = enemy
        end
    end

    -- 通知客户端清理敌人
    if #delEnemyIds > 0 then
        SendAck:send({
            type = MsgDef.ACK.GAME_ENEMY_DEAD,
            userId = UserInfo.userId_,

            delEnemyIds = delEnemyIds,
        })

        -- 清理死亡的敌人
        for i = 1, #delEnemyIds do
            UserInfo.delEnemy(delEnemyIds[i])
        end
    end

    -- 同步敌人位置
    if #syncEnemys > 0 then
        SendAck:send({
            type = MsgDef.ACK.GAME_ENEMY_SYNC,
            userId = UserInfo.userId_,

            syncEnemys = syncEnemys,
        })
    end

    -- 生成新的敌人，3秒后开始生成敌人
    UserInfo.enemyGenTime_ = UserInfo.enemyGenTime_ + dt
    UserInfo.enemyGenGap_ = UserInfo.enemyGenGap_ + dt
    if UserInfo.enemyGenTime_ > 2 and 
        UserInfo.enemyGenCount_ > 0 and 
        UserInfo.enemyGenGap_ > 0.8 then

        UserInfo.enemyGenGap_ = 0

        local enemy = UserInfo.genEnemy()
        SendAck:send({
            type = MsgDef.ACK.GAME_ENEMY_GENERAGE,
            userId = UserInfo.userId_,

            enemy = enemy,
        })
    end

    -- 检查结束
    if UserInfo.enemyCount_ <= 0 and UserInfo.enemyGenCount_ <= 0 then
        UserInfo.gameStop()
        SendAck:send({
            type = MsgDef.ACK.GAME_RESULT,
            userId = UserInfo.userId_,

            winUserId = UserInfo.userId_,
        })
    end
end

-- 游戏开始
local updateHandle_
function UserInfo.gameStart()
    Log.i()

    -- 重置数据
    UserInfo.spCount_ = 90000
    UserInfo.spCost_ = 100
    UserInfo.fields_ = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, }
    UserInfo.towerMap_ = {}
    UserInfo.enemyMap_ = {}
    UserInfo.enemyCount_ = 0
    UserInfo.enemyGenCount_ = 10
    UserInfo.enemyGenTime_ = 0
    UserInfo.enemyGenGap_ = 0

    if not updateHandle_ then
        -- 不需要每帧都刷新，50ms刷一次即可
        updateHandle_ = scheduler.scheduleGlobal(function(dt)
            UserInfo.onUpdate(dt)
        end, 0.1)
    end
end

-- 游戏结束
function UserInfo.gameStop()
    Log.i()
    if updateHandle_ then
        scheduler.unscheduleGlobal(updateHandle_)
        updateHandle_ = nil
    end
end

return UserInfo