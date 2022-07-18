--[[--
    MsgController.lua

    描述：消息处理器，存储数据
]]
local MsgController = {}
local GameDef = require("app.def.GameDef")
local MsgDef = require("app.def.MsgDef")
local UserInfo = require("app.data.UserInfo")
local ShopData = require("app.data.ShopData")
local GameData = require("app.data.GameData")
local Tower = require("app.model.Tower")
local Bullet = require("app.model.Bullet")
local Enemy = require("app.model.Enemy")
local Log = require("app.util.Log")

local funcMap_ = {} -- 类型：table，消息处理数据，key为消息id，value为function

---------------------------------------------------------------------------
-- 私有函数定义
---------------------------------------------------------------------------
local _init
local _handleAccountInfoAck
local _handleShopInfoAck
local _handleShopRefreshFreeAck
local _handleShopBuyGoodsAck
local _handleMatchSignupAck
local _handleMatchStartAck
local _handleGameInitAck
local _handleGameTowerGenerateAck
local _handleGameTowerComposeAck
local _handleGameTowerUpgradeAck
local _handleGameEnemyGenerateAck
local _handleGameEnemySyncAck
local _handleGameEnemyDeadAck
local _handleGameBulletAddAck
local _handleGameGiveupAck
local _handleGameResultAck

--[[--
    描述：消息处理入口

    @param msg 类型：table，消息

    @return none
]]
function MsgController:handleMsg(msg)
    if not isTable(msg) then
        Log.e("unexpect param, msg=", msg)
        return
    end

    local msgType = msg[MsgDef.KEY.TYPE]
    local func = funcMap_[msgType]
    if func then
        func(msg)
    end
end

---------------------------------------------------------------------------
-- 私有函数实现
---------------------------------------------------------------------------

--[[
    描述：初始化
    
    @param none
    
    @return none
]]
function _init()
    funcMap_[MsgDef.ACK.ACCOUNT_INFO] = _handleAccountInfoAck

    funcMap_[MsgDef.ACK.SHOP_INFO] = _handleShopInfoAck
    funcMap_[MsgDef.ACK.SHOP_REFRESH_FREE] = _handleShopRefreshFreeAck
    funcMap_[MsgDef.ACK.SHOP_BUY_GOODS] = _handleShopBuyGoodsAck

    funcMap_[MsgDef.ACK.MATCH_SIGNUP] = _handleMatchSignupAck
    funcMap_[MsgDef.ACK.MATCH_START] = _handleMatchStartAck

    funcMap_[MsgDef.ACK.GAME_INIT] = _handleGameInitAck
    funcMap_[MsgDef.ACK.GAME_TOWER_GENERATE] = _handleGameTowerGenerateAck
    funcMap_[MsgDef.ACK.GAME_TOWER_COMPOSE] = _handleGameTowerComposeAck
    funcMap_[MsgDef.ACK.GAME_TOWER_UPGRADE] = _handleGameTowerUpgradeAck
    funcMap_[MsgDef.ACK.GAME_ENEMY_GENERAGE] = _handleGameEnemyGenerateAck
    funcMap_[MsgDef.ACK.GAME_ENEMY_SYNC] = _handleGameEnemySyncAck
    funcMap_[MsgDef.ACK.GAME_ENEMY_DEAD] = _handleGameEnemyDeadAck
    funcMap_[MsgDef.ACK.GAME_BULLET_ADD] = _handleGameBulletAddAck
    funcMap_[MsgDef.ACK.GAME_GIVEUP] = _handleGameGiveupAck
    funcMap_[MsgDef.ACK.GAME_RESULT] = _handleGameResultAck
end

--[[
    描述：处理账户信息推送消息

    @param ack 类型：table，消息数据

    @return none
]]
function _handleAccountInfoAck(ack)
    -- 数据并不一定每次都存在，可能是部分刷新，需要判空
    UserInfo.userId_ = tonumber(ack["userId"]) or userId_
    UserInfo.nickname_ = tostring(ack["nickname"]) or nickname_
    UserInfo.trophy_ = tonumber(ack["trophy"]) or trophy_
    UserInfo.gold_ = tonumber(ack["gold"]) or gold_
    UserInfo.diamond_ = tonumber(ack["diamond"]) or diamond_
end

--[[
    描述：处理商城信息消息

    @param ack 类型：table，消息数据

    @return none
]]
function _handleShopInfoAck(ack)
    Log.d()
end

--[[
    描述：处理商城免费商品刷新消息

    @param ack 类型：table，消息数据

    @return none
]]
function _handleShopRefreshFreeAck(ack)
    Log.d()
end

--[[
    描述：处理商城购买商品消息

    @param ack 类型：table，消息数据

    @return none
]]
function _handleShopBuyGoodsAck(ack)
    Log.d()
end

--[[
    描述：处理报名比赛消息

    @param ack 类型：table，消息数据

    @return none
]]
function _handleMatchSignupAck()
    Log.d()
end

--[[
    描述：处理比赛开始消息

    @param ack 类型：table，消息数据

    @return none
]]
function _handleMatchStartAck(ack)
    Log.d()
end

--[[
    描述：处理（游戏内）游戏初始化消息

    @param ack 类型：table，消息数据

    @return none
]]
function _handleGameInitAck(ack)
    GameData:initGame()

    local playerInfos = ack["playerInfos"]
    for i = 1, #playerInfos do
        local info = playerInfos[i]
        if info.userId == UserInfo.userId_ then
            -- 我的信息
            GameData.selfInfo_.spCount = info.spCount
            GameData.selfInfo_.spCost = info.spCost
        else
            -- 对手的信息
            GameData.opponentInfo_.spCount = info.spCount
            GameData.opponentInfo_.spCost = info.spCost
        end
    end
end

--[[
    描述：处理（游戏内）塔生成消息

    @param ack 类型：table，消息数据

    @return none
]]
function _handleGameTowerGenerateAck(ack)
    Log.i(ack)

    GameData.selfInfo_.spCount = ack["spCount"]
    GameData.selfInfo_.spCost = ack["spCost"]

    local t = ack["tower"]
    if t then
        local id = t["id"]
        local towerId = t["towerId"]
        local level = t["level"]
        local pos = t["pos"]
        local tower = Tower.new(id, towerId, level, pos)
        GameData.selfInfo_.towerMap_[id] = tower
    end
end

--[[
    描述：处理（游戏内）塔合成消息

    @param ack 类型：table，消息数据

    @return none
]]
function _handleGameTowerComposeAck(ack)
    Log.d()
end

--[[
    描述：处理（游戏内）塔升级消息

    @param ack 类型：table，消息数据

    @return none
]]
function _handleGameTowerUpgradeAck(ack)
    Log.d()
end

--[[
    描述：处理（游戏内）敌人生成消息

    @param ack 类型：table，消息数据

    @return none
]]
function _handleGameEnemyGenerateAck(ack)
    local e = ack["enemy"]
    if e then
        local enemy = Enemy.new()
        enemy.id_ = e["id"]
        enemy.enemyId_ = e["enemyId"]
        enemy.blood_ = e["blood"]
        enemy:setMile(e["mile"])
        GameData.selfInfo_.enemyMap_[enemy.id_] = enemy
    end
end

--[[
    描述：处理（游戏内）敌人同步消息

    @param ack 类型：table，消息数据

    @return none
]]
function _handleGameEnemySyncAck(ack)
    local syncs = ack["syncEnemys"]
    for i = 1, #syncs do
        local e = syncs[i]
        local enemy = GameData.selfInfo_.enemyMap_[e["id"]]
        enemy:setMile(e["mile"])
    end
end

--[[
    描述：处理（游戏内）敌人死亡消息

    @param ack 类型：table，消息数据

    @return none
]]
function _handleGameEnemyDeadAck(ack)
    local delIds = ack["delEnemyIds"]

    if delIds and #delIds > 0 then
        GameData.selfInfo_.delEnemyIds_ = delIds
    end
end

--[[
    描述：处理（游戏内）子弹新增消息

    @param ack 类型：table，消息数据

    @return none
]]
function _handleGameBulletAddAck(ack)
    local bullets = ack["newBullets"]
    if bullets and #bullets > 0 then
        for i = 1, #bullets do
            local b = bullets[i]
            local id = b["id"]
            local bulletId = b["bulletId"]
            local towerId = b["towerId"]
            local enemyId = b["enemyId"]
            local bullet = Bullet.new(id, bulletId, towerId, enemyId)
            local tower = GameData.selfInfo_.towerMap_[towerId]
            bullet.x_ = tower.x_
            bullet.y_ = tower.y_
            GameData.selfInfo_.bulletMap_[id] = bullet
        end
    end
end

--[[
    描述：处理（游戏内）放弃比赛消息

    @param ack 类型：table，消息数据

    @return none
]]
function _handleGameGiveupAck(ack)
    Log.d()
end

--[[
    描述：处理（游戏内）游戏结算消息

    @param ack 类型：table，消息数据

    @return none
]]
function _handleGameResultAck(ack)
    -- 消息数据解析
    local winUserId = ack["winUserId"]

    -- 切换游戏状态
    GameData.state_ = GameDef.STATE.RESULT

    -- 记录结算数据
    GameData.isWin_ = winUserId == UserInfo:getUserId()
end

-- 文件被require时执行
_init()

return MsgController