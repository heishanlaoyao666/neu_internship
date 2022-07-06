--[[--
    MainScene.lua
    主界面
]]
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)
-- local scheduler = require("framework.scheduler")
local MainView = require("app.ui.outgame.view.MainView")
--[[--
    构造函数

    @param none

    @return none
]]
function MainScene:ctor()
    self:initScene()
    self.mainView_ = MainView.new() -- 类型：PlayView，主游戏界面
    self:addChild(self.mainView_)
end

function MainScene:onEnter()
end

function MainScene:onExit()
end

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

    if cc.UserDefault:getInstance():getBoolForKey("游戏外音乐") then
        audio.loadFile("sounds/lobby_bgm_120bpm.OGG", function()--大厅背景音乐
            audio.playBGM("sounds/lobby_bgm_120bpm.OGG", true)
        end)
    else
        audio.loadFile("sounds/lobby_bgm_120bpm.OGG", function()--大厅背景音乐
            audio.stopBGM("sounds/lobby_bgm_120bpm.OGG")
        end)
    end
end

function MainScene:update(dt)
    -- print("dt=", dt)
end

return MainScene
