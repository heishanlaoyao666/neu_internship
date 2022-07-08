--[[--
    Object.lua
    数据对象基类
]]
local Object = class("Object")
local rect1_ = cc.rect(0, 0, 0, 0)
local rect2_ = cc.rect(0, 0, 0, 0)
local id_ = 0 -- 类型：number，全局id，调试使用
--[[--
    构造函数

    @param x 类型：number
    @param y 类型：number
    @param width 类型：number
    @param height 类型：number

    @return none
]]
function Object:ctor(x, y, width, height)
    self.x_ = x -- 类型：number
    self.y_ = y -- 类型：number
    self.width_ = width -- 类型：number
    self.height_ = height -- 类型：number

    self.isDeath_ = false -- 类型：boolean，是否死亡（销毁）
    self.moveable_ = true --类型:boolean,是否可以移动

    self.buffMap_ = {}
    id_ = id_ + 1
    self.id_ = id_ -- 类型：number，唯一id
end
--[[--
    获取长

    @param none

    @return self.width_
]]
function Object:getWidth()
    return self.width_
end
--[[--
    获取ID

    @param none

    @return life
]]
function Object:getID()
    return self.id_
end
--[[--
    获取塔BUFF表

    @param none

    @return life
]]
function Object:getBuff()
    return self.buffMap_
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
    是否死亡

    @param none

    @return boolean
]]
function Object:isDeath()
    return self.isDeath_
end
--[[--
    添加Buff

    @param buffInfo 类型 buffInfo 

    @return none
]]
function Object:addBuff(buffInfo)
    local buffmodel = buffInfo:getBuffModel()
    for i = 1, #self.buffMap_ do
        if self.buffMap_[i]:getID()== buffmodel:getID() then
            --print("重复buff处理")
            return
        end
    end
    self.buffMap_[#self.buffMap_+1] = buffmodel
end
--[[--
    碰撞判定

    @param obj 类型：Object，待判定对象

    @return boolean
]]
function Object:isCollider(obj)
    rect1_.x = self.x_ - self.width_ * 0.5
    rect1_.y = self.y_ - self.height_ * 0.5
    rect1_.width = self.width_
    rect1_.height = self.height_

    rect2_.x = obj.x_ - obj.width_ * 0.5
    rect2_.y = obj.y_ - obj.height_ * 0.5
    rect2_.width = obj.width_
    rect2_.height = obj.height_

    return cc.rectIntersectsRect(rect1_, rect2_)
end

--[[--
    是否包含点

    @param x 类型：number
    @param y 类型：number

    @return boolean
]]
function Object:isContain(x, y)
    rect1_.x = self.x_ - self.width_ * 0.5
    rect1_.y = self.y_ - self.height_ * 0.5
    rect1_.width = self.width_
    rect1_.height = self.height_
    return cc.rectContainsPoint(rect1_, cc.p(x, y)) 
end

--[[--
    帧刷新

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function Object:update(dt)
    --遍历所有buff执行
    local destorybuffs = {}
    for i = 1, #self.buffMap_ do
        if self.buffMap_[i]:setRunTime(dt) then
            --buff删除
            destorybuffs[#destorybuffs+1] = self.buffMap_[i]
        end
    end
    --清理buff
    for i = #destorybuffs, 1, -1 do
        for j = #self.buffMap_, 1, -1 do
            if self.buffMap_[j] == destorybuffs[i] then
                table.remove(self.buffMap_, j)
            end
        end
    end
end

return Object