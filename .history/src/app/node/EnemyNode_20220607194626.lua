local EnemyNode =
    class(
    "EnemyNode",
    function()
        return cc.Node:create()
    end
)

function EnemyNode:create(x, y)
    local enemyNode = EnemyNode.new()
    enemyNode:addChild(enemyNode:init(x, y))
    return enemyNode
end

--构造
function EnemyNode:ctor()
    self.x = 0
    self.y = 0

    self.enemy = nil
end

function EnemyNode:init(x, y)
    local layer = ccui.Layout:create()
    self.enemy = cc.Sprite:create(ConstantsUtil.PATH_SMALL_ENEMY_PNG):addTo(layer)
    self.enemy:setPosition(x, y)
    self.enemy:setTag(ConstantsUtil.TAG_ENEMY)
    self.x = x
    self.y = y
    -- 移动
    return layer
end

return EnemyNode
