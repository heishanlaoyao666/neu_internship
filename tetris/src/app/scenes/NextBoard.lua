require"app.scenes.Common"
local Block = require"app.scenes.Block"

local BoardSize = 4

local NextBoard = class("NextBoard")

local function makeKey(x, y)
    return x*1000 + y
end

function NextBoard:ctor(node)
    self.map = {}

    for x = 0, BoardSize - 1 do
        for y = 0, BoardSize - 1 do
            local posX, posY = Grid2Pos(x + cSceneWidth + 1, y + cSceneHeight - 4)
            local sp = cc.Sprite:create("t_1.png")
            sp:setScale(0.33)
            sp:pos(posX, posY)
            node:addChild(sp)
            sp:setVisible(false)
            self.map[makeKey(x, y)] = sp
        end
    end
end

function NextBoard:Next()
    local style

    if self.nextStyle == nil then
        style = RandomStyle()
    else
        style = self.nextStyle
    end

    self.nextStyle = RandomStyle()

    self:Clear()
    RawPlace(self.nextStyle, 1, self, -1, 4)

    return style
end

function NextBoard:Clear()
    for y = 0, BoardSize - 1 do
        self:ClearLine(y)
    end
end

function NextBoard:Set(x, y, value)
    local sp = self.map[makeKey(x, y)]
    if sp == nil then
        return
    end
    sp:setVisible(value)
end

function NextBoard:Get(x, y)
    local sp = self.map[makeKey(x, y)]
    if sp == nil then
        return false
    end

    return sp:isVisible()
end

function NextBoard:ClearLine(y)
    for x = 0, BoardSize - 1 do
        self:Set(x, y, false)
    end
end

return NextBoard