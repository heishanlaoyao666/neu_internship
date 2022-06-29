--[[--
    游戏主界面
    PlayView.lua
]]
local BattleView = class("BattleView", function()
    return display.newColorLayer(cc.c4b(0, 0, 0, 0))
end)
--local TopInfoLayer = require("src\\app\\ui\\outgame\\layer\\TopInfoLayer.lua")
--local BottomInfoLayer = require("src\\app\\ui\\outgame\\layer\\BottomInfoLayer.lua")

--[[--
    构造函数

    @param none

    @return none
]]
function BattleView:ctor()
    self.TopInfoLayer_ = nil -- 类型：TopInfoLayer，顶部信息层
    self.BottomInfoLayer_ = nil -- 类型：BottomInfoLayer，底部信息层
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
function BattleView:initView()
    local width, height = display.width, 80
    self.container_ = ccui.Layout:create()
    --self.container_:setBackGroundColor(cc.c3b(200, 0, 0))
    --self.container_:setBackGroundColorType(1)
    self.container_:setContentSize(display.width, height)
    self.container_:addTo(self)
    self.container_:setAnchorPoint(0.5, 1)
    self.container_:setPosition(display.cx, display.height)
end

--[[--
    节点进入

    @param none

    @return none
]]
function BattleView:onEnter()
end

--[[--
    节点退出

    @param none

    @return none
]]
function BattleView:onExit()
end

--[[--
    帧刷新

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function BattleView:update(dt)
end

return BattleView