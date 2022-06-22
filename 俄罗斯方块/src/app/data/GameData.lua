--[[
    游戏数据文件
    暂时存放 ： 移动方块 固定方块 分数 下落速度
]]

local GameData = {}

local ConstDef = require("app.def.ConstDef")
local EventDef = require("app.def.EventDef")
local EventManager = require("app.manager.EventManager")

local Diamond = require("src.app.data.Diamond")
local DiamondGroupSiFangXing = require("src.app.data.DiamondGroupSiFangXing")
local DiamondGroupTiXing = require("src.app.data.DiamondGroupTiXing")
local DiamondGroupYouSanJiao = require("src.app.data.DiamondGroupYouSanJiao")
local DiamondGroupYouSiJiao = require("src.app.data.DiamondGroupYouSiJiao")
local DiamondGroupZhiTiao = require("src.app.data.DiamondGroupZhiTiao")
local DiamondGroupZuoSanJiao= require("src.app.data.DiamondGroupZuoSanJiao")
local DiamondGroupZuoSiJiao = require("src.app.data.DiamondGroupZuoSiJiao")

local allDiamond_ = {} --所有方块 l类型diamond
local currentDiamond_ = {} --正在下落的方块类型diamond
local DROP_SPEED_LEVEL_ = 1 --下落速度等级 1-9级 类型number

local canRotateByAntclockwise_= {}
local canRotateByClockwise_= {}
local canRotate_ = {canRotateByAntclockwise_,canRotateByClockwise_}

local canMove_ = {}

--[[--
    初始化数据

    @param none

    @return none
]]
function GameData:init()
    self.life_ = 0  --分数
end

--[[--
    判断该单元格是否有东西

    @param 位置x，y numble

    @return boolean
]]
function GameData:isExist(x,y)
    if x == display.top - ConstDef.DIAMOND_SIZE.HEIGHT*19 
      or x > display.top then 
        return true
    end
    if x == display.top - ConstDef.DIAMOND_SIZE.HEIGHT*19 
      or x > display.top then 
        return true
    end
    for i = 1, #allDiamond_ do
        if x == allDiamond[x].x_ then
           if y == allDiamond[x].y_ then 
            return true
           end
        end
    end
    return false
end

--[[--
    判断下方是否有东西或者到最后一格

    @param none

    @return boolean
]]
function GameData:canDrop(diamond)
    local y = diamond.y_ - ConstDef.DIAMOND_SIZE.HEIGHT
    if self:isExist(diamond.x_,y) then
        return false
    end
    return true
end

--[[

]]

--[[--
    判断物体是否可以移动

    @param 方块组，方向

    @return boolean
]]
function GameData:Move(dir)
    if dir == ConstDef.DIAMOND_GROUP_MOVE_SIZE.LEFT then 
        
    elseif dir == ConstDef.DIAMOND_GROUP_MOVE_SIZE.RIGGT then
        
    end
end

--[[--
    物体是否可以移动

    @param 方块组，方向

    @return boolean
]]
function GameData:canMove(dir)
    if dir == ConstDef.DIAMOND_GROUP_MOVE_SIZE.LEFT then 
        for i = 1, #currentDiamond_ do
            local x =currentDiamond_[i].x_ - ConstDef.DIAMOND_SIZE.WIDTH --方块向左位移x的大小 
            if self.isExist(x, currentDiamond_[i].y_) then
                return false
            end
        end
        return true
    elseif dir == ConstDef.DIAMOND_GROUP_MOVE_SIZE.RIGGT then
        for i = 1, #currentDiamond_ do
            local x = currentDiamond_[i].x_ - ConstDef.DIAMOND_SIZE.WIDTH --方块向右位移x的大小 
            if self.isExist(x, currentDiamond_[i].y_) then
                return false
            end
        end
        return true
    end
    return false
end

--[[
    返回方块组

    @param none

    @return table
]]
function GameData:getAllDiamond()
    return allDiamond_
end

--[[
    返回方块组

    @param none

    @return table
]]
function GameData:getCurDiamond()
    return currentDiamond_
end