--[[--
    方块节点
    BlockSprite.lua
]]
local BlockSprite = class("Block", function(res)
    return display.newSprite(res)
end)

--[[--
    构造函数

    @param res 类型：string，图片资源
    @param data 类型：Block，方块数据

    @return none
]]
function BlockSprite:ctor(res, data)
    self.data_ = data -- 类型：Bullet，子弹数据
    self:setScale(0.4)
    self:setAnchorPoint(0, 0)
    self:setPosition(self.data_:getX(), self.data_:getY())
end

--[[--
    帧刷新

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function BlockSprite:update(dt)
    self:setPosition(self.data_:getX(), self.data_:getY())
end

return BlockSprite

