--[[--
    TowerUpgradeNode.lua

    描述：塔节点，用于塔升级模块
]]
local TowerUpgradeNode = class("TowerUpgradeNode", require("app.ui.view.common.BaseNode"))
local Log = require("app.util.Log")

--[[--
    描述：构造函数

    @param towerId 类型：number，塔id

    @return none
]]
function TowerUpgradeNode:ctor(towerId)
    TowerUpgradeNode.super.ctor(self)

    Log.d()

    self.towerId_ = towerId -- 类型：number，塔id
end

--[[--
    描述：构造函数

    @param none

    @return none
]]
function TowerUpgradeNode:onEnter()
    TowerUpgradeNode.super.onEnter(self)

    Log.d()
end

return TowerUpgradeNode