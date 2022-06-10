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

function RankNode:create(nickname, score, rankData)
    -- body
    local rank = RankNode.new(nickname, score, rankData)
    rank:addChild(rank:init())
    return rank
end

function PauseNode:ctor(nickname, score, rankData)
    if rankData == nil then
        self.dataModel = RankModel.new(nickname, score)
    else
        self.dataModel = rankData
    end
end

function RankNode:init()
    -- body
    local layer = ccui.Layout:create()

    return layer
end

return RankNode
