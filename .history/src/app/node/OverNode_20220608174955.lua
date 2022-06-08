local OverNode =
    class(
    "OverNode",
    function()
        return cc.Node:create()
    end
)

function OverNode:create(itsColor, myRoleWithTail)
    -- body
    local overNode = OverNode.new()
    overNode:addChild(overNode:init(itsColor, myRoleWithTail))
    return overNode
end

function OverNode:ctor()
    -- body
end

function OverNode:init(itsColor, myRoleWithTail)
    -- body
    local layer = ccui.Layout:create()
    local overLayer = cc.LayerColor:create(itsColor):addTo(layer, ConstantsUtil.LEVEL_VISIABLE_MEDIUM)

    local listView = ccui.ListView:create():addTo(layer, ConstantsUtil.LEVEL_VISIABLE_MEDIUM)
    listView:setAnchorPoint(0.5, 0.5)
    local viewWidth = WinSize.width * 0.8
    local viewHeight = WinSize.height * 0.5
    listView:setPosition(WinSize.width / 2, WinSize.height / 2)
    listView:setContentSize(viewWidth, viewHeight)

    local infoLayer = ccui.ListView:create():addTo(listView)
    infoLayer:setAnchorPoint(0.5, 0.5)
    infoLayer:setContentSize(viewWidth, viewHeight * 0.3)
    -- 蒙的
    infoLayer:setDirection(1)
    local nicknameField = ccui.Layout:create():addTo(infoLayer)
    nicknameField:setContentSize(viewWidth / 2, viewHeight * 0.3)
    local nickname =
        ccui.Text:create(ConstantsUtil.username, ConstantsUtil.PATH_NORMAL_FONT_TTF, 25):addTo(nicknameField)
    nickname:setAnchorPoint(0.5, 0.5)

    local scoreField = ccui.Layout:create():addTo(infoLayer)
    scoreField:setContentSize(viewWidth / 2, viewHeight * 0.3)
    local score =
        ccui.TextBMFont:create(
        TypeConvert.Integer2StringLeadingZero(myRoleWithTail.score, 3),
        ConstantsUtil.PATH_BIG_NUM_FNT
    ):addTo(scoreField)

    local restartButton =
        ccui.Button:create(ConstantsUtil.PATH_OVER_BACK_PNG):addTo(
        listView,
        CONFIG_SCREEN_AUTOSCALE.LEVEL_VISIABLE_HIGH
    )
    restartButton:setAnchorPoint(0.5, 0.5)
    restartButton:addTouchEventListener(
        function(ref, event)
            -- body
            Log.i("restartButton")
            if cc.EventCode.BEGAN == event then
                --- 按下
            elseif cc.EventCode.ENDED == event then
                --- 松开
                Director:resume()
                layer:removeFromParent()
                nowScene = import("app.scenes.GameScene").new()
                display.replaceScene(nowScene)
            end
        end
    )

    local backButton =
        ccui.Button:create(ConstantsUtil.PATH_OVER_BACK_PNG):addTo(listView, ConstantsUtil.LEVEL_VISIABLE_HIGH)
    backButton:setAnchorPoint(0.5, 0.5)
    -- backButton:setContentSize()
    backButton:addTouchEventListener(
        function(ref, event)
            Log.i("backButton")
            if cc.EventCode.BEGAN == event then
                --- 按下
            elseif cc.EventCode.ENDED == event then
                --- 松开
                Director:resume()
                nowScene = import("app.scenes.MenuScene").new()
                display.replaceScene(nowScene)
            end
        end
    )

    return layer
end

return OverNode
