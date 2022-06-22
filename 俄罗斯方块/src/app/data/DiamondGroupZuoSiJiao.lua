--[[
    下落的方块的组的基类
]]

local DiamondGroupZuoSiJiao = class("DiamondGroupZuoSiJiao",require("src.app.data.Object"))
local GameData = require("src.app.data.GameData")
local ConstDef = require("app.def.ConstDef")
local Diamond = require("src.app.data.Diamond")

--[[--
    构造函数

    @param 位置信息 x，y  颜色 color  种类 size

    @return none
]]
function DiamondGroupZuoSiJiao:ctor(x,y,color)
    DiamondGroupZuoSiJiao.super.ctor(self, x, y, color)
    self:init()
end

--[[--
    判断物体是否可以旋转到南

    @param none

    @return boolean
]]
function DiamondGroupZuoSiJiao :canRotateToSouth()
    local diamond_2 ={x = self.x_ + ConstDef.DIAMOND_SIZE.WIDTH, y = self.y_} 
    local diamond_3 ={x = self.x_ - ConstDef.DIAMOND_SIZE.WIDTH, y = self.y_ + ConstDef.DIAMOND_SIZE.HEIGHT}
    local diamond_4 ={x = self.x_ , y = self.y_ + ConstDef.DIAMOND_SIZE.HEIGHT} 
    if GameData.isExist(diamond_2.x, diamond_2.y) and
        GameData.isExist(diamond_3.x, diamond_3.y) and
        GameData.isExist(diamond_4.x, diamond_4.y) then
        return true
    end
    return false
end

--[[--
    判断物体是否可以旋转到西

    @param none

    @return boolean
]]
function DiamondGroupZuoSiJiao :canRotateToWest()
    local diamond_2 ={x = self.x_ , y = self.y_ + ConstDef.DIAMOND_SIZE.HEIGHT} 
    local diamond_3 ={x = self.x_ + ConstDef.DIAMOND_SIZE.WIDTH, y = self.y_ + ConstDef.DIAMOND_SIZE.HEIGHT}
    local diamond_4 ={x = self.x_ + ConstDef.DIAMOND_SIZE.WIDTH, y = self.y_ + ConstDef.DIAMOND_SIZE.HEIGHT*2} 
    if GameData.isExist(diamond_2.x, diamond_2.y) and
        GameData.isExist(diamond_3.x, diamond_3.y) and
        GameData.isExist(diamond_4.x, diamond_4.y) then
        return true
    end
    return false
end

--[[--
    判断物体是否可以顺时针旋转到北
    @param none

    @return boolean
]]
function DiamondGroupZuoSiJiao :canRotateToNorth()
    return self:canRotateToSouth()
end

--[[--
    判断物体是否可以旋转到东

    @param none

    @return boolean
]]
function DiamondGroupZuoSiJiao :canRotateToEast()
    return self:canRotateToWest()
end

--[[--
    顺时针旋转函数

    @param none

    @return none
]]
function DiamondGroupZuoSiJiao:rotateByClockwise()
    if self.state_ == ConstDef.DIAMOND_GROUP_STATE_SIZE.NORTH then
        self.child_[2]:setX(self.x_)
        self.child_[2]:setY(self.y_ + ConstDef.DIAMOND_SIZE.HEIGHT)
        self.child_[3]:setX(self.x_ + ConstDef.DIAMOND_SIZE.WIDTH)
        self.child_[3]:setY(self.y_ + ConstDef.DIAMOND_SIZE.HEIGHT)
        self.child_[4]:setX(self.x_ + ConstDef.DIAMOND_SIZE.WIDTH)
        self.child_[4]:setY(self.y_ + ConstDef.DIAMOND_SIZE.HEIGHT*2)
    elseif self.state_ == ConstDef.DIAMOND_GROUP_STATE_SIZE.EAST then 
        self.child_[2]:setX(self.x_ + ConstDef.DIAMOND_SIZE.WIDTH)
        self.child_[2]:setY(self.y_)
        self.child_[3]:setX(self.x_ - ConstDef.DIAMOND_SIZE.WIDTH)
        self.child_[3]:setY(self.y_ + ConstDef.DIAMOND_SIZE.HEIGHT)
        self.child_[4]:setX(self.x_)
        self.child_[4]:setY(self.y_ + ConstDef.DIAMOND_SIZE.HEIGHT)
    elseif self.state_ == ConstDef.DIAMOND_GROUP_STATE_SIZE.SOUTH then 
        self.child_[2]:setX(self.x_)
        self.child_[2]:setY(self.y_ + ConstDef.DIAMOND_SIZE.HEIGHT)
        self.child_[3]:setX(self.x_ + ConstDef.DIAMOND_SIZE.WIDTH)
        self.child_[3]:setY(self.y_ + ConstDef.DIAMOND_SIZE.HEIGHT)
        self.child_[4]:setX(self.x_ + ConstDef.DIAMOND_SIZE.WIDTH)
        self.child_[4]:setY(self.y_ + ConstDef.DIAMOND_SIZE.HEIGHT*2)
    elseif self.state_ == ConstDef.DIAMOND_GROUP_STATE_SIZE.WEST then 
        self.child_[2]:setX(self.x_ + ConstDef.DIAMOND_SIZE.WIDTH)
        self.child_[2]:setY(self.y_)
        self.child_[3]:setX(self.x_ - ConstDef.DIAMOND_SIZE.WIDTH)
        self.child_[3]:setY(self.y_ + ConstDef.DIAMOND_SIZE.HEIGHT)
        self.child_[4]:setX(self.x_)
        self.child_[4]:setY(self.y_ + ConstDef.DIAMOND_SIZE.HEIGHT)
    end
end

--[[--
    逆时针旋转函数

    @param none

    @return none
]]
function DiamondGroupZuoSiJiao:rotateByAntclockwise()
    if self.state_ == ConstDef.DIAMOND_GROUP_STATE_SIZE.SOUTH then
        self.child_[2]:setX(self.x_)
        self.child_[2]:setY(self.y_ + ConstDef.DIAMOND_SIZE.HEIGHT)
        self.child_[3]:setX(self.x_ + ConstDef.DIAMOND_SIZE.WIDTH)
        self.child_[3]:setY(self.y_ + ConstDef.DIAMOND_SIZE.HEIGHT)
        self.child_[4]:setX(self.x_ + ConstDef.DIAMOND_SIZE.WIDTH)
        self.child_[4]:setY(self.y_ + ConstDef.DIAMOND_SIZE.HEIGHT*2)
    elseif self.state_ == ConstDef.DIAMOND_GROUP_STATE_SIZE.WEST then 
        self.child_[2]:setX(self.x_ + ConstDef.DIAMOND_SIZE.WIDTH)
        self.child_[2]:setY(self.y_)
        self.child_[3]:setX(self.x_ - ConstDef.DIAMOND_SIZE.WIDTH)
        self.child_[3]:setY(self.y_ + ConstDef.DIAMOND_SIZE.HEIGHT)
        self.child_[4]:setX(self.x_)
        self.child_[4]:setY(self.y_ + ConstDef.DIAMOND_SIZE.HEIGHT)
    elseif self.state_ == ConstDef.DIAMOND_GROUP_STATE_SIZE.NORTH then 
        self.child_[2]:setX(self.x_)
        self.child_[2]:setY(self.y_ + ConstDef.DIAMOND_SIZE.HEIGHT)
        self.child_[3]:setX(self.x_ + ConstDef.DIAMOND_SIZE.WIDTH)
        self.child_[3]:setY(self.y_ + ConstDef.DIAMOND_SIZE.HEIGHT)
        self.child_[4]:setX(self.x_ + ConstDef.DIAMOND_SIZE.WIDTH)
        self.child_[4]:setY(self.y_ + ConstDef.DIAMOND_SIZE.HEIGHT*2)
    elseif self.state_ == ConstDef.DIAMOND_GROUP_STATE_SIZE.EAST then 
        self.child_[2]:setX(self.x_ + ConstDef.DIAMOND_SIZE.WIDTH)
        self.child_[2]:setY(self.y_)
        self.child_[3]:setX(self.x_ - ConstDef.DIAMOND_SIZE.WIDTH)
        self.child_[3]:setY(self.y_ + ConstDef.DIAMOND_SIZE.HEIGHT)
        self.child_[4]:setX(self.x_)
        self.child_[4]:setY(self.y_ + ConstDef.DIAMOND_SIZE.HEIGHT)
    end
end


--[[--
    加入孩子函数,方块组以最下为初始点，如果存在多个最下，以最左为基础点

    @param 位置信息 x，y  颜色 color  种类 size

    @return none
]]
function DiamondGroupZuoSiJiao:init()
    local diamond_1 = Diamond.new(self.x_, self.y_,self.color_)
    local diamond_2 = Diamond.new(self.x_, self.y_, self.color_)
    local diamond_3 = Diamond.new(self.x_+ ConstDef.DIAMOND_SIZE.WIDTH, self.y_+ ConstDef.DIAMOND_SIZE.HEIGHT, self.color_ )
    local diamond_4 = Diamond.new(self.x_+ ConstDef.DIAMOND_SIZE.WIDTH, self.y_+ ConstDef.DIAMOND_SIZE.HEIGHT*2, self.color_)
    self.child_ = {diamond_1,diamond_2,diamond_3,diamond_4}
end

return DiamondGroupZuoSiJiao