local BulletNode =
    class(
    "BulletNode",
    function()
        return cc.Node:create()
    end
)
-- local
lcoal BulletModel = require("app.model.BulletModel")
--

function BulletNode:create(x, y)
    local bulletNode = BulletNode.new(x, y)
    bulletNode:addChild(bulletNode:init(x, y))
    return bulletNode
end

function BulletNode:ctor(x, y)
    self.dataModel = BulletModel.new(x, y)
    self.bullet = nil
end

function BulletNode:init(x, y)
    -- body
    self.bullet = cc.Sprite:create(ConstantsUtil.PATH_BULLET_PNG)
    y = y + self.bullet:getContentSize().height / 2
    self.bullet:setPosition(x, y)
    self.bullet:setAnchorPoint(0.5, 0.5)
    self.bullet:setTag(ConstantsUtil.TAG_BULLET)
    self.x = x
    self.y = y
    -- 移动
    return self.bullet
end

return BulletNode
