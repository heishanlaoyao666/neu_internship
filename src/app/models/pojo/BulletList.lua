---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by Asus.
--- DateTime: 2022/6/8 22:31
---
local BulletList = class("BulletList")
BulletList.data = {}
BulletList.num = 0
BulletList.head = 1
BulletList.tail = 1
BulletList.size = 10

function BulletList:ctor()

end
function BulletList:add(x, y)
    local Bullet = require("src/app/models/pojo/Bullet.lua")
    local bullet = Bullet:new()
    bullet:init(x, y)
    self.data[self.head] = bullet
    self.head = self.head + 1
    self.num = self.num + 1
    if self.num > self.size then
        return self:remove(), bullet
    else
        return nil, bullet
    end
end
function BulletList:remove()
    local value = self.data[self.tail]
    self.data[self.tail] = nil
    self.tail  = self.tail + 1
    self.num = self.num - 1
    return value
end
function BulletList:iterator()
    local counter = self.tail - 1
    return function()
        counter = counter + 1
        if counter < self.head then
            return self.data[counter]
        else
            return nil
        end
    end
end

return BulletList
