--[[--
    PlaySceneController.lua

    描述：启动场景控制器类
]]
local BaseClass = require("app.ui.sceneController.BaseSceneController")
local PlaySceneController = class("PlaySceneController", BaseClass)
local EventManager = require("app.manager.EventManager")
local SceneManager = require("app.manager.SceneManager")
local ToastManager = require("app.manager.ToastManager")
local GameData = require("app.data.GameData")
local GameDef = require("app.def.GameDef")
local MsgDef = require("app.def.MsgDef")
local SendMsg = require("app.msg.SendMsg")
local MathUtil = require("app.util.MathUtil")
local Log = require("app.util.Log")

---------------------------------------------------------------------------
-- 私有函数定义
---------------------------------------------------------------------------

--[[--
    描述：构造函数

    @param ...

    @return none
]]
function PlaySceneController:ctor()
    PlaySceneController.super.ctor(self)

    Log.d()
end

--[[--
    描述：场景帧刷新

    @param dt 类型：number，帧刷新间隔，单位：秒

    @return none
]]
function PlaySceneController:onSceneUpdate(dt)
    if GameData.state_ ~= GameDef.STATE.PLAY then
        return
    end

    -- 敌人移动
    for _, enemy in pairs(GameData.selfInfo_.enemyMap_) do
        enemy:onUpdate(dt)
    end

    -- 子弹移动 TODO 此处简单实现
    local alpha = dt * 10
    for _, bullet in pairs(GameData.selfInfo_.bulletMap_) do
        local enemy = GameData.selfInfo_.enemyMap_[bullet.enemyId_]
        if enemy then
            bullet.x_ = MathUtil.lerp(bullet.x_, enemy.x_, alpha)
            bullet.y_ = MathUtil.lerp(bullet.y_, enemy.y_, alpha)

            -- 命中检查
            local deltaX = bullet.x_ - enemy.x_
            local deltaY = bullet.y_ - enemy.y_
            if (deltaX * deltaX + deltaY * deltaY) < 100 then
                table.insert(GameData.selfInfo_.hitBulets_, bullet)
            end
        else
            -- TODO 简单实现，若是敌人先死亡，则销毁子弹
            table.insert(GameData.selfInfo_.hitBulets_, bullet)
        end
    end

    -- 通知服务器命中
    if #GameData.selfInfo_.hitBulets_ > 0 then
        SendMsg:sendBuletHitReq(GameData.selfInfo_.hitBulets_)
    end
end

--[[--
    描述：场景帧刷新后执行

    @param dt 类型：number，帧刷新间隔，单位：秒

    @return none
]]
function PlaySceneController:onSceneUpdateAfter(dt)
    if GameData.state_ ~= GameDef.STATE.PLAY then
        return
    end

    -- 清理死亡敌人数据
    local delEnemyIds = GameData.selfInfo_.delEnemyIds_
    if delEnemyIds then
        for i = 1, #delEnemyIds do
            GameData.selfInfo_.enemyMap_[delEnemyIds[i]] = nil
        end

        GameData.selfInfo_.delEnemyIds_ = nil
    end

    -- 清理命中子弹
    if #GameData.selfInfo_.hitBulets_ > 0 then
        for i = 1, #GameData.selfInfo_.hitBulets_ do
            local bulet = GameData.selfInfo_.hitBulets_[i]
            GameData.selfInfo_.bulletMap_[bulet.id_] = nil
        end
        GameData.selfInfo_.hitBulets_ = {}
    end
end

--[[--
    描述：消息处理

    @param msg 类型：table，消息体

    @return none
]]
function PlaySceneController:handleMsg(msg)
    if not isTable(msg) then
        Log.e("unexpect param, msg=", msg)
        return
    end

    local msgType = msg[MsgDef.KEY.TYPE]
    if msgType == MsgDef.ACK.GAME_TOWER_GENERATE then
        local ret = msg["ret"]
        if 0 == ret then
            EventManager:sendEvent(EventManager.DEF.ID.GAME_REFRESH_SP)
        elseif 1 == ret then
            ToastManager:showToast("SP不足！")
        elseif 2 == ret then
            ToastManager:showToast("没有空位！")
        end
    elseif msgType == MsgDef.ACK.GAME_RESULT then
        self.scene_:showResult()
    end
end

---------------------------------------------------------------------------
-- 私有函数实现
---------------------------------------------------------------------------

return PlaySceneController