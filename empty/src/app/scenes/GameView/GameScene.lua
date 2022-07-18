--[[--
    GameSceneScene.lua
    战斗场景
]]
local Music = require("app/data/Music")
local SettingMusic = require("src/app/scenes/SettingMusic")
local EventDef = require("app.def.EventDef.lua")
local EventManager = require("app/manager/EventManager.lua")
local GameScene = class("GameScene", function()
    return display.newScene("GameScene")
end)
local PlayView = require("app/scenes/GameView/ui/PlayView")
--[[--
    构造函数

    @param none

    @return none
]]
function GameScene:ctor()
    self.playView_ = PlayView.new() -- 类型：PlayView，主游戏界面
    self:addChild(self.playView_)
    --audio.playEffect("sounds/fireEffect.ogg", false))
    self:addNodeEventListener(cc.NODE_ENTER_FRAME_EVENT, handler(self, self.update))
    self:performWithDelay(function() 
        self:scheduleUpdate()
    end, 1)
end
--[[--
    帧循环

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function GameScene:update(dt)
    --GameData:update(dt)
    self.playView_:update(dt)
end
function GameScene:onEnter()
    EventManager:regListener(EventDef.ID.SCORE_SHOW_1, self, function()
        --音效
        local MusicOn = SettingMusic:isMusic1()
        print(MusicOn)
        if MusicOn == true then
            local audio = require("framework.audio")
            audio.loadFile(Music.SCORESHOW[1], function ()
                audio.playEffect(Music.SCORESHOW[1])
            end)
        else
            local audio = require("framework.audio")
            audio.loadFile(Music.SCORESHOW[1], function ()
                audio.stopEffect()
            end)
        end
    end)

    EventManager:regListener(EventDef.ID.SCORE_SHOW_2, self, function()
        --音效
        local MusicOn = SettingMusic:isMusic1()
        print(MusicOn)
        if MusicOn == true then
            local audio = require("framework.audio")
            audio.loadFile(Music.SCORESHOW[2], function ()
                audio.playEffect(Music.SCORESHOW[2])
            end)
        else
            local audio = require("framework.audio")
            audio.loadFile(Music.SCORESHOW[2], function ()
                audio.stopEffect()
            end)
        end
    end)

    EventManager:regListener(EventDef.ID.SCORE_SHOW_3, self, function()
        --音效
        local MusicOn = SettingMusic:isMusic1()
        print(MusicOn)
        if MusicOn == true then
            local audio = require("framework.audio")
            audio.loadFile(Music.SCORESHOW[3], function ()
                audio.playEffect(Music.SCORESHOW[3])
            end)
        else
            local audio = require("framework.audio")
            audio.loadFile(Music.SCORESHOW[3], function ()
                audio.stopEffect()
            end)
        end
    end)

    EventManager:regListener(EventDef.ID.INTO_GAME, self, function()
        --音效
        local MusicOn = SettingMusic:isMusic1()
        print(MusicOn)
        if MusicOn == true then
            local audio = require("framework.audio")
            audio.loadFile(Music.INGAME[1], function ()
                audio.playEffect(Music.INGAME[1])
            end)
        else
            local audio = require("framework.audio")
            audio.loadFile(Music.INGAME[1], function ()
                audio.stopEffect()
            end)
        end
    end)

    EventManager:regListener(EventDef.ID.SELECT_BOSS, self, function()
        --音效
        local MusicOn = SettingMusic:isMusic1()
        print(MusicOn)
        if MusicOn == true then
            local audio = require("framework.audio")
            audio.loadFile(Music.INGAME[2], function ()
                audio.playEffect(Music.INGAME[2])
            end)
        else
            local audio = require("framework.audio")
            audio.loadFile(Music.INGAME[2], function ()
                audio.stopEffect()
            end)
        end
    end)

    EventManager:regListener(EventDef.ID.CONFIRM_BOSS, self, function()
        --音效
        local MusicOn = SettingMusic:isMusic1()
        print(MusicOn)
        if MusicOn == true then
            local audio = require("framework.audio")
            audio.loadFile(Music.INGAME[3], function ()
                audio.playEffect(Music.INGAME[3])
            end)
        else
            local audio = require("framework.audio")
            audio.loadFile(Music.INGAME[3], function ()
                audio.stopEffect()
            end)
        end
    end)

    EventManager:regListener(EventDef.ID.BOSS_SHOW, self, function()
        --音效
        local MusicOn = SettingMusic:isMusic1()
        print(MusicOn)
        if MusicOn == true then
            local audio = require("framework.audio")
            audio.loadFile(Music.INGAME[4], function ()
                audio.playEffect(Music.INGAME[4])
            end)
        else
            local audio = require("framework.audio")
            audio.loadFile(Music.INGAME[4], function ()
                audio.stopEffect()
            end)
        end
    end)

    EventManager:regListener(EventDef.ID.TOWER_BUILD, self, function()
        --音效
        local MusicOn = SettingMusic:isMusic1()
        print(MusicOn)
        if MusicOn == true then
            local audio = require("framework.audio")
            audio.loadFile(Music.INGAME[5], function ()
                audio.playEffect(Music.INGAME[5])
            end)
        else
            local audio = require("framework.audio")
            audio.loadFile(Music.INGAME[5], function ()
                audio.stopEffect()
            end)
        end
    end)

    EventManager:regListener(EventDef.ID.TOWER_COMPOSE, self, function()
        --音效
        local MusicOn = SettingMusic:isMusic1()
        print(MusicOn)
        if MusicOn == true then
            local audio = require("framework.audio")
            audio.loadFile(Music.INGAME[6], function ()
                audio.playEffect(Music.INGAME[6])
            end)
        else
            local audio = require("framework.audio")
            audio.loadFile(Music.INGAME[6], function ()
                audio.stopEffect()
            end)
        end
    end)

    EventManager:regListener(EventDef.ID.TOWER_ATK, self, function()
        --音效
        local MusicOn = SettingMusic:isMusic1()
        print(MusicOn)
        if MusicOn == true then
            local audio = require("framework.audio")
            audio.loadFile(Music.INGAME[7], function ()
                audio.playEffect(Music.INGAME[7])
            end)
        else
            local audio = require("framework.audio")
            audio.loadFile(Music.INGAME[7], function ()
                audio.stopEffect()
            end)
        end
    end)

    EventManager:regListener(EventDef.ID.TOWER_ATK_HIT, self, function()
        --音效
        local MusicOn = SettingMusic:isMusic1()
        print(MusicOn)
        if MusicOn == true then
            local audio = require("framework.audio")
            audio.loadFile(Music.INGAME[8], function ()
                audio.playEffect(Music.INGAME[8])
            end)
        else
            local audio = require("framework.audio")
            audio.loadFile(Music.INGAME[8], function ()
                audio.stopEffect()
            end)
        end
    end)

    EventManager:regListener(EventDef.ID.WIN, self, function()
        --音效
        local MusicOn = SettingMusic:isMusic1()
        print(MusicOn)
        if MusicOn == true then
            local audio = require("framework.audio")
            audio.loadFile(Music.INGAME[9], function ()
                audio.playEffect(Music.INGAME[9])
            end)
        else
            local audio = require("framework.audio")
            audio.loadFile(Music.INGAME[9], function ()
                audio.stopEffect()
            end)
        end
    end)


    EventManager:regListener(EventDef.ID.GET_AWRADS, self, function()
        --音效
        local MusicOn = SettingMusic:isMusic1()
        print(MusicOn)
        if MusicOn == true then
            local audio = require("framework.audio")
            audio.loadFile(Music.INGAME[10], function ()
                audio.playEffect(Music.INGAME[10])
            end)
        else
            local audio = require("framework.audio")
            audio.loadFile(Music.INGAME[10], function ()
                audio.stopEffect()
            end)
        end
    end)

    EventManager:regListener(EventDef.ID.LOSE, self, function()
        --音效
        local MusicOn = SettingMusic:isMusic1()
        print(MusicOn)
        if MusicOn == true then
            local audio = require("framework.audio")
            audio.loadFile(Music.INGAME[11], function ()
                audio.playEffect(Music.INGAME[11])
            end)
        else
            local audio = require("framework.audio")
            audio.loadFile(Music.INGAME[11], function ()
                audio.stopEffect()
            end)
        end
    end)




end

function GameScene:onExit()
end

return GameScene