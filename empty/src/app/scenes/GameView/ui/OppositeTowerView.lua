--[[--
    对方塔信息界面
    OppositeTowerViwe.lua
]]
local OppositeTowerView = class("OppositeTowerView", function()
    return display.newColorLayer(cc.c4b(100, 100, 100, 100))
end)
local ConstDef = require("app/def/ConstDef")
local GameData = require("app/data/GameData.lua")
local TowerDef = require("app.def.TowerDef")
--[[--
    构造函数

    @param none

    @return none
]]
function OppositeTowerView:ctor()
    self.towerSprite=nil --类型：sprite 塔图片
    self.towerName =nil --类型：ttf 塔名字
    self.towerRarity =nil --类型：ttf 塔稀有度
    self.towerSkill =nil --类型：ttf 塔技能
    self.towerType = nil --类型:sprite 塔类型
    self:initView()
end

--[[--
    界面初始化

    @param none

    @return none
]]
function OppositeTowerView:initView()
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

    local bgLayer = ccui.ImageView:create("ui/battle/Secondary interface-Square tower information pop-up window/bg-pop-up.png")
    bgLayer:setAnchorPoint(0.5, 0.5)
    bgLayer:setPosition(display.cx, 960)
    bgLayer:addTo(self.container_)
    bgLayer:addTouchEventListener(function(sender, eventType)
		if 2 == eventType then
            return
		end
	end)
    bgLayer:setTouchEnabled(true)

   --塔图片
   self.towerSprite=display.newSprite("ui/battle/Battle interface/Tower/tower_1.png")
   self.towerSprite:setAnchorPoint(0.5, 0.5)
   self.towerSprite:setPosition(80, 140)
   self.towerSprite:addTo(bgLayer)
   --塔图片
   self.towerType=display.newSprite("ui/battle/Battle interface/Angle sign-Tower_type/TowerType-attack.png")
   self.towerType:setAnchorPoint(0.5, 0.5)
   self.towerType:setPosition(120, 180)
   self.towerType:addTo(bgLayer)
   --塔名字
   self.towerName=cc.Label:createWithTTF("名字","ui/font/fzbiaozjw.ttf",30)
   self.towerName:setAnchorPoint(0,1)
   self.towerName:setPosition(170,200)
   self.towerName:enableOutline(cc.c4b(14,14,42,255), 2)
   self.towerName:addTo(bgLayer)
   --塔稀有度
   self.towerRarity=cc.Label:createWithTTF("未知","ui/font/fzbiaozjw.ttf",24)
   self.towerRarity:setAnchorPoint(0,1)
   self.towerRarity:setPosition(380,200)
   self.towerRarity:enableOutline(cc.c4b(14,14,25,255), 2)
   self.towerRarity:addTo(bgLayer)
   --塔技能
   self.towerSkill=cc.Label:createWithTTF("初始化占位符","ui/font/fzbiaozjw.ttf",22)
   self.towerSkill:setLineBreakWithoutSpace(true)
   self.towerSkill:setMaxLineWidth(300)
   self.towerSkill:setAnchorPoint(0,1)
   self.towerSkill:setPosition(180,120)
   self.towerSkill:enableOutline(cc.c4b(12,6,24,255), 1)
   self.towerSkill:addTo(bgLayer)
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

    @param tower 类型：Tower.lua 类型:塔数据

    @return none
]]
function OppositeTowerView:showView(tower_id)
    local res= "ui/battle/Battle interface/"
    self.towerSprite:setTexture(string.format(res.."Tower/tower_%u.png",tower_id))
    self.towerType:setTexture(string.format(res.."Angle sign-Tower_type/TowerType-"..TowerDef.TABLE[tower_id].TYPE..".png"))
    local rarity ={
        [1] ="普通",
        [2] ="稀有",
        [3] ="史诗",
        [4] ="传说",
    }
    self.towerRarity:setString(rarity[TowerDef.TABLE[tower_id].RARITY])
    self.towerSkill:setString(TowerDef.TABLE[tower_id].INFORMATION)
    self.towerName:setString(TowerDef.TABLE[tower_id].NAME)
    self:setVisible(true)
    self.container_:setScale(0)
    self.container_:runAction(cc.ScaleTo:create(0.15, 1))
end

--[[--
    隐藏界面

    @param callback 类型：function，动画完成回调

    @return none
]]
function OppositeTowerView:hideView(callback)
    self.container_:runAction(cc.Sequence:create(
        cc.ScaleTo:create(0.15, 0), cc.CallFunc:create(function() 
            self:setVisible(false)
            if callback then
                callback()
            end
        end)
    ))
end

return OppositeTowerView