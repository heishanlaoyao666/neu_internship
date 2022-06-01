---require
-- require("AudioEngine")
---
local MainScene =
    class(
    "MainScene",
    function()
        return display.newScene("MainScene")
    end
)
---local

---
function MainScene:ctor()
end

function MainScene:onEnter()
    --- 由于找不到cs中的editbox,这个页面用自己拼的
    local bg = cc.Sprite:create(ConstantsUtil.PATH_BG_JPG)
    bg:setPosition(cc.p(WinSize.width / 2, WinSize.height / 2))
    bg:setAnchorPoint(0.5, 0.5)
    bg:addTo(self)

    local nicknameField = ccui.EditBox:create(cc.size(0.4 * WinSize.width, 0.05 * WinSize.height), nil, 0)
    nicknameField:setMaxLength(6) --设置输入最大长度为6
    nicknameField:setText("请输入昵称")
    nicknameField:setFont("ui/font/FontNormal.ttf", 22)
    nicknameField:setPosition(cc.p(WinSize.width * 0.5, WinSize.height * 0.5))
    nicknameField:setAnchorPoint(0.5, 0.5)
    nicknameField:registerScriptEditBoxHandler(
        function(eventType)
            if eventType == "began" then
                -- triggered when an edit box gains focus after keyboard is shown
            elseif eventType == "ended" then
                -- triggered when an edit box loses focus after keyboard is hidden.
            elseif eventType == "changed" then
                -- triggered when the edit box text was changed.
                print("cur text is ", nicknameField:getText())
            elseif eventType == "return" then
            -- triggered when the return button was pressed or the outside area of keyboard was touched.
            end
        end
    )
    nicknameField:addTo(self)

    local registerButton = ccui.Button:create("ui/register/register.png", "ui/register/register.png")
    registerButton:setContentSize(WinSize.width * 0.3, WinSize.height * 0.681)
    registerButton:setPosition(cc.p(WinSize.width * 0.5, WinSize.height * 0.7))
    registerButton:setAnchorPoint(0.5, 0.5)
    registerButton:setTitleText("")
    registerButton:addTouchEventListener(
        function(ref, event)
            Log.i("registerButton")
            if cc.EventCode.BEGAN == event then
                --- 按下
                Log.i("begin")
            elseif cc.EventCode.ENDED == event then
                --- 松开
                Log.i("end")
                ---TODO 加上对昵称是否位为空的判断
                Log.i(nicknameField:getText())
                local nickname = nicknameField:getText()
                if nickname == "请输入昵称" or nickname == "" then
                    --- TODO 用一个小窗口提示请输入昵称
                    Log.i("请输入昵称")
                else
                    --- 把用户名存起来
                    local menuScene = import("app.scenes.MenuScene").new()
                    display.replaceScene(menuScene)
                end
            end
        end
    )
    registerButton:addTo(self)

    -- local registerScene = cc.CSLoader:getInstance():createNodeWithFlatBuffersFile("RegisterScene.csb"):addTo(self, 1)
    -- local bg = ccui.Helper:seekWidgetByName(registerScene, "background")
    -- --- 这样拿到之后好像类型不对 但是转换会导致视图与对象不匹配
    -- local nicknameField = ccui.EditBox:create(cc.size(0.4 * size.width, 0.05 * size.height), "zMine/editBox.png", 0)
    -- --- local nicknameField = tolua.cast(ccui.Helper:seekWidgetByName(registerScene, "nickname"), "ccui.TextField")
    -- -- nicknameField = tolua.cast(nicknameField, )
    -- --- nicknameField:setReturnType(cc.KEYBOARD_RETURNTYPE_DsONE)
    -- --- nicknameField:setInputMode(cc.EDITEDITBOX_INPUT_MODE_NUMERIC)

    -- self:addChild(nicknameField)
    -- local registerButton = tolua.cast(ccui.Helper:seekWidgetByName(registerScene, "register"), "ccui.Button")
    -- ccui.Helper:doLayout(bg)
    -- --- listener
    -- registerButton:addTouchEventListener(
    --     function(ref, event)
    --         Log.i("registerButton")
    --         if cc.EventCode.BEGAN == event then
    --             --- 按下
    --             Log.i("begin")
    --         elseif cc.EventCode.ENDED == event then
    --             --- 松开
    --             Log.i("end")
    --             ---TODO 加上对昵称是否位为空的判断
    --             Log.i(nicknameField:getText())
    --             if nicknameField:getText() == "" then
    --                 --- 提示请输入昵称
    --                 Log.i("请输入昵称")
    --             else
    --                 --- 把用户名存起来
    --                 local menuScene = import("app.scenes.MenuScene").new()
    --                 display.replaceScene(menuScene)
    --             end
    --         end
    --     end
    -- )

    -- button layer

    -- local editText = ccui.EditBox:create(cc.size(350, 50), nil, 0)
    -- --- 推测第二个参数是背景图，第三个参数是好像没什么影响
    -- editText:setName("inputTxt")
    -- editText:setAnchorPoint(0.5, 0.5)
    -- editText:setPosition(240, 400)
    -- editText:setFontSize(25)
    -- editText:setPlaceHolder("请输入昵称")
    -- self:addChild(editText)

    -- local registerButton = ccui.MenuItemImage:create("ui/register/register.png")
    -- registerButton:setName("register")
    -- registerButton:setAnchorPoint(0.5, 0.5)
    -- registerButton:setPosition(240, 300)
    -- self:addChild(registerButton)
end

function MainScene:playMusic() 
    
end

function MainScene:onExit()
end

return MainScene
