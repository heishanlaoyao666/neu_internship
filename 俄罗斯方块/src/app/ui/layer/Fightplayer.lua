--[[--
    主战斗层，放战斗元素
    FightLayer.lua
]]
local FightLayer = class("FightLayer", require("app.ui.layer.BaseLayer"))
local GameData = require("app.data.GameData")
local Diamond = require("src.app.data.Diamond")
local DiamondSprite = require("src.app.data.DiamondSprite")
local ConstDef = require("app.def.ConstDef")
local EventDef = require("app.def.EventDef")
local EventManager = require("app.manager.EventManager")

--[[--
    构造函数

    @param none

    @return none
]]
function FightLayer:ctor()
    FightLayer.super.ctor(self)

    self.allDiamondMap_ = {} --类型： table key ：diamond value: diamond 方块
    
    -- 加载音效资源
    audio.loadFile("rotate.wav", function() end)
    audio.loadFile("move.wav", function() end)
    audio.loadFile("fast_down.wav", function() end)
    audio.loadFile("sounds/clean.mp3", function() end)
    audio.loadFile("sounds/bg.mp3", function() 
        audio.playBGM("sounds/bg.mp3", true)
    end)
    self:initView()
end

--[[--
    节点进入

    @param none

    @return none
]]
function FightLayer:onEnter()
    EventManager:regListener(EventDef.ID.CREATE_DIAMOND, self, function(diamond)
        local diamondNode = DiamondSprite.new(diamond:getColor(), diamond)
        self:addChild(diamondNode)
        self.alldiamondMap_[diamond] = diamondNode
    end)

    EventManager:regListener(EventDef.ID.DESTORY_DIAMOND, self, function(diamond)
        local node = self.diamondMap_[diamond]
        node:removeFromParent()
        self.alldiamondMap_[diamond] = nil
    end)


end

--[[--
    节点退出

    @param none

    @return none
]]
function FightLayer:onExit()
    EventManager:unRegListener(EventDef.ID.CREATE_DIAMOND, self)
    EventManager:unRegListener(EventDef.ID.DESTORY_DIAMOND, self)
end

--[[--
    初始化界面

    @param none

    @return none
]]
function FightLayer:initView()
    local allDiamonds = GameData:getAllDiamond()
    for i = 1, #allDiamonds  do
        local diamond = DiamondSprite.new(allDiamonds[i]:getColor() , allDiamonds [i])
        self:addChild(diamond)
        self.diamondMap_[allDiamonds [i]] = diamond
    end

    local curDiamonds = GameData:getCurDiamond()
    for i = 1, #curDiamonds do
        local diamond = DiamondSprite.new(curDiamonds[i]:getColor() , curDiamonds [i])
        self:addChild(diamond)
        self.diamondMap_[curDiamonds[i]] = diamond
    end
    
    local scale = display.top/5/3/100
    --
    local up = display.newSprite("c_2.png")
    up:setAnchorPoint(0.5,0.5)
    up:setScale(scale)
    up:setRotation(-90)
    up:setPosition(display.top/5/3*1.5,display.top/5/3*2.5)
    up:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
        if event.name == "ended" then
            GameData:Move(ConstDef.DIAMOND_GROUP_MOVE_SIZE.UP)
        end
    end)

    local down = display.newSprite("c_2.png")
    down:setAnchorPoint(0.5,0.5)
    down:setScale(scale)
    up:setRotation(90)
    down:setPosition(display.top/5/3*1.5,display.top/5/3*0.5)
    down:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
        if event.name == "ended" then
            GameData:Move(ConstDef.DIAMOND_GROUP_MOVE_SIZE.DOWN)
        end
    end)

    local left = display.newSprite("c_2.png")
    left:setAnchorPoint(0.5,0.5)
    left:setScale(scale)
    left:setPosition(display.top/5/3*0.5,display.top/5/3*1.5)
    left:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
        if event.name == "ended" then
            GameData:Move(ConstDef.DIAMOND_GROUP_MOVE_SIZE.LEFT)
        end
    end)

    local right = display.newSprite("c_2.png")
    right:setAnchorPoint(0.5,0.5)
    right:setScale(scale)
    right:setRotation(180)
    right:setPosition(display.top/5/3*2.5,display.top/5/3*1.5)
    right:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
        if event.name == "ended" then
            GameData:Move(ConstDef.DIAMOND_GROUP_MOVE_SIZE.RIGGT)
        end
    end)

    local rotateByClockwise = display.newSprite("c_1.png")
    rotateByClockwise:setAnchorPoint(0.5,0.5)
    rotateByClockwise:setScale(2)
    rotateByClockwise:setRotation(180)
    rotateByClockwise:setPosition(display.top/5/2*0.5 + display.top/5,display.top/5/2)
    rotateByClockwise:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
        if event.name == "ended" then
            GameData:Move(ConstDef.DIAMOND_GROUP_MOVE_SIZE.CLOCKWISE)
        end
    end)

    local rotateByAntclockwise = display.newSprite("c_1.png")
    rotateByAntclockwise:setAnchorPoint(0.5,0.5)
    rotateByAntclockwise:setScale(2)
    rotateByAntclockwise:setFlipX(true)
    rotateByAntclockwise:setRotation(180)
    rotateByAntclockwise:setPosition(display.top/5/2*1.5 + display.top/5,display.top/5/2)
    rotateByAntclockwise:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
        if event.name == "ended" then
            GameData:Move(ConstDef.DIAMOND_GROUP_MOVE_SIZE.ANTCLOCKWISE)
        end
    end)

end

--[[--
    帧刷新

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function FightLayer:update(dt)
    for _, node in pairs(self.allDiamondMap_) do
        node:update(dt)
    end
end

return FightLayer