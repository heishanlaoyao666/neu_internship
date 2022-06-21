
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()
    -- local label = display.newTTFLabel({
    --     text = "Hello, World",
    --     size = 64,
    -- })
    -- label:align(display.CENTER, display.cx, display.cy)
    -- label:addTo(self)
    --开始游戏按钮
    local images = {
        normal = "大厅（游戏外）\战斗界面\.png",
        pressed = "register/register.png",
        disabled = "register/register.png"
    }

    local registerBtn = ccui.Button:create(images["normal"], images["pressed"], images["disabled"])
    registerBtn:setAnchorPoint(cc.p(0.5 ,0.5))
    -- 居中
    registerBtn:setPosition(cc.p(display.cx, display.cy))
    -- 设置缩放程度
    registerBtn:setScale(0.5, 0.5)
    -- 设置是否禁用(false为禁用)
    registerBtn:setEnabled(true)
    -- registerBtn:addClickEventListener(function()
    --     print("lalala")
    -- end)

    registerBtn:addTouchEventListener(function(sender, eventType)
	 	if eventType == ccui.TouchEventType.ended then
	 		local registerBtn = import("app.scenes.GameScene"):new()
            display.replaceScene(registerBtn,"turnOffTiles",0.5)
            print(transform)
	 	end
	end)

    self:addChild(registerBtn, 4)


end

function MainScene:createMiddleMiddlePanel()
    
end

function MainScene:onEnter()
end

function MainScene:onExit()
end

return MainScene
