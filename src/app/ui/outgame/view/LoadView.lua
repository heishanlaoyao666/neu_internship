--[[--
    游戏主界面
    LoadView.lua
]]
local LoadView = class("LoadView", function()
    return display.newColorLayer(cc.c4b(0, 0, 0, 0))
end)
local ConstDef = require("app.def.outgame.ConstDef")
local EventDef = require("app.def.outgame.EventDef")
local EventManager = require("app.manager.EventManager")
local OutGameData = require("app.data.outgame.OutGameData")
local LoadBGLayer = require("app.ui.outgame.layer.LoadBGLayer")
local LoadInfoLayer = require("app.ui.outgame.layer.LoadInfoLayer")
local RegisterView = require("app.ui.outgame.view.RegisterView")

local pro = 0 -- 记录进度
--[[--
    构造函数

    @param none

    @return none
]]
function LoadView:ctor()
    self.bgLayer_ = nil -- 加载背景层
    self.loadInfoLayer_ = nil -- 加载信息层
    self.registerView_ = nil --加载注册界面

    self:initView()

    self:registerScriptHandler(function(event)
        if event == "enter" then
            self:onEnter()
            --self:checkLogin()
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
function LoadView:initView()
    self.bgLayer_ = LoadBGLayer.new()
    self:addChild(self.bgLayer_)

    self.loadInfoLayer_ = LoadInfoLayer.new()
    self:addChild(self.loadInfoLayer_)

    self.registerView_ = RegisterView.new()
    self:addChild(self.registerView_)
end

--[[--
    登录检测

    @param none

    @return none
]]
function LoadView:checkLogin()
    local account = cc.UserDefault:getInstance():getStringForKey("account")
    local password = cc.UserDefault:getInstance():getStringForKey("password")
    if account == "" or password == "" then
        OutGameData:setGameState(ConstDef.GAME_STATE.REGISTER)
        print("进入注册界面")
    else
        OutGameData:setGameState(ConstDef.GAME_STATE.INIT)
        print("进入主界面")
    end
end

--[[--
    节点进入

    @param none

    @return none
]]
function LoadView:onEnter()
    EventManager:regListener(EventDef.ID.GAMESTATE_CHANGE, self, function(state)
        print("登录事件")
        if state == ConstDef.GAME_STATE.REGISTER then
            self.registerView_:showView()
        end
    end)
end

--[[--
    节点退出

    @param none

    @return none
]]
function LoadView:onExit()
    EventManager:unRegListener(EventDef.ID.GAMESTATE_CHANGE, self)
end

--[[--
    帧刷新

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function LoadView:update(dt)
    if pro >= 100 and OutGameData:getGameState() == ConstDef.GAME_STATE.LOAD then
        self:checkLogin()
    else
        pro = pro + dt * 100
        pro = math.floor(pro)
        self.loadInfoLayer_:update(dt)
    end
end

return LoadView