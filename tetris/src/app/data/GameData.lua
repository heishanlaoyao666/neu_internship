--[[--
    GameData.lua
    游戏数据总文件，注意：只有一份，全局唯一
]]
local GameData = {}
-- local Bullet = require("app.data.Bullet")
local Block = require("app.data.Block")
-- local Plane = require("app.data.Plane")
local ConstDef = require("app.def.ConstDef")
local EventDef = require("app.def.EventDef")
local EventManager = require("app.manager.EventManager")

local DOWN_INTERVAL = 0.1 -- 类型：number，下落间隔

local CONTROL_BLOCK =false--类型：bool，玩家是否控制方块移动

local current_blocks_={}--类型:当前方块数组
local next_blocks_={}--类型:下个方块数组
local bottom_blocks_={}--类型:底部方块数组

local array_blocks_={}--类型:方块数组
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
    for x = 1,ConstDef.GAME_WIDTH_SIZE do
 
        array_blocks_[x]={}               --定义行（数组）
 
        for y = 1, ConstDef.GAME_HEIGHT_SIZE do
            array_blocks_[x][y]=nil         --二维数组中初始化数值都是nil
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
    if CONTROL_BLOCK==false then
        GameData:createBlocks(ConstDef.BLOCK_COLOUR.BLUE)
        CONTROL_BLOCK=true
    end
    GameData:blockMove(current_blocks_,dt,0,-1)
end
--[[--
    方块定时向下移动

    @param blocks 类型：table，要移动的方块表
    @param dt 类型：number，帧间隔，单位秒
    @param x 类型：number，移动方向
    @param t 类型：number，移动方向

    @return none
]]
function GameData:blockMove(move_blocks,dt,x,y)
    if #move_blocks==0 then
        return
    end
    if #move_blocks == 0 then
        return
    end
    self.downTick_ = self.downTick_ + dt
    if self.downTick_ > DOWN_INTERVAL then
        self.downTick_ = self.downTick_ - DOWN_INTERVAL
        local blocks_={} --存储相应方块数据
        local move_tag=true
        --向左移动检查
        if x == -1 and y == 0 then
            --收集数据
            for _, block in pairs(move_blocks) do
                if blocks_[block:getY()]~=nil then
                    if blocks_[block:getY()]:getX()>block:getX() then
                        blocks_[block:getY()]=block
                    end
                else
                    blocks_[block:getY()]=block
                end
            end
            --进行检查
            for _, block in pairs(blocks_) do
                local oldx=block:getX()/ConstDef.BLOCK_SIZE.HEIGHT
                local oldy=block:getY()/ConstDef.BLOCK_SIZE.HEIGHT
                if oldx+x < 1 or  array_blocks_[oldx+x][oldy]~=nil or false then
                    move_tag=false
                end
            end
        end
        
        --向右移动检查
        if x == 1 and y == 0 then
            --收集数据
            for _, block in pairs(move_blocks) do
                if blocks_[block:getY()]~=nil then
                    if blocks_[block:getY()]:getX()<block:getX() then
                        blocks_[block:getY()]=block
                    end
                else
                    blocks_[block:getY()]=block
                end
            end
            --进行检查
            for _, block in pairs(blocks_) do
                local oldx=block:getX()/ConstDef.BLOCK_SIZE.HEIGHT
                local oldy=block:getY()/ConstDef.BLOCK_SIZE.HEIGHT
                if oldx+x >ConstDef.GAME_WIDTH_SIZE or  array_blocks_[oldx+x][oldy]~=nil or false then
                    move_tag=false
                end
            end
        end
        
        --向下移动检查
        if x == 0 and y == -1 then
            --收集数据
            for _, block in pairs(move_blocks) do
                if blocks_[block:getX()]~=nil then
                    if blocks_[block:getX()]:getY()>block:getY() then
                        blocks_[block:getX()]=block
                    end
                else
                    blocks_[block:getX()]=block
                end
            end

            --进行检查
            for _, block in pairs(blocks_) do
                local oldx=block:getX()/ConstDef.BLOCK_SIZE.HEIGHT
                local oldy=block:getY()/ConstDef.BLOCK_SIZE.HEIGHT
                if oldy+y <1 or  array_blocks_[oldx][oldy+y]~=nil or false then
                    move_tag=false
                end
            end
        end
        
        --开始移动
        if move_tag then
            for i = 1, #current_blocks_ do
                local block = current_blocks_[i]
                local oldx=block:getX()/ConstDef.BLOCK_SIZE.HEIGHT
                local oldy=block:getY()/ConstDef.BLOCK_SIZE.WIDTH
                array_blocks_[oldx][oldy]=nil
                block:move(x, y)
                array_blocks_[oldx+x][oldy+y]=block
            end
        else
            if y==-1 then
                --进行转移
                for i = 1, #move_blocks do
                    bottom_blocks_[#bottom_blocks_+1]=move_blocks[i]
                end
                current_blocks_={}
                --进行清除
                GameData:clearLine()
            end 
        end
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
    产生不同种类方块

    @param type 类型：number，创建类型

    @return none
]]
function GameData:createBlocks(type)
    current_blocks_={}
    if true then
        GameData:createBlock(4,20,type)
        GameData:createBlock(5,20,type)
        GameData:createBlock(6,20,type)
        GameData:createBlock(7,20,type)
    end
end
--[[--
    产生方块

    @param x 类型：number，方块横坐标
    @param t 类型：number，方块纵坐标
    @param type 类型：number，方块颜色种类
    
    @return none
]]
function GameData:createBlock(x,y,type)
    local block = Block.new(type)
    block:setX(ConstDef.BLOCK_SIZE.WIDTH*x)
    block:setY(ConstDef.BLOCK_SIZE.HEIGHT*y)
    current_blocks_[#current_blocks_ + 1] = block
    array_blocks_[x][y]=block
end
--[[--
    清理所有方块

    @param none

    @return none
]]
function GameData:clearALL()
    for i = 1,ConstDef.GAME_HEIGHT_SIZE do
        for j = 1, ConstDef.GAME_WIDTH_SIZE do
            if array_blocks_[i][j]==1 then
                
            end
        end
    end
end
--[[--
    清理方块

    @param none

    @return none
]]
function GameData:clearLine()
    local destoryBlocks = {}
    local is_clear=false
    for y = 1, ConstDef.GAME_HEIGHT_SIZE do
        local amount=0
        for x = 1,ConstDef.GAME_WIDTH_SIZE do
            if array_blocks_[x][y]~=nil then 
                amount=amount+1
            end
        end
        if amount == 4 then
            --进行收集
            for x = 1,ConstDef.GAME_WIDTH_SIZE do
                destoryBlocks[#destoryBlocks + 1] = array_blocks_[x][y]
                is_clear=true
            end
        end
    end
    --清理方块
    for i = #destoryBlocks, 1, -1 do
        for j = #bottom_blocks_, 1, -1 do
            if bottom_blocks_[j] == destoryBlocks[i] then
                table.remove(bottom_blocks_, j)
            end
        end
    end
    --摧毁方块
    for i = #destoryBlocks, 1, -1 do
        local x=destoryBlocks[i]:getX()/ConstDef.BLOCK_SIZE.HEIGHT
        local y=destoryBlocks[i]:getY()/ConstDef.BLOCK_SIZE.WIDTH
        array_blocks_[x][y]=nil --行太长了 我怎么回写出这个玩意
        destoryBlocks[i]:destory()
    end
    if is_clear == false then
        return
    end
    --全体方块下移
    for y = 1, ConstDef.GAME_HEIGHT_SIZE do
        for x = 1,ConstDef.GAME_WIDTH_SIZE do
            local block=array_blocks_[x][y]
            if array_blocks_[x][y-1]~=nil and block~=nil then 
                array_blocks_[x][y]=nil
                block:move(x, y)
                array_blocks_[x][y-1]=block
            end
        end
    end
end
--[[--
    测试用 

    @param none

    @return none
]]
function GameData:printBlock()
    for x = 1,ConstDef.GAME_WIDTH_SIZE do
        local str=""
        for y = 1, ConstDef.GAME_HEIGHT_SIZE do
            if array_blocks_[x][y]==nil then 
                str=str.." nil "
            else
                str=str.." block "
            end
        end
        print(str)
    end
end
return GameData