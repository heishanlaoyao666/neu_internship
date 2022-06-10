local EnemyNode =
    class(
    "EnemyNode",
    function()
        return cc.Node:create()
    end
)

function EnemyNode:create(x, y)
    local enemy = EnemyNode.new()
    enemy:addChild(enemy:init(x, y))
    return enemy
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
    local function move()
        self.y = self.y - ConstantsUtil.SPEED_ENEMY_MOVE
        self:setPositionY(self.y)
        if self.y <= ConstantsUtil.DIE_PLACE_ENEMY then
            self:removeFromParent()
            CollisionController.removeEnemy(self)
        end
    end
    sp:scheduleUpdateWithPriorityLua(move, ConstantsUtil.LEVEL_VISIABLE_MEDIUM)
    CollisionController.addEnemy(self)
    return layer
end

return EnemyNode
