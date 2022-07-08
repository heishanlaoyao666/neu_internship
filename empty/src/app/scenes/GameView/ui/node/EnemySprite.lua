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

    self.random_x_=math.random(-20,20)
    self.random_y_=math.random(-30,30)

    local ttfsize =15
    if data:getTag()>=3 then
        ttfsize=30
    end
    self.life_ = cc.Label:createWithTTF(self.data_:getLife(),"ui/font/fzbiaozjw.ttf",ttfsize)
    self:addChild(self.life_)
    self.life_:setAnchorPoint(0.5,0.5)
    self.life_:setPosition(data:getWidth()*0.5,10)

    --自适应
    --self:setScale(2)
end

--[[--
    帧刷新

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function EnemySprite:update(dt)
    self:setPosition(self.data_:getX()+self.random_x_, self.data_:getY()+self.random_y_)
    self.life_:setString(self.data_:getLife())
end

return EnemySprite