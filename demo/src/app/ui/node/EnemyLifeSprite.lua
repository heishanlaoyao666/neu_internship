--[[
    EnemySprite.lua
     描述：精灵点
    编写：李昊
    修订：周星宇
    检查：张昊煜
]]

local EnemyDef = require("src.app.def.EnemyDef")

local EnemySprite = class("Enemy", function()
    local life = cc.Label:createWithTTF("","font/fzbiaozjw.ttf",EnemyDef.HP_SIZE)
    life:setAnchorPoint(0.5, 1.0)
    life:setColor(cc.c3b(255, 255, 255))
    life:enableOutline(cc.c4b(0, 0, 0, 255),1)
    return life 
end)

--[[--
    构造函数

    @param res 类型：string，资源路径
    @param data 类型：Enemy 敌人数据
    
    @return none
]]
function EnemySprite:ctor(data)
    self.data_ = data -- 类型：Enemy ，敌人数据
    self:setPosition(self.data_:getX(), self.data_:getY())
end

--[[--
    帧刷新

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function EnemySprite:update(dt)
    self:setPosition(self.data_:getX(), self.data_:getY())
    self:setString(string.format("%d", self.data_:getHp()))
end

return EnemySprite