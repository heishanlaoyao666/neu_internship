--[[
    Enemy.lua
    卡牌的父类
    描述：在player中储存信息
    编写：李昊
    修订：周星宇
    检查：张昊煜
]]

local Enemy  = class("Enemy",require("src.app.data.Object"))
local EventManager = require("app.manager.EventManager")
local EventDef = require("app.def.EventDef")

--[[
    构造函数
    @param x,y,name
    @return none
]]
function Enemy:ctor(x, y,id,hp)
    Enemy.super.ctor(self, x, y)

    --- 怪物基本信息
    self.hp_ = hp --血量 number
    self.id_ = id --序列号 第几只 number
    self.isDeath_ = false --是否死亡
    self.state_ = {} --状态列表
    for i = 1,5 do
        self.state_[i] = 0
    end

    EventManager:doEvent(EventDef.ID.ENEMY_CREATE,self)
    EventManager:doEvent(EventDef.ID.ENEMY_LIFE_CREATE,self)
end

--[[
    getId函数
    @param dt 类型：number，帧间隔，单位秒
    @return none
]]
function Enemy:getId()
    return self.id_
end

function Enemy:getHp()
    return self.hp_
end
--[[--
    销毁

    @param none

    @return none
]]
function Enemy:destroy()
    self.isDeath_ = true 
    EventManager:doEvent(EventDef.ID.ENEMY_DEATH,self)
    EventManager:doEvent(EventDef.ID.ENEMY_LIFE_DEATH,self)
    for i = 1,5 do
        if self.state_[i] == 1 then
            EventManager:doEvent(EventDef.ID.STATE_DEATH,self)
        end
    end
end

--[[
    update
    @param dt 类型：number，帧间隔，单位秒
    @return none
]]
function Enemy:update(data)
    --敌人信息管理
    self.x_ = data.x
    self.y_ = data.y
    self.hp_ = data.hp
    --状态管理
    if data.state == nil then
        for i = 1,5 do
            self.state_[i] = 0
        end
    else
        for k,v in pairs(data.state) do
            if self.state_[k] == 1 then
            else
                self.state_[k] = 1
                EventManager:doEvent(EventDef.ID.STATE_CREATE,self)
            end
        end

        for k,v in pairs(data.state) do
            local isDestroy = true
            if data.state[k] == nil then
                self.state_[k] = 0
                EventManager:doEvent(EventDef.ID.STATE_DEATH,self)
            end
        end

    end
end

return Enemy