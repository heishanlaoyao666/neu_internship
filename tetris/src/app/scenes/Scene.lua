require "app.scenes.Common"

local Scene = class("Scene")

local function makeKey(x,y)
    return x * 1000 + y
end

function Scene:ctor(node)
    self.map = {}

    for x = 0, cSceneWidth - 1 do
        for y = 0, cSceneHeight - 1 do
            local posX, posY = Grid2Pos(x, y)
            local sp = cc.Sprite:create("t_7.png")
            sp:pos(posX, posY)
            sp:setScale(0.33)
            node:addChild(sp)

            --将边框设置为可见,其他设置为不可见
            local visible = (x == 0 or x == cSceneWidth - 1) or y == 0
            sp:setVisible(visible)

            --将二维坐标系统转换为一维数组
            self.map[makeKey(x, y)] = sp
        end
    end
end

--按行消除
function Scene:ClearLine(y)
    for x = 1, cSceneWidth - 2 do
        self:Set(x, y, false)
    end
end

--全部消除
function Scene:Clear()
    for y = 1, cSceneHeight - 1 do
        self:ClearLine(y)
    end
end

--消除方块
function Scene:Set(x, y, value)
    local sp = self.map[makeKey(x, y)]
    if sp == nil then
        return
    end
    sp:setVisible(value)
end

--添加方块
function Scene:Get(x, y)
    local sp = self.map[makeKey(x, y)]
    if sp == nil then
        return
    end
    return sp:isVisible()
end

function Scene:IsFullLine(y)
    for x = 1, cSceneWidth - 2 do
        if not self:Get(x, y) then
            return false
        end
    end
    return true
end

function Scene:CheckAndSweep()
    local count = 0
    for y = 1, cSceneHeight - 1 do
        if self:IsFullLine(y) then
            self:ClearLine(y)
            count = count + 1
            break
        end
    end
    if count == 1 then
        return 5
    elseif count == 2 then
        return 15
    elseif count == 3 then
        return 25
    elseif count == 4 then
        return 35
    end
    return 0
end

function Scene:MoveDown(sy)
    for y = sy, cSceneHeight - 1 do
        for x = 1, cSceneWidth - 2 do
            self:Set(x,y, self:Get(x, y + 1))
        end
    end
end

function Scene:Shift()
    for y = 1, cSceneHeight - 2 do
        if self:IsEmptyLine(y) and (not self:IsEmptyLine(y + 1)) then
            self:MoveDown(y)
        end
    end
end

function Scene:IsEmptyLine(y)
    for x = 1, cSceneWidth - 2 do
        if self:Get(x, y) then
            return false
        end
    end
    return true
end

function Scene:onEnter()
end

function Scene:onExit()
end

return Scene
