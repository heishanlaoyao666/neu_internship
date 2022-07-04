local DamageSprite = class("Damage",function()
    return ccui.Layout:create()
end)
--[[--
    构造函数

    @param damage 类型：number，数字
    @param data 类型：Bullet，怪物数据
    
    @return none
]]
function DamageSprite:ctor(data)
    self.data_ = data -- 类型：Bullet，子弹数据
    self.random_x_=math.random(-10,10)
    self.random_y_=math.random(-10,10)

    self:setAnchorPoint(0.5, 0.5)
    self:setPosition(self.data_:getX()+self.random_x_, self.data_:getY()+self.random_y_)

    self.number_ =ccui.Text:create(self.data_:getDamage(), "ui/font/fzbiaozjw.ttf", 15)
    if self.data_:getCritical() then
        print("暴击了")
    end
    self.number_:setAnchorPoint(0.5, 0.5)
    self:addChild(self.number_)
    -- self.life_ = cc.Label:createWithTTF(self.data_:getLife(),"ui/font/fzbiaozjw.ttf",15)
    -- self:addChild(self.life_)
    -- self.life_:setAnchorPoint(0.5,0.5)
    -- self.life_:setPosition(20,10)
end

--[[--
    帧刷新

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function DamageSprite:update(dt)
    self:setPosition(self.data_:getX()+self.random_x_, self.data_:getY()+self.random_y_)
end

return DamageSprite