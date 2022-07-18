--[[--
    ReqController.lua

    描述：请求消息处理器
]]
local ReqController = {}
local UserInfo = require("server.UserInfo")
local OpponentUserInfo = require("server.OpponentUserInfo")
local SendAck = require("server.SendAck")
local MsgDef = require("app.def.MsgDef")
local Log = require("app.util.Log")

local funcMap_ = {} -- 类型：table，函数数据，key为消息id，value为function

---------------------------------------------------------------------------
-- 私有函数定义
---------------------------------------------------------------------------
local _init
local _handleLoginReq
local _handleShopInfoReq
local _handleShopBuyGoodsReq
local _handleShopOpenChestReq
local _handleMatchSignupReq
local _handleMatchSignupCancelReq
local _handleGameTowerGenerateReq
local _handleGameTowerComposeReq
local _handleGameTowerUpgradeReq
local _handleGameBulletHitReq
local _handleGameGiveupReq

--[[--
    描述：处理请求消息

    @param req 类型：table，请求消息

    @return none
]]
function ReqController:handleReq(req)
    if not isTable(req) then
        Log.e("unexpect param, req=", req)
        return
    end

    local msgType = req[MsgDef.KEY.TYPE]
    local func = funcMap_[msgType]
    if func then
        func(req)
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
    Log.d()

    funcMap_[MsgDef.REQ.LOGIN] = _handleLoginReq
    funcMap_[MsgDef.REQ.SHOP_INFO] = _handleShopInfoReq
    funcMap_[MsgDef.REQ.SHOP_BUY_GOODS] = _handleShopBuyGoodsReq
    funcMap_[MsgDef.REQ.SHOP_OPEN_CHEST] = _handleShopOpenChestReq
    funcMap_[MsgDef.REQ.MATCH_SIGNUP] = _handleMatchSignupReq
    funcMap_[MsgDef.REQ.MATCH_SIGHUP_CANCEL] = _handleMatchSignupCancelReq
    funcMap_[MsgDef.REQ.GAME_TOWER_GENERATE] = _handleGameTowerGenerateReq
    funcMap_[MsgDef.REQ.GAME_TOWER_COMPOSE] = _handleGameTowerComposeReq
    funcMap_[MsgDef.REQ.GAME_TOWER_UPGRADE] = _handleGameTowerUpgradeReq
    funcMap_[MsgDef.REQ.GAME_BULLET_HIT] = _handleGameBulletHitReq
    funcMap_[MsgDef.REQ.GAME_GIVEUP] = _handleGameGiveupReq
end

--[[
    描述：处理登录请求

    @param req 类型：table，请求消息

    @return none
]]
function _handleLoginReq(req)
    -- 登录成功
    SendAck:send({
        type = MsgDef.ACK.LOGIN,
        userId = UserInfo.userId_,

        ret = 0, -- 0 代表成功，非0代表错误码
    })

    -- 玩家信息推送
    SendAck:send({
        type = MsgDef.ACK.ACCOUNT_INFO,
        userId = UserInfo.userId_,

        nickname = UserInfo.nickname_,
        trophy = UserInfo.trophy_,
        gold = UserInfo.gold_,
        diamond = UserInfo.diamond_,
    })
end

--[[
    描述：处理商城信息请求

    @param req 类型：table，请求消息

    @return none
]]
function _handleShopInfoReq(req) end

--[[
    描述：处理商城购买请求

    @param req 类型：table，请求消息

    @return none
]]
function _handleShopBuyGoodsReq(req) end

--[[
    描述：处理商城开宝箱请求

    @param req 类型：table，请求消息

    @return none
]]
function _handleShopOpenChestReq(req) end

--[[
    描述：处理比赛报名请求

    @param req 类型：table，请求消息

    @return none
]]
function _handleMatchSignupReq(req)
    -- 报名成功消息
    SendAck:send({
        type = MsgDef.ACK.MATCH_SIGNUP,
        userId = UserInfo.userId_,

        ret = 0, -- 0 代表成功，非0代表错误码
    })

    -- 开赛消息，客户端用以切换游戏场景
    SendAck:send({
        type = MsgDef.ACK.MATCH_START,
        userId = UserInfo.userId_,
    })

    -- 游戏初始化消息
    SendAck:send({
        type = MsgDef.ACK.GAME_INIT,
        userId = UserInfo.userId_,

        playerInfos = {
            -- 自己的信息
            {
                userId = UserInfo.userId_,
                spCount = UserInfo.spCount_,
                spCost = UserInfo.spCost_,
            },
            -- 对手的信息
            {
                userId = OpponentUserInfo.userId_,
                spCount = OpponentUserInfo.spCount_,
                spCost = OpponentUserInfo.spCost_,
            },
        }
    })

    UserInfo.gameStart()
end

--[[
    描述：处理比赛报名取消请求

    @param req 类型：table，请求消息

    @return none
]]
function _handleMatchSignupCancelReq(req) end

--[[
    描述：处理（游戏内）塔生成请求

    @param req 类型：table，请求消息

    @return none
]]
function _handleGameTowerGenerateReq(req)
    local ret = 0
    local tower
    if UserInfo.spCount_ > UserInfo.spCost_ then
        local pos = UserInfo.getRandomPos()
        if pos > 0 then
            UserInfo.spCount_ = UserInfo.spCount_ - UserInfo.spCost_
            UserInfo.spCost_ = UserInfo.spCost_ + 50

            tower = UserInfo.genTower(pos)
        else
            ret = 2 -- 没有空位
        end
    else
        ret = 1 -- sp不足
    end

    -- 开赛消息，客户端用以切换游戏场景
    SendAck:send({
        type = MsgDef.ACK.GAME_TOWER_GENERATE,
        userId = UserInfo.userId_,

        ret = ret,
        spCount = UserInfo.spCount_,
        spCost = UserInfo.spCost_,

        tower = tower,
    })
end

--[[
    描述：处理（游戏内）塔合成请求

    @param req 类型：table，请求消息

    @return none
]]
function _handleGameTowerComposeReq(req) end

--[[
    描述：处理（游戏内）塔升级请求

    @param req 类型：table，请求消息

    @return none
]]
function _handleGameTowerUpgradeReq(req) end

--[[
    描述：处理（游戏内）子弹击中请求

    @param req 类型：table，请求消息

    @return none
]]
function _handleGameBulletHitReq(req)
    local bulets = req["bulets"]
    if bulets and #bulets > 0 then
        for i = 1, #bulets do
            local bulet = bulets[i]
            UserInfo.buletHit(bulet.id_, bulet.enemyId_)
        end
    end
end

--[[
    描述：处理（游戏内）认输请求

    @param req 类型：table，请求消息

    @return none
]]
function _handleGameGiveupReq(req)
    local giveupUserId = req[MsgDef.KEY.USER_ID]
    Log.i("giveupUserId=", giveupUserId)

    -- 计算比赛结果，发送结算消息
    SendAck:send({
        type = MsgDef.ACK.GAME_RESULT,
        userId = UserInfo.userId_,

        winUserId = OpponentUserInfo.userId_, -- 请求者是输家
    })

    UserInfo.gameStop()
end

-- 文件被require时执行
_init()

return ReqController