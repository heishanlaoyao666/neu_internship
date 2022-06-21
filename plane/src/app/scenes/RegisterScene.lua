local defaults = cc.UserDefault:getInstance()
local SystemConst = require("app.utils.SystemConst")
require("app.utils.Function")

local RegisterScene = class("RegisterScene", function()
    return display.newScene("RegisterScene")
end)

function RegisterScene:ctor()

    self.size = cc.Director:getInstance():getWinSize()
    -- 背景
    local bg = cc.Sprite:create(SystemConst.MENU_BG_NAME)
    bg:setPosition(cc.p(self.size.width/2, self.size.height/2))
    bg:setScale(0.8, 0.8)
    self:addChild(bg)

    -- 提示信息
    self.infoLabel = display.newTTFLabel({
        text = "请输入合法的用户名!",
        font = "Marker Felt",
        size = 18,
        color = cc.c3b(255, 0, 0)
    })

    --self.infoLabel:align(cc.p(display.CENTER, display.cx, 3 * self.size.height/5))
    self.infoLabel:setPosition(cc.p(display.cx, 3 * self.size.height/5))
    self.infoLabel:addTo(self)
    self.infoLabel:setVisible(false)

    -- EditBox
    self.editText = ccui.EditBox:create(cc.size(self.size.width / 1.7, 30), nil, 50)
    self.editText:setName("InputText")
    self.editText:setAnchorPoint(cc.p(0.5, 0.5))
    self.editText:setPosition(cc.p(self.infoLabel:getPositionX(), self.infoLabel:getPositionY() - 50))
    self.editText:setMaxLength(6)
    self.editText:setBright(true)
    self.editText:setFontSize(24)
    self.editText:setPlaceHolder("   请输入您的昵称:")

    
    -- object, z, tag
    self:addChild(self.editText, 5)

    -- 注册按钮

    local registerImages = {
        normal = SystemConst.REGISTER_BUTTON_NORMAL,
        pressed = SystemConst.REGISTER_BUTTON_PRESSED,
        disabled = SystemConst.REGISTER_BUTTON_DISABLED
    }

    self.registerBtn = ccui.Button:create(registerImages["normal"], registerImages["pressed"], registerImages["disabled"])
    self.registerBtn:setAnchorPoint(cc.p(0.5 ,0.5))
    -- 居中
    self.registerBtn:setPosition(cc.p(self.infoLabel:getPositionX(), self.infoLabel:getPositionY() - 100))
    -- 设置缩放程度
    self.registerBtn:setScale(1 / 700 * self.size.width, 1 / 700 * self.size.width)
    -- 设置是否禁用(false为禁用)
    self.registerBtn:setEnabled(true)
    self.registerBtn:addClickEventListener(function()
        local name = self.editText:getText()
        if(name ~= nil and name ~= "") then
            print("Register场景被Main场景替换...")
            defaults:setIntegerForKey("id", getUUID())
            defaults:setStringForKey("name", name)
            cc.Director:getInstance():replaceScene(require("app.scenes.Mainscene").new())
        else
            self.infoLabel:setVisible(true)
            print("Wrong name!")
        end
    end)

    self:addChild(self.registerBtn, 4)
end

function RegisterScene:onEnter()
end

function RegisterScene:onExit()
end

return RegisterScene
