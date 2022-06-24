--[[--
    投降界面
    SurrenderView.lua
]]
local SurrenderView = class("SurrenderView", function()
    return display.newColorLayer(cc.c4b(100, 100, 100, 100))
end)
local ConstDef = require("app/def/ConstDef")
local GameData = require("app/data/GameData.lua")

--[[--
    构造函数

    @param none

    @return none
]]
function SurrenderView:ctor()
    
    self:initView()
end

--[[--
    界面初始化

    @param none

    @return none
]]
function SurrenderView:initView()
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


    local bgLayer = ccui.ImageView:create("ui/battle/Secondary interface-Admit defeat confirmation pop-up/bg-pop-up.png")
    bgLayer:setAnchorPoint(0.5, 0.5)
    bgLayer:setPosition(display.cx, display.cy)
    bgLayer:addTo(self.container_)
    bgLayer:addTouchEventListener(function(sender, eventType)
		if 2 == eventType then
            return
		end
	end)
    bgLayer:setTouchEnabled(true)
    --投降提醒
    local ttf=cc.Label:createWithTTF(ConstDef.SURRENDER,"ui/font/fzbiaozjw.ttf",32)
    ttf:setAnchorPoint(0.5,0.5)
    ttf:setPosition(bgLayer:getContentSize().width*0.5,180)
    ttf:addTo(bgLayer)
    --确认按钮
    local surrenderBtn = ccui.Button:create("ui/battle/Secondary interface-Admit defeat confirmation pop-up/Button - confirm.png")
    bgLayer:addChild(surrenderBtn)
    surrenderBtn:setAnchorPoint(0, 0)
    surrenderBtn:setPosition(300, 60)
    surrenderBtn:addTouchEventListener(function(sender, eventType) 
        if eventType == 2 then
            
        end
    end)
    --取消按钮
    local cancelBtn = ccui.Button:create("ui/battle/Secondary interface-Admit defeat confirmation pop-up/Button - cancel.png")
    bgLayer:addChild(cancelBtn)
    cancelBtn:setAnchorPoint(0, 0)
    cancelBtn:setPosition(40, 60)
    cancelBtn:addTouchEventListener(function(sender, eventType) 
        if eventType == 2 then
            self:hideView()
        end
    end)
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

    @param none

    @return none
]]
function SurrenderView:showView()
    self:setVisible(true)
    self.container_:setScale(0)
    self.container_:runAction(cc.ScaleTo:create(0.15, 1))
end

--[[--
    隐藏界面

    @param callback 类型：function，动画完成回调

    @return none
]]
function SurrenderView:hideView(callback)
    self.container_:runAction(cc.Sequence:create(
        cc.ScaleTo:create(0.15, 0), cc.CallFunc:create(function() 
            self:setVisible(false)
            if callback then
                callback()
            end
        end)
    ))
end

return SurrenderView