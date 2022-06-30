local EnemySprite = class("Enemy", function(res)
    return display.newSprite(res)
end)
--[[--
    构造函数

    @param res 类型：string，资源路径
    @param data 类型：Enemy，怪物数据
    
    @return none
]]
function EnemySprite:ctor(res, data)
    self.data_ = data -- 类型：Enemy，怪物数据

    self:setAnchorPoint(0.5, 0.5)
    self:setPosition(self.data_:getX(), self.data_:getY())

    self.life_ = cc.Label:createWithTTF(self.data_:getLife(),"ui/font/fzbiaozjw.ttf",15)
    self:addChild(self.life_)
    self.life_:setAnchorPoint(0.5,0.5)
    self.life_:setPosition(20,10)
end

--[[--
    帧刷新

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function EnemySprite:update(dt)
    self:setPosition(self.data_:getX(), self.data_:getY())
    self.life_:setString(self.data_:getLife())
end

return EnemySprite