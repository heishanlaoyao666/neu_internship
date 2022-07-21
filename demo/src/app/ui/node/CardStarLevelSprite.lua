--[[
    CardStarLevelSprite.lua
     描述：防御塔点
    编写：李昊
    修订：周星宇
    检查：张昊煜
]]
local FightConstDef = require("src.app.def.FightConstDef")

local CardStarLevelSprite = class("Card",function(data)
    return display.newSprite(FightConstDef.OTHER_IMAGE.STAR_LEVEL[data:getStarLevel()])
end)

--[[--
    构造函数

    @param res 类型：string，资源路径
    @param data 类型：Card 防御塔数据
    
    @return none
]]
function CardStarLevelSprite:ctor(data)
    self.data_ = data -- 类型：Enemy ，敌人数据
    self:setAnchorPoint(0.5, 0.5)
    self:setPosition(self.data_:getX() + 30, self.data_:getY()+35)
end

--[[
    帧刷新

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function CardStarLevelSprite:update(dt)
    if self.data_:getIsMove() then
        self:setVisible(false)
    else
        self:setVisible(true)
    end
    self:setPosition(self.data_:getX(), self.data_:getY())
end

return CardStarLevelSprite