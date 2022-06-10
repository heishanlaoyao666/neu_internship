local PauseNode =
    class(
    "PauseNode",
    function()
        return cc.Node:create()
    end
)

function PauseNode:ctor()
    -- body
end

function PauseNode:create()
    -- body
    local pause = PauseNode.new()
    pause:addChild(pause:init())
    return pause
end

function PauseNode:init()
    -- body
end

return PauseNode
