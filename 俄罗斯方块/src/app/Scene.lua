require("app.Common")
local Block = require("app.Block")
local Scene = class("Scene")

local function makeKey(x,y)
    return x*1000+y
end

function Scene:ctor(node)
    self.map={}
    for x=0,cSceneWidth-1 do
        for y=0,cSceneHeight-1 do
            local posX,posY = Grid2Pos(x, y)

            --print(Block.fileName)
            local sp = cc.Sprite:create("res\\美术资源\\t_1.png")
            sp:setScale(0.2)
            sp:setPosition(posX,posY)
            node:addChild(sp)

            local visible = (x==0 or x==cSceneWidth-1) or y==0

            sp:setVisible(visible)

            self.map[makeKey(x,y)]=sp
        end
    end
end

--清除一行
function Scene:ClearLine(y)
    -- body
    for x=1,cSceneWidth-2 do
        self:Set(x,y,false)
    end
end

--清除所有
function Scene:Clear()
    -- body
    for y=1,cSceneHeight-1 do
        self:ClearLine(y)
    end
end

--设置精灵坐标
function  Scene:Set(x,y,value)
    local sp =self.map[makeKey(x, y)]
    if sp==nil then
        return
    end

    sp:setVisible(value)
end

--获取格子坐标
function Scene:Get(x,y)
    -- body
    local sp = self.map[makeKey(x, y)]
    if sp==nil then
        return
    end

    return sp:isVisible()
end

--判断行是否满
function Scene:IsFullLine(y)
    for x=1,cSceneWidth-2 do
        if not self:Get(x,y) then
            return false
        end
    end

    return true
end

--检测清除满行方块，并计算得分
function Scene:CheckAndSweep()
    -- body
    local count=0
    for y=1,cSceneHeight-1 do
        if self:IsFullLine(y) then
            self:ClearLine(y)
            count = count+1
            break
        end

    end
    local scoreAdd=cc.UserDefault:getInstance():getIntegerForKey("scoreAdd")
    cc.UserDefault:getInstance():setStringForKey("score",cc.UserDefault:getInstance():getStringForKey("score")+10*count)
    cc.UserDefault:getInstance():setIntegerForKey("scoreAdd",scoreAdd+10*count)
    return count
end

--清除满行后向下移动
function Scene:MoveDown(sy)
    -- body
    for y=sy,cSceneHeight-1 do
        for x=1,cSceneWidth-2 do
            self:Set(x, y, self:Get(x, y+1))
        end
    end
end

--下移
function Scene:Shift()
    -- body
    for y=1,cSceneHeight-2 do
        if self:IsEmptyLine(y)and(not self:IsEmptyLine(y+1)) then
            self:MoveDown(y)
        end
    end
end

function Scene:IsEmptyLine(y)
    -- body
    for x=1,cSceneWidth-2 do
        if self:Get(x,y) then
            return false
        end
    end

    return true
end


 return Scene