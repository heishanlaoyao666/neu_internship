--[[--
    BasePage.lua

    描述：大厅中主页面基类，派生有：商城、战斗、图鉴页面
]]
local BasePage = class("BasePage", function() return ccui.Layout:create() end)
local Log = require("app.util.Log")

--[[--
    描述：构造函数

    @param none

    @return none
]]
function BasePage:ctor()
    -- NodeEX扩展，注册生命周期函数
    self:setNodeEventEnabled(true)
end

--[[--
    描述：页面进入

    @param none

    @return none
]]
function BasePage:onEnter()
    Log.d()
end

--[[--
    描述：页面退出

    @param none

    @return none
]]
function BasePage:onExit()
    Log.d()
end

return BasePage