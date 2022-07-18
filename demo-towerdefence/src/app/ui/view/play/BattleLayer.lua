--[[--
    BattleLayer.lua

    描述：战斗层，包括塔、敌人、子弹
]]
local BattleLayer = class("BattleLayer", require("app.ui.view.common.BaseNode"))
local GameDef = require("app.def.GameDef")
local GameData = require("app.data.GameData")
local TowerNode = require("app.ui.view.play.battle.TowerNode")
local EnemyNode = require("app.ui.view.play.battle.EnemyNode")
local BulletNode = require("app.ui.view.play.battle.BulletNode")
local Log = require("app.util.Log")

---------------------------------------------------------------------------
-- 私有函数定义
---------------------------------------------------------------------------
local _addTowerNode
local _addEnemyNode
local _addBulletNode

--[[--
    描述：构造函数

    @param isSelf 类型：boolean，是否我自己

    @return none
]]
function BattleLayer:ctor(isSelf)
    BattleLayer.super.ctor(self)

    Log.d()

    self.isSelf_ = isSelf -- 类型：boolean，是否我自己
    self.towerNodeMap_ = {} -- 类型：table，塔节点数据
    self.enemyNodeMap_ = {} -- 类型：table，敌人节点数据
    self.bulletNodeMap_ = {} -- 类型：table，子弹节点数据
end

--[[--
    描述：节点进入

    @param none

    @return none
]]
function BattleLayer:onEnter()
    BattleLayer.super.onEnter(self)

    Log.d()

    local width, height = GameDef.WIDTH * display.scale, GameDef.HEIGHT * display.scale
    self:setContentSize(cc.size(width, height))

    --self:initTestBg(cc.c4b(0, 255, 0, 150))

    if self.isSelf_ then
        self:align(display.CENTER_TOP, display.cx, display.cy + 50 * display.scale)
    end
end

--[[--
    描述：帧刷新

    @param dt 类型：number，帧刷新间隔，单位：秒

    @return none
]]
function BattleLayer:onUpdate(dt)
    -- 检查塔新增
    for id, tower in pairs(GameData.selfInfo_.towerMap_) do
        if not self.towerNodeMap_[id] then
            _addTowerNode(self, tower)
        end
    end

    -- 检查敌人新增，刷新敌人
    for id, enemy in pairs(GameData.selfInfo_.enemyMap_) do
        local enemyNode = self.enemyNodeMap_[id]
        if enemyNode then
            enemyNode:onUpdate(dt)
        else
            _addEnemyNode(self, enemy)
        end
    end

    -- 删除死亡敌人
    local delEnemyIds = GameData.selfInfo_.delEnemyIds_
    if delEnemyIds and #delEnemyIds > 0 then
        Log.i(delEnemyIds)
        for i = 1, #delEnemyIds do
            local id = delEnemyIds[i]
            local enemyNode = self.enemyNodeMap_[id]
            if enemyNode then
                enemyNode:setScale(10)
                enemyNode:removeSelf()
                self.enemyNodeMap_[id] = nil
            end
        end
    end

    -- 检查子弹新增，刷新子弹
    for id, bullet in pairs(GameData.selfInfo_.bulletMap_) do
        local bulletNode = self.bulletNodeMap_[id]
        if bulletNode then
            bulletNode:onUpdate(dt)
        else
            _addBulletNode(self, bullet)
        end
    end

    -- 移除命中的子弹
    if #GameData.selfInfo_.hitBulets_ > 0 then
        for i = 1, #GameData.selfInfo_.hitBulets_ do
            local bulet = GameData.selfInfo_.hitBulets_[i]
            local buletNode = self.bulletNodeMap_[bulet.id_]
            if buletNode then
                buletNode:removeSelf()
                self.bulletNodeMap_[bulet.id_] = nil
            end
        end
    end
end

---------------------------------------------------------------------------
-- 私有函数实现
---------------------------------------------------------------------------

--[[
    描述：添加塔节点

    @param self 类型：BattleLayer，当前节点
    @param tower 类型：Tower，塔数据

    @return none
]]
function _addTowerNode(self, tower)
    -- Log.i(tower)

    local towerNode = TowerNode.new(tower)
    towerNode:setScale(display.scale)
    self:addChild(towerNode)

    self.towerNodeMap_[tower.id_] = towerNode
end

--[[
    描述：添加敌人

    @param self 类型：BattleLayer，当前节点
    @param enemy 类型：Enemy，敌人数据

    @return none
]]
function _addEnemyNode(self, enemy)
    -- Log.i(enemy)

    local enemyNode = EnemyNode.new(enemy)
    enemyNode:setScale(display.scale)
    self:addChild(enemyNode)

    self.enemyNodeMap_[enemy.id_] = enemyNode
end

--[[
    描述：添加子弹

    @param self 类型：BattleLayer，当前节点
    @param bullet 类型：Bullet，子弹数据

    @return none
]]
function _addBulletNode(self, bullet)
    -- Log.i(bullet)

    local bulletNode = BulletNode.new(bullet)
    bulletNode:setScale(display.scale * 5)
    self:addChild(bulletNode, 10)

    self.bulletNodeMap_[bullet.id_] = bulletNode
end

return BattleLayer