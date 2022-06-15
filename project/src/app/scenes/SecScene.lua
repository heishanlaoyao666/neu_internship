
local SecScene = class("SecScene", function()
    return display.newScene("SecScene")
end)

function SecScene:ctor()

    display.newSprite("bg_menu.jpg")
        :pos(display.cx,display.cy)
        :addTo(self)


     --按钮4
     local images = {
        normal4 = "main/shezhi1_cover.png",
        pressed4= "main/shezhi2_cover.png",
        disabled4 = "main/shezhi1_cover.png"
    }

    local ShezhiBtn = ccui.Button:create(images["normal4"], images["pressed4"], images["disabled4"])
    ShezhiBtn:setAnchorPoint(cc.p(0.5 ,0.5))
    -- 居中
    ShezhiBtn:setPosition(cc.p(display.cx, display.cy-100))
    -- 设置缩放程度
    ShezhiBtn:setScale(1.0, 1.0)
    -- 设置是否禁用(false为禁用)
    ShezhiBtn:setEnabled(true)
    ShezhiBtn:addClickEventListener(function()
        print("lalala")
    end)

    ShezhiBtn:addTouchEventListener(function(sender, eventType)
	 	if eventType == ccui.TouchEventType.ended then
	 		local ShezhiBtn = import("app.scenes.Shezhi"):new()
            display.replaceScene(ShezhiBtn,"turnOffTiles",0.5)
            print(transform)
	 	end
	end)
























     --按钮3
     local images = {
        normal3 = "main/rank_menu.png",
        pressed3 = "main/rank_menu2.png",
        disabled3 = "main/rank_menu.png"
    }

    local RankBtn = ccui.Button:create(images["normal3"], images["pressed3"], images["disabled3"])
    RankBtn:setAnchorPoint(cc.p(0.5 ,0.5))
    -- 居中
    RankBtn:setPosition(cc.p(display.cx, display.cy))
    -- 设置缩放程度
    RankBtn:setScale(1.0, 1.0)
    -- 设置是否禁用(false为禁用)
    RankBtn:setEnabled(true)
    RankBtn:addClickEventListener(function()
        print("lalala")
    end)

    RankBtn:addTouchEventListener(function(sender, eventType)
	  	if eventType == ccui.TouchEventType.ended then
	  		local NewGameBtn = import("app.scenes.Rank"):new()
             display.replaceScene(NewGameBtn,"turnOffTiles",0.5)
             print(transform)
	  	end
	 end)























     --按钮2
    local images = {
        normal2 = "main/continue_menu.png",
        pressed2 = "main/continue_menu2.png",
        disabled2 = "main/continue_menu.png"
    }

    local ContinueBtn = ccui.Button:create(images["normal2"], images["pressed2"], images["disabled2"])
    ContinueBtn:setAnchorPoint(cc.p(0.5 ,0.5))
    -- 居中
    ContinueBtn:setPosition(cc.p(display.cx, display.cy+100))
    -- 设置缩放程度
    ContinueBtn:setScale(1.0, 1.0)
    -- 设置是否禁用(false为禁用)
    ContinueBtn:setEnabled(true)
    ContinueBtn:addClickEventListener(function()
        print("lalala")
    end)

     ContinueBtn:addTouchEventListener(function(sender, eventType)
	  	if eventType == ccui.TouchEventType.ended then
	  		local NewGameBtn = import("app.scenes.ResumeScene"):new()
             display.replaceScene(NewGameBtn,"turnOffTiles",0.5)
             print(transform)
	  	end
	 end)
    













     --按钮1
     local images = {
        normal = "main/new_game1.png",
        pressed = "main/new_game2.png",
        disabled = "main/new_game1.png"
    }

    local NewGameBtn = ccui.Button:create(images["normal"], images["pressed"], images["disabled"])
    NewGameBtn:setAnchorPoint(cc.p(0.5 ,0.5))
    -- 居中
    NewGameBtn:setPosition(cc.p(display.cx, display.cy+200))
    -- 设置缩放程度
    NewGameBtn:setScale(1.0, 1.0)
    -- 设置是否禁用(false为禁用)
    NewGameBtn:setEnabled(true)
    NewGameBtn:addClickEventListener(function()
        print("lala")
    end)

    NewGameBtn:addTouchEventListener(function(sender, eventType)
	 	if eventType == ccui.TouchEventType.ended then
	 		local NewGameBtn = import("app.scenes.ThirdScene"):new()
            display.replaceScene(NewGameBtn,"turnOffTiles",0.5)
            print(transform)
	 	end
	end)


















    self:addChild(NewGameBtn, 4)
    self:addChild(ContinueBtn, 4)
    self:addChild(RankBtn, 4)
    self:addChild(ShezhiBtn, 4)
end

function SecScene:onEnter()
end

function SecScene:onExit()
end

return SecScene
