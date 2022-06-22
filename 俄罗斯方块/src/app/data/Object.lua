--[[
    基本方块
]]

local Object = class("Object")
local rect1_ = cc.rect(0, 0, 0, 0)
local rect2_ = cc.rect(0, 0, 0, 0)

local id_ = 0 -- 类型：number，全局id，调试使用

--[[
    构造函数
    @param x 类型：number
    @param y 类型：number
]]


function Object:ctor(x,y,color)
    self.x_ = x --位置x 类型numble
    self.y_ = x --位置y 类型numble
    self.color_ = color -- 颜色 类型string
    self.isDeath_ = false --是否需要删除
    
    id_ = id_ + 1
    self.id_ = id_ -- 类型：number，唯一id
end

--[[--
    设置x

    @param x 类型：number

    @return none
]]
function Object:setX(x)
    self.x_ = x
end

--[[--
    获取x

    @param none

    @return number
]]
function Object:getX()
    return self.x_
end

--[[--
    设置y

    @param y 类型：number

    @return none
]]
function Object:setY(y)
    self.y_ = y
end

--[[--
    获取y

    @param none

    @return number
]]
function Object:getY()
    return self.y_
end

--[[--
    获取color

    @param none

    @return string
]]
function Object:getColor()
    return self.color_
end

--[[--
    是否死亡

    @param none

    @return boolean
]]
function Object:isDeath()
    return self.isDeath_
end

--[[--
    帧刷新

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function Object:update(dt)
end

return Object