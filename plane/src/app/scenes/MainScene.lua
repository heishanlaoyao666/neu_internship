--- 主页面
local SystemConst = require("app.utils.SystemConst")
local defaults = cc.UserDefault:getInstance()
local audio = require("framework.audio")


local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()

    self.size = cc.Director:getInstance():getWinSize()

    -- 音乐
    if defaults:getBoolForKey(SystemConst.MUSIC_KEY) then
        audio.loadFile(SystemConst.INDEX_BG_MUSIC, function ()
            audio.playBGM(SystemConst.INDEX_BG_MUSIC)
        end)
    end

    -- 背景
    self.bg = cc.Sprite:create(SystemConst.MENU_BG_NAME)
    self.bg:setPosition(cc.p(self.size.width/2, self.size.height/2))
    self.bg:setScale(0.8, 0.8)
    self:addChild(self.bg)

    -- 新游戏
    local newGameImages = {
        normal =  SystemConst.INDEX_BUTTON_NEW_GAME_NORMAL,
        pressed = SystemConst.INDEX_BUTTON_NEW_GAME_PRESSED,
        disabled = SystemConst.INDEX_BUTTON_NEW_GAME_DISABLED
    }

    self.newBtn = ccui.Button:create(newGameImages["normal"], newGameImages["pressed"], newGameImages["disabled"])
    self.newBtn:setAnchorPoint(cc.p(0.5 ,0.5))
    -- 居中
    self.newBtn:setPosition(cc.p(display.cx, 3 * self.size.height / 5))
    -- 设置缩放程度
    self.newBtn:setScale(1 / 700 * self.size.width, 1 / 700 * self.size.width)
    -- 设置是否禁用(false为禁用)
    self.newBtn:setEnabled(true)
    self.newBtn:addClickEventListener(function ()
        print("进入到GamePlay场景...")

        if defaults:getBoolForKey(SystemConst.SOUND_KEY) then
            audio.loadFile(SystemConst.BUTTON_EFFECT, function ()
                audio.playEffect(SystemConst.BUTTON_EFFECT, false)
            end)
        end

        defaults:setBoolForKey("flag", false)

        cc.Director:getInstance():pushScene(require("app.scenes.GamePlayScene").new())
    end)

    self:addChild(self.newBtn, 4)

    -- 继续
    local resumeImages = {
        normal = SystemConst.INDEX_BUTTON_RESUME_NORMAL,
        pressed = SystemConst.INDEX_BUTTON_RESUME_PRESSED,
        disabled = SystemConst.INDEX_BUTTON_RESUME_DISABLED
    }

    self.resumeBtn = ccui.Button:create(resumeImages["normal"], resumeImages["pressed"], resumeImages["disabled"])
    self.resumeBtn:setAnchorPoint(cc.p(0.5 ,0.5))
    -- 居中
    self.resumeBtn:setPosition(cc.p(self.newBtn:getPositionX(), self.newBtn:getPositionY() - 50))
    -- 设置缩放程度
    self.resumeBtn:setScale(1 / 700 * self.size.width, 1 / 700 * self.size.width)
    -- 设置是否禁用(false为禁用)
    self.resumeBtn:setEnabled(defaults:getBoolForKey(SystemConst.IF_CONTINUE))
    self.resumeBtn:addClickEventListener(function ()

        if defaults:getBoolForKey(SystemConst.SOUND_KEY) then
            audio.loadFile(SystemConst.BUTTON_EFFECT, function ()
                audio.playEffect(SystemConst.BUTTON_EFFECT, false)
            end)
        end

        if defaults:getBoolForKey(SystemConst.IF_CONTINUE) then
            defaults:setBoolForKey(SystemConst.IF_CONTINUE, true)
            cc.Director:getInstance():popScene()
        end
    end)

    self:addChild(self.resumeBtn, 4)

    -- 排行榜
    local rankImages = {
        normal = SystemConst.INDEX_BUTTON_RANK_NORMAL,
        pressed = SystemConst.INDEX_BUTTON_RANK_PRESSED,
        disabled = SystemConst.INDEX_BUTTON_RANK_DISABLED
    }

    self.rankBtn = ccui.Button:create(rankImages["normal"], rankImages["pressed"], rankImages["disabled"])
    self.rankBtn:setAnchorPoint(cc.p(0.5 ,0.5))
    self.rankBtn:setPosition(cc.p(self.newBtn:getPositionX(), self.newBtn:getPositionY() - 100))
    -- 设置缩放程度
    self.rankBtn:setScale(1 / 700 * self.size.width, 1 / 700 * self.size.width)
    -- 设置是否禁用(false为禁用)
    self.rankBtn:setEnabled(true)
    self.rankBtn:addClickEventListener(function ()

        if defaults:getBoolForKey(SystemConst.SOUND_KEY) then
            audio.loadFile(SystemConst.BUTTON_EFFECT, function ()
                audio.playEffect(SystemConst.BUTTON_EFFECT, false)
            end)
        end

        cc.Director:getInstance():pushScene(require("app.scenes.RankScene").new())
    end)

    self:addChild(self.rankBtn, 4)

    -- 设置
    local settingsImages = {
        normal = SystemConst.INDEX_BUTTON_SETTINGS_NORMAL,
        pressed = SystemConst.INDEX_BUTTON_SETTINGS_PRESSED,
        disabled = SystemConst.INDEX_BUTTON_SETTINGS_DISABLED
    }

    self.settingsBtn = ccui.Button:create(settingsImages["normal"], settingsImages["pressed"], settingsImages["disabled"])
    self.settingsBtn:setAnchorPoint(cc.p(0.5 ,0.5))
    -- 居中
    self.settingsBtn:setPosition(cc.p(self.newBtn:getPositionX(), self.newBtn:getPositionY() - 150))
    -- 设置缩放程度
    self.settingsBtn:setScale(1 / 700 * self.size.width, 1 / 700 * self.size.width)
    -- 设置是否禁用(false为禁用)
    self.settingsBtn:setEnabled(true)
    self.settingsBtn:addClickEventListener(function ()

        if defaults:getBoolForKey(SystemConst.SOUND_KEY) then
            audio.loadFile(SystemConst.BUTTON_EFFECT, function ()
                audio.playEffect(SystemConst.BUTTON_EFFECT, false)
            end)
        end

        cc.Director:getInstance():pushScene(require("app.scenes.SettingScene").new())
    end)

    self:addChild(self.settingsBtn, 4)

end

function MainScene:onEnter()
end

function MainScene:onExit()
end

return MainScene
