local Block = class("Block")

--定义方块的数据结构
local blockArray = {
    --T
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
    --0
    {
        {
            {0,1,1,0},
            {0,1,1,0},
            {0,0,0,0},
            {0,0,0,0},
        }
    },
    --S
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
    --Z
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
    --I
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
    --L
    {
        initOffset = 1,
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
    ---J
    {
        initOffset = 1,
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
SceneWidth = 10 + 2--场景宽度，12个方块
SceneHeight = 20--场景高度，20个方块

function Block:ctor(func,index)
    self.x = SceneWidth/2 - 3--屏幕正中间
    self.y = SceneHeight--屏幕最上方
    local offset = blockArray[index].initOffset
    if offset then
        self.y = self.y + offset
    end

    self.index = index--方块形状
    self.func = func--方块形态，即各个角度的形态
    self.trans =1--有待改进，改成初始角度随机的
end

function RandomStyle()--随机取方块形状
    math.randomseed(os.time())
    local n = math.random(1, #blockArray)
    return n
end

function IterateBlock(index, trans, callback)--通过得到的形状和形态使场景中对应位置的方块显示
    local transArray = blockArray[index]--方块种类
    local eachBlock = transArray[trans]--方块具体角度
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

function RawPlace(index, trans, func, newX, newY)
    local result = {}
    if IterateBlock(index, trans, function(x, y, b)
        if b then
            local finalX = newX + x
            local finalY = newY - y
            if func:Search(finalX, finalY) then
                return false
            end
            table.insert(result, {x = finalX, y = finalY})--找不到则插入
        end
        return true--可以放置
    end) then

        for k, v in ipairs(result) do
            func:Set(v.x, v.y, true)
        end
        return true
    end
end

function Block:Move(deltaX, deltaY)
    self:Clear()
    local x = self.x + deltaX
    local y = self.y + deltaY
    if RawPlace(self.index, self.trans, self.func, x, y) then
        self.x = x
        self.y = y
        return true
    else
        self:Place()
        return false
    end
end

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

    if RawPlace(self.index, trans, self.func, self.x, self.y) then
        self.trans = trans
    else
        self:Place()
    end
end

function Block:Place()
    return RawPlace(self.index, self.trans, self.func, self.x, self.y)
end

function Block:Clear()
    IterateBlock(self.index, self.trans, function(x, y, b)
        local finalX = self.x + x
        local finalY = self.y - y
        if b then
            self.func:Set(finalX, finalY, false)
        end
        return true
    end)
end
return Block