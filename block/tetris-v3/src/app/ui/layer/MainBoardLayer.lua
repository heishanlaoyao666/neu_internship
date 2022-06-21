--[[--
    主面板层
    MainBoardLayer.lua
]]
local MainBoardLayer = class("MainBoardLayer", require("app.ui.layer.BaseLayer"))
local ConstDef = require("app.def.ConstDef")
local Functions = require("app.utils.Functions")

--[[--
    构造函数

    @param none

    @return none
]]
function MainBoardLayer:ctor(gameData)

    self.spriteMap_ = {} -- 类型：table，Key：转换后的精灵坐标，Value：sprite 精灵对象
    self.colorMap_ = {} -- 类型：table，Key：转换后的精灵坐标，Value：color 精灵

    self.gameData_ = gameData


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
end

--[[--
    节点退出

    @param none

    @return none
]]
function MainBoardLayer:onExit()
end

--[[--
    Set

    @param x，y 类型：number，坐标
    @param value 类型：boolean

    @return none
]]
function MainBoardLayer:set(x, y, value)

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

function MainBoardLayer:update(dt)
    --print("MainBoardLayer Update!")
    for x = 0, ConstDef.MAIN_BOARD_WIDTH - 1 do
        for y = 0, ConstDef.MAIN_BOARD_HEIGHT - 1 do
            self.colorMap_[Functions.makeKey(x, y)] = self:set(x, y, self.gameData_:getMainBoard():get(x, y))
        end
    end
end

return MainBoardLayer