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
    local maskBtn = ccui.Button:create("artcontent/lobby_ongame/currency/mask_popup.png")
    self:addChild(maskBtn)
    maskBtn:setAnchorPoint(0.5, 0.5)
    maskBtn:setOpacity(127)
    maskBtn:setPosition(display.cx,display.cy)

    maskBtn:addTouchEventListener(
        function(sender, eventType)
            -- ccui.TouchEventType
            if 2 == eventType then -- touch end
                cc.UserDefault:getInstance():setBoolForKey("fight",false)
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
    local basemapSprite = display.newSprite("artcontent/lobby_ongame/battle_interface/matching/basemap_popup.png")
    self.container_:addChild(basemapSprite)
    basemapSprite:setAnchorPoint(0.5, 0.5)
    basemapSprite:setPosition(width/2,height/2)

    --取消按钮
    local cancelBtn = ccui.Button:create("artcontent/lobby_ongame/battle_interface/matching/button_cancel.png")
    basemapSprite:addChild(cancelBtn)
    cancelBtn:setAnchorPoint(0.5, 0.5)
    cancelBtn:setPosition(basemapSprite:getContentSize().width/2, basemapSprite:getContentSize().height/2-100)
    cancelBtn:addTouchEventListener(function(sender, eventType)
        -- ccui.TouchEventType
        if 2 == eventType then -- touch end
            if cc.UserDefault:getInstance():getBoolForKey("音效") then
                audio.playEffect("sounds/ui_btn_close.OGG",false)
            end
            cc.UserDefault:getInstance():setBoolForKey("fight",false)
            self:removeFromParent(true)
        end
    end)

    --旋转
    local groupSprite = display.newSprite("artcontent/lobby_ongame/battle_interface/matching/group128.png")
    basemapSprite:addChild(groupSprite)
    --basemapSprite:setContentSize(width, height)
    groupSprite:setAnchorPoint(0.5, 0.5)
    groupSprite:setPosition(basemapSprite:getContentSize().width/2, basemapSprite:getContentSize().height/2)
    groupSprite:runAction(cc.RotateBy:create(4, 720))
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

