--[[--
    子弹节点
    BulletSprite.lua
]]
local DiamondSprite = class("Diamond", function(res)
    return display.newSprite(res)
end)

--[[--
    构造函数

    @param res 类型：string，图片资源
    @param data 类型：Bullet，子弹数据

    @return none
]]
function DiamondSprite:ctor(res, data)
    self.data_ = data -- 类型：Bullet，子弹数据
    self:setAnchorPoint(0.5, 0.5)
    self:setPosition(self.data_:getX(), self.data_:getY())
end

--[[--
    帧刷新

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function DiamondSprite:update(dt)
    self:setPosition(self.data_:getX(), self.data_:getY())
end

return DiamondSprite