--[[--
    游戏结束主界面
    OverView.lua
]]
local OverView = class("OverView", function()
    return display.newColorLayer(cc.c4b(0, 0, 0, 0))
end)
local BGLayer = require("app.ui.layer.BGLayer")
local OverLayer = require("app.ui.layer.OverLayer")


--[[--
    构造函数

    @param none

    @return none
]]
function OverView:ctor(gameData)
    self.bgLayer_ = nil -- 类型：BGLayer，背景层
    self.overLayer_ = nil -- 类型：MainBoardLayer，主面板层

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
function OverView:initView()
    self.bgLayer_ = BGLayer.new(self.gameData_)
    self:addChild(self.bgLayer_)

    self.overLayer_ = OverLayer.new(self.gameData_)
    self:addChild(self.overLayer_)

end

--[[--
    节点进入

    @param none

    @return none
]]
function OverView:onEnter()

end

--[[--
    节点退出

    @param none

    @return none
]]
function OverView:onExit()

end

--[[--
    帧刷新

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function OverView:update(dt)

end

--[[--
    显示界面

    @param none

    @return none
]]
function OverView:showView()
    self:setVisible(true)
end

--[[--
    隐藏界面

    @param callback 类型：function，动画完成回调

    @return none
]]
function OverView:hideView(callback)
    self:setVisible(false)
end

return OverView