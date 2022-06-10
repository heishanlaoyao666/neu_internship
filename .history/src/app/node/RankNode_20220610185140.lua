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

function RankNode:create(rank, nickname, score, rankData)
    -- body
    local rank = RankNode.new(rank, nickname, score, rankData)
    rank:addChild(rank:init())
    return rank
end

function PauseNode:ctor(rank, nickname, score, rankData)
    if rankData == nil then
        self.dataModel = RankModel.new(rank, nickname, score)
    else
        self.dataModel = rankData
    end
end

function RankNode:init()
    -- body
    local itemLayer = ccui.Layout:create()
    local itemWidth = WinSize.width * 0.8333
    local itemHeight = WinSize.height * 0.1
    itemLayer:setContentSize(itemWidth, itemHeight)

    local itemBg = ccui.ImageView:create("ui/rank/rank_item_bg.png")
    itemBg:setAnchorPoint(0.5, 0.5)
    itemBg:setScale9Enabled(true)
    itemBg:setContentSize(itemWidth, itemHeight)
    itemBg:pos(itemWidth * 0.5, 0)
    itemBg:addTo(itemLayer)

    local itemRank = ccui.TextBMFont:create(tostring(self.dataModel.rank), ConstantsUtil.PATH_BIG_NUM)
    itemRank:setAnchorPoint(0.5, 1)
    itemRank:setScale(0.5)
    itemRank:pos(itemWidth * 0.08, itemHeight * 0.45)
    itemRank:addTo(itemLayer)

    local itemNickname = ccui.Text:create(self.dataModel.nickname, "FontNormal.ttf", 30)
    itemNickname:setAnchorPoint(0.5, 0.5)
    itemNickname:pos(itemWidth * 0.4, 0)
    itemNickname:addTo(itemLayer)

    local itemScore = ccui.Text:create(tostring(self.dataModel.score), "FontNormal.ttf", 30)
    itemScore:setAnchorPoint(0.5, 0.5)
    itemScore:pos(itemWidth * 0.7, 0)
    itemScore:addTo(itemLayer)

    return itemLayer
end

return RankNode
