--[[
    EnemySprite.lua
     描述：精灵点
    编写：李昊

]]

local EnemySprite = class("Enemy", function(enemy)
    return display.newSprite(enemy)
end)

--[[--
    构造函数

    @param res 类型：string，资源路径
    @param data 类型：Enemy 敌人数据

    @return none
]]
function EnemySprite:ctor(enemy, data)
    self.data_ = data -- 类型：Enemy ，敌人数据
    self:setAnchorPoint(0.5, 0.5)
    self:setPosition(self.data_:getX(), self.data_:getY())
end

--[[
    帧刷新

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function EnemySprite:update(dt)
    self:setPosition(self.data_:getX(), self.data_:getY())
end

return EnemySprite