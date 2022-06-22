--[[
    下落的方块的组的基类
]]

local Diamond = class("DiamondGroup",require("src.app.data.Object"))
local ConstDef = require("app.def.ConstDef")
local EventDef = require("app.def.EventDef")
local EventManager = require("app.manager.EventManager")

--[[--
    构造函数

    @param 位置x，y 颜色 color

    @return none
]]
function Diamond:ctor(x,y,color)
    Diamond.super.ctor(self, x, y, color)
    EventManager:doEvent(EventDef.ID.CREATE_DIAMOND, self)
end

--[[--
    方块销毁

    @param none

    @return none
]]
function Diamond:destory()
    self.isDeath_ = true 
    EventManager:doEvent(EventDef.ID.DESTORY_DIAMOND, self)
end

--[[
    方块下一一格
]]
function Diamond:drop()
    self.y_ = self.y_ - ConstDef.DIAMOND_SIZE.HEIGHT
end

--[[
    方块帧刷新

    @param dt 类型：number，时间，秒

    @return none
]]
function Diamond:update(dt)
    if not self.isDeath_ then
        if self.y_ < display.buttom + ConstDef.DIAMOND_SIZE.HEIGHT then
            self:destory()
        end
    end
end

return Diamond