--[[
    BaseLayer.lua
    Layer基类
    描述：Layer基类
    编写：周星宇
    修订：李昊
    检查：张昊煜
]]
local BaseLayer = class("BaseLayer", function()
    return display.newLayer()
end)

--[[--
    构造函数

    @param none

    @return none
]]
function BaseLayer:ctor()

    self.isListening_ = false
    self.listener_ = nil

    self:registerScriptHandler(function(event)
        if event == "enter" then
            self:onEnter()
        elseif event == "exit" then
            self:onExit()
        end
    end)
end

--[[--
    显示界面

    @param none

    @return none
]]
function BaseLayer:showView()
    self:setVisible(true)
    self.listener_:setSwallowTouches(true)
    self.isListening_ = true
end

--[[--
    隐藏界面

    @param none

    @return none
]]
function BaseLayer:hideView()
    self:setVisible(false)
    self.listener_:setSwallowTouches(false)
    self.isListening_ = false
end

--[[--
    节点进入

    @param none

    @return none
]]
function BaseLayer:onEnter()
end

--[[--
    节点退出

    @param none

    @return none
]]
function BaseLayer:onExit()
end

--[[--
    帧刷新

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function BaseLayer:update(dt)
end

return BaseLayer