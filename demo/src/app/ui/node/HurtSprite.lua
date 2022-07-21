--[[
    HurtSprite.lua
     描述：精灵点
    编写：李昊

]]

local HurtSprite = class("Hurt", function()
    local hurt = cc.Label:createWithTTF("","font/fzbiaozjw.ttf",20)
    return hurt
end)

--[[--
    构造函数

    @param res 类型：string，资源路径
    @param data 类型：Hurt 敌人数据

    @return none
]]
function HurtSprite:ctor(data)
    self.data_ = data -- 类型：Hurt ，敌人数据
    self:setAnchorPoint(0.5, 0.5)
    if data.color == 1 then
        self:setColor(cc.c3b(255, 255, 255))
    elseif data.color == 2 then
        self:setColor(cc.c3b(255, 255, 0))
    end
    self:enableOutline(cc.c4b(0, 0, 0, 255),1)
    self:setPosition(self.data_:getX(), self.data_:getY())
end

--[[
    帧刷新

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function HurtSprite:update(dt)
    self:setPosition(self.data_:getX(), self.data_:getY())
    self:setString(string.format("%d", self.data_:getNum()))
end

return HurtSprite