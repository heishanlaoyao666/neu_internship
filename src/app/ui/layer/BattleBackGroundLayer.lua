---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by Asus.
--- DateTime: 2022/6/21 10:13
---
--[[--
    战斗的背景界面
    BattleBackGroundLayer.lua
]]

local BattleBackGroundLayer = class("BattleBackGroundLayer", function()
    return display.newLayer()
end)
--local
local StringDef = require("app.def.StringDef")
--

--[[--
    @description: 构造函数，主要包括属性，暂时只有拉伸因子 留待后面匹配不同屏幕进行扩展
    @param none
    @return none
]]
function BattleBackGroundLayer:ctor()
    self.BGScaleFactor_ = 1 --拉伸因子，留待扩展
    self:init()
end

--[[--
    @description； 初始化界面元素，简单的背景精灵初始化
    @param none
    @return none
]]
function BattleBackGroundLayer:init()
    local sprite = display.newSprite(StringDef.PATH_BASE_BATTLE)
    sprite:setAnchorPoint(0, 0)
    sprite:setContentSize(display.width, display.height)
    sprite:setPosition(0, 0)
    sprite:setScale(self.BGScaleFactor_) --设计尺寸和拉伸留待讨论,先使用默认值
    sprite:addTo(self)
end

--[[--
    @description: 因为是背景界面，所以什么都不用做，留待扩展
]]
function BattleBackGroundLayer:update()

end

--[[--
    @description: 执行事件的注册
]]
function BattleBackGroundLayer:onEnter()

end

--[[--
    @description: 执行事件的注销
]]
function BattleBackGroundLayer:onExit()

end

return BattleBackGroundLayer
