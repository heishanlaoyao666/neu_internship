--[[
    LogInAndRegisterScene.lua
    描述：登录注册界面
    编写：张昊煜
    修订：李昊
    检查：周星宇
]]
local LogInAndRegisterScene = class("LogInAndRegisterScene", function()
    return display.newScene("LogInAndRegisterScene")
end)

local TCP = require("app.network.TCP")
local DialogView = require("app.ui.view.logInAndRegister.DialogView")
local LoginErrDialog = require("app.ui.view.logInAndRegister.LoginErrDialog")
local RegisterSucceedDialog = require("app.ui.view.logInAndRegister.RegisterSucceedDialog")
local MsgManager = require("app.manager.MsgManager")
local EventManager = require("app.manager.EventManager")
local EventDef = require("app.def.EventDef")
local MsgDef = require("app.def.MsgDef")
local PlayerData = require("app.data.PlayerData")
local DialogManager = require("app.manager.DialogManager")

--[[--
    构造函数

    @param none

    @return none
]]
function LogInAndRegisterScene:ctor()



    -- 开屏背景 - 1280 * 720
    local indexBG = display.newSprite("image/loading/loading_bg.jpg")
    indexBG:setAnchorPoint(0.5, 0.5)
    indexBG:setPosition(display.cx, display.cy)
    self:addChild(indexBG)

    --判断本地是否有用户数据，如果有，则直接使用本地数据进入Lobby场景
    local info = {
        cc.UserDefault:getInstance():getStringForKey("nick"),
        cc.UserDefault:getInstance():getStringForKey("pwd"),
        cc.UserDefault:getInstance():getStringForKey("pid")
    }
    local nick = cc.UserDefault:getInstance():getStringForKey("nick")
    local pwd = cc.UserDefault:getInstance():getStringForKey("pwd")
    local pid = cc.UserDefault:getInstance():getStringForKey("pid")
    local flag = true
    for _, value in ipairs(info) do
        if value == nil or value == "" then
            flag = false
            break
        end
    end

    if flag then
        MsgManager:login(nick, pwd)
    end
    --如果没有本地用户数据，则留在此页面，等待登录或注册结束之后将用户数据存在本地

    local nickEditLayer = ccui.Layout:create()
    nickEditLayer:setBackGroundColor(cc.c3b(255, 255, 255))
    nickEditLayer:setBackGroundColorType(1)
    nickEditLayer:setContentSize(400,60)
    nickEditLayer:setPosition(display.cx,display.cy)
    nickEditLayer:setAnchorPoint(0.5, 0.5)
    nickEditLayer:addTo(self)

    local nickEditBox = ccui.EditBox:create(cc.size(400, 60), nil, 0)
    nickEditBox:setPosition(display.cx,display.cy)
    nickEditBox:setBright(true)
    nickEditBox:setFontSize(40)
    nickEditBox:setMaxLength(12)
    nickEditBox:setFontColor(cc.c4b(0, 0, 0, 0))
    nickEditBox:setPlaceHolder("请输入昵称")
    self:addChild(nickEditBox)


    local pwdLayer = ccui.Layout:create()
    pwdLayer:setBackGroundColor(cc.c3b(255, 255, 255))
    pwdLayer:setBackGroundColorType(1)
    pwdLayer:setContentSize(400,60)
    pwdLayer:setPosition(display.cx,display.cy - 100)
    pwdLayer:setAnchorPoint(0.5, 0.5)
    pwdLayer:addTo(self)

    local pwdEditBox = ccui.EditBox:create(cc.size(400, 60), nil, 0)
    pwdEditBox:setPosition(display.cx,display.cy - 100)
    pwdEditBox:setBright(true)
    pwdEditBox:setFontSize(40)
    pwdEditBox:setMaxLength(12)
    pwdEditBox:setFontColor(cc.c4b(0, 0, 0, 0))
    pwdEditBox:setPlaceHolder("请输入密码")
    pwdEditBox:setInputFlag(0)
    self:addChild(pwdEditBox)

    local loginTxt = cc.Label:createWithTTF("登录","font/fzhz.ttf", 48)
    loginTxt:setPosition(display.cx-80,display.cy-200)
    loginTxt:enableOutline(cc.c4b(0, 0, 0, 255), 1) -- 2像素纯黑色描边
    loginTxt:setTextColor(cc.c4b(248,191,42,255))

    local loginBtn = ccui.Button:create(nil, nil)
    loginBtn:setAnchorPoint(0.5, 0.5)
    loginBtn:setScale9Enabled(true)
    loginBtn:setContentSize(loginTxt:getContentSize())
    loginBtn:pos(display.cx-80,display.cy-200)
	loginBtn:setTitleFontSize(20)
    loginBtn:setPressedActionEnabled(true)
    loginBtn:addTouchEventListener(function(sender, eventType)
        if 0 == eventType then
            loginTxt:setScale(0.8)
		end
		if 2 == eventType then
            loginTxt:setScale(1)
            local nick = nickEditBox:getText()
            local pwd = pwdEditBox:getText()

            if nick~=nil and pwd ~= nil and nick ~= "" and pwd ~= "" then
                print("login", nick, pwd)
                MsgManager:login(nick, pwd)

            end
		end
	end)

    local loginLayer = display.newLayer()
    loginLayer:setContentSize(loginTxt:getContentSize())
    loginLayer:addChild(loginTxt)
    loginLayer:addChild(loginBtn)
    loginLayer:addTo(self)



    local regTxt = cc.Label:createWithTTF("注册","font/fzhz.ttf", 48)
    regTxt:setPosition(display.cx+80,display.cy-200)
    regTxt:enableOutline(cc.c4b(0, 0, 0, 255), 1) -- 2像素纯黑色描边
    regTxt:setTextColor(cc.c4b(248,191,42,255))


    local regBtn = ccui.Button:create(nil, nil)
    regBtn:setAnchorPoint(0.5, 0.5)
    regBtn:setScale9Enabled(true)
    regBtn:setContentSize(loginTxt:getContentSize())
    regBtn:pos(display.cx+80,display.cy-200)
	regBtn:setTitleFontSize(20)
    regBtn:setPressedActionEnabled(true)
    regBtn:addTouchEventListener(function(sender, eventType)
        if 0 == eventType then
            regTxt:setScale(0.8)
		end
		if 2 == eventType then
            regTxt:setScale(1)
            local nick = nickEditBox:getText()
            local pwd = pwdEditBox:getText()
            if nick~=nil and pwd ~= nil and nick ~= "" and pwd ~= "" then
                print("register", nick, pwd)
                -- todo 进行网络传输，注册用户名密码，
                MsgManager:register(nick, pwd)
            end
		end
	end)

    local regLayer = display.newLayer()
    regLayer:setContentSize(regTxt:getContentSize())
    regLayer:addChild(regTxt)
    regLayer:addChild(regBtn)
    regLayer:addTo(self)

    -- 弹窗
    self.dialogView_ = DialogView.new() -- 类型：DialogView，弹窗界面
    self:addChild(self.dialogView_)

end

--[[--
    onEnter

    @param none

    @return none
]]
function LogInAndRegisterScene:onEnter()
    -- 监听登录成功
    EventManager:regListener(EventDef.ID.LOGIN_SUCCEED, self, function(resp)
        TCP.unRegListener(MsgDef.ACK_TYPE.LOGIN_SUCCEED)
        cc.UserDefault:getInstance():setStringForKey("nick", resp["nick"] )
        cc.UserDefault:getInstance():setStringForKey("pwd", resp["pwd"])
        cc.UserDefault:getInstance():setIntegerForKey("pid", resp["pid"])

        PlayerData:setId(resp["pid"])
        PlayerData:setName(resp["nick"])
        PlayerData:setPassword(resp["pwd"])

        display.replaceScene(require("app.scenes.LobbyScene"):new())
        MsgManager:recPlayerData() -- 联网更新
        MsgManager:recStoreData()

    end)
    -- 监听登录失败
    EventManager:regListener(EventDef.ID.LOGIN_FAIL, self, function()
        TCP.unRegListener(MsgDef.ACK_TYPE.LOGIN_FAIL)
        local dialog = LoginErrDialog.new("用户名或密码错误")
        DialogManager:showDialog(dialog)
    end)
    -- 监听注册成功
    EventManager:regListener(EventDef.ID.REGISTER_SUCCEED, self, function(resp)

        print("注册成功")

        TCP.unRegListener(MsgDef.ACK_TYPE.REGISTER_SUCCEED)
        local dialog = RegisterSucceedDialog.new("注册成功")
        cc.UserDefault:getInstance():setStringForKey("nick", resp["nick"])
        cc.UserDefault:getInstance():setStringForKey("pwd", resp["pwd"])
        cc.UserDefault:getInstance():setIntegerForKey("pid", resp["pid"])

        PlayerData:setId(resp["pid"])
        PlayerData:setName(resp["nick"])
        PlayerData:setPassword(resp["pwd"])

        DialogManager:showDialog(dialog)
    end)
    -- 监听注册失败
    EventManager:regListener(EventDef.ID.REGISTER_FAIL, self, function()
        TCP.unRegListener(MsgDef.ACK_TYPE.REGISTER_FAIL)
        local dialog = LoginErrDialog.new("用户名重复")
        DialogManager:showDialog(dialog)
    end)
end

--[[--
    onExit

    @param none

    @return none
]]
function LogInAndRegisterScene:onExit()
    EventManager:unRegListener(EventDef.ID.LOGIN_SUCCEED, self)
    EventManager:unRegListener(EventDef.ID.LOGIN_FAIL, self)
    EventManager:unRegListener(EventDef.ID.REGISTER_SUCCEED, self)
    EventManager:unRegListener(EventDef.ID.REGISTER_FAIL, self)
end

--[[--
    界面刷新

    @param none

    @return none
]]
function LogInAndRegisterScene:update()

end

return LogInAndRegisterScene