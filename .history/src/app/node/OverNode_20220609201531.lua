local OverNode =
    class(
    "OverNode",
    function()
        return cc.Node:create()
    end
)

function OverNode:create(itsColor, myRole)
    -- body
    local overNode = OverNode.new()
    overNode:addChild(overNode:init(itsColor, myRole))
    return overNode
end

function OverNode:ctor()
    -- body
end

function OverNode:init(itsColor, myRole)
    -- body
    local layer = ccui.Layout:create()
    local overLayer = cc.LayerColor:create(itsColor):addTo(layer)

    local listView = ccui.ListView:create():addTo(layer)
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
    nicknameField:setAnchorPoint(0.5, 0.5)
    local nickname =
        ccui.Text:create(ConstantsUtil.username, ConstantsUtil.PATH_NORMAL_FONT_TTF, 25):addTo(nicknameField)
    nickname:setAnchorPoint(0.5, 0.5)

    local scoreField = ccui.Layout:create():addTo(infoLayer)
    scoreField:setContentSize(viewWidth / 2, viewHeight * 0.3)
    local score =
        ccui.TextBMFont:create(TypeConvert.Integer2StringLeadingZero(myRole.score, 3), ConstantsUtil.PATH_BIG_NUM_FNT):addTo(
        scoreField
    )
    score:setScale(0.2)
    score:setAnchorPoint(1, 1)
    score:setContentSize(viewWidth / 2, 0)

    local restartButton = ccui.Button:create(ConstantsUtil.PATH_OVER_RESTART_PNG):addTo(listView)
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
                --
                GameHandler.bulletArray = {}
                GameHandler.enemyArray = {}
                --
                local nowScene = import("app.scenes.GameScene").new()
                display.replaceScene(nowScene)
            end
        end
    )

    local backButton = ccui.Button:create(ConstantsUtil.PATH_OVER_BACK_PNG):addTo(listView)
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
                local nowScene = import("app.scenes.MenuScene").new()
                display.replaceScene(nowScene)
            end
        end
    )
    return layer
end

return OverNode
