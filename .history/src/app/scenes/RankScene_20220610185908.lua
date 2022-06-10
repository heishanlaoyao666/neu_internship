local RankScene =
    class(
    "RankScene",
    function()
        return display.newScene("RankScene")
    end
)

---local
local RankNode = require("app.node.RankNode")
---

function RankScene:ctor()
end

function RankScene:onEnter()
    FileUtil.loadRank()

    local rankScene = cc.CSLoader:getInstance():createNodeWithFlatBuffersFile("RankScene.csb"):addTo(self, 1)
    local bg = ccui.Helper:seekWidgetByName(rankScene, "background")
    ccui.Helper:doLayout(bg)

    local backButton = tolua.cast(ccui.Helper:seekWidgetByName(rankScene, "back"), "ccui.Button")
    backButton:addTouchEventListener(
        function(ref, event)
            ConstantsUtil.playButtonEffect()
            if cc.EventCode.BEGAN == event then
                --- 按下
            elseif cc.EventCode.ENDED == event then
                --- 松开
                local menuScene = import("app.scenes.MenuScene").new()
                display.replaceScene(menuScene)
            end
        end
    )

    local rankBg = ccui.ImageView:create("ui/rank/rank_bg.png")
    local rankList = tolua.cast(ccui.Helper:seekWidgetByName(rankScene, "rank_list"), "ccui.ListView")
    -- rankList
    for i = 1, #(GameHandler.RankData) do
        local item = RankNode:create(i, 0, 0, GameHandler.RankData[i])
        rankList:pushBackCustomItem(item)
        -- base
        -- local itemLayer = ccui.Layout:create()
        -- local itemWidth = WinSize.width * 0.8333
        -- local itemHeight = WinSize.height * 0.1
        -- itemLayer:setContentSize(itemWidth, itemHeight)
        -- rankList:pushBackCustomItem(itemLayer)

        -- local itemBg = ccui.ImageView:create("ui/rank/rank_item_bg.png")
        -- itemBg:setAnchorPoint(0.5, 0.5)
        -- itemBg:setScale9Enabled(true)
        -- itemBg:setContentSize(itemWidth, itemHeight)
        -- itemBg:pos(itemWidth * 0.5, 0)
        -- itemBg:addTo(itemLayer)

        -- local itemRank = ccui.TextBMFont:create(tostring(i), ConstantsUtil.PATH_BIG_NUM)
        -- itemRank:setAnchorPoint(0.5, 1)
        -- itemRank:setScale(0.5)
        -- itemRank:pos(itemWidth * 0.08, itemHeight * 0.45)
        -- itemRank:addTo(itemLayer)

        -- local itemNickname = ccui.Text:create("123456", "FontNormal.ttf", 30)
        -- itemNickname:setAnchorPoint(0.5, 0.5)
        -- itemNickname:pos(itemWidth * 0.4, 0)
        -- itemNickname:addTo(itemLayer)

        -- local itemScore = ccui.Text:create(tostring(scoreInit), "FontNormal.ttf", 30)
        -- itemScore:setAnchorPoint(0.5, 0.5)
        -- itemScore:pos(itemWidth * 0.7, 0)
        -- itemScore:addTo(itemLayer)
    end
end

function RankScene:onExit()
end

return RankScene
