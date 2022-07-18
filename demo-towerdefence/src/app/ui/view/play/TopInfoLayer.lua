--[[--
    TopInfoLayer.lua

    描述：顶部信息层，也即对手的信息+操作
]]
local TopInfoLayer = class("TopInfoLayer", require("app.ui.view.common.BaseNode"))
local Log = require("app.util.Log")

--[[--
    描述：构造函数

    @param none

    @return none
]]
function TopInfoLayer:ctor()
    TopInfoLayer.super.ctor(self)

    Log.d()
end

--[[--
    描述：构造函数

    @param none

    @return none
]]
function TopInfoLayer:onEnter()
    TopInfoLayer.super.onEnter(self)

    Log.d()
end

return TopInfoLayer