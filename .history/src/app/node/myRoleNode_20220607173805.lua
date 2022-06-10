local MyRoleNode =
    class(
    "MyRoleNode",
    function()
        return cc.Node:create()
    end
)

function MyRoleNode:create(painting)
    local myRoleNode = MyRoleNode.new()
    myRoleNode.addChild(myRoleNode:init(painting))
    return myRoleNode
end

function MyRoleNode:ctor()
    self.x = 0
    self.y = 0
    self.hp = ConstantsUtil.DEFAULT_HP
    self.score = ConstantsUtil.DEFAULT_SCORE
    -- plane
    self.tailFlame = nil
    self.myRole = nil
    -- default
    self.defaultHeight = 0
end

function MyRoleNode:init(painting)
    -- body
    local layer = ccui.Layout:create()
    self.myRole = cc.Sprite:create(ConstantsUtil.PATH_ROLE[painting]):addTo(layer)
    self.tailFlame = cc.ParticleSystemQuad:create(ConstantsUtil.PATH_TAIL_FLAME_PNG):addTo(layer)
    self.deltaHeight = self.myRole:getContentSize().height / 2 + self.tailFlame:getContentSize().height / 2
    self.myRole:setTag(ConstantsUtil.TAG_MY_ROLE)
    self.myRole:setAnchorPoint(0.5, 0.5)
    self.myRole:setPosition(WinSize.width / 2, WinSize.height * -0.3)
    self.tailFlame:setAnchorPoint(0.5, 0.5)
    self.tailFlame:setPosition(WinSize.width / 2, WinSize.height * -0.3 - self.deltaHeight)

    local roleShowUp = cc.MoveTo:create(2, cc.p(WinSize.width * 0.5, WinSize.height * 0.17))
    local fireShowUp =
        cc.MoveTo:create(2, cc.p(WinSize.width * 0.5, WinSize.height * 0.17 - myRole:getContentSize().height / 2))

    return layer
end

function MyRoleNode:runAction(action)
    self.myRole:runAction(action)
    action:setPosition(action:getPositionX(), action:getPositionY() - self.defaultHeight)
    action.self.tailFlame:runAction(action)
end

return MyRoleNode
