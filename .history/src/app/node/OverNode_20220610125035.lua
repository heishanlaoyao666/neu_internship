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
    local overLayer = cc.LayerColor:create(itsColor):addTo(layer)
    local list = tolua.cast(CSLoader:createNodeWithFlatBuffersFile("overLayer.csb"), "ccui.Layout"):addTo(overLayer)

    local listView = tolua.cast(ccui.Helper:seekWidgetByName(list, "infoList"), "ccui.ListView")
    local nameField = tolua.cast(ccui.Helper:seekWidgetByName(list, "nameField"), "ccui.Layout")
    local scoreField = tolua.cast(ccui.Helper:seekWidgetByName(list, "scoreField"), "ccui.Layout")
    --
    local nickname = ccui.Text:create(ConstantsUtil.username, ConstantsUtil.PATH_NORMAL_FONT_TTF, 30)
    nickname:addTo(nameField)
    nickname:setAnchorPoint(0.5, 0.5)
    --
    Log.i("Score: " .. TypeConvert.Integer2StringLeadingZero(GameHandler.myRole:getMyScore(), 3))
    local score =
        ccui.TextBMFont:create(
        TypeConvert.Integer2StringLeadingZero(GameHandler.myRole:getMyScore(), 3),
        ConstantsUtil.PATH_BIG_NUM_FNT
    ):addTo(scoreField)
    score:setScale(0.4)
    score:setAnchorPoint(1, 1)
    score:pos(0, scoreField:getContentSize().height * 0.5)
    score:setContentSize(0, scoreField:getContentSize().height)

    -- local listView = ccui.ListView:create():addTo(layer)
    -- listView:setAnchorPoint(0.5, 0.5)
    -- local viewWidth = WinSize.width * 0.8
    -- local viewHeight = WinSize.height * 0.8
    -- listView:setPosition(WinSize.width / 2, WinSize.height / 2)
    -- listView:setContentSize(viewWidth, viewHeight)

    -- local infoLayer = ccui.ListView:create():addTo(listView)
    -- infoLayer:setAnchorPoint(0.5, 0.5)
    -- local infoWidth = viewWidth
    -- local infoHeight = viewHeight * 0.5
    -- infoLayer:setContentSize(infoWidth, infoHeight)
    -- infoLayer:setDirection(0)
    -- --
    -- --
    -- local scoreLayer = ccui.Layout:create():addTo(infoLayer, ConstantsUtil.LEVEL_VISIABLE_HIGH)
    -- scoreLayer:setContentSize(infoWidth / 2, infoHeight)

    -- local restartButton = ccui.Button:create(ConstantsUtil.PATH_OVER_RESTART_PNG):addTo(listView)
    -- restartButton:setAnchorPoint(0.5, 0.5)
    -- restartButton:addTouchEventListener(
    --     function(ref, event)
    --         -- body
    --         Log.i("restartButton")
    --         if cc.EventCode.BEGAN == event then
    --             --- 按下
    --         elseif cc.EventCode.ENDED == event then
    --             --- 松开
    --             Director:resume()
    --             layer:removeFromParent()
    --             --
    --             display:getRunningScene():destroy()
    --             GameHandler.BulletArray = {}
    --             GameHandler.EnemyArray = {}
    --             GameHandler.myRole = nil
    --             --
    --             local nowScene = import("app.scenes.GameScene").new()
    --             display.replaceScene(nowScene)
    --         end
    --     end
    -- )

    -- local backButton = ccui.Button:create(ConstantsUtil.PATH_OVER_BACK_PNG):addTo(listView)
    -- backButton:setAnchorPoint(0.5, 0.5)
    -- -- backButton:setContentSize()
    -- backButton:addTouchEventListener(
    --     function(ref, event)
    --         Log.i("backButton")
    --         if cc.EventCode.BEGAN == event then
    --             --- 按下
    --         elseif cc.EventCode.ENDED == event then
    --             --- 松开
    --             --
    --             GameHandler.myRole = nil
    --             --
    --             Director:resume()
    --             local nowScene = import("app.scenes.MenuScene").new()
    --             display.replaceScene(nowScene)
    --         end
    --     end
    -- )
    return layer
end

return OverNode
