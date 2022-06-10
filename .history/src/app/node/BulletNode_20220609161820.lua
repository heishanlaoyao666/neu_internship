local BulletNode =
    class(
    "BulletNode",
    function()
        return cc.Node:create()
    end
)
-- local
local BulletModel = require("app.model.BulletModel")
--

function BulletNode:create(x, y)
    local bulletNode = BulletNode.new(x, y)
    bulletNode:addChild(bulletNode:init())
    return bulletNode
end

function BulletNode:ctor(x, y)
    self.dataModel = BulletModel.new(x, y)
    self.bullet = nil
end

function BulletNode:init()
    -- body
    self.bullet = cc.Sprite:create(ConstantsUtil.PATH_BULLET_PNG)
    self.dataModel.y = self.dataModel.y + self.bullet:getContentSize().height / 2
    self.bullet:setPosition(self.dataModel.x, self.dataModel.y)
    self.bullet:setAnchorPoint(0.5, 0.5)
    self.bullet:setTag(ConstantsUtil.TAG_BULLET)

    local function bulletMove()
        self.dataModel.y = self.dataModel.y + ConstantsUtil.SPEED_BULLET_MOVE
        self.bullet:setPositionY(self.dataModel.y)
        if self.dataModel.y > WinSize.height then
            self.bullet:removeFromParent()
            self:removeFromParent()
            table.removebyvalue(GameHandler.BulletArray, self, false)
            table.removebyvalue(GameHandler.BulletData, self.dataModel, false)
        end
    end
    -- 每帧刷新一次
    bullet:scheduleUpdateWithPriorityLua(bulletMove, 0)
    table.insert(ConstantsUtil.bulletArray, bullet)

    -- 移动
    return self.bullet
end

return BulletNode
