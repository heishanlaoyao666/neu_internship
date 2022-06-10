local RankNode =
    class(
    "RankNode",
    function()
        return cc.Node:create()
    end
)
-- local
local RankModel = require("app.model.RankModel")
--

function RankNode:create(nickname, score)
    -- body
    local rank = RankNode.new(nickname, score)
    rank:addChild(rank:init())
    return rank
end

function PauseNode:ctor()
    self.dataModel = 
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
            if cc.EventCode.BEGAN == event then
                --- 按下
            elseif cc.EventCode.ENDED == event then
                --- 松开
                self:removeFromParent()
                GameHandler.isPause = false
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
            if cc.EventCode.BEGAN == event then
                --- 按下
            elseif cc.EventCode.ENDED == event then
                --- 松开
                --
                GameHandler.updateContinue(true)
                FileUtil.saveGame()
                --
                Director:resume()
                local menuScene = import("app.scenes.MenuScene").new()
                display.replaceScene(menuScene)
            end
        end
    )

    return layer
end

return PauseNode
