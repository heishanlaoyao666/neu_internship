--[[
    菜单层
    SpriteLayer.lua
    描述：菜单层
    编写：周星宇
    修订：李昊
    检查：张昊煜
]]
local ConstDef = require("app.def.ConstDef")
local SpriteLayer = class("SpriteLayer", require("app.ui.layer.BaseLayer"))
local AvatarDialog = require("app.ui.layer.lobby.top.dialog.AvatarDialog")
local MenuDialog = require("app.ui.layer.lobby.top.dialog.MenuDialog")
local DialogManager = require("app.manager.DialogManager")
local EventManager = require("app.manager.EventManager")
local EventDef = require("app.def.EventDef")
local PlayerData = require("app.data.PlayerData")
local MsgManager = require("app.manager.MsgManager")

--[[--
    构造函数

    @param none

    @return none
]]
function SpriteLayer:ctor()
    SpriteLayer.super.ctor(self)

    self.container_ = nil
    self.avatarBtn_ = nil
    self.menuBtn_ = nil

    self:initView()
end

--[[--
    界面初始化

    @param none

    @return none
]]
function SpriteLayer:initView()
    self.container_ = ccui.Layout:create()
    self.container_:setContentSize(ConstDef.WINDOW_SIZE.TOPBAR.WIDTH,
            ConstDef.WINDOW_SIZE.TOPBAR.HEIGHT) -- 设置为顶部栏大小
    self.container_:setAnchorPoint(0, 1)
    self.container_:setPosition(0, display.size.height)
    self:addChild(self.container_)

    -- 头像按钮
    self.avatarBtn_ = ccui.Button:create(PlayerData:getHeadPortrait())
    self.avatarBtn_:setAnchorPoint(0.5, 0.5)
    self.avatarBtn_:setPosition(cc.p( 80, 70))
    self.avatarBtn_:addClickEventListener(function()
        local avatarDialog = AvatarDialog.new()
        DialogManager:showDialog(avatarDialog)
    end)
    self.container_:addChild(self.avatarBtn_)

    -- 菜单按钮
    self.menuBtn_ = ccui.Button:create("image/lobby/top/menu_btn.png")
    self.menuBtn_:setAnchorPoint(0.5, 0.5)
    self.menuBtn_:setPosition(cc.p(670, 70))
    self.menuBtn_:addClickEventListener(function()
        local menuDialog = MenuDialog.new()
        DialogManager:showDialog(menuDialog)
    end)
    self.container_:addChild(self.menuBtn_)
end

--[[--
    节点进入

    @param none

    @return none
]]
function SpriteLayer:onEnter()
    -- 头像切换事件
    EventManager:regListener(EventDef.ID.AVATAR_SWITCH, self, function(avatar)
        self.avatarBtn_:loadTextureNormal(avatar)
        PlayerData:setHeadPortrait(avatar)
        self:update()
    end)
    EventManager:regListener(EventDef.ID.INIT_PLAYER_DATA, self, function()
        self.avatarBtn_:loadTextureNormal(PlayerData:getHeadPortrait())
    end)
end

--[[--
    节点退出

    @param none

    @return none
]]
function SpriteLayer:onExit()
    EventManager:unRegListener(EventDef.ID.AVATAR_SWITCH, self)
    EventManager:unRegListener(EventDef.ID.INIT_PLAYER_DATA, self)
end

--[[--
    界面刷新

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function SpriteLayer:update()
    MsgManager:sendPlayerData()
end

return SpriteLayer