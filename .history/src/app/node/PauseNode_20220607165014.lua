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
    local layer = ccui.Layout:create()
    local pauseLayer = cc.LayerColor:create(itsColor):addTo(layer, ConstantsUtil.LEVEL_VISIABLE_MEDIUM)
    local continueButton =
        ccui.Button:create(ConstantsUtil.PATH_INGAME_CONTINUE_PNG):addTo(
        layer,
        CONFIG_SCREEN_AUTOSCALE.LEVEL_VISIABLE_HIGH
    )
    local backButton =
        ccui.Button:create(ConstantsUtil.PATH_INGAME_BACK_PNG):addTo(layer, ConstantsUtil.LEVEL_VISIABLE_HIGH)

    return layer
end

return PauseNode
