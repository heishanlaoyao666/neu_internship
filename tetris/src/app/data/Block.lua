--[[--
    Block.lua
    方块数据文件
]]
local Block = class("Block", require("app.data.Object"))
local ConstDef = require("app.def.ConstDef")
local EventDef = require("app.def.EventDef")
local EventManager = require("app.manager.EventManager")

--[[--
    构造函数

    @param none

    @return none
]]
function Block:ctor()
    Block.super.ctor(self, 0, 0, ConstDef.BLOCK_SIZE.WIDTH, ConstDef.BLOCK_SIZE.HEIGHT)
    EventManager:doEvent(EventDef.ID.CREATE_BULLET, self)
end

--[[--
    方块销毁

    @param none

    @return none
]]
function Block:destory()
    self.isDeath_ = true 
    EventManager:doEvent(EventDef.ID.DESTORY_BULLET, self)
end
--[[--
    方块移动

    @param x 类型：int，横坐标
    @param y 类型：int，纵坐标

    @return none
]]
function Block:move(x,y)
    self.y_ = self.y_ + ConstDef.BLOCK_SIZE.HEIGHT
end
--[[--
    方块帧刷新

    @param dt 类型：number，时间，秒

    @return none
]]
function Block:update(dt)
    --self.y_ = self.y_ + ConstDef.BULLET_SPEED * dt

    if not self.isDeath_ then
        if self.y_ > display.top + ConstDef.BULLET_SIZE.HEIGHT then
            self:destory()
        end
    end
end

return Block