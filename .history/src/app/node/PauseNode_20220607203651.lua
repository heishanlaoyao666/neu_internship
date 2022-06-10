local PauseNode =
    class(
    "PauseNode",
    function()
        return cc.Node:create()
    end
)

function PauseNode:create(itsColor)
    -- body
    local pause = PauseNode.new()
    pause:addChild(pause:init(itsColor))
    return pause
end

function PauseNode:ctor()
    -- body
end

function PauseNode:init(itsColor)
    -- body
    local layer = ccui.Layout:create()
    local pauseLayer = cc.LayerColor:create(itsColor):addTo(layer, ConstantsUtil.LEVEL_VISIABLE_MEDIUM)

    local listView = ccui.ListView:create():addTo(layer, ConstantsUtil.LEVEL_VISIABLE_MEDIUM)
    listView:setAnchorPoint(0.5, 0.5)
    listView:setPosition(WinSize.width / 2, WinSize.height / 2)
    listView:setContentSize(WinSize.width * 0.8, WinSize.height * 0.3)

    local continueButton =
        ccui.Button:create(ConstantsUtil.PATH_INGAME_CONTINUE_PNG):addTo(
        listView,
        CONFIG_SCREEN_AUTOSCALE.LEVEL_VISIABLE_HIGH
    )
    continueButton:setAnchorPoint(0.5, 0.5)
    continueButton:addTouchEventListener(
        function(ref, event)
            -- body
            Log.i("continueButton")
            if cc.EventCode.BEGAN == event then
                --- 按下
            elseif cc.EventCode.ENDED == event then
                --- 松开
                layer:removeFromParent()
                ConstantsUtil.puase = false
                Director:resume()
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
                lastGameScene = clone(display.getRunningScene())
                Log.i(lastGameScene)
                Director:resume()
                local menuScene = import("app.scenes.MenuScene").new()
                display.replaceScene(menuScene)
            end
        end
    )

    return layer
end

return PauseNode
