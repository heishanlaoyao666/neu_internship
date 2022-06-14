--[[--
    GameData.lua
    游戏数据总文件，注意：只有一份，全局唯一
]]
local GameData = {}
-- local Bullet = require("app.data.Bullet")
-- local EnemyPlane = require("app.data.EnemyPlane")
-- local Plane = require("app.data.Plane")
local ConstDef = require("app.def.ConstDef")
local EventDef = require("app.def.EventDef")
local EventManager = require("app.manager.EventManager")

local DOWN_INTERVAL = 0.2 -- 类型：number，下落间隔

local CONTROL_BLOCK =false--类型：bool，玩家是否控制方块移动

local current_blocks_={}--类型:当前方块数组
local next_blocks_={}--类型:下个方块数组
local blocks_={}--类型:底部方块数组

local array_blocks={}--类型:方块数组
--[[--
    初始化数据

    @param none

    @return none
]]
function GameData:init()
    self.score_ = 0 -- 类型：number，得分
    self.downTick_ = 0 -- 类型：number，下落时间tick

    -- 类型：number，历史最高
    self.history_ = cc.UserDefault:getInstance():getIntegerForKey("history", 0)

    -- 类型：number，游戏状态
    self.gameState_ = ConstDef.GAME_STATE.INIT

    --初始化方块
    for i = 1,ConstDef.GAME_HEIGHT_SIZE do
 
        array_blocks[i]={}               --定义行（数组）
 
        for j = 1, ConstDef.GAME_WIDTH_SIZE do
            array_blocks[i][j]=nil         --二维数组中初始化数值都是“0”
        end
    end
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
    获取历史最高

    @param none

    @return number
]]
function GameData:getHistory()
    return self.history_
end

--[[--
    获取当前方块

    @param none

    @return table
]]
function GameData:getCurrentBlock()
    return current_blocks_
end

--[[--
    获取下一个方块

    @param none

    @return table
]]
function GameData:getNextBlock()
    return next_blocks_
end
--[[--
    获取底部方块

    @param none

    @return table
]]
function GameData:getBlock()
    return blocks_
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
    帧刷新

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function GameData:update(dt)
    if self.gameState_ ~= ConstDef.GAME_STATE.PLAY then
        return
    end

    
end
--[[--
    旋转方块

    @param none

    @return none
]]
function GameData:rotationBlock(direction)
    if direction==ConstDef.ROTATION_DIRECTION.LEFT then
        --向左旋转
        else
            --向右旋转

    end
    
end
--[[--
    产生方块

    @param none

    @return none
]]
function GameData:createBlock()
    
end
--[[--
    清理所有方块

    @param none

    @return none
]]
function GameData:clearALL()
    
end
--[[--
    清理最低下一行方块

    @param none

    @return none
]]
function GameData:clearLine()
    
end
return GameData