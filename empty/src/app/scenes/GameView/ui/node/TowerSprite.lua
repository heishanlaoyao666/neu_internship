local TowerSprite = class("Tower", function(res)
    return display.newSprite(res)
end)
--[[--
    构造函数

    @param res 类型：string，资源路径
    @param data 类型：Enemy，怪物数据
    
    @return none
]]
function TowerSprite:ctor(res, data)
    self.data_ = data -- 类型：Enemy，怪物数据

    self:setAnchorPoint(0.5, 0.5)
    self:setPosition(self.data_:getX(), self.data_:getY())

    self.star_level_= display.newSprite(string.format("ui/battle/Battle interface/Angle sign-Grade/%u.png",data:getGrade()))
    self.star_level_:setAnchorPoint(0.5,0.5)
    self.star_level_:setPosition(80,85)
    self:addChild(self.star_level_)

end

--[[--
    帧刷新

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function TowerSprite:update(dt)
    self:setPosition(self.data_:getX(), self.data_:getY())
    self.star_level_:setTexture(string.format("ui/battle/Battle interface/Angle sign-Grade/%u.png",self.data_:getGrade()))
end

return TowerSprite