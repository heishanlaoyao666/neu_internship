
--- 一代方块

local cBlockArray = {

    -- T字型
    {
        color = 1,
        {
            -- 旋转轴在(2, 2)处
            { 1,1,1,0 },
            { 0,1,0,0 },
            { 0,0,0,0 },
            { 0,0,0,0 },
        },
        {
            { 0,1,0,0 },
            { 1,1,0,0 },
            { 0,1,0,0 },
            { 0,0,0,0 },
        },
        {
            { 0,1,0,0 },
            { 1,1,1,0 },
            { 0,0,0,0 },
            { 0,0,0,0 },
        },
        {
            { 0,1,0,0 },
            { 0,1,1,0 },
            { 0,1,0,0 },
            { 0,0,0,0 },
        },
    },

    -- 方块型
    {
        color = 2,
        {
            { 0,1,1,0 },
            { 0,1,1,0 },
            { 0,0,0,0 },
            { 0,0,0,0 },
        },
    },

    -- S字型
    {
        color = 3,
        {
            { 0,1,1,0 },
            { 1,1,0,0 },
            { 0,0,0,0 },
            { 0,0,0,0 },
        },
        {
            { 0,1,0,0 },
            { 0,1,1,0 },
            { 0,0,1,0 },
            { 0,0,0,0 },
        },
    },

    -- Z字型
    {
        color = 4,
        {
            { 1,1,0,0 },
            { 0,1,1,0 },
            { 0,0,0,0 },
            { 0,0,0,0 },
        },
        {
            { 0,0,1,0 },
            { 0,1,1,0 },
            { 0,1,0,0 },
            { 0,0,0,0 },
        },
    },

    -- 条形
    {
        color = 5,
        initOffset = 1,
        {
            { 0,0,0,0 },
            { 1,1,1,1 },
            { 0,0,0,0 },
            { 0,0,0,0 },
        },
        {
            { 0,1,0,0 },
            { 0,1,0,0 },
            { 0,1,0,0 },
            { 0,1,0,0 },
        },
    },

    -- L型
    {
        color = 6,
        initOffset = 1,
        {
            { 0,0,0,0 },
            { 1,1,1,0 },
            { 1,0,0,0 },
            { 0,0,0,0 },
        },
        {
            { 1,1,0,0 },
            { 0,1,0,0 },
            { 0,1,0,0 },
            { 0,0,0,0 },
        },
        {
            { 0,0,1,0 },
            { 1,1,1,0 },
            { 0,0,0,0 },
            { 0,0,0,0 },
        },
        {
            { 0,1,0,0 },
            { 0,1,0,0 },
            { 0,1,1,0 },
            { 0,0,0,0 },
        },
    },

    -- 反L型
    {
        color = 7,
        initOffset = 1,
        {
            { 0,0,0,0 },
            { 1,1,1,0 },
            { 0,0,1,0 },
            { 0,0,0,0 },
        },
        {
            { 0,1,0,0 },
            { 0,1,0,0 },
            { 1,1,0,0 },
            { 0,0,0,0 },
        },
        {
            { 1,0,0,0 },
            { 1,1,1,0 },
            { 0,0,0,0 },
            { 0,0,0,0 },
        },
        {
            { 0,1,1,0 },
            { 0,1,0,0 },
            { 0,1,0,0 },
            { 0,0,0,0 },
        },
    },
}

local Block = class("Block")


local InitOffset = cSceneWidth/2 - 3

function Block:ctor(scene, index)

    self.x = InitOffset
    self.y = cSceneHeight

    local offset = cBlockArray[index].initOffset
    if offset then
        self.y = self.y + offset
    end

    self.scene = scene
    self.index = index
    self.trans = 1
    
end

function RandomStyle()
    return math.random(1, #cBlockArray)
end

-- 遍历方块
local function IterateBlock(index, trans, callback)

    local transArray = cBlockArray[index]
    local eachBlock = transArray[trans]

    for y = 1, #eachBlock do

        local xData = eachBlock[y]

        for x = 1, #xData do
            local data = xData[x]

            -- data ~= 0 等价于布尔值
            -- 当callback返回值为false时相当于遇到错误
            if not callback(x, y, data ~= 0) then
                return
            end
        end
    end
    return true
end


-- 放置方块到游戏场景
function RawPlace(index, trans, scene, newX, newY)

    -- 返回的数组
    local result = {}

    -- 当if为真时意味着块的所有点都可以放在新位置上
    if IterateBlock(index, trans, function(x, y, b)
        -- 当b为真时意味着当前所遍历的点=1
        if b then
            local finalX = newX + x
            local finalY = newY - y

            -- 判断场景中的对应点有没有被方块占用
            if scene:Get(finalX, finalY) then
                -- 位置已经被占用
                return false
            end

            table.insert(result, {
                x = finalX,
                y = finalY
            })
        end

        return true end) then

        for k, v in ipairs(result) do
            scene:Set(v.x, v.y, true)
        end

        return true

    end
end


function Block:Move(deltaX, deltaY)

    self:Clear()

    local x = self.x +deltaX
    local y = self.y + deltaY

    -- 如果移动后的新位置可以放置
    if RawPlace(self.index, self.trans, self.scene, x, y) then
        self.x = x
        self.y = y
        return true
    else
        -- 否则把方块放回原位
        self:Place()
        return false
    end
end


function Block:Rotate()

    local offset = cBlockArray[self.index].initOffset
    if offset and self.y == 0 then
        return
    end

    self:Clear()

    local transArray = cBlockArray[self.index]
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


function Block:Place()
    return RawPlace(self.index, self.trans, self.scene, self.x, self.y)
end


function Block:Clear()

    IterateBlock(self.index, self.trans, function(x, y, b)
        local finalX = self.x + x
        local finalY = self.y - y

        if b then
            self.scene:Set(finalX, finalY, false)
        end

        return true
    end)
end

return Block