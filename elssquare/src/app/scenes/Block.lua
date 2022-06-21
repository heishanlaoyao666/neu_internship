--[[
1. 方块的基本类型
2. 方块数据化
]]--
 
--[[

1.---
***
 *

2.---
**
**

3.---
 **
**

4.---
**
 **

5.---
****

6.---
***
*

7.---
***
  *

]]---


local blockArray = {
    --- 1：T
    {
        {
            {1,1,1,0},
            {0,1,0,0},
            {0,0,0,0},
            {0,0,0,0},
        },
        {
            {0,1,0,0},
            {1,1,0,0},
            {0,1,0,0},
            {0,0,0,0},
        },
        {
            {0,1,0,0},
            {1,1,1,0},
            {0,0,0,0},
            {0,0,0,0},
        },
        {
            {0,1,0,0},
            {0,1,1,0},
            {0,1,0,0},
            {0,0,0,0},
        },
    },
    --- 2：O
    {
        {
            {0,1,1,0},
            {0,1,1,0},
            {0,0,0,0},
            {0,0,0,0},
        }
    },
    --- 3：S
    {
        {
            {0,1,1,0},
            {1,1,0,0},
            {0,0,0,0},
            {0,0,0,0},
        },
        {
            {0,1,0,0},
            {0,1,1,0},
            {0,0,1,0},
            {0,0,0,0},
        },
    },
    --- 4：Z
    {
        {
            {1,1,0,0},
            {0,1,1,0},
            {0,0,0,0},
            {0,0,0,0},
        },
        {
            {0,0,1,0},
            {0,1,1,0},
            {0,1,0,0},
            {0,0,0,0},
        },
    },
    --- 5:——
    {
        initOffset = 1,
        {
            {0,0,0,0},
            {1,1,1,1},
            {0,0,0,0},
            {0,0,0,0},
        },
        {
            {0,1,0,0},
            {0,1,0,0},
            {0,1,0,0},
            {0,1,0,0},
        },
    },
    --- 6:L
    {
        {
            {0,0,0,0},
            {1,1,1,0},
            {1,0,0,0},
            {0,0,0,0},
        },
        {
            {1,1,0,0},
            {0,1,0,0},
            {0,1,0,0},
            {0,0,0,0},
        },
        {
            {0,0,1,0},
            {1,1,1,0},
            {0,0,0,0},
            {0,0,0,0},
        },
        {
            {0,1,0,0},
            {0,1,0,0},
            {0,1,1,0},
            {0,0,0,0},
        },
    },
    --- 7:L
    {
        {
            {0,0,0,0},
            {1,1,1,0},
            {0,0,1,0},
            {0,0,0,0},
        },
        {
            {0,1,1,0},
            {0,1,0,0},
            {0,1,0,0},
            {0,0,0,0},
        },
        {
            {1,0,0,0},
            {1,1,1,0},
            {0,0,0,0},
            {0,0,0,0},
        },
        {
            {0,1,0,0},
            {0,1,0,0},
            {1,1,0,0},
            {0,0,0,0},
        },
    },
}



local Block = class("Block")

--- 中心点偏移

local InitXOffset = cSceneWidth/2 - 3

function RandomStyle()
    --math.randomseed(os.time())
    return math.random(1, #blockArray)
end

function Block:ctor(scene, index)
    self.x = InitXOffset
    self.y = cSceneHeight
    local offset = blockArray[index].InitXOffset
    if offset then
        self.y = self.y + offset
    end

    self.index = index
    self.scene = scene
    self.trans = 1
end


---遍历方块

function IterateBlock(index, trans, callback)
    local transArray = blockArray[index]
    local eachBlock = transArray[trans]
    for y = 1, #eachBlock do
        local xdata = eachBlock[y]
        for x = 1, #xdata do
            local data = xdata[x]
            if not callback(x, y, data~=0) then
                return false
            end
        end
    end
    return true
end

---原始位置：将给定的数据放到方块中

function RawPlace(index, trans, scene, newX, newY)
    local result = {}
    if IterateBlock(index, trans, function(x, y, b)
        if b then
            local finalX = newX + x
            local finalY = newY - y
            if scene:Get(finalX, finalY) then
                return false
            end
            table.insert(result, {x = finalX, y = finalY})
        end
        return true
    end) then
        for k, v in ipairs(result) do
            scene:Set(v.x, v.y, true)
        end
        return true
    end
end

---移动方块
function Block:Move(deltaX, deltaY)
    print("===========",self)
    self:Clear()

    local x = self.x + deltaX
    local y = self.y + deltaY
    if RawPlace(self.index, self.trans, self.scene, x, y) then
        self.x = x
        self.y = y
        return true
    else
        self:Place()
        return false
    end
end

---旋转方块
function Block:Rotation()
    local offset = blockArray[self.index].InitXOffset
    if offset and self.y == 0 then
        return
    end

    self:Clear()

    local transArray = blockArray[self.index]
    local trans = self.trans + 1
    if trans > #transArray then
        trans = 1
    end

    if RawPlace(self.index, trans, self.scene, self.x, self.y) then
        self.trans = trans
    else
        self:Place()
    end
end

---设置方块
function Block:Place()
    return RawPlace(self.index, self.trans, self.scene, self.x, self.y)
end

---清除方块
function Block:Clear()
    IterateBlock(self.index, self.trans, function(x, y, b)
        local finalX = self.x + x
        local finalY = self.y - y
        --local num = 0
        if b then
            self.scene:Set(finalX, finalY, false)
        --    num = num+1
        end
        --print("嘿嘿嘿")
        --print(num)
        return true
    end)
end

return Block