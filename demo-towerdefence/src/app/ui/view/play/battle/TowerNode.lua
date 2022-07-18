--[[--
    TowerNode.lua

    描述：塔节点，用于游戏棋盘内
]]
local TowerNode = class("TowerNode", require("app.ui.view.common.BaseNode"))
local Log = require("app.util.Log")

local RES_DIR = "img/play/tower/"

--[[--
    描述：构造函数

    @param tower 类型：Tower，塔数据

    @return none
]]
function TowerNode:ctor(tower)
    TowerNode.super.ctor(self)

    Log.d()

    self.tower_ = tower -- 类型：Tower，塔数据
end

--[[--
    描述：节点进入

    @param none

    @return none
]]
function TowerNode:onEnter()
    TowerNode.super.onEnter(self)

    Log.d()

    -- 初始化底图
    local towerSprite = display.newSprite(string.format("%stower_%d.png", RES_DIR, self.tower_.towerId_))
    towerSprite:align(display.LEFT_BOTTOM, 0, 0)
    self:addChild(towerSprite)

    local size = towerSprite:getContentSize()
    self:setContentSize(size)
    self:setAnchorPoint(display.ANCHOR_POINTS[display.CENTER])
    self:setPosition(self.tower_.x_ * display.scale, self.tower_.y_ * display.scale)

    -- 初始化等级
    local levelSprite = display.newSprite(string.format("%slevel_%d.png", RES_DIR, self.tower_.level_))
    levelSprite:align(display.RIGHT_TOP, size.width, size.height)
    self:addChild(levelSprite)
end

return TowerNode