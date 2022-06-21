
local Common = require ("app.scenes.Common")

local Block = require ("app.scenes.Block")

local BoardSize = 4

local Next = class("Next")

local function makeKey(x, y)
    return x * 1000 + y
end

function Next:ctor(node)
    self.map = {}
    

    for x = 0, BoardSize - 1 do
        for y = 0, BoardSize - 1 do


            local posX, posY = Common.GridPos(x + cSceneWidth + 1, y + cSceneHeight - 4)
            local sp = display.newSprite("res/ui/t_2.png")
            sp:setPosition(posX, posY)
            node:addChild(sp)
            sp:setVisible(false)
            self.map[makeKey(x, y)] = sp
        end
    end
end

function Next:Next()
    local style
    if self.nextStype == nil then
        style = RandomStyle()
    else
        style = self.nextStype
    end
    self.nextStype = RandomStyle()

    self:Clear()
    Block.RawPlace(self.nextStype, 1, self, -1, 4)

    return style
end

function Next:Clear()
    for y = 1, BoardSize - 1 do
        self:CleaLine(y)
    end
end

function Next:Set(x, y, value)
    local sp = self.map[makeKey(x, y)]
    if sp == nil then
        return
    end
    sp:setVisible(value)
end


function Next:Get(x, y)
    local sp = self.map[makeKey(x, y)]
    if sp == nil then
        return
    end
    return sp:isVisible()
end

function Next:CleaLine(y)
    for x = 1, BoardSize - 1 do
        self:Set(x, y, false)
    end
end

return Next