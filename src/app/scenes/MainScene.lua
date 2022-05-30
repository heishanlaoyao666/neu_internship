local MainScene =
    class(
    "MainScene",
    function()
        return display.newScene("MainScene")
    end
)

local size = cc.Director:getInstance():getWinSize()

function MainScene:ctor()
    -- local label =
    --     display.newTTFLabel(
    --     {
    --         text = "Hello, World",
    --         size = 64
    --     }
    -- )
    -- label:align(display.CENTER, display.cx, display.cy)
    -- label:addTo(self)
end

function MainScene:onEnter()
    local registerScene =
        cc.CSLoader:getInstance():createNodeWithFlatBuffersFile("RegisterScene.csb"):addTo(self, 1)
    local bg = ccui.Helper:seekWidgetByName(registerScene, "background")
    -- bg:setContentSize(size)
    ccui.Helper:doLayout(bg)

    -- local bg = cc.Sprite:create("ui/main/bg_menu.jpg")
    -- bg:setPosition(cc.p(size.width / 2, size.height / 2))
    -- self:addChild(bg)

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

function MainScene:onExit()
end

return MainScene
