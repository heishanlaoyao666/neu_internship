--[[
    LobbyScene.lua
    大厅
    描述：大厅场景
    编写：周星宇
    修订：李昊
    检查：张昊煜
]]
local LobbyScene = class("LobbyScene", function()
    return display.newScene("LobbyScene")
end)
local IndexView = require("app.ui.view.lobby.IndexView")
local StoreView = require("app.ui.view.lobby.StoreView")
local PictorialView = require("app.ui.view.lobby.PictorialView")
local DialogView = require("app.ui.view.lobby.DialogView")
local TopBar = require("app.ui.view.lobby.TopBar")
local DownBar = require("app.ui.view.lobby.DownBar")
local EventManager = require("app.manager.EventManager")
local EventDef = require("app.def.EventDef")
local ConstDef = require("app.def.ConstDef")
local LobbyData = require("app.data.LobbyData")


--[[--
    构造函数

    @param none

    @return none
]]
function LobbyScene:ctor()

    -- 初始化数据
    self.lobbyData_ = nil

    -- 初始化界面

    self.indexView_ = IndexView.new() -- 类型：PlayView，主游戏界面
    self.indexView_:setVisible(true)
    self:addChild(self.indexView_)

    self.storeView_ = StoreView.new() -- 类型：StoreView，商店界面
    self.storeView_:setVisible(false)
    self:addChild(self.storeView_)

    self.pictorialView_ = PictorialView.new() -- 类型：PictorialView，图鉴界面
    self.pictorialView_:setVisible(false)
    self:addChild(self.pictorialView_)

    self.downBar_ = DownBar.new() -- 类型：DownBar，底部栏
    self:addChild(self.downBar_)

    self.topBar_ = TopBar.new() -- 类型：TopBar，顶部栏
    self:addChild(self.topBar_)

    self.dialogView_ = DialogView.new() -- 类型：DialogView，弹窗界面
    self:addChild(self.dialogView_)

    self:registerScriptHandler(function(event)
        if event == "enter" then
            self:onEnter()
        elseif event == "exit" then
            self:onExit()
        end
    end)
end

--[[--
    节点进入

    @param none

    @return none
]]
function LobbyScene:onEnter()
    -- 大厅临时状态信息
    self.lobbyData_ = LobbyData:init()

    -- 大厅视图切换事件
    EventManager:regListener(EventDef.ID.LOBBY_VIEW_SWITCH, self, function(code)
        if code == ConstDef.LOBBY_VIEW_CODE.STORE then -- 商店
            self.storeView_:setVisible(true)
            self.indexView_:setVisible(false)
            self.pictorialView_:setVisible(false)
        elseif code == ConstDef.LOBBY_VIEW_CODE.INDEX then -- 主页
            self.storeView_:setVisible(false)
            self.indexView_:setVisible(true)
            self.pictorialView_:setVisible(false)
        elseif code == ConstDef.LOBBY_VIEW_CODE.PICTORIAL then -- 图鉴
            self.storeView_:setVisible(false)
            self.indexView_:setVisible(false)
            self.pictorialView_:setVisible(true)
        end
    end)
end

--[[--
    节点退出

    @param none

    @return none
]]
function LobbyScene:onExit()

    self.lobbyData_ = nil

    EventManager:unRegListener(EventDef.ID.LOBBY_VIEW_SWITCH, self)
end


--[[--
    帧循环

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function LobbyScene:update(dt)
end

return LobbyScene