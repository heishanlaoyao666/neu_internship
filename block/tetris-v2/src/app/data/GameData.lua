--[[--
    GameData.lua
    游戏数据总文件，注意：只有一份，全局唯一
]]
local ConstDef = require("app.def.ConstDef")
local EventManager = require("app.manager.EventManager")
local EventDef = require("app.def.EventDef")
local Block = require("app.data.Block")
local GameData = {}

local style_ = nil -- 单例的风格
--[[--
    初始化数据

    @param none

    @return none
]]
function GameData:init()
    self.score_ = 0 -- 类型：number，得分
    self.level_ = 0 -- 类型：number，等级
    self.speed_ = 0.5 -- 类型：number，速度
    self.gameState_ =  ConstDef.GAME_STATE.INIT -- 类型：number，游戏状态
end

--[[--
    获取分数

    @param none

    @return number
]]
function GameData:getScore()
    return self.score_
end

--[[--
    获取等级

    @param none

    @return number
]]
function GameData:getLevel()
    return self.level_
end

--[[--
    帧刷新

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function GameData:update(dt)

end

--[[--
    是否游戏中

    @param none

    @return boolean
]]
function GameData:isPlaying()
    return self.gameState_ == ConstDef.GAME_STATE.PLAY
end

--[[--
    设置游戏状态

    @param state 类型：number，游戏状态

    @return none
]]
function GameData:setGameState(state)
    self.gameState_ = state
    EventManager:doEvent(EventDef.ID.GAMESTATE_CHANGE, state)
end

--[[--
    获取游戏状态

    @param none

    @return number
]]
function GameData:getGameState()
    return self.gameState_
end

--[[--
    获取速度

    @param none

    @return number
]]
function GameData:getSpeed()
    return self.speed_
end

--[[--
    下一个风格

    @param none

    @return number
]]
function GameData:getStyle()

    local style

    if style_ == nil then
        style_ = Block:RandomStyle()
    end

    style = style_
    style_ = Block:RandomStyle()

    return style
end

--[[--
    计算得分

    @param none

    @return none
]]
function GameData:CalScore(count)
    if count == 1 then
        self.score_ = self.score_ + 5
    elseif count == 2 then
        self.score_ = self.score_ + 15
    elseif count == 3 then
        self.score_ = self.score_ + 25
    elseif count == 4 then
        self.score_ = self.score_ + 35
    end

    self.level_ = self.score_ / 100 + 1
end

--[[--
    帧刷新 - 总游戏调度函数

    @param none

    @return none
]]
function GameData:update(dt)
    if self.gameState_ ~= ConstDef.GAME_STATE.PLAY then
        return
    end

    EventManager:doEvent(EventDef.ID.CREATE_BLOCK)
end



return GameData