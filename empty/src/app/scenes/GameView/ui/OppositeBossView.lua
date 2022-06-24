--[[--
    对方BOSS信息界面
    OppositeBossViwe.lua
]]
local OppositeBossView = class("OppositeBossView", function()
    return display.newColorLayer(cc.c4b(100, 100, 100, 100))
end)
local ConstDef = require("app/def/ConstDef")
local GameData = require("app/data/GameData.lua")

--[[--
    构造函数

    @param none

    @return none
]]
function OppositeBossView:ctor()
    self.bossSprite = nil --类型：sprite，boss图片
    self.bossName =nil --类型：ttf,boss名字
    self.bossSkill=nil --类型：ttf，boss技能
    self:initView()
end

--[[--
    界面初始化

    @param none

    @return none
]]
function OppositeBossView:initView()
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

    
    
    local bgLayer = ccui.ImageView:create("ui/battle/Secondary interface-Boss information Popup/bg-pop-up.png")
    bgLayer:setAnchorPoint(0.5, 0.5)
    bgLayer:setPosition(display.cx, 960)
    bgLayer:addTo(self.container_)
    bgLayer:addTouchEventListener(function(sender, eventType)
		if 2 == eventType then
            return
		end
	end)
    bgLayer:setTouchEnabled(true)

    --boss图片
    self.bossSprite=display.newSprite("ui/battle/Secondary interface-Boss information Popup/boss-1.png")
    self.bossSprite:setAnchorPoint(0.5, 0.5)
    self.bossSprite:setPosition(120, 160)
    self.bossSprite:addTo(bgLayer)
    --boss名字
    self.bossName=cc.Label:createWithTTF(ConstDef.BOSS[GameData:getGameOpposite()].NAME,"ui/font/fzbiaozjw.ttf",34)
    self.bossName:setAnchorPoint(0,1)
    self.bossName:setPosition(240,240)
    self.bossName:enableOutline(cc.c4b(14,14,25,255), 2)
    self.bossName:addTo(bgLayer)
    --boss技能
    self.bossSkill=cc.Label:createWithTTF(ConstDef.BOSS[GameData:getGameOpposite()].SKILL,"ui/font/fzbiaozjw.ttf",22)
    self.bossSkill:setLineBreakWithoutSpace(true)
    self.bossSkill:setMaxLineWidth(300)
    self.bossSkill:setAnchorPoint(0,1)
    self.bossSkill:setPosition(240,160)
    self.bossSkill:enableOutline(cc.c4b(12,6,24,255), 1)
    self.bossSkill:addTo(bgLayer)
    -- 点击背景返回
    self.container_:addTouchEventListener(function(sender, eventType)
		if 2 == eventType then
            self:hideView()
		end
	end)
    self.container_:setTouchEnabled(true)
end

--[[--
    显示界面

    @param table 类型：table，显示界面的参数

    @return none
]]
function OppositeBossView:showView()
    self.bossSprite:setTexture("ui/battle/Secondary interface-Boss information Popup/boss-"..tonumber(GameData:getGameOpposite())..".png")
    self.bossName:setString(ConstDef.BOSS[GameData:getGameOpposite()].NAME)
    self.bossSkill:setString(ConstDef.BOSS[GameData:getGameOpposite()].SKILL)
    self:setVisible(true)
    self.container_:setScale(0)
    self.container_:runAction(cc.ScaleTo:create(0.15, 1))
    
end

--[[--
    隐藏界面

    @param callback 类型：function，动画完成回调

    @return none
]]
function OppositeBossView:hideView(callback)
    self.container_:runAction(cc.Sequence:create(
        cc.ScaleTo:create(0.15, 0), cc.CallFunc:create(function() 
            self:setVisible(false)
            if callback then
                callback()
            end
        end)
    ))
end

return OppositeBossView