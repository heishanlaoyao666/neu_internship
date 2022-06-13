
require("app.Common")
local Block = require("app.Block")


local BoardSize = 4

local NextBoard = class("NextBoard")

local function makeKey(x,y)
    -- body
    return x*1000+y
end

function NextBoard:ctor(node)
    -- body
    self.map={}

    for x=0,BoardSize-1 do
        for y=0,BoardSize-1 do
            -- body
            local posX,posY = Grid2Pos(x+cSceneWidth+1, y+cSceneHeight-4)
            --print(Block.fileName)
            local sp = cc.Sprite:create("res\\美术资源\\t_3.png")
            sp:setScale(0.2)
            sp:setPosition(posX,posY)
            node:addChild(sp)
            sp:setVisible(false)

            self.map[makeKey(x, y)]=sp
        end
    end
end

function NextBoard:Next()
    -- body
    local style

    if self.nextStyle==nil then
        style=RandomStyle()
    else
        style=self.nextStyle
    end

    self.nextStyle=RandomStyle()

    self:Clear()
    RawPlace(self.nextStyle, 1, self, -1, 4)

    return style
end

function NextBoard:Clear()
    -- body
    for y=0,BoardSize-1 do
        self:ClearLine(y)
    end
end

function NextBoard:Set(x,y,value)
    -- body
    local sp = self.map[makeKey(x, y)]
    if sp==nil then
        return
    end
    sp:setVisible(value)
end

function NextBoard:Get(x,y)
    -- body
    local sp = self.map[makeKey(x, y)]
    if sp==nil then
        return
    end

    return sp:isVisible()
end

function NextBoard:ClearLine(y)
    -- body
    for x=0,BoardSize-1 do
        self:Set(x, y, false)
    end
end


return NextBoard