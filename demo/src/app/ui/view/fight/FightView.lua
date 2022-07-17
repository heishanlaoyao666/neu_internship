--[[
    FightView.lua
    Index界面
    描述：Index界面
    编写：李昊
]]
local FightView = class("FightView", function()
    return display.newColorLayer(cc.c4b(0, 0, 0, 0))
end)

local BGLayer = require("src.app.ui.layer.fight.BGLayer")
local FightLayer = require("src.app.ui.layer.fight.FightLayer")
local InfoLayer = require("src.app.ui.layer.fight.InfoLayer")
local AnimLayer = require("src.app.ui.layer.fight.AnimLayer")

--[[--
    构造函数

    @param none

    @return none
]]
function FightView:ctor()

    self.bgLayer_ = nil -- 类型：BGLayer，背景层
    self.fightLayer_ = nil -- 类型：FightLayer,战斗层
    self.infoLayer_ = nil-- 类型：InfoLayer,信息层
    self.animLayer_ = nil-- 类型：AnimLayer,动画层

    self:initView()

    self:registerScriptHandler(function(event)
        if event == "enter" then
            self:onEnter()
        elseif event == "exit" then
            self:onExit()
        end
    end)
end

--[[--
    界面初始化

    @param none

    @return none
]]
function FightView:initView()
    self.bgLayer_ = BGLayer.new()
    self.bgLayer_:addTo(self)

    self.fightLayer_ = FightLayer.new()
    self.fightLayer_:addTo(self)

    self.infoLayer_ = InfoLayer.new()
    self.infoLayer_:addTo(self)

    self.animLayer_ = AnimLayer.new()
    self.animLayer_:addTo(self)

end

--[[--
    节点进入

    @param none

    @return none
]]
function FightView:onEnter()
end

--[[--
    节点退出

    @param none

    @return none
]]
function FightView:onExit()
end

--[[--
    帧循环

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function FightView:update(dt)
    self.fightLayer_:update(dt)
    self.infoLayer_:update(dt)
end

return FightView