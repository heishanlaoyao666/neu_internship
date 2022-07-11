--[[
    SpriteLayer.lua
    精灵层
    描述：精灵层
    编写：周星宇
    修订：李昊
    检查：张昊煜
]]
local SpriteLayer = class("SpriteLayer", require("app.ui.layer.BaseLayer"))
local TeamComp = require("app.ui.layer.lobby.pictorial.component.component.TeamComp")
local LadderComp = require("app.ui.layer.lobby.index.component.LadderComp")
local PlayerData = require("app.data.PlayerData")

--[[--
    构造函数

    @param none

    @return none
]]
function SpriteLayer:ctor()
    SpriteLayer.super.ctor(self)

    self.container_ = nil
    self.modeBtn_ = nil
    self.teamComp_ = nil
    self.ladderComp_ = nil

    self:initView()
end

--[[--
    界面初始化

    @param none

    @return none
]]
function SpriteLayer:initView()
    self.container_ = ccui.Layout:create()
    self.container_:setContentSize(display.width, display.height)
    self.container_:addTo(self)
    self.container_:setAnchorPoint(0.5, 0.5)
    self.container_:setPosition(display.cx, display.cy)

    self.modeBtn_ = ccui.Button:create("image/lobby/index/mode_btn.png")
    self.modeBtn_:setAnchorPoint(0.5, 0.5)
    self.modeBtn_:setPosition(display.cx, 0.45 * display.size.height)
    self.container_:addChild(self.modeBtn_)

    -- 天梯奖励展示区
    self.ladderComp_ = LadderComp.new()
    self.container_:addChild(self.ladderComp_)

    -- 当前队伍展示
    self.teamComp_ = TeamComp.new(1)
    self.container_:addChild(self.teamComp_)


end

return SpriteLayer