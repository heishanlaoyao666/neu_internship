--[[--
    背景层
    BGLayer.lua
]]
local BGLayer = class("BGLayer", require("app.ui.layer.BaseLayer"))
local ConstDef = require("app.def.ConstDef")

--[[--
    构造函数

    @param none

    @return none
]]
function BGLayer:ctor()
    BGLayer.super.ctor(self)
    self.bgScaleFactor_ = 1 -- 类型：number，背景缩放系数
    self.bgSprites_ = {} -- 类型：Sprite数组

    self:initView()
end

--[[--
    界面初始化
    
    @param none

    @return none
]]
function BGLayer:initView()
    -- 背景图720 * 1280 
    self.bgScaleFactor_ = ConstDef.BLOCK_SIZE.HEIGHT / display.newSprite("t_1.png"):getContentSize().height
    local offsetY = 0
    local offsetX = 0
    --绘画左柱子
    for j = 1, ConstDef.GAME_HEIGHT_SIZE+1 do
        local sprite = display.newSprite("t_1.png")
        self:addChild(sprite)
        self.bgSprites_[#self.bgSprites_ + 1] = sprite
        sprite:setScale(self.bgScaleFactor_ )
        sprite:setAnchorPoint(0, 0)
        sprite:setPosition(offsetX, offsetY)
        offsetY = offsetY + sprite:getContentSize().height * self.bgScaleFactor_ 
    end
    offsetY = 0
    for i = 1, ConstDef.GAME_WIDTH_SIZE do
        local sprite = display.newSprite("t_1.png")
        self:addChild(sprite)
        self.bgSprites_[#self.bgSprites_ + 1] = sprite
        sprite:setScale(self.bgScaleFactor_ )
        sprite:setAnchorPoint(0, 0)
        sprite:setPosition(offsetX, offsetY)
        offsetX = offsetX + sprite:getContentSize().height * self.bgScaleFactor_ 
    end
    --绘画右柱子
    offsetY = 0
    offsetX = display.newSprite("t_1.png"):getContentSize().width * self.bgScaleFactor_ *(ConstDef.GAME_WIDTH_SIZE)
    for j = 1, ConstDef.GAME_HEIGHT_SIZE+1 do
        local sprite = display.newSprite("t_1.png")
        self:addChild(sprite)
        self.bgSprites_[#self.bgSprites_ + 1] = sprite
        sprite:setScale(self.bgScaleFactor_ )
        sprite:setAnchorPoint(0, 0)
        sprite:setPosition(offsetX, offsetY)
        offsetY = offsetY + sprite:getContentSize().height * self.bgScaleFactor_ 
    end
    
    
end

--[[--
    界面刷新

    @param dt 类型：number，帧间隔

    @return none
]]
function BGLayer:update(dt)
    -- for i = 1, #self.bgSprites_ do
    --     local sprite = self.bgSprites_[i]
    --     local posY = sprite:getPositionY()
    --     posY = posY - dt * ConstDef.SELF_SPEED
        
    --     if posY + sprite:getContentSize().height * self.bgScaleFactor_ < display.bottom then
    --         -- 超过屏幕边界
    --         sprite:setPositionY(posY + sprite:getContentSize().height * self.bgScaleFactor_ * #self.bgSprites_)
    --     else
    --         sprite:setPositionY(posY)
    --     end
    -- end
end

return BGLayer