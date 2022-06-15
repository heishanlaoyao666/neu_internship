--- 敌机

local size = cc.Director:getInstance():getWinSize()
local SystemConst = require("app.scenes.SystemConst")

local Enemy = class("Enemy", function()
    return cc.Sprite:create()
end)

function Enemy.create()
    local sprite = Enemy.new()
    return sprite
end

function Enemy:ctor()

    local enemyFrameName = SystemConst.EnemyName
    local hitPointsTemp = SystemConst.EnemyInitialHitPoints
    local velocityTemp = SystemConst.SpriteVelocity.EnemyPlane

    -- self:setSpriteFrame(enemyFrameName)  -- 无法使用该方法
    self:setTexture(enemyFrameName)
    self:setVisible(false)

    -- 设置敌人精灵的基本属性
    self.hitPoints = 0  -- 当前的生命值
    self.initialHitPoints = hitPointsTemp  -- 初始的生命值
    self.velocity = velocityTemp  -- 速度

    local body = cc.PhysicsBody:create()
    
    -- 敌方飞机身体(圆形)
    body:addShape(cc.PhysicsShapeCircle:create(self:getContentSize().width/2 - 5))
   
    self:setPhysicsBody(body)
    body:setCategoryBitmask(0x01)    --类别掩码
    body:setCollisionBitmask(0x02)   --碰撞掩码
    body:setContactTestBitmask(0x01)  --接触检测掩码

    self:spawn()  -- 产生敌人


    -- 调度函数
    local function update(delta)

        local x, y = self:getPosition()
        self:setPosition(cc.p(x + self.velocity.x * delta, y + self.velocity.y * delta))

        x, y = self:getPosition()

        if y + self:getContentSize().height / 2 < 0 then
            -- 不是重新创建敌人对象，而是重新调整它的坐标
            self:spawn()  -- 生成敌人
        end
    end

    -- 通过Lua语言开始游戏调度 -- 0是调度优先级
    self:scheduleUpdateWithPriorityLua(update, 0)

    -- 层事件回调函数
    function onNodeEvent(tag)
        if tag == "exit" then
            -- 停止游戏调度
            self:unscheduleUpdate()
        end
    end

    -- 注册层事件
    self:registerScriptHandler(onNodeEvent)

    
end

-- 产生敌人的函数
function Enemy:spawn()
    local yPos = size.height + self:getContentSize().height/2
    local xPos = math.random() * (size.width - self:getContentSize().width) + self:getContentSize().width/2
    self:setPosition(cc.p(xPos, yPos))
    self:setAnchorPoint(cc.p(0.5, 0.5))

    self.hitPoints = self.initialHitPoints
    self:setVisible(true)
end

return Enemy