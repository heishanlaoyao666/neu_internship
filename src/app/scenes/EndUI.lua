local eventDispatcher = cc.Director:getInstance():getEventDispatcher()

local scheduler = require("framework.scheduler")

local EndUI = class("EndUI", function()
	return display.newScene("EndUI")
end)

function EndUI:ctor()
	self:addNodeEventListener(cc.NODE_EVENT, function(e)
		if e.name == "enter" then
			self:onEnter()
		elseif e.name == "exit" then
			eventDispatcher:removeEventListener(self.eventListenerCustom_)
		end
	end)
end

function EndUI:onEnter()
	audio.pauseAll()
	local width,height = 480,720
	local startLayer = ccui.Layout:create()
    --startLayer:setBackGroundImage("res\\ui\\main\\bg_menu.jpg")
	startLayer:setBackGroundColorType(1)
    startLayer:setContentSize(cc.size(width,height))
    startLayer:setPosition(display.cx, display.cy)
    startLayer:setAnchorPoint(cc.p(0.5, 0.5))
	startLayer:setOpacity(127)
	startLayer:addTo(self)

	display.newTTFLabel({
        text = "昵称:" .. cc.UserDefault:getInstance():getStringForKey("name"),
        size = 25,
        color = display.COLOR_WHITE
	})
    :align(display.LEFT_CENTER, 100, display.top - 150)
    :addTo(self)
	display.newTTFLabel({
        text = "得分:" .. cc.UserDefault:getInstance():getStringForKey("grade"),
        size = 25,
        color = display.COLOR_WHITE
	})
    :align(display.LEFT_CENTER, 300, display.top - 150)
    :addTo(self)

	if cc.UserDefault:getInstance():getStringForKey("grade")>cc.UserDefault:getInstance():getStringForKey("maxGrade") then
		cc.UserDefault:getInstance():setStringForKey("maxGrade",cc.UserDefault:getInstance():getStringForKey("grade"))
	end
--重新战斗
local cancelButton = ccui.Button:create("res\\ui\\gameover\\restart.png",  1)
cancelButton:setAnchorPoint(0.5,1)
cancelButton:setScale9Enabled(true)
cancelButton:setContentSize(cc.size(300, 80))
cancelButton:setTitleFontSize(25)
cancelButton:addTouchEventListener(function(sender, eventType)
	if 2 == eventType then
		if cc.UserDefault:getInstance():getBoolForKey("yinxiao") then
			audio.playEffect("res\\sounds\\buttonEffet.ogg",false)
		end
		display.resume()
		scheduler.unscheduleGlobal(handle1)
		scheduler.unscheduleGlobal(handle2)
		scheduler.unscheduleGlobal(handle3)
		scheduler.unscheduleGlobal(handle4)
		local AnotherScene1=require("src\\app\\scenes\\BattleUI.lua"):new()
                display.replaceScene(AnotherScene1, "fade", 0.5)
		audio.playBGM("res\\sounds\\bgMusic.ogg")
	end
end)
cancelButton:pos(display.cx, display.top-230 )
cancelButton:addTo(self)

--返回菜单
    local cancelButton1 = ccui.Button:create("res\\ui\\gameover\\back.png",  1)
    cancelButton1:setAnchorPoint(0.5,1)
	cancelButton1:setScale9Enabled(true)
	cancelButton1:setContentSize(cc.size(300, 80))
	cancelButton1:setTitleFontSize(25)
	cancelButton1:addTouchEventListener(function(sender, eventType)
		if 2 == eventType then
			if cc.UserDefault:getInstance():getBoolForKey("yinxiao") then
                audio.playEffect("res\\sounds\\buttonEffet.ogg",false)
            end
			display.resume()
			scheduler.unscheduleGlobal(handle1)
		    scheduler.unscheduleGlobal(handle2)
		    scheduler.unscheduleGlobal(handle3)
		    scheduler.unscheduleGlobal(handle4)
			local AnotherScene=require("app.scenes.MainScene"):new()
			display.replaceScene(AnotherScene, "fade", 0.5)
		end
	end)
	cancelButton1:pos(display.cx, display.top-350 )
	cancelButton1:addTo(self)
end

return EndUI

