local SettingScene =
    class(
    "SettingScene",
    function()
        return display.newScene("SettingScene")
    end
)
--- local

---

function SettingScene:ctor()
end

function SettingScene:onEnter()
    local settingScene = CSLoader:createNodeWithFlatBuffersFile("SettingScene.csb"):addTo(self, 1)
    local bg = ccui.Helper:seekWidgetByName(settingScene, ConstantsUtil.BACKGROUND)
    ccui.Helper:doLayout(bg)

    local musicControlButton = tolua.cast(ccui.Helper:seekWidgetByName(settingScene, "music_control"), "ccui.Button")
    if musicKey == false then
        --- 如果处于关闭状态 替换成关闭的样子
        --- TODO loadTextures出来的按钮背景会变得尺寸错误 csb文件里面设置的就没问题
        musicControlButton:loadTextures(ConstantsUtil.PATH_SETTING_CLOSE_PNG, ConstantsUtil.PATH_SETTING_CLOSE_PNG)
    end
    musicControlButton:addTouchEventListener(
        function(ref, event)
            Log.i("musicControlButton")
            if effectKey then
                Audio.playEffectSync(ConstantsUtil.PATH_BUTTON_EFFECT, false)
            end
            if cc.EventCode.BEGAN == event then
                --- 按下
                Log.i("begin")
            elseif cc.EventCode.ENDED == event then
                --- 松开
                Log.i("end")
                --- 判断当前音乐情况
                --- 配置音乐
                if musicKey == true then
                    --- 当前开启 点击后关闭
                    Audio.stopBGM()
                    musicControlButton:loadTextures(
                        ConstantsUtil.PATH_SETTING_CLOSE_PNG,
                        ConstantsUtil.PATH_SETTING_CLOSE_PNG
                    )
                    musicKey = false
                else
                    --- 当前关闭 点击后开启
                    Audio.playBGM(ConstantsUtil.PATH_MAIN_MUSIC, true)
                    musicControlButton:loadTextures(
                        ConstantsUtil.PATH_SETTING_OPEN_PNG,
                        ConstantsUtil.PATH_SETTING_OPEN_PNG
                    )
                    musicKey = true
                end
            end
        end
    )

    local effectControlButton = tolua.cast(ccui.Helper:seekWidgetByName(settingScene, "effect_control"), "ccui.Button")
    --- 如果这里用 ~effectKey 就会出现找不到这个类的错误
    if effectKey == false then
        --- 如果处于关闭状态 替换成关闭的样子
        effectControlButton:loadTextures(ConstantsUtil.PATH_SETTING_CLOSE_PNG, ConstantsUtil.PATH_SETTING_CLOSE_PNG)
    end
    effectControlButton:addTouchEventListener(
        function(ref, event)
            Log.i("effectControlButton")
            if effectKey then
                Audio.playEffectSync(ConstantsUtil.PATH_BUTTON_EFFECT, false)
            end
            if cc.EventCode.BEGAN == event then
                --- 按下
                Log.i("begin")
            elseif cc.EventCode.ENDED == event then
                --- 松开
                Log.i("end")
                --- 判断当前音效是怎样的
                --- 配置音效
                if effectKey == true then
                    --- 当前开启 点击后关闭
                    effectControlButton:loadTextures(
                        ConstantsUtil.PATH_SETTING_CLOSE_PNG,
                        ConstantsUtil.PATH_SETTING_CLOSE_PNG
                    )
                    effectKey = false
                else
                    --- 当前关闭 点击后开启
                    effectControlButton:loadTextures(
                        ConstantsUtil.PATH_SETTING_OPEN_PNG,
                        ConstantsUtil.PATH_SETTING_OPEN_PNG
                    )
                    effectKey = true
                end
            end
        end
    )

    local backButton = tolua.cast(ccui.Helper:seekWidgetByName(settingScene, "back"), "ccui.Button")
    backButton:addTouchEventListener(
        function(ref, event)
            Log.i("backButton")
            if effectKey then
                Audio.playEffectSync(ConstantsUtil.PATH_BUTTON_EFFECT, false)
            end
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
    Log.i("OnExit")
    UserDefault:setBoolForKey(ConstantsUtil.MUSIC_KEY, musicKey)
    UserDefault:setBoolForKey(ConstantsUtil.EFFECT_KEY, effectKey)
end

return SettingScene
