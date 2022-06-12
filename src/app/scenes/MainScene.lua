
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

local audio = require("framework.audio")

local music = false
local sound = false


audio.loadFile("texture/sounds/buttonEffet.ogg", function ()
end)


--函数，第一个是主屏幕。第二个是背景移动速度
local function  blackgroungd1(mainScene1,speed)

    local setting = io.open("setting.txt","a+")
    if setting:read()  == "true" then
        music = true
    end 
    if setting:read("*l")  == "true" then
        sound = true
    end
    print(music)
    print(sound)
    

    io.close(setting)
    
    audio.loadFile("texture/sounds/mainMainMusic.ogg", function ()
        if music then
            audio.playBGM("texture/sounds/mainMainMusic.ogg")
        end
    end)

    local b1= display.newSprite("texture/img_bg/img_bg_1.jpg")
    :pos(display.cx,display.cy)
    :addTo(mainScene1)
   
    local b2= display.newSprite("texture/img_bg/img_bg_1.jpg")
    :pos(display.cx,display.cy-1280)
    :addTo(mainScene1)

    local move1 = cc.MoveBy:create(10*speed,cc.p(0,1000))
    local move2 = cc.MoveBy:create(0,cc.p(0,-1280))
    local move3 = cc.MoveBy:create(2.80*speed,cc.p(0,280))

    local move4 = cc.MoveBy:create(12.80*speed,cc.p(0,1280))
    local move5 = cc.MoveBy:create(0,cc.p(0,-1280))

    local SequenceAction1 = cc.Sequence:create(move1,move2,move3)
    local SequenceAction2 = cc.Sequence:create(move4,move5)

    transition.execute(b1,cc.RepeatForever:create(SequenceAction1))
    transition.execute(b2,cc.RepeatForever:create(SequenceAction2))

    b1:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
		dump(event)
		if event.name == "began" then
            local  register = import("src.app.scenes.register"):new()
            display.replaceScene(register)
		end
	end)
    b1:setTouchMode(cc.TOUCH_MODE_ONE_BY_ONE) -- default mode
	b1:setTouchEnabled(true)

    b2:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
		dump(event)
		if event.name == "began" then
            local  register = import("src.app.scenes.register"):new()
            display.replaceScene(register)
		end
	end)
    b2:setTouchMode(cc.TOUCH_MODE_ONE_BY_ONE) -- default mode
	b2:setTouchEnabled(true)   
end


function MainScene:ctor()
    blackgroungd1(self,1)
end


function MainScene:onEnter()
end

function MainScene:onExit()
end

return MainScene
