--[[--
    战斗主界面
    FightingView.lua
]]
local FightingView = class("FightingView", function()
    return display.newColorLayer(cc.c4b(0, 0, 0, 0))
end)

local FightingBGLayer = require("app.ui.ingame.layer.FightingBGLayer")
local FightingInfoLayer = require("app.ui.ingame.layer.FightInfoLayer")
local FightingLayer = require("app.ui.ingame.layer.FightingLayer")

--[[--
    构造函数

    @param none

    @return none
]]
function FightingView:ctor()
    self.bgLayer_ = nil -- 加载背景层
    self.infoLayer_ = nil -- 加载信息层
    self.fightingLayer_ = nil -- 加载战斗层

    self:initView()
end

--[[--
    界面初始化

    @param none

    @return none
]]
function FightingView:initView()
    self.bgLayer_ = FightingBGLayer.new()
    self:addChild(self.bgLayer_)

    self.infoLayer_ = FightingInfoLayer.new()
    self:addChild(self.infoLayer_)

    self.fightingLayer_ = FightingLayer.new()
    self:addChild(self.fightingLayer_)
end

--[[--
    帧刷新

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function FightingView:update(dt)
end

return FightingView