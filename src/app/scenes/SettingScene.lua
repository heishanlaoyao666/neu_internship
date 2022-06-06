MENU_BG_PATH="D:/quick-cocos2dx-community/test/src/app/scenes/picture/ui/main/bg_menu.jpg"
MUSIC_CONTRL_PATH="D:/quick-cocos2dx-community/test/src/app/scenes/picture/ui/setting/bg_music_contrl_cover.png"
SOUND_CONTRL_PATH="D:/quick-cocos2dx-community/test/src/app/scenes/picture/ui/setting/sound_click_contrl_cover.png"
BUTTON_ON_PATH="D:/quick-cocos2dx-community/test/src/app/scenes/picture/ui/setting/soundon1_cover.png"
BUTTON_OFF_PATH="D:/quick-cocos2dx-community/test/src/app/scenes/picture/ui/setting/soundon2_cover.png"
MUSIC_PATH="D:/quick-cocos2dx-community/test/src/app/scenes/picture/sound/mainMainMusic.ogg"
BUTTON_BACK_N_PATH="D:/quick-cocos2dx-community/test/src/app/scenes/picture/ui/back_peek0.png"
BUTTON_BACK_S_PATH="D:/quick-cocos2dx-community/test/src/app/scenes/picture/ui/back_peek1.png"
soundsEnable=true
local SettingScene = class("SettingScene", function()
    return display.newScene("SettingScene")
end)
local function onChangedMusicCheckBox(sender,eventType)
    if eventType==ccui.CheckBoxEventType.selected then
        
        audio.loadFile(MUSIC_PATH, function()
        audio.playBGM(MUSIC_PATH, true)
           -- body
       end)
       
        --cc.simpleAudioEngine.playMusic(MUSIC_PATH,true)
    elseif eventType==ccui.CheckBoxEventType.unselected then
        --cc.simpleAudioEngine:getInstance().
        audio.stopBGM()
    end

end
local function onChangedSoundsCheckBox(sender,eventType)
    if eventType==ccui.CheckBoxEventType.selected then
        soundsEnable=true
    elseif eventType==ccui.CheckBoxEventType.unselected then
        soundsEnable=false
    end
end
function SettingScene:ctor()
    -- body
    local bg=display.newSprite(MENU_BG_PATH,display.cx,display.cy)
    self:add(bg)
    local musicContrl=display.newSprite(MUSIC_CONTRL_PATH)
    self:add(musicContrl)
    musicContrl:setPosition(cc.p(cc.Director:getInstance():getWinSize().width*0.3,cc.Director:getInstance():getWinSize().height*0.7))
    local cbxMusic=ccui.CheckBox:create(BUTTON_OFF_PATH,
                                        BUTTON_ON_PATH,
                                        BUTTON_ON_PATH,
                                        BUTTON_OFF_PATH,
                                        BUTTON_OFF_PATH)
    cbxMusic:setScale(0.5)
    cbxMusic:setAnchorPoint(0.5,0.5)
    cbxMusic:setPosition(cc.p(cc.Director:getInstance():getWinSize().width*0.7,cc.Director:getInstance():getWinSize().height*0.7))
    cbxMusic:addEventListener(onChangedMusicCheckBox)
    self:add(cbxMusic)
    local soundContrl=display.newSprite(SOUND_CONTRL_PATH)
    self:add(soundContrl)
    soundContrl:setPosition(cc.p(cc.Director:getInstance():getWinSize().width*0.3,cc.Director:getInstance():getWinSize().height*0.5))
    local cbxSounds=ccui.CheckBox:create(BUTTON_OFF_PATH,
                                         BUTTON_ON_PATH,
                                         BUTTON_ON_PATH,
                                         BUTTON_OFF_PATH,
                                         BUTTON_OFF_PATH)
    cbxSounds:setScale(0.5)
    cbxSounds:setAnchorPoint(0.5,0.5)
    cbxSounds:setPosition(cc.p(cc.Director:getInstance():getWinSize().width*0.7,cc.Director:getInstance():getWinSize().height*0.5))
    cbxSounds:addEventListener(onChangedSoundsCheckBox)
    self:add(cbxSounds)
                 
    local backButton=ccui.Button:create(BUTTON_BACK_N_PATH,BUTTON_BACK_S_PATH)
    backButton:setAnchorPoint(0,0)
    backButton:setScale(0.7)
    backButton:setScale9Enabled(true)
    backButton:setPosition(0,650)
    backButton:addClickEventListener(function(sender, eventType)
		--local Loginscene=require("D:/quick-cocos2dx-community/test/src/app/scenes/RegisterScene.lua")
        --local transition=display.wrapSceneWithTransition(Loginscene,"fade",0.5)
        --display.replaceScene()
        app:enterScene("MainScene", nil, "fade", 0.8)

	end)
    backButton:setPressedActionEnabled(true)
    self:add(backButton)
end

return SettingScene