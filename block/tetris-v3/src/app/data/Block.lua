--[[--
    方块定义
    Block.lua
]]
local ConstDef = require("app.def.ConstDef")
local Block = class("Block")


local blockArray_ = { -- 方块数组
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

local initOffset_ = ConstDef.MAIN_BOARD_WIDTH/2 - 3 -- 偏移量

--[[--
    构造函数

    @param board 类型：board，面板
    @param index 类型：number，块类型索引

    @return none
]]
function Block:ctor(board, index)

    self.x_ = initOffset_ -- 创建块时块的初始位置
    self.y_ = ConstDef.MAIN_BOARD_HEIGHT

    local offset = blockArray_[index].initOffset
    if offset then
        self.y_ = self.y_ + offset
    end

    self.board_ = board
    self.index_ = index
    self.trans_ = 1
    
end

--[[--
    随机生成风格

    @param none

    @return number
]]
function Block:randomStyle()
    return math.random(1, #blockArray_)
end

--[[--
    遍历方块(局部函数)

    @param index 类型：number，块类型索引
    @param trans 类型：number，块旋转索引
    @param callback 类型：function，回调函数

    @return none
]]
function Block:iterateBlock(index, trans, callback)

    local transArray = blockArray_[index]
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

--[[--
    判断行方块是否可以放置函数

    @param index 类型：number，块类型索引
    @param trans 类型：number，块旋转索引
    @param newX 类型：number，新x轴位置
    @param newY 类型：number，新Y轴位置

    @return boolean
]]
function Block:rawPlace(index, trans, newX, newY)

    -- 返回的数组
    local result = {}

    -- 当if为真时意味着块的所有点都可以放在新位置上
    if Block:iterateBlock(index, trans, function(x, y, b)
        -- 当b为真时意味着当前所遍历的点=1
        if b then
            local finalX = newX + x
            local finalY = newY - y

            -- 判断面板中的对应点有没有被方块占用
            if self.board_:get(finalX, finalY) ~= -1 then
                -- 位置已经被占用
                return false
            end

            table.insert(result, {
                x = finalX,
                y = finalY
            })
        end

        return true end) then

        for _, v in ipairs(result) do
            self.board_:set(v.x, v.y, blockArray_[index]["color"])
        end

        return true

    end
end

--[[--
    块移动函数

    @param deltaX 类型：number，移动增量
    @param deltaY 类型：number，移动增量

    @return boolean
]]
function Block:move(deltaX, deltaY)

    self:clear()

    local x = self.x_ +deltaX
    local y = self.y_ + deltaY

    -- 如果移动后的新位置可以放置
    if self:rawPlace(self.index_, self.trans_, x, y) then
        self.x_ = x
        self.y_ = y
        return true
    else
        -- 否则把方块放回原位
        self:place()
        return false
    end
end

--[[--
    顺时针旋转函数

    @param none

    @return none
]]
function Block:rotateCW()

    local offset = blockArray_[self.index_].initOffset
    if offset and self.y_ == 0 then
        return
    end

    self:clear()

    local transArray = blockArray_[self.index_]
    local trans = self.trans_ + 1

    if trans > #transArray then
        trans = 1
    end

    if self:rawPlace(self.index_, trans, self.x_, self.y_) then
        self.trans_ = trans
    else
        self:place()
    end

end

--[[--
    逆时针旋转函数

    @param none

    @return none
]]
function Block:rotateCCW()

    local offset = blockArray_[self.index_].initOffset
    if offset and self.y_ == 0 then
        return
    end

    self:clear()

    local transArray = blockArray_[self.index_]
    local trans = self.trans_ - 1

    if trans < 1 then
        trans = #transArray
    end

    if self:rawPlace(self.index_, trans, self.x_, self.y_) then
        self.trans_ = trans
    else
        self:place()
    end

end

--[[--
    方块放置函数

    @param none

    @return none
]]
function Block:place()
    return self:rawPlace(self.index_, self.trans_, self.x_, self.y_)
end

--[[--
    清除函数

    @param none

    @return boolean
]]
function Block:clear()

    Block:iterateBlock(self.index_, self.trans_, function(x, y, b)
        local finalX = self.x_ + x
        local finalY = self.y_ - y

        if b then
            self.board_:set(finalX, finalY, -1)
        end

        return true
    end)
end


return Block