require "app.utils.Common"
local Block = require "app.data.Block"

local BoardSize = 4

local NextBlock = class("NextBlock")

local function makeKey(x, y)
    return x*1000 + y
end

function NextBlock:ctor()
    self.map = {}
end

function NextBlock:Next()
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

function NextBlock:Clear()
    for y = 0, BoardSize - 1 do
        self:ClearLine(y)
    end
end

function NextBlock:Set(x, y, value)
    local sp = self.map[makeKey(x, y)]
    if sp == nil then
        return
    end
    sp:setVisible(value)
end

function NextBlock:Get(x, y)
    local sp = self.map[makeKey(x, y)]
    if sp == nil then
        return false
    end

    return sp:isVisible()
end

function NextBlock:ClearLine(y)
    for x = 0, BoardSize - 1 do
        self:Set(x, y, false)
    end
end

return NextBlock