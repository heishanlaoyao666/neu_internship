local MenuScene =
    class(
    "MenuScene",
    function()
        return display.newScene("MenuScene")
    end
)
---local

---

function MenuScene:ctor()
end

function MenuScene:onEnter()
    local menuScene = CSLoader:createNodeWithFlatBuffersFile("MenuScene.csb"):addTo(self, 1)
    local bg = ccui.Helper:seekWidgetByName(menuScene, "background")
    ccui.Helper:doLayout(bg)

    local rankButton = tolua.cast(ccui.Helper:seekWidgetByName(menuScene, "rank"), "ccui.Button")
    rankButton:addTouchEventListener(
        function(ref, event)
            Log.i("rankButton")
            if effectKey then
                Audio.playEffectSync(ConstantsUtil.PATH_BUTTON_EFFECT, false)
            end
            if cc.EventCode.BEGAN == event then
                --- 按下
                Log.i("begin")
            elseif cc.EventCode.ENDED == event then
                --- 松开
                Log.i("end")
                nowScene = import("app.scenes.RankScene").new()
                display.replaceScene(nowScene)
            end
        end
    )

    local settingButton = tolua.cast(ccui.Helper:seekWidgetByName(menuScene, "setting"), "ccui.Button")
    settingButton:addTouchEventListener(
        function(ref, event)
            Log.i("settingButton")
            if effectKey then
                Audio.playEffectSync(ConstantsUtil.PATH_BUTTON_EFFECT, false)
            end
            if cc.EventCode.BEGAN == event then
                --- 按下
                Log.i("begin")
            elseif cc.EventCode.ENDED == event then
                --- 松开
                Log.i("end")
                nowScene = import("app.scenes.SettingScene").new()
                display.replaceScene(nowScene)
            end
        end
    )

    local newGameButton = tolua.cast(ccui.Helper:seekWidgetByName(menuScene, "new_game"), "ccui.Button")
    newGameButton:addTouchEventListener(
        function(ref, event)
            Log.i("newGameButton")
            if effectKey then
                Audio.playEffectSync(ConstantsUtil.PATH_BUTTON_EFFECT, false)
            end
            if cc.EventCode.BEGAN == event then
                --- 按下
                Log.i("begin")
            elseif cc.EventCode.ENDED == event then
                --- 松开
                Log.i("end")
                ConstantsUtil.bulletArray = {}
                ConstantsUtil.enemyArray = {}
                nowScene = import("app.scenes.GameScene").new()
                display.replaceScene(nowScene)
            end
        end
    )

    local continueButton = tolua.cast(ccui.Helper:seekWidgetByName(menuScene, "continue"), "ccui.Button")
    continueButton:addTouchEventListener(
        function(ref, event)
            if effectKey then
                Audio.playEffectSync(ConstantsUtil.PATH_BUTTON_EFFECT, false)
            end
            if cc.EventCode.BEGAN == event then
                --- 按下
            elseif cc.EventCode.ENDED == event then
                --- 松开
                if ConstantsUtil.myRoleSave == nil then
                    Log.i("lastGame is nil.")
                else
                    nowScene = import("app.scenes.GameScene").new()
                    nowScene:setMyRole(ConstantsUtil.myRoleSave)
                    display.replaceScene(nowScene)
                end
            end
        end
    )
end

function MenuScene:onExit()
end

return MenuScene
