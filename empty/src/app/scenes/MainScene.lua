
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()

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


end

function MainScene:createMiddleMiddlePanel()
    
end

function MainScene:onEnter()
end

function MainScene:onExit()
end

return MainScene
