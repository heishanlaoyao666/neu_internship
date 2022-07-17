

local Hurt = class("Hurt",require("src.app.data.Object"))
local EventManager = require("app.manager.EventManager")
local EventDef = require("app.def.EventDef")

function Hurt:ctor(x,y,id,num,color)
    self.x_ = x
    self.y_ = y
    self.id_ = id
    self.num_ = num
    self.color_ = color
    print("----- add hurt -----")
    print(self.num_)

    EventManager:doEvent(EventDef.ID.HURT_CREATE,self)
end 

function Hurt:getId()
    return self.id_
end

function Hurt:getNum()
    return self.num_
end

function Hurt:getColor()
    return self.color_
end

function Hurt:destroy()
    EventManager:doEvent(EventDef.ID.HURT_DEATH,self)
end

function Hurt:update(data)
    self.x_ = data.x
    self.y_ = data.y
    self.num_ = data.num
end

return Hurt