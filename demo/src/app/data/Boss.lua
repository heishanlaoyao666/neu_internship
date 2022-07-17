--[[
    Boss.lua
]]

local Boss = class("Boss",require("src.app.data.Object"))

local EventManager = require("app.manager.EventManager")
local EventDef = require("app.def.EventDef")

function Boss:ctor(x, y, id, hp)
    Boss.super.ctor(self, x, y)

    --- 怪物基本信息
    self.hp_ = hp --血量 number
    self.id_ = id --序列号 第几只 number
    self.isDeath_ = false --是否死亡
    self.state_ = {} --状态列表

    EventManager:doEvent(EventDef.ID.BOSS_CREATE,self)
    EventManager:doEvent(EventDef.ID.ENEMY_LIFE_CREATE,self)

end

--[[
    getId函数
    @param dt 类型：number，帧间隔，单位秒
    @return none
]]
function Boss:getId()
    return self.id_
end

function Boss:getHp()
    return self.hp_
end
--[[--
    销毁

    @param none

    @return none
]]
function Boss:destroy()
    self.isDeath_ = true 
    EventManager:doEvent(EventDef.ID.BOSS_DEATH,self)
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
function Boss:update(data)
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
            if data.state[k] == nil then
                self.state_[k] = 0
                EventManager:doEvent(EventDef.ID.STATE_DEATH,self)
            end
        end

    end
end

return Boss