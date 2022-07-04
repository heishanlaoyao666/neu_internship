--[[
    DownBar.lua
    DownBar底部栏
    描述：DownBar底部栏
    编写：周星宇
    修订：李昊
    检查：张昊煜
]]
local DownBar = class("DownBar", function()
    return display.newColorLayer(cc.c4b(0, 0, 0, 0))
end)

local MenuLayer = require("app.ui.layer.lobby.down.MenuLayer")

--[[--
    构造函数

    @param none

    @return none
]]
function DownBar:ctor()

    self.menuLayer_ = nil -- 类型：MenuLayer，菜单层

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
function DownBar:initView()

    self.menuLayer_ = MenuLayer.new()
    self:addChild(self.menuLayer_)
end

--[[--
    节点进入

    @param none

    @return none
]]
function DownBar:onEnter()
end

--[[--
    节点退出

    @param none

    @return none
]]
function DownBar:onExit()
end


return DownBar