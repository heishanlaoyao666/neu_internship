---require
-- require("AudioEngine")
---
local GameScene =
    class(
    "GameScene",
    function()
        return display.newScene("GameScene")
    end
)
---local

---
function GameScene:ctor()
end

function GameScene:onEnter()
    local gameScene = CSLoader:createNodeWithFlatBuffersFile("GameScene.csb"):addTo(self, 1)

    --- 背景移动
    local bg0 = tolua.cast(ccui.Helper:seekWidgetByName(gameScene, "background_0"), "cc.Sprite")
    local bg1 = tolua.cast(ccui.Helper:seekWidgetByName(gameScene, "background_1"), "cc.Sprite")
    local bg = {}
    bg[0] = bg0
    bg[1] = bg1
    local nowBg = 0

    local function backgroundMove()
        bg[nowBg]:setPositionY(bg[nowBg]:getPositionY() - ConstantsUtil.SPEED_BG_MOVE)
        bg[(nowBg + 1) % 2]:setPositionY(bg[nowBg]:getPositionY() + WinSize.height - ConstantsUtil.SPEED_BG_MOVE) --- 吐槽 为什么连异或操作都没有 裂开
        if bg[(nowBg + 1) % 2]:getPositionY() == WinSize.height / 2 then
            bg[nowBg]:setPositionY(WinSize.height * 1.5)
            nowBg = (nowBg + 1) % 2
        end
    end
    backgroundEntry = Scheduler:scheduleScriptFunc(backgroundMove, 1.0 / 60, false)
    -- Director:sharedDirector():getScheduler():unscheduleScriptEntry(backgroundEntry)

    --- 我方飞机相关
    local myRole = tolua.cast(ccui.Helper:seekWidgetByName(gameScene, "my_role"), "cc.Sprite")
    local myFireBloom = tolua.cast(ccui.Helper:seekWidgetByName(gameScene, "role_fire"), "cc.ParticleSystemQuad")
    local myBullet = tolua.cast(ccui.Helper:seekWidgetByName(gameScene, "role_bullet"), "cc.Sprite")

    --- 我方飞机登场
    local roleShowUp = cc.MoveTo:create(2, cc.p(WinSize.width * 0.5, WinSize.height * 0.17))
    myRole:runAction(roleShowUp)
    local fireShowUp = cc.MoveTo:create(2, cc.p(WinSize.width * 0.5, WinSize.height * 0.097))
    myFireBloom:runAction(fireShowUp)

    --- 单点触摸移动
    local function onTouchBegan(touch, event)
        -- 不要忘了return true  否则事件不能响应
        Log.i("touch begin")
        return true
    end
    local function onTouchEnded(touch, event)
        -- body
        Log.i("touch end")
    end

    local function onTouchMoved(touch, event)
        local target = event:getCurrentTarget() --获取当前的控件
        local posX, posY = target:getPosition() --获取当前的位置
        local delta = touch:getDelta() --获取滑动的距离
        target:setPosition(cc.p(posX + delta.x, posY + delta.y)) --给精灵重新设置位置
        --- 火焰也需要重新设置位置
        myFireBloom:setPosition(cc.p(posX + delta.x, posY + delta.y - target:getContentSize().height))
    end

    local listener1 = cc.EventListenerTouchOneByOne:create() --创建一个单点事件监听
    listener1:setSwallowTouches(true) --是否向下传递
    listener1:registerScriptHandler(onTouchBegan, cc.Handler.EVENT_TOUCH_BEGAN)
    listener1:registerScriptHandler(onTouchMoved, cc.Handler.EVENT_TOUCH_MOVED)
    listener1:registerScriptHandler(onTouchEnded, cc.Handler.EVENT_TOUCH_ENDED)
    local eventDispatcher = self:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener1, myRole) --分发监听事件
end

function GameScene:onExit()
    Scheduler:unscheduleScriptEntry(backgroundEntry)
end

return GameScene
