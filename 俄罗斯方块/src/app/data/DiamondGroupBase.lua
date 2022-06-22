--[[
    下落的方块的组的基类

    x判断旋转函数有待改良
]]

local DiamondGroupBase = class("DiamondGroupBase",require("src.app.data.Object"))
local GameData = require("src.app.data.GameData")
local ConstDef = require("app.def.ConstDef")

--[[--
    构造函数

    @param 位置信息 x，y  颜色 color 

    @return none
]]
function DiamondGroupBase:ctor(x,y,color)
    DiamondGroupBase.super.ctor(self, x, y, color)
    self.child_ = nil
    self.state_ = ConstDef.DIAMOND_GROUP_STATE_SIZE.EAST
end

--[[--
    是否可以下落函数

    @param none

    @return none
]]
function DiamondGroupBase:canDrop()
    for i = 1,4 do
        if not GameData:canDrop(self.child_[i]) then
            return false
        end
    end
    return true
end

--[[--
    移动函数

    @param dir 方向 number

    @return none
]]
function DiamondGroupBase:Move(dir)
    if GameData.canMove(self, dir) then
        if dir == ConstDef.DIAMOND_GROUP_MOVE_SIZE.LEFT then
            self.x_ = self.x_ - ConstDef.DIAMOND_SIZE.WIDTH
            for i =1,4 do
                self.child_[i].x_ = self.child_[i].x_ - ConstDef.DIAMOND_SIZE.WIDTH
            end
        end
        if dir == ConstDef.DIAMOND_GROUP_MOVE_SIZE.RIGGT then
            self.x_ = self.x_ + ConstDef.DIAMOND_SIZE.WIDTH
            for i =1,4 do
                self.child_[i].x_ = self.child_[i].x_ + ConstDef.DIAMOND_SIZE.WIDTH
            end
        end
    end
end

--[[--
    方块组销毁

    @param none

    @return none
]]
function DiamondGroupBase:destory()
    self.isDeath_ = true 
end

--[[
    方块组下一一格
]]
function DiamondGroupBase:drop()
    self.y_ = self.y_ - ConstDef.DIAMOND_SIZE.HEIGHT
    for i = 1,4 do
        self.child_[i].y_ = self.child_[i].y_ - ConstDef.DIAMOND_SIZE.HEIGHT
    end    
end

--[[--
    顺时针旋转函数

    @param none

    @return boolean
]]
function DiamondGroupTiXing:CanRotateByClockwise()
    if self.state_ == ConstDef.DIAMOND_GROUP_STATE_SIZE.NORTH then
        return self:canRotateToEast()
    elseif self.state_ == ConstDef.DIAMOND_GROUP_STATE_SIZEE.EAST then 
        return self:canRotateToSouth()
    elseif self.state_ == ConstDef.DIAMOND_GROUP_STATE_SIZEE.SOUTH then 
        return self:canRotateToWest()
    elseif self.state_ == ConstDef.DIAMOND_GROUP_STATE_SIZEE.WEST then 
        return self:canRotateToNorth()
    end
end

--[[--
    逆时针旋转函数

    @param none

    @return boolean
]]
function DiamondGroupTiXing:canRotateByAntclockwise()
    if self.state_ == ConstDef.DIAMOND_GROUP_STATE_SIZE.SOUTH then
        return self:canRotateToEast()
    elseif self.state_ == ConstDef.DIAMOND_GROUP_STATE_SIZEE.WEST then 
        return self:canRotateToSouth()
    elseif self.state_ == ConstDef.DIAMOND_GROUP_STATE_SIZEE.NORTH then 
        return self:canRotateToWest()
    elseif self.state_ == ConstDef.DIAMOND_GROUP_STATE_SIZEE.EAST then 
        return self:canRotateToNorth()
    end
end

--[[--
    判断物体是否可以旋转到东

    @param none

    @return boolean
]]
function DiamondGroupTiXing:canRotateToEast()
    return true
end

--[[--
    判断物体是否可以旋转到南

    @param none

    @return boolean
]]
function DiamondGroupTiXing:canRotateToNorth()
    return true
end

--[[--
    判断物体是否可以旋转到西

    @param none

    @return boolean
]]
function DiamondGroupTiXing:canRotateToWest()
    return true
end

--[[--
    判断物体是否可以旋转到北

    @param none

    @return boolean
]]
function DiamondGroupTiXing:canRotateToNorth()
    return true
end