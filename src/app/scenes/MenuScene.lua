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
            if cc.EventCode.BEGAN == event then
                --- 按下
                Log.i("begin")
            elseif cc.EventCode.ENDED == event then
                --- 松开
                Log.i("end")
                local rankScene = import("app.scenes.RankScene").new()
                display.replaceScene(rankScene)
            end
        end
    )

    local settingButton = tolua.cast(ccui.Helper:seekWidgetByName(menuScene, "setting"), "ccui.Button")
    settingButton:addTouchEventListener(
        function(ref, event)
            Log.i("settingButton")
            if cc.EventCode.BEGAN == event then
                --- 按下
                Log.i("begin")
            elseif cc.EventCode.ENDED == event then
                --- 松开
                Log.i("end")
                local settingScene = import("app.scenes.SettingScene").new()
                display.replaceScene(settingScene)
            end
        end
    )

    local newGameButton = tolua.cast(ccui.Helper:seekWidgetByName(menuScene, "new_game"), "ccui.Button")
    newGameButton:addTouchEventListener(
        function(ref, event)
            Log.i("newGameButton")
            if cc.EventCode.BEGAN == event then
                --- 按下
                Log.i("begin")
            elseif cc.EventCode.ENDED == event then
                --- 松开
                Log.i("end")
                local newGameScene = import("app.scenes.GameScene").new()
                display.replaceScene(newGameScene)
            end
        end
    )
end

function MenuScene:onExit()
end

return MenuScene
