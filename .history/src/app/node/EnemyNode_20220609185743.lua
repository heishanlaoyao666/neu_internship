local EnemyNode =
    class(
    "EnemyNode",
    function()
        return cc.Node:create()
    end
)
-- local
local EnemyModel = require("app.node.EnemyModel")
--

function EnemyNode:create(x, y)
    local enemyNode = EnemyNode.new(x, y)
    enemyNode:addChild(enemyNode:init())
    return enemyNode
end

--构造
function EnemyNode:ctor(x, y)
    self.dataModel = EnemyModel.new(x, y)
    self.enemy = nil
end

function EnemyNode:init(x, y)
    local layer = ccui.Layout:create()
    self.enemy = cc.Sprite:create(ConstantsUtil.PATH_SMALL_ENEMY_PNG):addTo(layer)
    self.enemy:setPosition(x, y)
    self.enemy:setAnchorPoint(0.5, 0.5)
    self.enemy:setTag(ConstantsUtil.TAG_ENEMY)
    self.x = x
    self.y = y
    -- 移动
    return layer
end

return EnemyNode
