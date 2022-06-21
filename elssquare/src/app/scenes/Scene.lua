

--- 8 * 18

local Scene = class("Scene")

local function makeKey(x, y)
    return x * 1000 + y
end

function Scene:ctor(node)
    self.map = {}
    --墙
    for x = 0, cSceneWidth-1 do
        for y = 0, cSceneHeight-1 do           
            local posX, posY = GridPos(x, y)
            local t1 = {"res/ui/t_1.png",
                "res/ui/t_2.png","res/ui/t_3.png","res/ui/t_4.png","res/ui/t_5.png","res/ui/t_6.png","res/ui/t_7.png"}
            --local sp = display.newSprite("res/ui/t_2.png")
            local sp = display.newSprite(t1[math.random(1,7)])
            sp:setPosition(posX, posY)
            sp:setScale(0.2,0.2)
            node:addChild(sp)

            local visible = (x == 0 or x == cSceneWidth-1) or y == 0
            sp:setVisible(visible)

            self.map[makeKey(x, y)] = sp
        end
    end
end

function Scene:ClearLine(y)
    for x = 1, cSceneWidth-2 do
        self:Set(x, y, false)
    end
end

function Scene:Clear()
    for y = 1, cSceneHeight-1 do
        self:ClearLine(y)
    end
end

function Scene:Set(x, y, value)
    local sp = self.map[makeKey(x, y)]
    if sp == nil then
        return
    end
    sp:setVisible(value)
end

function Scene:Get(x, y)
    local sp = self.map[makeKey(x, y)]
    if sp == nil then
        return
    end
    return sp:isVisible()
end

--- 方块消除

function Scene:IsFullLine(y)
    for x = 1, cSceneWidth - 2 do
        if not self:Get(x, y) then
            return false
        end
        
    end
    return true
end

function  Scene:CheckAndSweep()
    local count = 0
    for y = 1, cSceneHeight - 1 do
        if  self:IsFullLine(y) then
            self:ClearLine(y)
            count = count + 1
            break
        end
    end
    --print("1111111111")
    --print(count)
    return count
end

function Scene:MoveDown(sy)
    for y = sy, cSceneHeight - 2 do
        for x = 1, cSceneWidth - 2 do
            self:Set(x, y, self:Get(x, y + 1))
        end
    end
end

function Scene:Shift()
    for y = 1, cSceneHeight - 2 do
        if  self:IsEmptyLine(y) and  (not self:IsEmptyLine(y + 1)) then
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

return Scene