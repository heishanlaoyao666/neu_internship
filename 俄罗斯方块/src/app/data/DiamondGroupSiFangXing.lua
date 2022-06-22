--[[
    下落的方块的组的基类
]]

local DiamondGroupSiFangXing = class("DiamondGroupSiFangXing",require("src.app.data.DiamondGroupBase"))
local GameData = require("src.app.data.GameData")
local ConstDef = require("app.def.ConstDef")
local Diamond = require("src.app.data.Diamond")

--[[--
    构造函数

    @param 位置信息 x，y  颜色 color  种类 size

    @return none
]]
function DiamondGroupSiFangXing:ctor(x,y,color)
    DiamondGroupSiFangXing.super.ctor(self, x, y, color)
    self.size_ = ConstDef.DIAMOND_GROUP_SIZE.SIFANGXING
    self:init()
end

--[[--
    顺时针旋转函数

    @param none

    @return none
]]
function DiamondGroupSiFangXing:rotateByClockwise(dir)
end

--[[--
    逆时针旋转函数

    @param none

    @return none
]]
function DiamondGroupSiFangXing:rotateByAntclockwise(dir)
end

--[[--
    加入方块函数,方块组以最下为初始点，如果存在多个最下，以最左为基础点

    @param 位置信息 x，y  颜色 color  种类 size

    @return none
]]
function DiamondGroupSiFangXing:init()
    local diamond_1 = Diamond.new(self.x_, self.y_,self.color_)
    local diamond_2 = Diamond.new(self.x_ + ConstDef.DIAMOND_SIZE.WIDTH, self.y_, self.color_)
    local diamond_3 = Diamond.new(self.x_, self.y_+ ConstDef.DIAMOND_SIZE.HEIGHT, self.color_ )
    local diamond_4 = Diamond.new(self.x_ + ConstDef.DIAMOND_SIZE.WIDTH, self.y_+ ConstDef.DIAMOND_SIZE.HEIGHT, self.color_)
    self.child_ = {diamond_1,diamond_2,diamond_3,diamond_4}
end

return DiamondGroupSiFangXing