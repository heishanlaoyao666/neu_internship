SettingScene = class("SettingScene", function()
    return display.newScene("SettingScene")
end)

local audio = require("framework.audio")

function SettingScene:ctor()  
end

audio.loadFile("texture/sounds/buttonEffet.ogg", function ()
end)


function SettingScene:onEnter()

    local sound = true
    local music = true 
    local b2 = display.newSprite("texture/ui/main/bg_menu.jpg")
    :pos(display.cx,display.cy)
    :addTo(self)

    local back = ccui.Button:create("texture/ui/gameover/back.png", "texture/ui/gameover/back.png")
    back:setAnchorPoint(0.0, 1.0)
    back:setScale9Enabled(true)
    back:setContentSize(307, 75)
    back:pos(display.left,display.top)
    back:addTo(self)

    back:addTouchEventListener(function(sender, eventType)
		if 2 == eventType then
      audio.playEffect("texture/sounds/buttonEffet.ogg")
			local  menu = import("src.app.scenes.MenuScene"):new()
            display.replaceScene(menu)
		end
	end)

    local music1 = display.newSprite("texture/ui/setting/bg_music_contrl_cover.png")
    :pos(display.cx-68,display.cy+25)
    :addTo(self)

    local set1 = display.newSprite("texture/ui/setting/soundon1_cover.png")
    :pos(display.cx+139.5,display.cy+25)
    :addTo(self)
    set1:setScale(0.5)

    local set2 = display.newSprite("texture/ui/setting/soundon2_cover.png")
    :pos(display.cx+139.5,display.cy+25)
    :addTo(self)
    set2:setScale(0.5)

    set1:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
		dump(event)
    audio.playEffect("texture/sounds/buttonEffet.ogg")
		if event.name == "began" then
            set1:setVisible(false)
            set2:setVisible(true)
            set2:setTouchEnabled(true)
            set1:setTouchEnabled(false)
            music = false
            audio.stopBGM()
		end
	end)
    set2:setVisible(false)

    set2:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
		dump(event)
    audio.playEffect("texture/sounds/buttonEffet.ogg")
		if event.name == "began" then
            set2:setVisible(false)
            set1:setVisible(true)
            set1:setTouchEnabled(true)
            set2:setTouchEnabled(false)
            music = true
            audio.playBGM("texture/sounds/mainMainMusic.ogg")

		end
	end)
    set2:setTouchMode(cc.TOUCH_MODE_ONE_BY_ONE) -- default mode

    set1:setTouchEnabled(true)

    local sound1 = display.newSprite("texture/ui/setting/sound_click_contrl_cover.png")
    :pos(display.cx-68,display.cy-25)
    :addTo(self)
    

    local set3 = display.newSprite("texture/ui/setting/soundon1_cover.png")
    :pos(display.cx+139.5,display.cy-25)
    :addTo(self)
    set3:setScale(0.5)
    local set4 = display.newSprite("texture/ui/setting/soundon2_cover.png")
    :pos(display.cx+139.5,display.cy-25)
    :addTo(self)
    set4:setScale(0.5)

    set3:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
		dump(event)
    audio.playEffect("texture/sounds/buttonEffet.ogg")
		if event.name == "began" then
            set3:setVisible(false)
            set4:setVisible(true)
            set4:setTouchEnabled(true)
            set3:setTouchEnabled(false)
            sound = false
		end
	end)
    set4:setVisible(false)

    set4:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
		dump(event)
    audio.playEffect("texture/sounds/buttonEffet.ogg")
		if event.name == "began" then
            set4:setVisible(false)
            set3:setVisible(true)
            set3:setTouchEnabled(true)
            set4:setTouchEnabled(false)
            sound = true
		end
	end)
    set4:setTouchMode(cc.TOUCH_MODE_ONE_BY_ONE) -- default mode

    set3:setTouchEnabled(true)
    
end

function SettingScene:onExit()
end

return SettingScene