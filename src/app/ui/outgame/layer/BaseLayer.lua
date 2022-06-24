--[[--
    BaseLayer.lua
    Layer基类
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