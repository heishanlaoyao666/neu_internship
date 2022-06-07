local eventDispatcher = cc.Director:getInstance():getEventDispatcher()

local zhucheUI = class("zhucheUI", function()
	return display.newScene("zhucheUI")
end)

function zhucheUI:ctor()
	self:addNodeEventListener(cc.NODE_EVENT, function(e)
		if e.name == "enter" then
			self:onEnter()
		elseif e.name == "exit" then
			eventDispatcher:removeEventListener(self.eventListenerCustom_)
		end
	end)
end

function zhucheUI:onEnter()
	local width,height = 480,720
	local startLayer = ccui.Layout:create()
    startLayer:setBackGroundImage("res\\ui\\main\\bg_menu.jpg")
	startLayer:setBackGroundColorType(1)
    startLayer:setContentSize(cc.size(width,height))
    startLayer:setPosition(display.cx, display.cy)
    startLayer:setAnchorPoint(cc.p(0.5, 0.5))
	startLayer:addTo(self)

    display.newTTFLabel({
        text = "新用户请注册:",
        size = 25,
        color = display.COLOR_WHITE
	})
    :align(display.LEFT_CENTER, 70, display.top - 180)
    :addTo(self)

    local locationEditbox = ccui.EditBox:create(cc.size(display.width-150, 40), "ButtonNormal.png", 1)
	locationEditbox:setAnchorPoint(0,0)
	locationEditbox:pos(70, display.top - 270)
	self:addChild(locationEditbox)

	local function getUUID() local curTime = os.time() local uuid = curTime + math.random(10000000)
        return uuid end

    local zhucheButton = ccui.Button:create("res\\ui\\register\\register.png", 1)
    zhucheButton:setAnchorPoint(0.5, 0.5)
	zhucheButton:setScale9Enabled(true)
	zhucheButton:setContentSize(cc.size(150, 50))
	zhucheButton:addTouchEventListener(function(sender, eventType)
		if 2 == eventType then
			if cc.UserDefault:getInstance():getBoolForKey("yinxiao") then
                audio.playEffect("res\\sounds\\buttonEffet.ogg",false)
            end
			if locationEditbox:getText()=="" then
				-- body
				print("昵称不能为空！")
			else
			cc.UserDefault:getInstance():setStringForKey("name",locationEditbox:getText())
			cc.UserDefault:getInstance():setStringForKey("id",getUUID())
			cc.UserDefault:getInstance():setStringForKey("maxGrade",0)
			print(cc.UserDefault:getInstance():getStringForKey("id"))
			local AnotherScene=require("src\\app\\scenes\\MainScene.lua"):new()
                display.replaceScene(AnotherScene, "fade", 0.5)
			end
			--cc.
		end
	end)
	zhucheButton:pos(display.cx, display.cy-20)
	zhucheButton:addTo(self)

    local cancelButton = ccui.Button:create("res\\ui\\back_peek0.png",
	"res\\ui\\back_peek1.png",  1)
    cancelButton:setAnchorPoint(0,1)
	cancelButton:setScale9Enabled(true)
	cancelButton:setContentSize(cc.size(130, 40))
	--cancelButton:setTitleText("Cancel")
	cancelButton:setTitleFontSize(25)
	cancelButton:addTouchEventListener(function(sender, eventType)
		if 2 == eventType then
			local AnotherScene=require("src\\app\\scenes\\MainScene.lua"):new()
                display.replaceScene(AnotherScene, "fade", 0.5)
		end
	end)
	cancelButton:pos(10, display.top-10 )
	cancelButton:addTo(self)

end

return zhucheUI

