local OverNode =
    class(
    "OverNode",
    function()
        return cc.Node:create()
    end
)

function OverNode:create(itsColor)
    -- body
    local overNode = OverNode.new()
    overNode:addChild(overNode:init(itsColor))
    return overNode
end

function OverNode:ctor()
    -- body
end

function OverNode:init(itsColor)
    -- body
    local layer = ccui.Layout:create()
    local overLayer = cc.LayerColor:create(itsColor):addTo(layer, ConstantsUtil.LEVEL_VISIABLE_MEDIUM)

    local listView = ccui.ListView:create():addTo(layer, ConstantsUtil.LEVEL_VISIABLE_MEDIUM)
    listView:setAnchorPoint(0.5, 0.5)
    listView:setPosition(WinSize.width / 2, WinSize.height / 2)
    listView:setContentSize(WinSize.width * 0.8, WinSize.height * 0.5)

    local beginButton =
        ccui.Button:create(ConstantsUtil.PATH_INGAME_CONTINUE_PNG):addTo(
        listView,
        CONFIG_SCREEN_AUTOSCALE.LEVEL_VISIABLE_HIGH
    )
    beginButton:setAnchorPoint(0.5, 0.5)
    beginButton:addTouchEventListener(
        function(ref, event)
            -- body
            Log.i("beginButton")
            if cc.EventCode.BEGAN == event then
                --- 按下
            elseif cc.EventCode.ENDED == event then
                --- 松开
                layer:removeFromParent()
                nowScene = import("app.scenes.GameScene").new()
                display.replaceScene(nowScene)
            end
        end
    )

    local backButton =
        ccui.Button:create(ConstantsUtil.PATH_INGAME_BACK_PNG):addTo(listView, ConstantsUtil.LEVEL_VISIABLE_HIGH)
    backButton:setAnchorPoint(0.5, 0.5)
    -- backButton:setContentSize()
    backButton:addTouchEventListener(
        function(ref, event)
            Log.i("backButton")
            -- if effectKey then
            --     Audio.playEffectSync(ConstantsUtil.PATH_BUTTON_EFFECT, false)
            -- end
            if cc.EventCode.BEGAN == event then
                --- 按下
            elseif cc.EventCode.ENDED == event then
                --- 松开
                nowScene = import("app.scenes.MenuScene").new()
                display.replaceScene(nowScene)
            end
        end
    )

    return layer
end

return OverNode
