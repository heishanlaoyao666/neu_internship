--[[--
    结算界面
    ResultView.lua
]]
local GameWinView = class("GameWinView", function()
    return display.newColorLayer(cc.c4b(100, 100, 100, 100))
end)
local ConstDef = require("app/def/ConstDef.lua")
local GameData = require("app/data/GameData.lua")
local TowerDef     = require("app.def.TowerDef")
local width, height = 720, 1280
--[[--
    构造函数

    @param none

    @return none
]]
function GameWinView:ctor()
    self.container_ = nil -- 类型：Layout，控件容器

    self:initView()
end

--[[--
    界面初始化

    @param none

    @return none
]]
function GameWinView:initView()

    self.container_ = ccui.Layout:create()
    self.container_:setBackGroundColor(cc.c3b(0, 0, 0))
    self.container_:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)--设置颜色模式
    self.container_:setBackGroundColorOpacity(128)--设置透明度
    self.container_:setBackGroundColorType(1)
    self.container_:setContentSize(width, height)
    self.container_:addTo(self)
    self.container_:setAnchorPoint(0.5, 0.5)
    self.container_:setPosition(display.cx, display.cy)

    self.winLayout = ccui.Layout:create()
    self.winLayout:setBackGroundColor(cc.c3b(255, 255, 255))
    self.winLayout:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)--设置颜色模式
    self.winLayout:setBackGroundColorOpacity(128)--设置透明度
    self.winLayout:setBackGroundColorType(1)
    self.winLayout:setContentSize(width, height*0.25)
    self.winLayout:addTo(self.container_)
    self.winLayout:setAnchorPoint(0.5, 0.5)
    self.winLayout:setPosition(display.cx, display.cy+height*0.2)

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
function GameWinView:showView(msg)
    
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
function GameWinView:hideView(callback)
    self.container_:runAction(cc.Sequence:create(
        cc.ScaleTo:create(0.15, 0), cc.CallFunc:create(function() 
            self:setVisible(false)
            if callback then
                callback()
            end
        end)
    ))
end

return GameWinView