local TowerSprite = class("TowerSprit", function(res)
    return display.newSprite(res)
end)

--[[--
    构造函数

    @param res 类型：string，资源路径
    @param data 类型：object, 塔数据

    @return none
]]
function TowerSprite:ctor(res, data)
    self.data_ = data

    self:setPosition(self.data_:getX(), self.data_:getY())
end

--[[--
    帧刷新

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function TowerSprite:update(dt)
    self:setPosition(self.data_:getX(), self.data_:getY())
end

return TowerSprite
