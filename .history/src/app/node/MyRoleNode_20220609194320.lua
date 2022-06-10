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

function MyRoleNode:create(painting)
    local myRoleNode = MyRoleNode.new()
    myRoleNode:addChild(myRoleNode:init(painting))
    return myRoleNode
end

function MyRoleNode:ctor()
    -- 这里的DataModel只考虑了飞机，没有管飞机尾巴，可能在后续扩展会有影响
    self.dataModel = PlaneModel.new()
    -- plane
    self.tailFlame = nil
    self.myRole = nil
end

function MyRoleNode:setMyPosition(x, y)
    self.myRole:setPosition(x, y)
    self.tailFlame:setPosition(x, y - ConstantsUtil.DEFAULT_DELTA_HEIGHT)
    self.dataModel.x = x
    self.dataModel.y = y
end

function MyRoleNode:setMyHp(hp)
    self.dataModel.hp = hp
end

function MyRoleNode:setMyScore(score)
    self.dataModel.score = score
end

function MyRoleNode:getMyHp()
    return self.dataModel.hp
end

function MyRoleNode:getMyScore()
    return self.dataModel.score
end

function MyRoleNode:getWidth()
    return self.myRole:getBoundingBox().width
end

function MyRoleNode:getHeight()
    return self.myRole:getBoundingBox().height
end

function MyRoleNode:getPosition()
    return cc.p(self.dataModel.x, self.dataModel.y)
end

function MyRoleNode:getPositionX()
    return self.dataModel.x
end

function MyRoleNode:getPositionY()
    return self.dataModel.y
end

-- 把登场的移动拆分出来，需要scene自己去调用
function MyRoleNode:initMove(duration, targetX, targetY)
    local myRoleShow = cc.MoveTo:create(duration, cc.p(targetX, targetY))
    local tailFlameShow = cc.MoveTo:create(duration, cc.p(targetX, targetY - ConstantsUtil.DEFAULT_DELTA_HEIGHT))
    self.myRole:runAction(myRoleShow)
    self.tailFlame:runAction(tailFlameShow)
    self.dataModel.x = targetX
    self.dataModel.y = targetY
end

function MyRoleNode:init(painting)
    local layer = ccui.Layout:create()
    self.myRole = cc.Sprite:create(ConstantsUtil.PATH_ROLE[painting]):addTo(layer)
    self.tailFlame = cc.ParticleSystemQuad:create(ConstantsUtil.PATH_TAIL_FLAME_PLIST):addTo(layer)

    self.myRole:setName(ConstantsUtil.TAG_MY_ROLE)
    self.myRole:setAnchorPoint(0.5, 0.5)
    self.myRole:setPosition(self.dataModel.x, self.dataModel.y)

    self.tailFlame:setAnchorPoint(0.5, 0.5)
    self.tailFlame:setRotation(180)
    self.tailFlame:setPosition(self.dataModel.x, self.dataModel.y - ConstantsUtil.DEFAULT_DELTA_HEIGHT)

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
