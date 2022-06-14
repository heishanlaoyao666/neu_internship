--[[--
    暂停界面
    PauseView.lua
]]
local PauseView = class("PauseView", function()
    return display.newColorLayer(cc.c4b(100, 100, 100, 100))
end)
local ConstDef = require("app.def.ConstDef")
local GameData = require("app.data.GameData")

--[[--
    构造函数

    @param none

    @return none
]]
function PauseView:ctor()
    self.container_ = nil -- 类型：Layout，控件容器
    self.scoreLabel_ = nil -- 类型：Text，分数
    self.historyLabel_ = nil -- 类型：Text，历史最高
    self:initView()
end

--[[--
    界面初始化

    @param none

    @return none
]]
function PauseView:initView()
    local width, height = 300, 300
    self.container_ = ccui.Layout:create()
    self.container_:setBackGroundColor(cc.c3b(200, 200, 200))
    self.container_:setBackGroundColorType(1)
    self.container_:setContentSize(width, height)
    self.container_:addTo(self)
    self.container_:setAnchorPoint(0.5, 0.5)
    self.container_:setPosition(display.cx, display.cy)

    self.scoreLabel_ = ccui.Text:create("分数 : ".. GameData:getScore(), "ui/font/FontNormal.ttf", 30)
    self.scoreLabel_:setAnchorPoint(0, 0.5)
    self.scoreLabel_:setPosition(20, height - 40)
    self.container_:addChild(self.scoreLabel_)

    self.historyLabel_ = ccui.Text:create("历史最佳 : ".. GameData:getHistory(), "ui/font/FontNormal.ttf", 30)
    self.historyLabel_:setAnchorPoint(0, 0.5)
    self.historyLabel_:setPosition(20, height - 90)
    self.container_:addChild(self.historyLabel_)

    local continueBtn = ccui.Button:create("ui/continue/pauseResume.png")
    self.container_:addChild(continueBtn)
    continueBtn:setAnchorPoint(0.5, 0.5)
    continueBtn:setPosition(width * 0.5, height - 200)
    continueBtn:addTouchEventListener(function(sender, eventType) 
        if eventType == 2 then
            self:hideView(function() 
                GameData:setGameState(ConstDef.GAME_STATE.PLAY)
            end)
        end
    end)

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
function PauseView:showView()
    self:setVisible(true)
    self.container_:setScale(0)
    self.container_:runAction(cc.ScaleTo:create(0.15, 1))
    self.scoreLabel_:setString("分数 : ".. GameData:getScore())
    self.historyLabel_:setString("历史最佳 : ".. GameData:getHistory())
end

--[[--
    隐藏界面

    @param callback 类型：function，动画完成回调

    @return none
]]
function PauseView:hideView(callback)
    self.container_:runAction(cc.Sequence:create(
        cc.ScaleTo:create(0.15, 0), cc.CallFunc:create(function() 
            self:setVisible(false)
            if callback then
                callback()
            end
        end)
    ))
end

return PauseView