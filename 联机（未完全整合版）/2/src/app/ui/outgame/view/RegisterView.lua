--[[--
    注册界面
    RegisterView.lua
]]
local RegisterView = class("RegisterView", function()
    return display.newColorLayer(cc.c4b(0, 0, 0, 0))
end)
local OutGameData = require("app.data.outgame.OutGameData")
local ConstDef = require("app.def.outgame.ConstDef")
local OutgameMsg = require("app.msg.OutgameMsg")
--[[--
    构造函数

    @param none

    @return none
]]
function RegisterView:ctor()
    self.container_ = nil -- 类型：Layout，控件容器

    self:initView()
    self:setVisible(false)
end

--[[--
    界面初始化

    @param none

    @return none
]]
function RegisterView:initView()
    local width, height = 400, 350
    self.container_ = ccui.Layout:create()
    self.container_:setBackGroundColor(cc.c3b(100, 100, 100))
    self.container_:setBackGroundColorType(1)
    self.container_:setContentSize(width, height)
    self.container_:addTo(self)
    self.container_:setAnchorPoint(0.5, 0.5)
    self.container_:setPosition(display.cx, display.cy)

    --账号Text
    local accountText = ccui.Text:create("账号","artcontent/font.fzhz.ttf",36)
    accountText:pos(display.cx * 1/6, display.cy * 2/5)
    self.container_:addChild(accountText)

    --账号文本框
    local accountEditbox = ccui.EditBox:create(cc.size(240, 40),
    "artcontent/lobby_ongame/battle_interface/basemap_selectedteams.png", 0)
    accountEditbox:setAnchorPoint(0.5,0.5)
    accountEditbox:pos(display.cx * 3/5, display.cy * 2/5)
    self.container_:addChild(accountEditbox)

    --密码Text
    local passwordText = ccui.Text:create("密码","artcontent/font.fzhz.ttf",36)
    passwordText:pos(display.cx * 1/6, display.cy * 1/5)
    self.container_:addChild(passwordText)

    --密码文本框
    local passwordEditbox = ccui.EditBox:create(cc.size(240, 40),
    "artcontent/lobby_ongame/battle_interface/basemap_selectedteams.png", 0)
    passwordEditbox:setAnchorPoint(0.5,0.5)
    passwordEditbox:pos(display.cx * 3/5, display.cy * 1/5)
    self.container_:addChild(passwordEditbox)

    --注册确定按钮
    local btn = ccui.Button:create("artcontent/register/register.png","artcontent/register/register2.png")
    btn:addTouchEventListener(function(sender, eventType)
        if 2 == eventType then
            if cc.UserDefault:getInstance():getBoolForKey("音效") then
                audio.playEffect("sounds/ui_btn_click.OGG",false)
            end
            account = tostring(accountEditbox:getText())
            password = tostring(passwordEditbox:getText())
            if password == "" or account == "" then
                print("账户或密码不能为空")
            else
                OutgameMsg:register(account,password)
                local data={1,4,7,9,18}
                local data1={gold=10000,
                diamond=10000,trophyAmount=300,}
                local data2={id={},num={},level={},}
                local data3={
                rankObjectAmount={}}
                local data4={lineup={},level={}}
                for i=1,5 do
                    data2.id[i]=data[i]
                    data2.num[i]=0
                    data2.level[i]=1
                end
                for j=1,3 do
                    for i=1,5 do
                        data4.lineup[j*5-5+i]=data[i]
                        data4.level[j*5-5+i]=1
                    end
                end

                for i=1,22 do
                    data3.rankObjectAmount[i]=1
                end
                OutgameMsg:sendData(account,"financeData",data1)
                OutgameMsg:sendData(account,"towerData",data2)
                OutgameMsg:sendData(account,"achieveData",data3)
                OutgameMsg:sendData(account,"lineupData",data4)
                OutgameMsg:getdataFromMsg()
                self:hideView(function()
                    OutGameData:setGameState(ConstDef.GAME_STATE.INIT)
                end)
                cc.UserDefault:getInstance():setStringForKey("account", account)
                cc.UserDefault:getInstance():setStringForKey("password", password)
            end
        end
    end)
    btn:pos(display.cx * 1/2, display.cy * 1/12)
    self.container_:addChild(btn)
end

--[[--
    显示界面

    @param none

    @return none
]]
function RegisterView:showView()
    self:setVisible(true)
    self.container_:setScale(0)
    self.container_:runAction(cc.ScaleTo:create(0.15, 1))
end

--[[--
    隐藏界面

    @param callback 类型：function，动画完成回调

    @return none
]]
function RegisterView:hideView(callback)
    self.container_:runAction(cc.Sequence:create(
        cc.ScaleTo:create(0.15, 0), cc.CallFunc:create(function()
            self:setVisible(false)
            if callback then
                callback()
            end
        end)
    ))
end

return RegisterView