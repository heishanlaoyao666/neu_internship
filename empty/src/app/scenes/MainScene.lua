
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()

    self:createMiddleMiddlePanel()

    --开始游戏按钮
    local images = {
        normal = "ui/hall/battle/Button-Battle_Mode.png",
        pressed = "",
        disabled = "ui/hall/battle/Button-Battle_Mode.png"
    }

    local NewGameBtn = ccui.Button:create(images["normal"], images["pressed"], images["disabled"])
    NewGameBtn:setAnchorPoint(cc.p(0.5 ,0.5))
    -- 居中
    NewGameBtn:setPosition(cc.p(display.cx, display.cy))
    -- 设置缩放程度
    NewGameBtn:setScale(0.5, 0.5)
    -- 设置是否禁用(false为禁用)
    NewGameBtn:setEnabled(true)
    -- registerBtn:addClickEventListener(function()
    --     print("lalala")
    -- end)

    NewGameBtn:addTouchEventListener(function(sender, eventType)
	 	if eventType == ccui.TouchEventType.ended then
	 		local ABtn = import("app.scenes.GameScene"):new()
            display.replaceScene(ABtn,"turnOffTiles",0.5)
            print(transform)
	 	end
	end)

    self:addChild(NewGameBtn, 4)

    self:createMiddleBottomPanel()


end
--bg-battle_interface.png
function MainScene:createMiddleMiddlePanel()
    local width ,height  =display.width,display.top
    local settingLayer = ccui.Layout:create()
    settingLayer:setBackGroundImage("ui/hall/battle/bg-battle_interface.png")
    settingLayer:setContentSize(width,height)
    settingLayer:setPosition(width*0.5,height*0.5)
    settingLayer:setAnchorPoint(0.5,0.5)
    settingLayer:addTo(self)

end

function MainScene:createMiddleBottomPanel()
    local width,height = display.width,display.top
    local menuLayer = ccui.Layout:create()
    menuLayer:setContentSize(width,height)
    menuLayer:setPosition(width*0.5,0)
    menuLayer:setAnchorPoint(0.5,0.5)
    menuLayer:addTo(self)

    local shopBtn = ccui.Button:create(
        "ui/hall/bottom-tab/tab-unselected-left.png",
        "ui/hall/bottom-tab/tab-selected.png",
        "ui/hall/bottom-tab/tab-unselected-left.png"
    )
    shopBtn:setAnchorPoint(1,0)
    shopBtn:setScale(2/3)
    shopBtn:pos(width*0.5,height*0.5)
    shopBtn:addTo(menuLayer)
    
end

function MainScene:onEnter()
end

function MainScene:onExit()
end

return MainScene
