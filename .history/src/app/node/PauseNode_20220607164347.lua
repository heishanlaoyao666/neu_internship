local PauseNode =
    class(
    "PauseNode",
    function()
        return cc.Node:create()
    end
)

function PauseNode:create()
    -- body
    local pause = PauseNode.new()
    pause:addChild(pause:init(x, y))
    return pause
end

function PauseNode:ctor()
    -- body
end

-- cc.c4b(0, 0, 0, 110)
function PauseNode:init(itsColor)
    -- body
    local layer = cc.LayerColor:create(itsColor)
end

return PauseNode
