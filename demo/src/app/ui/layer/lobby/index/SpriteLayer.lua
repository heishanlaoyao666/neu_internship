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
local EventManager = require("app.manager.EventManager")
local EventDef = require("app.def.EventDef")
local ConstDef = require("app.def.ConstDef")
local DialogManager = require("app.manager.DialogManager")
local ModeDialog = require("app.ui.layer.lobby.index.dialog.ModeDialog")
local MsgManager = require("app.manager.MsgManager")

--[[--
    构造函数

    @param none

    @return none
]]
function SpriteLayer:ctor()
    SpriteLayer.super.ctor(self)

    self.container_ = nil
    self.teamContainer_ = nil
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
    self.modeBtn_:addClickEventListener(function()
        local dialog = ModeDialog.new()
        DialogManager:showDialog(dialog)
    end)
    self.container_:addChild(self.modeBtn_)

    -- 天梯奖励展示区
    self.ladderComp_ = LadderComp.new()
    self.container_:addChild(self.ladderComp_)

    -- 当前队伍展示
    self.teamContainer_ = ccui.Layout:create()
    self.teamContainer_:setContentSize(ConstDef.WINDOW_SIZE.TEAM_VIEW.WIDTH,
            ConstDef.WINDOW_SIZE.TEAM_VIEW.HEIGHT)
    self.container_:addChild(self.teamContainer_)

    self.teamComp_ = TeamComp.new(PlayerData:getFightCardGroupIndex())
    self.teamContainer_:addChild(self.teamComp_)

end

--[[--
    onEnter

    @param none

    @return none
]]
function SpriteLayer:onEnter()
    EventManager:regListener(EventDef.ID.CARD_GROUP_SWITCH, self, function()
        self.teamContainer_:removeAllChildren()
        self.teamComp_ = TeamComp.new(PlayerData:getFightCardGroupIndex())
        self.teamContainer_:addChild(self.teamComp_)

        self:update()
    end)
end

--[[--
    onExit

    @param none

    @return none
]]
function SpriteLayer:onExit()
    EventManager:unRegListener(EventDef.ID.CARD_GROUP_SWITCH, self)
end

--[[--
    界面刷新

    @param none

    @return none
]]
function SpriteLayer:update()
    -- 向服务端发送数据
    MsgManager:sendPlayerData()
end

return SpriteLayer