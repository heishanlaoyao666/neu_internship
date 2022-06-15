--- 设置页面


-- 局部变量
local size = cc.Director:getInstance():getWinSize()

local FightScene = class("FightScene", function()
    return display.newScene("FightScene")
end)

function FightScene:ctor()

    -- 背景
    local bg = cc.Sprite:create("img_bg/bg.jpg")
    bg:setPosition(cc.p(size.width/2, size.height/2))
    bg:setScale(0.8, 0.8)
    self:addChild(bg)

    -- 顶部栏
    local topLayer = ccui.Layout:create()
    -- topLayer:setBackGroundColor(cc.c3b(24, 78, 168))
    -- topLayer:setBackGroundColorType(1)
    topLayer:setContentSize(display.width, 50)
    topLayer:setPosition(display.cx, display.height - 50)
    topLayer:setAnchorPoint(0.5, 0)
    topLayer:setCascadeOpacityEnabled(true)
    topLayer:setOpacity(1 * 255)
    topLayer:addTo(self)

    -- 暂停
    local images = {
        normal = "ui/battle/uiPause.png",
        pressed = "ui/battle/uiPause.png",
        disabled = "ui/battle/uiPause.png"
    }

    local pauseBtn = ccui.Button:create(images["normal"], images["pressed"], images["disabled"])
    -- 设置锚点
    pauseBtn:setAnchorPoint(cc.p(0 ,0))
    -- 居中
    pauseBtn:setPosition(0, 0)
    -- 设置缩放程度
    pauseBtn:setScale(1, 1)
    -- 设置是否禁用(false为禁用)
    pauseBtn:setEnabled(true)
    pauseBtn:addClickEventListener(function ()
        cc.Director:getInstance():pushScene(require("app.scenes.ResumeScene").new())
    end)

    topLayer:addChild(pauseBtn, 1)

    -- 生命与分数
    local lifeImg = ccui.ImageView:create("ui/battle/life.png")
    local scoreImg = ccui.ImageView:create("ui/battle/score.png")

    lifeImg:setPosition(65, 10)
    lifeImg:setAnchorPoint(cc.p(0 ,0))
    lifeImg:setScale(0.8, 0.8)

    scoreImg:setPosition(200, 10)
    scoreImg:setAnchorPoint(cc.p(0 ,0))
    scoreImg:setScale(0.8, 0.8)

    lifeImg:addTo(topLayer)
    scoreImg:addTo(topLayer)

    local lifeLabel = display.newTTFLabel({
        text = "100",
        font = "Marker Felt",
        size = 20,
        color = cc.c3b(255, 255, 255) 
    })

    lifeLabel:setAnchorPoint(cc.p(0, 0))
    lifeLabel:setPosition(120, 10)
    lifeLabel:addTo(topLayer)


    local scoreLabel = display.newTTFLabel({
        text = "0",
        font = "Marker Felt",
        size = 20,
        color = cc.c3b(255, 255, 255) 
    })

    scoreLabel:setAnchorPoint(cc.p(0, 0))
    scoreLabel:setPosition(255, 10)
    scoreLabel:addTo(topLayer)



    -- 主体栏

    local mainLayer = ccui.Layout:create()
    -- mainLayer:setBackGroundColor(cc.c3b(24, 78, 168))
    -- mainLayer:setBackGroundColorType(1)
    mainLayer:setContentSize(display.width, display.height -50)
    mainLayer:setPosition(display.cx, 0)
    mainLayer:setAnchorPoint(0.5, 0)
    mainLayer:setCascadeOpacityEnabled(true)
    mainLayer:setOpacity(1 * 255)
    mainLayer:addTo(self)

    -- 飞机
    local plane = cc.Sprite:create("player/red_plane.png")
    plane:setPosition(display.cx, 80)
    plane:addTo(mainLayer)


    -- 单点触摸事件监听器EventListenerTouchOneByOne
    
    local function touchBegan(touch, event)
        -- 如果设置为false则后面的事件都无法响应
        -- return true

        print("touchBegan")
        -- 获取事件所绑定的node
        local node = event:getCurrentTarget()
        -- 获取当前点击点所在相对按钮的位置坐标
        local locationInNode = node:convertToNodeSpace(touch:getLocation())
        local s = node:getContentSize()
        local rect = cc.rect(0, 0, s.width, s.height)
        -- 点击范围判断检测
        if cc.rectContainsPoint(rect, locationInNode) then
            print("sprite x = %d, y = %d", locationInNode.x, locationInNode.y)
            print("sprite tag = %d", node:getTag())
            -- node:runAction(cc.ScaleBy:create(0.06, 1.06))
            return true
        end

        return false
    end

    local function touchMoved(touch, event)
        print("touchMoved")

        -- 获得事件所绑定的node
        local node = event:getCurrentTarget()
        local currentPosX, currentPosY = node:getPosition()
        local diff = touch:getDelta()
        local s = node:getContentSize()
        local dstX = currentPosX + diff.x
        -- 移动当前按钮精灵的坐标位置并设置移动限制
        if(dstX >= (display.left + 10 + s.width/2) and dstX <= (display.right - 10 - s.width/2)) then
            node:setPosition(cc.p(dstX, currentPosY))
        end
    end

    local function touchEnded(touch, event)
        print("touchEnded")
        -- 获取事件所绑定的node
        local node = event:getCurrentTarget()
        -- 获取当前点击点所在相对按钮的位置坐标
        local locationInNode = node:convertToNodeSpace(touch:getLocation())
        local s = node:getContentSize()
        local rect = cc.rect(0, 0, s.width, s.height)

        -- 点击范围判断检测
        if cc.rectContainsPoint(rect, locationInNode) then
            print("sprite x = %d, y = %d", locationInNode.x, locationInNode.y)
            print("sprite tag = %d", node:getTag())
            -- node:runAction(cc.ScaleBy:create(0.06, 1.06))
            return true
        end
    end

    local listener1 = cc.EventListenerTouchOneByOne:create()
    
    listener1:registerScriptHandler(touchBegan, cc.Handler.EVENT_TOUCH_BEGAN)
    listener1:registerScriptHandler(touchMoved, cc.Handler.EVENT_TOUCH_MOVED)
    listener1:registerScriptHandler(touchEnded, cc.Handler.EVENT_TOUCH_ENDED)
    
    local eventDispatcher = cc.Director:getInstance():getEventDispatcher()
    -- 添加监听器
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener1, plane)

    
    -- 飞机拖尾
    local particleSystem = cc.ParticleSystemQuad:create("particle/fire.plist")
    plane:addChild(particleSystem, 1)
    particleSystem:setPosition(plane:getContentSize().width/2, 0)
    -- particleSystem.rotation = 90 -- 失效
    -- particleSystem:setAnchorPoint(1, 0) -- 失效
    particleSystem:setScale(1)
    particleSystem:setRotation(180)


    -- 子弹
    local bullet = cc.Sprite:create("player/blue_bullet.png")
    bullet:setScale(0.5, 0.5)
    bullet:setPosition(plane:getContentSize().width/2, plane:getContentSize().height/2)
    -- 把子弹放在底层
    plane:addChild(bullet, -1)



    -- 敌机
    local enemy = cc.Sprite:create("player/small_enemy.png")

    

    return layer






end

function FightScene:onEnter()
end

function FightScene:onExit()
end

return FightScene
