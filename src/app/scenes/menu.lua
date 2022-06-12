menu = class("menu", function()
    return display.newScene("menu")
end)

local music = false
local sound = false

local audio = require("framework.audio")

audio.loadFile("texture/sounds/buttonEffet.ogg", function ()
end)

function menu:ctor()  
  local setting = io.open("setting.txt","a+")
    if setting:read()  == "true" then
        music = true
    end 
    if setting:read("*l")  == "true" then
        sound = true
    end 
    io.close(setting)
end

function menu:onEnter()

    local setting = io.open("setting.txt","a+")
    if setting:read()  == "true" then
        music = true
    end 
    if setting:read("*l")  == "true" then
        sound = true
    end 
    io.close(setting)

    if music then
        audio.playBGM("texture/sounds/mainMainMusic.ogg")
    end

    local b2 = display.newSprite("texture/ui/main/bg_menu.jpg")
    :pos(display.cx,display.cy)
    :addTo(self)

    local confirmButton = ccui.Button:create("texture/ui/main/continue_menu.png", "texture/ui/main/continue_menu2.png")
    confirmButton:setAnchorPoint(0.5, 0.5)
    confirmButton:setScale9Enabled(true)
    confirmButton:setContentSize(144, 49)
    confirmButton:pos(display.cx,display.cy+75)
    confirmButton:addTo(self)

    confirmButton:addTouchEventListener(function(sender, eventType)
		if 2 == eventType then
      if sound then
          audio.playEffect("texture/sounds/buttonEffet.ogg")
      end
			local  play1 = import("src.app.scenes.play1"):new()
      display.replaceScene(play1)
		end
	  end)

    local confirmButton1 = ccui.Button:create("texture/ui/main/new_game1.png", "texture/ui/main/new_game2.png")
    confirmButton1:setAnchorPoint(0.5, 0.5)
    confirmButton1:setScale9Enabled(true)
    confirmButton1:setContentSize(144, 49)
    confirmButton1:pos(display.cx,display.cy+25)
    confirmButton1:addTo(self)

    -- 点击输出输入框的内容
    confirmButton1:addTouchEventListener(function(sender1, eventType)
		if 2 == eventType then
			  local  play1 = import("src.app.scenes.play1"):new()
        if sound then
            audio.playEffect("texture/sounds/buttonEffet.ogg")
        end
        display.replaceScene(play1)
		end
	  end)

    local confirmButton2 = ccui.Button:create("texture/ui/main/rank_menu.png", "texture/ui/main/rank_menu2.png")
    confirmButton2:setAnchorPoint(0.5, 0.5)
    confirmButton2:setScale9Enabled(true)
    confirmButton2:setContentSize(144, 49)
    confirmButton2:pos(display.cx,display.cy-25)
    confirmButton2:addTo(self)

    -- 点击输出输入框的内容
    confirmButton2:addTouchEventListener(function(sender2, eventType)
		if 2 == eventType then
      if sound then
          audio.playEffect("texture/sounds/buttonEffet.ogg")
      end
			
		end
	  end)

    local confirmButton3 = ccui.Button:create("texture/ui/main/shezhi1_cover.png", "texture/ui/main/shezhi2_cover.png")
    confirmButton3:setAnchorPoint(0.5, 0.5)
    confirmButton3:setScale9Enabled(true)
    confirmButton3:setContentSize(144, 49)
    confirmButton3:pos(display.cx,display.cy-75)
    confirmButton3:addTo(self)

    -- 点击输出输入框的内容
    confirmButton3:addTouchEventListener(function(sender3, eventType)
		if 2 == eventType then
      if sound then
          audio.playEffect("texture/sounds/buttonEffet.ogg")
      end
      local  shezhi1 = import("src.app.scenes.shezhi"):new()
      display.replaceScene(shezhi1)
		end
	  end)
end

function menu:onExit()
end

return menu