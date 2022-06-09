local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:yinXiao(path)
    if cc.UserDefault:getInstance():getBoolForKey("yinxiao") then
        audio.loadFile(path, function ()
            audio.playEffect(path, false)
        end)
    end
end

function MainScene:ctor()

    self:iniInterface()
end

--初始化界面函数
function MainScene:iniInterface()



    --背景图片
    local sp = display.newSprite("res/ui/main/bg_menu.jpg")
    sp:pos(display.cx, display.cy)
    sp:addTo(self)
    sp:setScale(1.3)




    --背景音乐
    local channelCount = 0
    local loadedCB = function(fn, success)
        if not success then
            print("Fail to load audio:" .. fn)
            return
        end
        channelCount = channelCount + 1
        local playWay = audio.playBGM
        local text = "Play BGM:"
        if channelCount > 1 then
            playWay = audio.playEffect
            text = "Play Effect:"
        end
                playWay(fn)

        if channelCount == 2 then
            self:loadBtns()
        end
    end

    if cc.UserDefault:getInstance():getBoolForKey("yinyue") then
        audio.loadFile("res/sounds/bgMusic.ogg",loadedCB)
    else
        audio.stopBGM("res/sounds/bgMusic.ogg")
        -- body
    end


    local scrollView = ccui.ScrollView:create()
    scrollView:addTo(self)
    scrollView:align(display.TOP_CENTER, display.cx, display.top)
    self.scrollView = scrollView

    local btn_Name= {
    "res/ui/main/new_game1.png",
    "res/ui/main/continue_menu.png",
    "res/ui/main/rank_menu.png",
    "res/ui/main/shezhi1_cover.png",

    "res/ui/main/new_game2.png",
    "res/ui/main/continue_menu2.png",
    "res/ui/main/rank_menu2.png",
    "res/ui/main/shezhi2_cover.png",
    }
    local scene= {
    "app.scenes.game",
    "app.scenes.Continue",
    "app.scenes.Rank",
    "app.scenes.Setting"
    }
    local total = 0
    local btnSize = nil
    for i = 4, 1,-1 do
        local btn = ccui.Button:create(btn_Name[i],btn_Name[i+4] ,1)
        btn:addTouchEventListener(function(sender, eventType)
          if 2 == eventType then
              self:yinXiao("res/sounds/buttonEffet.ogg")
              if i==1 then
                  if cc.UserDefault:getInstance():getStringForKey("id")=="a" then
                      local AnotherScene=require("app/scenes/zhuCe"):new()
                      display.replaceScene(AnotherScene, "fade", 0.5)
                  else
                      local AnotherScene1=require("app/scenes/game"):new()
                      display.replaceScene(AnotherScene1, "fade", 0.5)

                  end
              elseif i==2 then
                  if  cc.UserDefault:getInstance():getStringForKey("id")=="a" then
                  else
                      local AnotherScene=require("app/scenes/game"):new()
                      display.replaceScene(AnotherScene, "fade", 0.5)
                  end
              end
              elseif i>2 then
                  local AnotherScene=require(scene[i]):new()
                  display.replaceScene(AnotherScene,"fade",0.5)
          end
        end)



    if not btnSize then
    btnSize = btn:getContentSize()
    end

    btn:pos((display.width - btnSize.width) / 2 + btnSize.width / 2,
    btnSize.height * total+50 +total*20)
    total = total + 1

    scrollView:addChild(btn)
    scrollView:setContentSize(cc.size(display.width, 500))

    end


end

function MainScene:onEnter()
end

function MainScene:onExit()
end

return MainScene
