local eventDispatcher = cc.Director:getInstance():getEventDispatcher()

local SheZhiUI = class("SheZhiUI", function()
	return display.newScene("SheZhiUI")
end)

function SheZhiUI:ctor()
	self:addNodeEventListener(cc.NODE_EVENT, function(e)
		if e.name == "enter" then
			self:onEnter()
		elseif e.name == "exit" then
			eventDispatcher:removeEventListener(self.eventListenerCustom_)
		end
	end)
end

function SheZhiUI:onEnter()

	local width,height = 480,720
	local startLayer = ccui.Layout:create()
    startLayer:setBackGroundImage("res\\ui\\main\\bg_menu.jpg")
	startLayer:setBackGroundColorType(1)
    startLayer:setContentSize(cc.size(width,height))
    startLayer:setPosition(display.cx, display.cy)
    startLayer:setAnchorPoint(cc.p(0.5, 0.5))
	startLayer:addTo(self)

	--音效控制
	local sprite = display.newSprite("res\\ui\\setting\\sound_click_contrl_cover.png")
    sprite:pos(display.cx, display.cy + 200)
	sprite:addTo(self)

	local landscapeCheckBox = ccui.CheckBox:create("res\\ui\\setting\\soundon2_cover.png", nil, "res\\ui\\setting\\soundon1_cover.png", nil, nil)
	:align(display.LEFT_CENTER, display.cx-140, display.cy+130)
	:addTo(self)
	if cc.UserDefault:getInstance():getBoolForKey("yinxiao") then
		landscapeCheckBox:setSelected(true)
	else
		landscapeCheckBox:setSelected(false)
	end
	landscapeCheckBox:addEventListener(function(sender, eventType)
		-- body
		if 1==eventType then--1是没选上0是选上
			cc.UserDefault:getInstance():setBoolForKey("yinxiao",false)
	else
		cc.UserDefault:getInstance():setBoolForKey("yinxiao",true)
	end
	end)

	--音乐控制
	local sprite1 = display.newSprite("res\\ui\\setting\\bg_music_contrl_cover.png")
    sprite1:pos(display.cx, display.cy + 50)
	sprite1:addTo(self)

	local landscapeCheckBox1 = ccui.CheckBox:create("res\\ui\\setting\\soundon2_cover.png", nil, "res\\ui\\setting\\soundon1_cover.png", nil, nil)
	:align(display.LEFT_CENTER, display.cx-140, display.cy-20)
	:addTo(self)
	if cc.UserDefault:getInstance():getBoolForKey("yinyue") then
		-- body
		landscapeCheckBox1:setSelected(true)
	else
		landscapeCheckBox1:setSelected(false)
	end
	landscapeCheckBox1:addEventListener(function(sender, eventType)
		-- body
		if 1==eventType then--1是没选上0是选上
			audio.stopBGM("res\\sounds\\mainMainMusic.ogg")
			cc.UserDefault:getInstance():setBoolForKey("yinyue",false)
	else
		audio.playBGM("res\\sounds\\mainMainMusic.ogg",true)
		cc.UserDefault:getInstance():setBoolForKey("yinyue",true)
	end
	end)

	--版本号以及联系方式
	display.newTTFLabel({
		text = "版本号:1.1",
        size = 25,
        color = display.COLOR_RED
	})
	:align(display.LEFT_CENTER, display.cx-140, display.cy-130)
	:setOpacity(100)
	:addTo(self)

	display.newTTFLabel({
		text = "联系方式:10086",
        size = 25,
        color = display.COLOR_WHITE
	})
	:align(display.LEFT_CENTER, display.cx-140, display.cy-170)
	:addTo(self)

	display.newTTFLabel({
		text = "_____________",
        size = 25,
        color = display.COLOR_WHITE
	})
	:align(display.LEFT_CENTER, display.cx-140, display.cy-170)
	:addTo(self)

--返回按钮
local cancelButton = ccui.Button:create("res\\ui\\back_peek0.png",
"res\\ui\\back_peek1.png",  1)
cancelButton:setAnchorPoint(0,1)
cancelButton:setScale9Enabled(true)
cancelButton:setContentSize(cc.size(130, 40))
cancelButton:setTitleFontSize(25)
cancelButton:addTouchEventListener(function(sender, eventType)
	if 2 == eventType then
		if cc.UserDefault:getInstance():getBoolForKey("yinxiao") then
			audio.playEffect("res\\sounds\\buttonEffet.ogg",false)
		end
		local AnotherScene=require("src\\app\\scenes\\MainScene.lua"):new()
                display.replaceScene(AnotherScene, "fade", 0.5)
	end
end)
cancelButton:pos(10, display.top-10 )
cancelButton:addTo(self)

end

return SheZhiUI

