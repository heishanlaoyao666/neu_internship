--[[--
    游戏全局数据
    GameData.lua
]]
local ConstDef = require("app.def.ConstDef")
local EventManager = require("app.manager.EventManager")
local EventDef = require("app.def.EventDef")
local Block = require("app.data.Block")
local MainBoard = require("app.data.MainBoard")
local NextBoard = require("app.data.NextBoard")
local GameData = class("GameData")


--[[--
    构造函数

    @param none

    @return none
]]
function GameData:ctor()
    self:init()
end

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
    self.curStyle_ = nil -- 类型：number，当前风格
    self.nextStyle_ = nil -- 类型：number，下一风格

    self.mainBoard_ = MainBoard.new()
    self.nextBoard_ = NextBoard.new()

    self.mainBlock_ = nil
    self.nextBlock_ = nil
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
    self.speed_ = 1 - 0.1 * self.level_
    return self.speed_ < 0.1 and 0.1 or self.speed_
end

--[[--
    获得当前风格

    @param none

    @return number
]]
function GameData:getCurStyle()

    if self.curStyle_ == nil then
        self.curStyle_ = Block:randomStyle()
    end

    return self.curStyle_
end

--[[--
    获得下一个风格

    @param none

    @return number
]]
function GameData:getNextStyle()

    if self.nextStyle_ == nil then
        self.nextStyle_ = Block:randomStyle()
    end

    self.curStyle_ = self.nextStyle_

    self.nextStyle_ = Block:randomStyle()

    return self.curStyle_
end

--[[--
    计算得分

    @param none

    @return none
]]
function GameData:calScore(count)
    if count == 1 then
        self.score_ = self.score_ + 5
    elseif count == 2 then
        self.score_ = self.score_ + 15
    elseif count == 3 then
        self.score_ = self.score_ + 25
    elseif count == 4 then
        self.score_ = self.score_ + 35
    end

    local level = math.floor(self.score_ / 100) + 1

    if level ~= self.level_ then
        self.level_ = level
        EventManager:doEvent(EventDef.ID.UPDATE_SPEED)
    end
end

--[[--
    获取MainBoard

    @param none

    @return MainBoard
]]
function GameData:getMainBoard()
    return self.mainBoard_
end

--[[--
    获取NextBoard

    @param none

    @return NextBoard
]]
function GameData:getNextBoard()
    return self.nextBoard_
end

--[[--
    获取MainBlock

    @param none

    @return MainBlock
]]
function GameData:getMainBlock()
    return self.mainBlock_
end

--[[--
    获取NextBlock

    @param none

    @return NextBlock
]]
function GameData:getNextBlock()
    return self.nextBlock_
end

--[[--
    生成新块

    @param none

    @return number
]]
function GameData:generateBlock()

    -- Current
    self:gen()

    -- Next
    local style = self:getNextStyle()
    self.nextBoard_:clear()
    self.nextBlock_ = Block.new(self.nextBoard_, style)
    self.nextBlock_:rawPlace(style, 1, -1, 4)

end


--[[--
    响应函数

    @param none

    @return none
]]
function GameData:tick()

    if self:getGameState() ~= ConstDef.GAME_STATE.PLAY then
        return
    end

    -- 如果无法移动就生成一个新块
    if not self.mainBlock_:move(0, -1) then
        -- 由于两个面板都需要更新，所以使用事件
        self:generateBlock()
    else
        self.mainBlock_:clear()
        local count = 0

        -- 触发清除事件
        while true do
            local temp = self.mainBoard_:checkAndSweep()
            if temp <= 0 then
                break
            end
            count = count + temp
            self.mainBoard_:shift()
        end

        self:calScore(count)

        self.mainBlock_:place()
    end
end

--[[--
    生成块

    @param none

    @return none
]]
function GameData:gen()

    local style = self:getCurStyle()

    self.mainBlock_ = Block.new(self.mainBoard_, style)

    if not self.mainBlock_:place() then
        -- GameOver
        self.mainBoard_:clear()
        EventManager:doEvent(EventDef.ID.OVER_GAME)
    end
end

--[[--
    帧刷新 - 总游戏调度函数

    @param none

    @return none
]]
function GameData:update(dt)

end

return GameData