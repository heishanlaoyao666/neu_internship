--[[--
    MainScene.lua
    主界面
]]
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)
local MainView = require("app.ui.outgame.view.MainView")
local LoadView = require("app.ui.outgame.view.LoadView")
local OutGameData = require("app.data.outgame.OutGameData")
local ConstDef = require("app.def.outgame.ConstDef")
local EventDef = require("app.def.EventDef")
local EventManager = require("app.manager.EventManager")
local RegisterView = require("app.ui.outgame.view.RegisterView")
local OutgameMsg= require("app.msg.OutgameMsg")
local MsgController= require("app.msg.MsgController")
OutgameMsg:onEnter()
--[[--
    构造函数

    @param none

    @return none
]]
function MainScene:ctor()
    self:initScene()
    if cc.UserDefault:getInstance():getIntegerForKey("play")==2 then
        self.mainView_=MainView:new():addTo(self)
    else
        OutgameMsg:connect()
        self.mainView_ = nil -- 类型：MainView，主游戏界面
        OutGameData:init()
        print("init()")
        self.loadView_ = LoadView.new() -- 类型：LoadView，加载界面
        self:addChild(self.loadView_)

        self.registerView_ = RegisterView.new()
        self:addChild(self.registerView_)

        self:addNodeEventListener(cc.NODE_ENTER_FRAME_EVENT, handler(self, self.update))
        self:performWithDelay(function()
            self:scheduleUpdate()
        end, 1)
        -- local tower={1,4,7,9,18}
        -- for j=1,3 do
        --     for i=1,5 do
        --         cc.UserDefault:getInstance():setIntegerForKey("current"  ..  i..  j,tower[i])
        --     end
        -- end
    end
end

function MainScene:onEnter()
    EventManager:regListener(EventDef.ID.GAMESTATE_CHANGE, self, function(state)
        print("登录事件")
        if state == ConstDef.GAME_STATE.REGISTER then
            self.registerView_:showView()
        elseif state == ConstDef.GAME_STATE.INIT then
            self:unscheduleUpdate()
            self.loadView_:removeFromParent(true)
            self.mainView_=MainView:new():addTo(self)
        end
    end)
    --MsgController:registerListener(self, handler(self, self.handleMsg))
end

function MainScene:onExit()
    EventManager:unRegListener(EventDef.ID.GAMESTATE_CHANGE, self)
    --MsgController:unregisterListener(self)
end

-- function MainScene:handleMsg(msg)
--     --print(msg.towerData.tower[1])
--     print(msg.financeData.gold)
-- end
--[[--
    初始化主界面

    @param none

    @return none
]]
function MainScene:initScene()
    -- 加载音效资源
    audio.loadFile("sounds/ui_btn_click.OGG", function() end)--点击按钮
    audio.loadFile("sounds/ui_btn_close.OGG", function() end)--关闭按钮

    audio.loadFile("sounds/get_free_item.OGG", function() end)--点击免费商品
    audio.loadFile("sounds/get_paid_item.OGG", function() end)--点击付费商品
    audio.loadFile("sounds/buy_paid_item.OGG", function() end)--购买付费商品
    audio.loadFile("sounds/open_box.OGG", function() end)--打开宝箱
    audio.loadFile("sounds/get_item.OGG", function() end)--获得物品
    audio.loadFile("sounds/player_match.OGG", function() end)--匹配
    audio.loadFile("sounds/tower_level_up.OGG", function() end)--塔升级

    audio.loadFile("sounds/confirm_boss.OGG", function() end)
    audio.loadFile("sounds/ingame_bgm_100bpm.OGG", function() end)
    audio.loadFile("sounds/lose.OGG", function() end)
    audio.loadFile("sounds/tower_atk_hit.OGG", function() end)
    audio.loadFile("sounds/tower_atk.OGG", function() end)
    audio.loadFile("sounds/tower_build.OGG", function() end)
    audio.loadFile("sounds/tower_compose.OGG", function() end)
    audio.loadFile("sounds/win.OGG", function() end)

    if cc.UserDefault:getInstance():getBoolForKey("游戏外音乐") then
        audio.loadFile("sounds/lobby_bgm_120bpm.OGG", function()--大厅背景音乐
            audio.playBGM("sounds/lobby_bgm_120bpm.OGG", true)
        end)
    else
        audio.loadFile("sounds/lobby_bgm_120bpm.OGG", function()--大厅背景音乐
            audio.stopBGM("sounds/lobby_bgm_120bpm.OGG")
        end)
    end

    --初始化当前阵容塔能否触控
    cc.UserDefault:getInstance():setIntegerForKey("available",2)
end

function MainScene:update(dt)
    self.loadView_:update(dt)
end

return MainScene
