local MyRoleNode =
    class(
    "MyRoleNode",
    function()
        return cc.Node:create()
    end
)
-- local
local PlaneModel = require("app.model.PlaneModel")
--

function MyRoleNode:create(painting, duration, targetX, targetY)
    local myRoleNode = MyRoleNode.new()
    myRoleNode:addChild(myRoleNode:init(painting, duration, targetX, targetY))
    return myRoleNode
end

function MyRoleNode:setMyPosition(x, y)
    self.x = x
    self.y = y
    self.myRole:setPositionY(y)
    self.tailFlame:setPositionY(y - ConstantsUtil.DEFAULT_DELTA_HEIGHT)
end

function MyRoleNode:ctor()
    self.dataModel = PlaneModel.create()
    -- plane
    self.tailFlame = nil
    self.myRole = nil
end

function MyRoleNode:init(painting, duration, targetX, targetY)
    -- body
    local layer = ccui.Layout:create()
    self.myRole = cc.Sprite:create(ConstantsUtil.PATH_ROLE[painting]):addTo(layer)
    self.tailFlame = cc.ParticleSystemQuad:create(ConstantsUtil.PATH_TAIL_FLAME_PLIST):addTo(layer)

    self.myRole:setName(ConstantsUtil.TAG_MY_ROLE)
    self.myRole:setAnchorPoint(0.5, 0.5)
    self.myRole:setPosition(ConstantsUtil.INIT_PLANE_X, ConstantsUtil.INIT_PLANE_Y)

    self.tailFlame:setAnchorPoint(0.5, 0.5)
    self.tailFlame:setRotation(180)
    self.tailFlame:setPosition(
        ConstantsUtil.INIT_PLANE_X,
        ConstantsUtil.INIT_PLANE_Y - ConstantsUtil.DEFAULT_DELTA_HEIGHT
    )

    local myRoleShow = cc.MoveTo:create(duration, cc.p(targetX, targetY))
    local tailFlameShow = cc.MoveTo:create(duration, cc.p(targetX, targetY - ConstantsUtil.DEFAULT_DELTA_HEIGHT))
    self.myRole:runAction(myRoleShow)
    self.tailFlame:runAction(tailFlameShow)

    --- 单点触摸移动
    local function onTouchBegan(touch, event)
        Log.i("touch begin")
        return true
    end
    local function onTouchEnded(touch, event)
        Log.i("touch end")
    end
    local function onTouchMoved(touch, event)
        local target = event:getCurrentTarget() --获取当前的控件
        local posX, posY = target:getPosition() --获取当前的位置
        local delta = touch:getDelta() --获取滑动的距离
        target:setPosition(cc.p(posX + delta.x, posY + delta.y)) --给精灵重新设置位置
        self.tailFlame:setPosition(cc.p(posX + delta.x, posY + delta.y - ConstantsUtil.DEFAULT_DELTA_HEIGHT))
        self.dataModel.x = posX + delta.x
        self.dataModel.y = posY + delta.y
    end

    --- 事件分发器
    local eventDispatcher = self:getEventDispatcher()
    local listener1 = cc.EventListenerTouchOneByOne:create() --创建一个单点事件监听
    listener1:setSwallowTouches(false) --是否向下传递
    listener1:registerScriptHandler(onTouchBegan, cc.Handler.EVENT_TOUCH_BEGAN)
    listener1:registerScriptHandler(onTouchMoved, cc.Handler.EVENT_TOUCH_MOVED)
    listener1:registerScriptHandler(onTouchEnded, cc.Handler.EVENT_TOUCH_ENDED)
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener1, self.myRole) --分发监听事件

    return layer
end

return MyRoleNode
