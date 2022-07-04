--[[
    DialogView.lua
    弹窗界面
    描述：弹窗界面
    编写：周星宇
    修订：李昊
    检查：张昊煜
]]
local DialogView = class("DialogView", function()
    return display.newColorLayer(cc.c4b(0, 0, 0, 0))
end)

local DialogManager = require("app.manager.DialogManager")

--[[--
    构造函数

    @param none

    @return none
]]
function DialogView:ctor()

    self.container_ = nil

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
function DialogView:initView()

    self.container_ = ccui.Layout:create()
    self.container_:setContentSize(display.width, display.height)
    self.container_:addTo(self)
    self.container_:setAnchorPoint(0.5, 0.5)
    self.container_:setPosition(display.cx, display.cy)

    DialogManager:init(self.container_)
end

--[[--
    节点进入

    @param none

    @return none
]]
function DialogView:onEnter()
end

--[[--
    节点退出

    @param none

    @return none
]]
function DialogView:onExit()
end


return DialogView