local RankScene =
    class(
    "RankScene",
    function()
        return display.newScene("RankScene")
    end
)

---local
local musicKey = cc.UserDefault:getInstance():getBoolForKey("music_key", true)
local effectKey = cc.UserDefault:getInstance():getBoolForKey("effect_key", true)
---

function RankScene:ctor()
end

function RankScene:onEnter()
    local rankScene = cc.CSLoader:getInstance():createNodeWithFlatBuffersFile("RankScene.csb"):addTo(self, 1)
    local bg = ccui.Helper:seekWidgetByName(rankScene, "background")
    ccui.Helper:doLayout(bg)

    local backButton = tolua.cast(ccui.Helper:seekWidgetByName(rankScene, "back"), "ccui.Button")
    backButton:addTouchEventListener(
        function(ref, event)
            Log.i("backButton")
            if cc.EventCode.BEGAN == event then
                --- 按下
                Log.i("begin")
            elseif cc.EventCode.ENDED == event then
                --- 松开
                Log.i("end")
                local menuScene = import("app.scenes.MenuScene").new()
                display.replaceScene(menuScene)
            end
        end
    )
end

function RankScene:onExit()
end

return RankScene
