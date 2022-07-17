--[[
    BulletSprite.lua
    描述：防御塔点
    编写：李昊
    修订：周星宇
    检查：张昊煜
]]

local BulletSprite = class("Bullet",function(Bullet)
    return display.newSprite("image/fight/fight/bullet/1.png")
end)

--[[--
    构造函数

    @param res 类型：string，资源路径
    @param data 类型：Bullet 子弹数据
    
    @return none
]]
function BulletSprite:ctor(Bullet, data)

    self.data_ = data -- 类型：Enemy ，敌人数据

    self:setAnchorPoint(0.5, 0.5)
    self:setPosition(self.data_:getX(), self.data_:getY())
end

--[[
    帧刷新

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function BulletSprite:update(dt)
    self:setPosition(self.data_:getX(), self.data_:getY())
end

return BulletSprite