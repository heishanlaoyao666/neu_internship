--[[
    Object.lua
    数据结构基类
    描述：数据结构基类
    编写：李昊
    修订：周星宇
    检查：张昊煜
]]

local Object = class("Object")

--[[
    构造函数

    @param none

    @return none
]]
function Object:ctor(x,y,name)
    self.x_ = x --类型：number
    self.y_ = y --类型：number
    self.name_ = name --类型：string
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
    设置name

    @param y 类型：string

    @return none
]]
function Object:setName(name)
    self.name_ = name
end

--[[--
    获取name

    @param none

    @return string
]]
function Object:getName()
    return self.name_
end

--[[--
    帧刷新

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function Object:update(dt)
end

return Object