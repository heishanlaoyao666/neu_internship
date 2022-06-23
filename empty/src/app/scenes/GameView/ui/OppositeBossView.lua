--[[--
    对方BOSS信息界面
    OppositeBossViwe.lua
]]
local OppositeBossView = class("OppositeBossView", function()
    return display.newColorLayer(cc.c4b(100, 100, 100, 100))
end)
local ConstDef = require("app/def/ConstDef")
local GameData = require("app/data/GameData")

--[[--
    构造函数

    @param none

    @return none
]]
function OppositeBossView:ctor()
    self.bossSprite = nil --类型：sprite，boss图片
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
    self.container_:setOpacity(0.5)
    self.container_:setBackGroundColorType(1)
    self.container_:setContentSize(width, height)
    self.container_:addTo(self)
    self.container_:setAnchorPoint(0.5, 0.5)
    self.container_:setPosition(display.cx, display.cy)

    
    -- 点击背景返回
    self.container_:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event) 
        if event.name == "began" then
            self:hideView()
        end
    end)
    self.container_:setTouchEnabled(true)

    local bg = ccui.ImageView:create("ui/battle/Secondary interface-Boss information Popup/bg-pop-up.png")
    bg:setAnchorPoint(0.5, 0.5)
    bg:setPosition(width*0.5, height*0.5)
    self.container_:addChild(bg)
    bg:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event) 
        if event.name == "began" then
            return
        end
    end)
    bg:setTouchEnabled(true)
end

--[[--
    显示界面

    @param table 类型：table，显示界面的参数

    @return none
]]
function OppositeBossView:showView()
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