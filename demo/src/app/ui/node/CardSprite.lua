--[[
    CardSprite.lua
     描述：防御塔点
    编写：李昊
    修订：周星宇
    检查：张昊煜
]]

local CardSprite = class("Card",function(card)
    return display.newSprite(card)
end)

local EventManager = require("app.manager.EventManager")
local EventDef = require("app.def.EventDef")

--[[--
    构造函数

    @param res 类型：string，资源路径
    @param data 类型：Card 防御塔数据
    
    @return none
]]
function CardSprite:ctor(card, data)
    self.data_ = data -- 类型：Enemy ，敌人数据
    self.isMove_ = false

    self:setAnchorPoint(0.5, 0.5)
    self:setScale(0.85)
    self:setPosition(self.data_:getX(), self.data_:getY())

    local delta = {} -- 鼠标按下的位置和中心点位置的偏移量
    self:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
        if event.name == "began" then
            local x, y = self:getPosition()
            delta.x = event.x - x
            delta.y = event.y - y
            EventManager:doEvent(EventDef.ID.CARD_BEGAN_DRAG, self)
            self.isMove_ = true
            self.data_:setIsMove(true)
            return true
        end
        if event.name == "moved" then
            if (event.x < display.right - 10 and event.y < display.top - 10) then
                self:setPosition(cc.p(event.x - delta.x, event.y - delta.y))
                EventManager:doEvent(EventDef.ID.CARD_MOVED_DRAG, self)
            end
        end
        if event.name == "ended" then
            self.isMove_ = false
            self.data_:setIsMove(false)
            EventManager:doEvent(EventDef.ID.CARD_ENDED_DRAG, self)
        end
    end)
    self:setTouchEnabled(true)
end

function CardSprite:getCardPos()
    return {x = self.data_:getX(), y = self.data_:getY()}
end

--[[
    帧刷新

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function CardSprite:update(dt)
    if self.isMove_ then
    else
        self:setPosition(self.data_:getX(), self.data_:getY())
    end
end

return CardSprite