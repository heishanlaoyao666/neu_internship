--[[
    StateSprite.lua
     描述：精灵点
    编写：李昊

]]

local StateSprite = class("State", function(State)
    return display.newSprite("image/fight/fight/buff/firing.png")
end)

--[[--
    构造函数

    @param res 类型：string，资源路径
    @param data 类型：State 敌人数据

    @return none
]]
function StateSprite:ctor(data)
    self.data_ = data -- 类型：State ，敌人数据
    self:setAnchorPoint(0.5, 0.3)
    self:setScale(0.7)
    self:setPosition(self.data_:getX(), self.data_:getY())
end

--[[
    帧刷新

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function StateSprite:update(dt)
    self:setPosition(self.data_:getX(), self.data_:getY())
end

return StateSprite