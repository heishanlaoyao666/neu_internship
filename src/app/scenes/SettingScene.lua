local SettingScene =
    class(
    "SettingScene",
    function()
        return display.newScene("SettingScene")
    end
)
--- local
local musicKey = cc.UserDefault:getInstance():getBoolForKey(ConstantsUtil.MUSIC_KEY, true)
local effectKey = cc.UserDefault:getInstance():getBoolForKey(ConstantsUtil.EFFECT_KEY, true)
---

function SettingScene:ctor()
end

function SettingScene:onEnter()
    local settingScene = cc.CSLoader:getInstance():createNodeWithFlatBuffersFile("SettingScene.csb"):addTo(self, 1)
    local bg = ccui.Helper:seekWidgetByName(settingScene, ConstantsUtil.BACKGROUND)
    ccui.Helper:doLayout(bg)

    local musicControlButton = tolua.cast(ccui.Helper:seekWidgetByName(settingScene, "music_control"), "ccui.Button")
    if ~musicKey then
        --- 如果处于关闭状态 替换成关闭的样子
        musicControlButton:loadTextures(ConstantsUtil.PATH_SETTING_CLOSE_PNG, ConstantsUtil.PATH_SETTING_CLOSE_PNG)
    end
    musicControlButton:addTouchEventListener(
        function(ref, event)
            Log.i("musicControlButton")
            if cc.EventCode.BEGAN == event then
                --- 按下
                Log.i("begin")
            elseif cc.EventCode.ENDED == event then
                --- 松开
                Log.i("end")
                --- 判断当前音乐情况
                --- 配置音乐
                if musicKey then
                    --- 当前开启 点击后关闭
                    musicControlButton:loadTextures(ConstantsUtil.PATH_SETTING_CLOSE_PNG, ConstantsUtil.PATH_SETTING_CLOSE_PNG)
                    musicKey = false
                else
                    --- 当前关闭 点击后开启
                    musicControlButton:loadTextures(ConstantsUtil.PATH_SETTING_OPEN_PNG, ConstantsUtil.PATH_SETTING_OPEN_PNG)
                    musicKey = true
                end
            end
        end
    )

    local effectControlButton = tolua.cast(ccui.Helper:seekWidgetByName(settingScene, "effect_control"), "ccui.Button")
    if ~effectKey then
        --- 如果处于关闭状态 替换成关闭的样子
        effectControlButton:loadTextures("ui/setting/soundon2_cover.png", "ui/setting/soundon2_cover.png")
    end
    effectControlButton:addTouchEventListener(
        function(ref, event)
            Log.i("effectControlButton")
            if cc.EventCode.BEGAN == event then
                --- 按下
                Log.i("begin")
            elseif cc.EventCode.ENDED == event then
                --- 松开
                Log.i("end")
                --- 判断当前音效是怎样的
                --- 配置音效
                if effectKey then
                    --- 当前开启 点击后关闭
                    effectControlButton:loadTextures("ui/setting/soundon2_cover.png", "ui/setting/soundon2_cover.png")
                    effectKey = false
                else
                    --- 当前关闭 点击后开启
                    effectControlButton:loadTextures("ui/setting/soundon1_cover.png", "ui/setting/soundon1_cover.png")
                    effectKey = true
                end
            end
        end
    )

    local backButton = tolua.cast(ccui.Helper:seekWidgetByName(settingScene, "back"), "ccui.Button")
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

function SettingScene:onExit()
    cc.UserDefault:setBoolForKey(ConstantsUtil.MUSIC_KEY, musicKey)
    cc.UserDefault:setBoolForKey(ConstantsUtil.EFFECT_KEY, effectKey)
end

return SettingScene
