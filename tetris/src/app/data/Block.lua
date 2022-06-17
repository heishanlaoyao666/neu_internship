local Block = class("Block")

--设置初始生成的x
local InitXOffset = cSceneWidth / 2 - 3

--方块数据
local cBlockArray = {
    --[[
        形状：
        ***
         *
        与变换
    ]]
    {
        {
            {1, 1, 1, 0},
            {0, 1, 0, 0},
            {0, 0, 0, 0},
            {0, 0, 0, 0}
        },
        {
            {0, 1, 0, 0},
            {1, 1, 0, 0},
            {0, 1, 0, 0},
            {0, 0, 0, 0}
        },
        {
            {0, 1, 0, 0},
            {1, 1, 1, 0},
            {0, 0, 0, 0},
            {0, 0, 0, 0}
        },
        {
            {0, 1, 0, 0},
            {0, 1, 1, 0},
            {0, 1, 0, 0},
            {0, 0, 0, 0}
        }
    },
    --[[
        形状：
         **
         **
        与变换
    ]]
    {
        {
            {0, 1, 1, 0},
            {0, 1, 1, 0},
            {0, 0, 0, 0},
            {0, 0, 0, 0}
        }
    },
    --[[
        形状：
         **
        **
        与变换
    ]]
    {
        {
            {0, 1, 1, 0},
            {1, 1, 0, 0},
            {0, 0, 0, 0},
            {0, 0, 0, 0}
        },
        {
            {0, 1, 0, 0},
            {0, 1, 1, 0},
            {0, 0, 1, 0},
            {0, 0, 0, 0}
        }
    },
    --[[
        形状：
        **
         **
        与变换
    ]]
    {
        {
            {1, 1, 0, 0},
            {0, 1, 1, 0},
            {0, 0, 0, 0},
            {0, 0, 0, 0}
        },
        {
            {0, 0, 1, 0},
            {0, 1, 1, 0},
            {0, 1, 0, 0},
            {0, 0, 0, 0}
        }
    },
    --[[
        形状：
         *
         *
         *
         *
        与变换
    ]]
    {
        initOffset = 1,
        {
            {0, 0, 0, 0},
            {1, 1, 1, 1},
            {0, 0, 0, 0},
            {0, 0, 0, 0}
        },
        {
            {0, 1, 0, 0},
            {0, 1, 0, 0},
            {0, 1, 0, 0},
            {0, 1, 0, 0}
        }
    },
    --[[
        形状：
        ***
        *
        与变换
    ]]
    {
        initOffset = 1,
        {
            {0, 0, 0, 0},
            {1, 1, 1, 0},
            {1, 0, 0, 0},
            {0, 0, 0, 0}
        },
        {
            {1, 1, 0, 0},
            {0, 1, 0, 0},
            {0, 1, 0, 0},
            {0, 0, 0, 0}
        },
        {
            {0, 0, 1, 0},
            {1, 1, 1, 0},
            {0, 0, 0, 0},
            {0, 0, 0, 0}
        },
        {
            {0, 1, 0, 0},
            {0, 1, 0, 0},
            {0, 1, 1, 0},
            {0, 0, 0, 0}
        }
    },
    --[[
        形状：
        ***
          *
        与变换
    ]]
    {
        initOffset = 1,
        {
            {0, 0, 0, 0},
            {1, 1, 1, 0},
            {0, 0, 1, 0},
            {0, 0, 0, 0}
        },
        {
            {0, 1, 0, 0},
            {0, 1, 0, 0},
            {1, 1, 0, 0},
            {0, 0, 0, 0}
        },
        {
            {1, 0, 0, 0},
            {1, 1, 1, 0},
            {0, 0, 0, 0},
            {0, 0, 0, 0}
        },
        {
            {0, 1, 1, 0},
            {0, 1, 0, 0},
            {0, 1, 0, 0},
            {0, 0, 0, 0}
        }
    }
}

--[[--
    描述：从方块数组中随机一个index并返回

    @return 一个index
]]
function RandomStyle()
    math.randomseed(os.time())
    return math.random(1, #cBlockArray)
end

--[[--
    描述：初始化方块

    @param scnen 场景
    @param index 方块种类编号

    @return none
]]
function Block:ctor(scene, index)
    self.x = InitXOffset
    self.y = cSceneHeight

    --矩阵第一行是否有方块，保证方块贴着顶部生成
    local offset = cBlockArray[index].initOffset
    if offset then
        self.y = self.y + offset
    end

    self.scene = scene
    self.index = index
    self.trans = 1
end

--[[--
    描述：遍历方块

    @param index 方块种类编号
    @param trans 旋转编号
    @param callback 回调函数

    @return bool
]]
local function IterateBlock(index, trans, callback)
    --获取种类
    local transArray = cBlockArray[index]
    --获取旋转
    local eachBlock = transArray[trans]

    for y = 1, #eachBlock do
        local xdata = eachBlock[y]

        for x = 1, #xdata do
            local data = xdata[x]

            if not callback(x, y, data ~= 0) then
                return false
            end
        end
    end
    return true
end

--[[--
    描述：放置方块

    @param index 方块种类编号
    @param trans 旋转编号
    @param scene 场景
    @param newX x偏移量
    @param newY y偏移量

    @return bool
]]
function RawPlace(index, trans, scene, newX, newY)
    local result = {}

    --判断该位置是否有方块
    if
        IterateBlock(
            index,
            trans,
            function(x, y, b)
                if b then
                    local finalX = newX + x
                    local finalY = newY - y

                    if scene:Get(finalX, finalY) then
                        return false
                    end
                    table.insert(result, {x = finalX, y = finalY})
                end
                return true
            end
        )
     then
        for k, v in pairs(result) do
            scene:Set(v.x, v.y, true)
        end
        return true
    end
end

--[[--
    描述：移动方块

    @param deltaX x偏移量
    @param deltaY y偏移量

    @return none
]]
function Block:Move(deltaX, deltaY)
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

--[[--
    描述：旋转方块

    @param none

    @return none
]]
function Block:Rotate(value)
    local offset = cBlockArray[self.index].initOffset
    if offset and self.y == 0 then
        return
    end

    self:Clear()

    local transArray = cBlockArray[self.index]

    local trans = self.trans
    if value == 0 then
        trans = trans + 1
        if trans > #transArray then
            trans = 1
        end
    else
        trans = trans - 1
        if trans < 1 then
            trans = 4
        end
    end

    if RawPlace(self.index, trans, self.scene, self.x, self.y) then
        self.trans = trans
    else
        self:Place()
    end
end

--放置方块
function Block:Place()
    return RawPlace(self.index, self.trans, self.scene, self.x, self.y)
end

--消除方块
function Block:Clear()
    IterateBlock(
        self.index,
        self.trans,
        function(x, y, b)
            local finalX = self.x + x
            local finalY = self.y - y

            if b then
                self.scene:Set(finalX, finalY, false)
            end
            return true
        end
    )
end

return Block
