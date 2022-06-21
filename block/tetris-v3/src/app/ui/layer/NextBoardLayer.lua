--[[--
    次面板层
    NextBoardLayer.lua
]]
local NextBoardLayer = class("NextBoardLayer", require("app.ui.layer.BaseLayer"))
local ConstDef = require("app.def.ConstDef")
local Functions = require("app.utils.Functions")

--[[--
    构造函数

    @param none

    @return none
]]
function NextBoardLayer:ctor(gameData)
    NextBoardLayer.super.ctor(self)

    self.gameData_ = gameData

    self.spriteMap_ = {} -- 类型：table，Key：转换后的精灵坐标，Value：sprite 精灵对象
    self.colorMap_ = {} -- 类型：table，Key：转换后的精灵坐标，Value：color 精灵


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
function NextBoardLayer:initView()
    for x = 0, ConstDef.NEXT_BOARD_WIDTH - 1 do
        for y = 0, ConstDef.NEXT_BOARD_HEIGHT - 1 do
            local posX, posY = Functions.Grid2Pos(x + ConstDef.MAIN_BOARD_WIDTH + 1, y + ConstDef.MAIN_BOARD_HEIGHT - 4)
            local sp = cc.Sprite:create(ConstDef.GRID_TYPE.TYPE_0)
            sp:setPosition(posX, posY)
            sp:setScale(0.35)
            self:addChild(sp)
            sp:setVisible(false)

            self.spriteMap_[Functions.makeKey(x, y)] = sp
        end
    end
end

--[[--
    节点进入

    @param none

    @return none
]]
function NextBoardLayer:onEnter()
end

--[[--
    节点退出

    @param none

    @return none
]]
function NextBoardLayer:onExit()
end

--[[--
    Set

    @param x，y 类型：number，坐标
    @param value 类型：boolean

    @return none
]]
function NextBoardLayer:set(x, y, value)

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


function NextBoardLayer:update(dt)
    --print("NextBoardLayer Update!")
    for x = 0, ConstDef.NEXT_BOARD_WIDTH - 1 do
        for y = 0, ConstDef.NEXT_BOARD_HEIGHT - 1 do
            self.colorMap_[Functions.makeKey(x, y)] = self:set(x, y, self.gameData_:getNextBoard():get(x, y))
        end
    end
end

return NextBoardLayer