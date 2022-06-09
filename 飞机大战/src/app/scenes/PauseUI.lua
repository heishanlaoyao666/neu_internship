local eventDispatcher = cc.Director:getInstance():getEventDispatcher()

local scheduler = require("framework.scheduler")
local PauseUI = class("PauseUI", function()
	return display.newScene("PauseUI")
end)

function PauseUI:ctor()
	self:addNodeEventListener(cc.NODE_EVENT, function(e)
		if e.name == "enter" then
			self:onEnter()
		elseif e.name == "exit" then
			eventDispatcher:removeEventListener(self.eventListenerCustom_)
		end
	end)
end

function PauseUI:onEnter()

	audio.pauseAll()
	local width,height = 480,920
	local startLayer = ccui.Layout:create()
    --startLayer:setBackGroundImage("res\\ui\\main\\bg_menu.jpg")
	startLayer:setBackGroundColorType(1)
    startLayer:setContentSize(cc.size(width,height))
    startLayer:setPosition(display.cx, display.cy)
    startLayer:setAnchorPoint(cc.p(0.5, 0.5))
	startLayer:setOpacity(127)
	startLayer:addTo(self)
	-- local tb={"ss","a"}
	-- local str = json.encode(tb)
	-- print(str)
--返回战斗
local cancelButton = ccui.Button:create("res\\ui\\continue\\pauseResume.png",  1)
cancelButton:setAnchorPoint(0.5,1)
cancelButton:setScale9Enabled(true)
cancelButton:setContentSize(cc.size(300, 80))
cancelButton:setTitleFontSize(25)
cancelButton:addTouchEventListener(function(sender, eventType)
	if 2 == eventType then
		if cc.UserDefault:getInstance():getBoolForKey("yinxiao") then
			audio.playEffect("res\\sounds\\buttonEffet.ogg",false)
		end
		audio.resumeAll()
		self:removeFromParent(true)
		display.resume()

	end
end)
cancelButton:pos(display.cx, display.top-230 )
cancelButton:addTo(self)

--返回菜单
    local cancelButton1 = ccui.Button:create("res\\ui\\continue\\pauseBackRoom.png",  1)
    cancelButton1:setAnchorPoint(0.5,1)
	cancelButton1:setScale9Enabled(true)
	cancelButton1:setContentSize(cc.size(300, 80))
	cancelButton1:setTitleFontSize(25)
	cancelButton1:addTouchEventListener(function(sender, eventType)
		if 2 == eventType then
			save()
			cc.UserDefault:getInstance():setBoolForKey("document",true)
			if cc.UserDefault:getInstance():getBoolForKey("yinxiao") then
                audio.playEffect("res\\sounds\\buttonEffet.ogg",false)
            end
			scheduler.unscheduleGlobal(handle1)
		    scheduler.unscheduleGlobal(handle2)
		    scheduler.unscheduleGlobal(handle3)
		    scheduler.unscheduleGlobal(handle4)
			display.resume()
			local AnotherScene=require("app.scenes.MainScene"):new()
			display.replaceScene(AnotherScene, "fade", 0.5)
		end
	end)
	cancelButton1:pos(display.cx, display.top-350 )
	cancelButton1:addTo(self)
end

return PauseUI

