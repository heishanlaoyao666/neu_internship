--[[
    Bullet.lua
    卡牌的父类
    描述：在player中储存信息
    编写：李昊
]]

local Bullet  = class("Bullet",require("src.app.data.Object"))
local EventManager = require("app.manager.EventManager")
local EventDef = require("app.def.EventDef")

--[[
    构造函数
    @param x,y,name
    @return none
]]
function Bullet:ctor(x, y,size,id)
    Bullet.super.ctor(self, x, y)
    self.size_ = size
    self.id_ = id
    EventManager:doEvent(EventDef.ID.BULLET_CREATE,self)
end

--[[
    getId函数
    @param dt 类型：number，帧间隔，单位秒
    @return none
]]
function Bullet:getId()
    return self.id_
end

--[[
    getSize函数
    @param dt 类型：number，帧间隔，单位秒
    @return none
]]
function Bullet:getSize()
    return self.size_
end

--[[--
    销毁

    @param none

    @return none
]]
function Bullet:destroy()
    EventManager:doEvent(EventDef.ID.BULLET_DEATH,self)
end

--[[
    update
    @param dt 类型：number，帧间隔，单位秒
    @return none
]]
function Bullet:update(data)
    self.x_ = data.x
    self.y_ = data.y
end

return Bullet