--[[--
    对方塔信息界面
    OppositeTowerViwe.lua
]]
local OppositeTowerView = class("OppositeTowerView", function()
    return display.newColorLayer(cc.c4b(100, 100, 100, 100))
end)
local ConstDef = require("app/def/ConstDef")
local GameData = require("app/data/GameData")

--[[--
    构造函数

    @param none

    @return none
]]
function OppositeTowerView:ctor()
    
    self:initView()
end

--[[--
    界面初始化

    @param none

    @return none
]]
function OppositeTowerView:initView()
    -- local width, height = 300, 300
    -- self.container_ = ccui.Layout:create()
    -- self.container_:setBackGroundColor(cc.c3b(200, 200, 200))
    -- self.container_:setBackGroundColorType(1)
    -- self.container_:setContentSize(width, height)
    -- self.container_:addTo(self)
    -- self.container_:setAnchorPoint(0.5, 0.5)
    -- self.container_:setPosition(display.cx, display.cy)

    -- local label = ccui.Text:create("Game Over", "ui/font/FontNormal.ttf", 40)
    -- label:setAnchorPoint(0.5, 0.5)
    -- label:setPosition(width * 0.5, height - 40)
    -- self.container_:addChild(label)

    -- self.scoreLabel_ = ccui.Text:create("分数 : ".. GameData:getScore(), "ui/font/FontNormal.ttf", 30)
    -- self.scoreLabel_:setAnchorPoint(0.5, 0.5)
    -- self.scoreLabel_:setPosition(width * 0.5, height - 120)
    -- self.container_:addChild(self.scoreLabel_)

    -- self.historyLabel_ = ccui.Text:create("历史最佳 : ".. GameData:getHistory(), "ui/font/FontNormal.ttf", 30)
    -- self.historyLabel_:setAnchorPoint(0.5, 0.5)
    -- self.historyLabel_:setPosition(width * 0.5, height - 190)
    -- self.container_:addChild(self.historyLabel_)

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
function OppositeTowerView:showView()
    -- self:setVisible(true)
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
function OppositeTowerView:hideView(callback)
    -- self.container_:runAction(cc.Sequence:create(
    --     cc.ScaleTo:create(0.15, 0), cc.CallFunc:create(function() 
    --         self:setVisible(false)
    --         if callback then
    --             callback()
    --         end
    --     end)
    -- ))
end

return OppositeTowerView