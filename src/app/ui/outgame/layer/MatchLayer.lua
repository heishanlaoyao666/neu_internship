--[[--
    匹配层
    MatchLayer.lua
]]
local MatchLayer = class("MatchLayer", require("app.ui.outgame.layer.BaseLayer"))


--[[--
    构造函数

    @param none

    @return none
]]
function MatchLayer:ctor()
    MatchLayer.super.ctor(self)


    self:initView()
end

--[[--
    界面初始化

    @param none

    @return none
]]
function MatchLayer:initView()
    local sprite0 = ccui.Button:create("artcontent/lobby(ongame)/currency/mask_popup.png")
    self:addChild(sprite0)
    sprite0:setAnchorPoint(0.5, 0.5)
    sprite0:setOpacity(127)
    sprite0:setPosition(display.cx,display.cy)

    sprite0:addTouchEventListener(
        function(sender, eventType)
            -- ccui.TouchEventType
            if 2 == eventType then -- touch end
                self:removeFromParent(true)
            end
        end
    )

    local width, height = display.width, 1120
    self.container_ = ccui.Layout:create()
    -- self.container_:setBackGroundColor(cc.c3b(200, 0, 0))
    -- self.container_:setBackGroundColorType(1)
    self.container_:setContentSize(display.width, height)
    self.container_:addTo(self)
    self.container_:setAnchorPoint(0.5, 0.5)
    self.container_:setPosition(display.cx, display.cy)

    --底图
    local sprite1 = display.newSprite("artcontent/lobby(ongame)/battle_interface/matching/basemap_popup.png")
    self.container_:addChild(sprite1)
    --sprite1:setContentSize(width, height)
    sprite1:setAnchorPoint(0.5, 0.5)
    sprite1:setPosition(width/2,height/2)

    --取消按钮
    local button = ccui.Button:create("artcontent/lobby(ongame)/battle_interface/matching/button_cancel.png")
    sprite1:addChild(button)
    button:setAnchorPoint(0.5, 0.5)
    button:setPosition(sprite1:getContentSize().width/2, sprite1:getContentSize().height/2-100)
    button:addTouchEventListener(function(sender, eventType)
        -- ccui.TouchEventType
        if 2 == eventType then -- touch end
            if cc.UserDefault:getInstance():getBoolForKey("音效") then
                audio.playEffect("sounds/ui_btn_close.OGG",false)
            end
            self:removeFromParent(true)
        end
    end)

    --旋转
    local sprite2 = display.newSprite("artcontent/lobby(ongame)/battle_interface/matching/group128.png")
    sprite1:addChild(sprite2)
    --sprite1:setContentSize(width, height)
    sprite2:setAnchorPoint(0.5, 0.5)
    sprite2:setPosition(sprite1:getContentSize().width/2, sprite1:getContentSize().height/2)
    sprite2:runAction(cc.RotateBy:create(4, 720))
    self:performWithDelay(function()--延迟函数，延迟一秒执行()
        self:Failure()
    end, 4)

end

--[[--
    匹配失败界面

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function MatchLayer:Failure()
    print("匹配失败")
    self:removeFromParent(true)
end

--[[--
    界面刷新

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function MatchLayer:update(dt)
end

return MatchLayer

