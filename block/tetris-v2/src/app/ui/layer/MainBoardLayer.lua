--[[--
    主面板层
    MainBoardLayer.lua
]]
local MainBoardLayer = class("MainBoardLayer", require("app.ui.layer.BaseLayer"))
local ConstDef = require("app.def.ConstDef")
local Functions = require("app.utils.Functions")
local GameData = require("app.data.GameData")
local Block = require("app.data.Block")
local EventManager = require("app.manager.EventManager")
local EventDef = require("app.def.EventDef")

--[[--
    构造函数

    @param none

    @return none
]]
function MainBoardLayer:ctor()

    self.spriteMap_ = {} -- 类型：table，Key：转换后的精灵坐标，Value：sprite 精灵对象
    self.colorMap_ = {} -- 类型：table，Key：转换后的精灵坐标，Value：color 精灵
    self.block_ = nil -- 类型：Block

    self.scheduleIdA_ = nil
    self.scheduleIdB_ = nil


    self:registerScriptHandler(function(event)
        if event == "enter" then
            self:onEnter()
        elseif event == "exit" then
            self:onExit()
        end
    end)

    self:initView()
end

--[[--
    初始化界面

    @param none

    @return none
]]
function MainBoardLayer:initView()
    for x = 0, ConstDef.MAIN_BOARD_WIDTH - 1 do
        for y = 0, ConstDef.MAIN_BOARD_HEIGHT - 1 do
            local posX, posY = Functions.Grid2Pos(x, y)
            local sp = cc.Sprite:create(ConstDef.GRID_TYPE.TYPE_0)
            sp:setScale(0.35)
            sp:setPosition(posX, posY)
            self:addChild(sp)
            self.spriteMap_[Functions.makeKey(x, y)] = sp

            local visible = (x == 0 or x == ConstDef.MAIN_BOARD_WIDTH - 1) or y == 0
            sp:setVisible(visible)
            if visible then
                -- 初始化为白色方块
                self.colorMap_[Functions.makeKey(x, y)] = 0
            else
                -- 初始化不可见
                self.colorMap_[Functions.makeKey(x, y)] = -1
            end
        end
    end
end

--[[--
    节点进入

    @param none

    @return none
]]
function MainBoardLayer:onEnter()
    EventManager:regListener(EventDef.ID.CREATE_BLOCK, self, function()
        self:Gen()
    end)
    EventManager:regListener(EventDef.ID.BEGIN_GAME, self, function()
        self:ProcessInput()
    end)
end

--[[--
    节点退出

    @param none

    @return none
]]
function MainBoardLayer:onExit()
    EventManager:unRegListener(EventDef.ID.CREATE_BLOCK, self)
end

--[[--
    处理键盘事件

    @param none

    @return none
]]
function MainBoardLayer:ProcessInput()

    local listener = cc.EventListenerKeyboard:create()
    local keyState = {}

    -- 按下键盘
    listener:registerScriptHandler(function(keyCode, event)
        keyState[keyCode] = true
    end, cc.Handler.EVENT_KEYBOARD_PRESSED)
    -- 松开键盘
    listener:registerScriptHandler(function(keyCode, event)
        keyState[keyCode] = nil
        -- w(旋转)
        if keyCode == 133 then
            self.block_:RotateCW()
        elseif keyCode == 134 then
            self.block_:RotateCCW()
        -- p(暂停游戏)
        elseif keyCode == 139 then
            if GameData:getGameState() == ConstDef.GAME_STATE.PLAY then
                GameData:setGameState(ConstDef.GAME_STATE.PAUSE)
            elseif GameData:getGameState() == ConstDef.GAME_STATE.PAUSE then
                GameData:setGameState(ConstDef.GAME_STATE.PLAY)
            end
        end
    end, cc.Handler.EVENT_KEYBOARD_RELEASED)

    -- 创建事件分发器
    local eventDispatcher = self:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, self)

    -- 操作调度器
    self.scheduleIdA_ = cc.Director:getInstance():getScheduler():scheduleScriptFunc(function()

        for keyCode, v in pairs(keyState) do

            -- s(向下)
            if keyCode == 142 then
                self.block_:Move(0, -1)
                -- a(向左)
            elseif keyCode == 124 then
                self.block_:Move(-1, 0)
                -- d(向右)
            elseif keyCode == 127 then
                self.block_:Move(1, 0)
            end
        end
    end, 0.1, false)

    -- 自动下坠调度器
    self.scheduleIdB_ = cc.Director:getInstance():getScheduler():scheduleScriptFunc(function ()
        self:Tick()
    end , GameData:getSpeed(), false)

end


--[[--
    生成块

    @param none

    @return none
]]
function MainBoardLayer:Gen()

    local style = GameData:getStyle()
    self.block_ = Block.new(self, style)

    if not self.block_:Place() then
        -- GameOver
        self:Clear()
    end
end












function MainBoardLayer:Tick()

    --if GameData:getGameState() ~= ConstDef.GAME_STATE.PLAY then
    --    return
    --end

    -- 如果无法移动就生成一个新块
    if not self.block_:Move(0, -1) then
        self:Gen()
    else
        self.block_:Clear()
        local count = 0

        -- 触发清除事件
        while true do
            local temp = self:CheckAndSweep()
            if temp <= 0 then
                break
            end
            count = count + temp
            self:Shift()
        end
        self.block_:Place()
    end
end








--[[--
    清除行

    @param none

    @return none
]]
function MainBoardLayer:ClearLine(y)

    for x = 1, ConstDef.MAIN_BOARD_WIDTH - 2 do
        self:Set(x, y, -1)
    end
end

--[[--
    清除所有

    @param none

    @return none
]]
function MainBoardLayer:Clear()

    for y = 1, ConstDef.MAIN_BOARD_HEIGHT - 1 do
        self:ClearLine(y)
    end

end

--[[--
    Set

    @param x，y 类型：number，坐标
    @param value 类型：boolean

    @return none
]]
function MainBoardLayer:Set(x, y, value)

    local sp = self.spriteMap_[Functions.makeKey(x, y)]
    if sp == nil then
        return
    end

    -- Color
    if value == -1 then
        self.colorMap_[Functions.makeKey(x, y)] = -1
        sp:setVisible(false)
        return
    elseif value == 0 then
        self.colorMap_[Functions.makeKey(x, y)] = 0
        sp:setTexture(ConstDef.GRID_TYPE.TYPE_0)
    elseif value == 1 then
        self.colorMap_[Functions.makeKey(x, y)] = 1
        sp:setTexture(ConstDef.GRID_TYPE.TYPE_1)
    elseif value == 2 then
        self.colorMap_[Functions.makeKey(x, y)] = 2
        sp:setTexture(ConstDef.GRID_TYPE.TYPE_2)
    elseif value == 3 then
        self.colorMap_[Functions.makeKey(x, y)] = 3
        sp:setTexture(ConstDef.GRID_TYPE.TYPE_3)
    elseif value == 4 then
        self.colorMap_[Functions.makeKey(x, y)] = 4
        sp:setTexture(ConstDef.GRID_TYPE.TYPE_4)
    elseif value == 5 then
        self.colorMap_[Functions.makeKey(x, y)] = 5
        sp:setTexture(ConstDef.GRID_TYPE.TYPE_5)
    elseif value == 6 then
        self.colorMap_[Functions.makeKey(x, y)] = 6
        sp:setTexture(ConstDef.GRID_TYPE.TYPE_6)
    elseif value == 7 then
        self.colorMap_[Functions.makeKey(x, y)] = 7
        sp:setTexture(ConstDef.GRID_TYPE.TYPE_7)
    end

    sp:setVisible(true)
end

--[[--
    Get

    @param x，y 类型：number，坐标

    @return none
]]
function MainBoardLayer:Get(x, y)

    local sp = self.spriteMap_[Functions.makeKey(x, y)]
    local color = self.colorMap_[Functions.makeKey(x, y)]

    if sp == nil then
        return
    end

    return color
end

--[[--
    是否是满行

    @param y 类型：number，行索引

    @return none
]]
function MainBoardLayer:IsFullLine(y)

    for x = 1, ConstDef.MAIN_BOARD_WIDTH - 2 do
        if self:Get(x, y) == -1 then
            return false
        end
    end

    return true
end

--[[--
    是否是空行

    @param y 类型：number，行索引

    @return none
]]
function MainBoardLayer:IsEmptyLine(y)

    for x = 1, ConstDef.MAIN_BOARD_WIDTH - 2 do
        if self:Get(x, y) ~= -1 then
            return false
        end
    end

    return true
end

--[[--
    检查是否可以覆盖

    @param none

    @return none
]]
function MainBoardLayer:CheckAndSweep()

    local count = 0
    for y = 1, ConstDef.MAIN_BOARD_HEIGHT - 1 do

        if self:IsFullLine(y) then
            self:ClearLine(y)
            count = count + 1
            break
        end
    end

    -- 消掉的行数
    return count

end

--[[--
    下移

    @param sy 类型：number，行数

    @return none
]]
function MainBoardLayer:MoveDown(sy)

    for y = sy, ConstDef.MAIN_BOARD_HEIGHT - 2 do
        for x = 1, ConstDef.MAIN_BOARD_WIDTH - 2 do
            self:Set(x, y, self:Get(x, y + 1))
        end
    end

end

--[[--
    移动

    @param none

    @return none
]]
function MainBoardLayer:Shift()

    for y = 1, ConstDef.MAIN_BOARD_HEIGHT - 2 do

        -- 如果当前行为空且上一行不为空
        if self:IsEmptyLine(y) and (not self:IsEmptyLine(y + 1)) then
            self:MoveDown(y)
        end
    end
end


return MainBoardLayer