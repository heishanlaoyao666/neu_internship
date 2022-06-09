require("app.Common")

local Scene = class("Scene")

local function makeKey(x,y)
    return x*1000+y
end

function Scene:ctor(node)
    self.map={}
    for x=0,cSceneWidth-1 do
        for y=0,cSceneHeight-1 do
            local posX,posY = Grid2Pos(x, y)
            local sp = cc.Sprite:create("res\\美术资源\\t_1.png")
            sp:setScale(0.32)
            sp:setPosition(posX,posY)
            node:addChild(sp)

            local visible = (x==0 or x==cSceneWidth-1) or y==0

            sp:setVisible(visible)

            self.map[makeKey(x,y)]=sp
        end

    end
end

function Scene:ClearLine(y)
    -- body
    for x=1,cSceneWidth-2 do
        self:Set(x,y,false)
    end
end

function Scene:Clear()
    -- body
    for y=1,cSceneHeight-1 do
        self:ClearLine(y)
    end
end

function  Scene:Set(x,y,value)
    local sp =self.map[makeKey(x, y)]
    if sp==nil then
        return
    end

    sp:setVisible(value)
end

function Scene:Get(x,y)
    -- body
    local sp = self.map[makeKey(x, y)]
    if sp==nil then
        return
    end

    return sp:isVisible()
end

function Scene:IsFullLine(y)
    for x=1,cSceneWidth-2 do
        if not self:Get(x,y) then
            return false
        end
    end

    return true
end

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
    return count
end

function Scene:MoveDown(sy)
    -- body
    for y=sy,cSceneHeight-1 do
        for x=1,cSceneWidth-2 do
            self:Set(x, y, self:Get(x, y+1))
        end
    end
end

function Scene:Shift()
    -- body
    for y=1,cSceneHeight-2 do
        if self:IsFullLine(y)and(not self:IsFullLine(y+1)) then
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