--[[--
    随机BOSS界面
    RandomBossView.lua
]]
local RandomBossView = class("RandomBossView", function()
    return display.newColorLayer(cc.c4b(100, 100, 100, 100))
end)
local ConstDef = require("app/def/ConstDef")
local EventDef = require "app/def/EventDef.lua"
local GameData = require("app/data/GameData.lua")
local EventManager = require ("app/manager/EventManager.lua")

--[[--
    构造函数

    @param none

    @return none
]]
function RandomBossView:ctor()
    self.speed =1000 --类型：number 平移速度
    self.bossSprites_ = {} -- 类型：Sprite数组
    self:initView()
end

--[[--
    界面初始化

    @param none

    @return none
]]
function RandomBossView:initView()
    local width, height = 720, 1280
    self.container_ = ccui.Layout:create()
    self.container_:setBackGroundColor(cc.c3b(0, 0, 0))
    self.container_:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)--设置颜色模式
    self.container_:setBackGroundColorOpacity(128)--设置透明度
    self.container_:setBackGroundColorType(1)
    self.container_:setContentSize(width, height)
    self.container_:addTo(self)
    self.container_:setAnchorPoint(0.5, 0.5)
    self.container_:setPosition(display.cx, display.cy)
    
    --选取背景
    local bg=display.newSprite("ui/battle/Secondary interface-Random boss pop-up/bg-pop-up.png")
    bg:setScale(720/645)
    bg:setAnchorPoint(0.5, 0.5)
    bg:setPosition(display.cx, display.cy)
    bg:addTo(self.container_)
    --选取框
    local bgSelect=display.newSprite("ui/battle/Secondary interface-Random boss pop-up/bg-select-boss.png")
    bgSelect:setAnchorPoint(0.5, 0.5)
    bgSelect:setPosition(display.cx, display.cy)
    bgSelect:addTo(self.container_)
    --选取指针
    local arrow=display.newSprite("ui/battle/Secondary interface-Random boss pop-up/Arrow - Gem.png")
    arrow:setAnchorPoint(0.5, 0.5)
    arrow:setPosition(display.cx, display.cy+100)
    arrow:addTo(self.container_)
    --boss创建
    local offsetX = 35
    for i = 1, 8 do
        local id =math.random(1,4)
        local sprite = display.newSprite(string.format("ui/battle/Secondary interface-Random boss pop-up/boss-%u.png",id))
        self:addChild(sprite)
        sprite.id_=id
        self.bossSprites_[#self.bossSprites_ + 1] = sprite
        sprite:setAnchorPoint(0.5, 0.5)
        sprite:setPosition(offsetX, display.cy)
        offsetX = offsetX + 150
    end
    -- 屏蔽点击
    self:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event) 
        if event.name == "began" then
            return true
        end
    end)
    self:setTouchEnabled(true)
end

--[[--
    显示界面

    @param none

    @return none
]]
function RandomBossView:showView()
    self:setVisible(true)
    -- self.container_:setScale(0)
    -- self.container_:runAction(cc.ScaleTo:create(0.15, 1))
    -- self.scoreLabel_:setString("分数 : ".. GameData:getScore())

    -- self.historyLabel_:setString("历史最佳 : ".. GameData:getHistory())

    -- cc.UserDefault:getInstance():setIntegerForKey("history", GameData:getHistory())
end

--[[--
    隐藏界面

    @param callback 类型：function，动画完成回调

    @return none
]]
function RandomBossView:hideView(callback)
    self.container_:runAction(cc.Sequence:create(
        cc.ScaleTo:create(0.15, 0), cc.CallFunc:create(function() 
            self:setVisible(false)
            if callback then
                callback()
            end
        end)
    ))
end
--[[--
    界面刷新

    @param dt 类型：number，帧间隔

    @return none
]]
function RandomBossView:update(dt)
    if self.speed <= 0 then
        if not self.bossSprites_ then
            return
        end
        --决定boss
        local min = 999
        local minId = 0 
        for i = 1, #self.bossSprites_ do 
            local sprite = self.bossSprites_[i]
            local posX = sprite:getPositionX()
            if min>math.abs(posX-display.cx) then
                min = math.abs(posX-display.cx)
                minId=sprite.id_
            end
        end
        GameData:setGameOpposite(minId)
        EventManager:doEvent(EventDef.ID.OPPOSITE_SELECT,ConstDef.BOSS[minId].ID)
        self.bossSprites_= nil
        --self:hideView()
        return
    end
    for i = 1, #self.bossSprites_ do 
        local sprite = self.bossSprites_[i]
        local posX = sprite:getPositionX()
        posX = posX - dt * self.speed
        
        if posX + 75 < 0 then
            -- 超过屏幕边界
            sprite:setPositionX(posX + 150 * #self.bossSprites_)
        else
            sprite:setPositionX(posX)
        end
    end
    self.speed=self.speed-2
end
return RandomBossView