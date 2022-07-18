--[[--
    MyTowerNode.lua

    描述：我的塔节点，相较于TowerIconNode，多了等级信息
]]
local MyTowerNode = class("MyTowerNode", require("app.ui.view.common.BaseNode"))
local TowerNode = require("app.ui.view.common.TowerNode")
local Log = require("app.util.Log")

local RES_DIR = "img/common/tower_level/"

--[[--
    描述：构造函数

    @param towerId 类型：number，塔id
    @param towerLevel 类型：number，塔等级

    @return none
]]
function MyTowerNode:ctor(towerId, towerLevel)
    MyTowerNode.super.ctor(self)

    Log.d()

    self.towerId_ = towerId -- 类型：number，塔id
    self.towerLevel_ = towerLevel -- 类型：number，塔等级
end

--[[--
    描述：节点进入

    @param none

    @return none
]]
function MyTowerNode:onEnter()
    MyTowerNode.super.onEnter(self)

    Log.d()

    -- 初始化塔节点
    local towerNode = TowerNode.new(self.towerId_)
    towerNode:setAnchorPoint(display.ANCHOR_POINTS[display.CENTER_TOP])
    self:addChild(towerNode)

    -- 初始化等级
    local levelSprite = display.newSprite(string.format("%s%d.png", RES_DIR, self.towerLevel_))
    levelSprite:setAnchorPoint(display.ANCHOR_POINTS[display.CENTER_TOP])
    self:addChild(levelSprite)

    local offsetY = 3 -- 塔与等级之间的间隙
    local towerSize = towerNode:getContentSize()
    local levelSize = levelSprite:getContentSize()
    local width = math.max(towerSize.width, levelSize.width)
    local height = towerSize.height + offsetY + levelSize.height
    self:setContentSize(cc.size(width, height))

    -- 重置坐标
    local cx = width * 0.5
    towerNode:setPosition(cx, height)
    levelSprite:setPosition(cx, height - towerSize.height - offsetY)
end

return MyTowerNode