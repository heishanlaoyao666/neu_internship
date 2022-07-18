--[[--
    TowerNode.lua

    描述：塔节点，适用游戏外通用图标
]]
local TowerNode = class("TowerNode", require("app.ui.view.common.BaseNode"))
local TowerConfig = require("app.config.TowerConfig")
local Log = require("app.util.Log")

local RES_DIR = "img/common/tower/"

--[[--
    描述：构造函数

    @param towerId 类型：number，塔id

    @return none
]]
function TowerNode:ctor(towerId)
    TowerNode.super.ctor(self)

    Log.d()

    self.towerId_ = towerId -- 类型：number，塔id
    self.config_ = TowerConfig:getConfig(towerId) -- 类型：table，塔配置数据
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
    self:initBg(string.format("%s%d.png", RES_DIR, self.towerId_), 0, 0)

    -- 初始化塔类型精灵
    local typeSprite = display.newSprite(string.format("%stype_%d.png", RES_DIR, self.config_.towerType))
    typeSprite:setAnchorPoint(display.ANCHOR_POINTS[display.RIGHT_TOP])
    local size = self:getContentSize()
    typeSprite:setPosition(size.width, size.height)
    self:addChild(typeSprite)
end

return TowerNode