--[[--
    BulletNode.lua

    描述：子弹节点类
]]
local BulletNode = class("BulletNode", require("app.ui.view.common.BaseNode"))
local Log = require("app.util.Log")

local RES_DIR = "img/play/bullet/"

--[[--
    描述：构造函数

    @param bullet 类型：Bullet，子弹数据

    @return none
]]
function BulletNode:ctor(bullet)
    BulletNode.super.ctor(self)

    Log.d()

    self.bullet_ = bullet
end

--[[--
    描述：节点进入

    @param none

    @return none
]]
function BulletNode:onEnter()
    BulletNode.super.onEnter(self)

    Log.d()

    -- 初始化子弹，TODO 根据子弹id
    local bulletSprite = display.newSprite(string.format("%s%d.png", RES_DIR, self.bullet_.bulletId_))
    bulletSprite:align(display.CENTER, 0, 0)
    self:addChild(bulletSprite)

    self:setPosition(self.bullet_.x_ * display.scale, self.bullet_.y_ * display.scale)
end

--[[--
    描述：帧刷新

    @param dt 类型：number，帧刷新间隔，单位：秒

    @return none
]]
function BulletNode:onUpdate(dt)
    self:setPosition(self.bullet_.x_ * display.scale, self.bullet_.y_ * display.scale)
end

return BulletNode