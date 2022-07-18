--[[--
    EnemyNode.lua

    描述：敌人节点类
]]
local EnemyNode = class("EnemyNode", require("app.ui.view.common.BaseNode"))
local Log = require("app.util.Log")

local RES_DIR = "img/play/"

--[[--
    描述：构造函数

    @param enemy 类型：Enemy，敌人数据

    @return none
]]
function EnemyNode:ctor(enemy)
    EnemyNode.super.ctor(self)

    Log.d()

    self.enemy_ = enemy
end

--[[--
    描述：节点进入

    @param none

    @return none
]]
function EnemyNode:onEnter()
    EnemyNode.super.onEnter(self)

    Log.d()

    -- 初始化敌人图片 TODO 应根据敌人类型
    local enemySprite = display.newSprite(RES_DIR .. "enemy.png")
    enemySprite:align(display.LEFT_BOTTOM, 0, 0)
    self:addChild(enemySprite)

    local size = enemySprite:getContentSize()
    self:setContentSize(size)
    self:setAnchorPoint(display.ANCHOR_POINTS[display.CENTER])

    -- TODO 初始化血量
end

--[[--
    描述：帧刷新

    @param dt 类型：number，帧刷新间隔，单位：秒

    @return none
]]
function EnemyNode:onUpdate(dt)
    local scale = display.scale
    self:setPosition(self.enemy_.x_ * scale, self.enemy_.y_ * scale)

    -- TODO 刷新血量
end

return EnemyNode