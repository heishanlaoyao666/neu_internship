--[[--
    游戏主界面
    PlayView.lua
]]
local PlayView = class("PlayView", function()
    return display.newColorLayer(cc.c4b(0, 0, 0, 0))
end)
local BGLayer = require("app.ui.layer.BGLayer")
local InfoLayer = require("app.ui.layer.InfoLayer")
local MainBoardLayer = require("app.ui.layer.MainBoardLayer")
local NextBoardLayer = require("app.ui.layer.NextBoardLayer")

--[[--
    构造函数

    @param none

    @return none
]]
function PlayView:ctor(gameData)
    self.bgLayer_ = nil -- 类型：BGLayer，背景层
    self.mainBoardLayer_ = nil -- 类型：MainBoardLayer，主面板层
    self.infoLayer_ = nil -- 类型：InfoLayer，信息层
    self.nextBoardLayer_ = nil -- 类型：NextBoardLayer，预告层

    self.gameData_ = gameData

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
function PlayView:initView()
    self.bgLayer_ = BGLayer.new(self.gameData_)
    self:addChild(self.bgLayer_)

    self.mainBoardLayer_ = MainBoardLayer.new(self.gameData_)
    self:addChild(self.mainBoardLayer_)

    self.infoLayer_ = InfoLayer.new(self.gameData_)
    self:addChild(self.infoLayer_)

    self.nextBoardLayer_ = NextBoardLayer.new(self.gameData_)
    self:addChild(self.nextBoardLayer_)

end

--[[--
    节点进入

    @param none

    @return none
]]
function PlayView:onEnter()
    print("PlayView Enter!")
end

--[[--
    节点退出

    @param none

    @return none
]]
function PlayView:onExit()
    print("PlayView Exit!")
end

--[[--
    帧刷新

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function PlayView:update(dt)
    self.mainBoardLayer_:update(dt)
    self.nextBoardLayer_:update(dt)
    self.infoLayer_:update(dt)
end

return PlayView