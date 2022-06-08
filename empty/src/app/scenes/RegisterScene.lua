local RegisterScene = class("RegisterScene", function()
    return display.newScene("RegisterScene")
end)
--函数定义
local getUUID
--[[--
    构造函数

    @param none

    @return none
]]
function RegisterScene:ctor()

    cc.FileUtils:getInstance():addSearchPath("res/")
    -- 创建居中面板
    self:createPanel()
    --判断是否切换场景  
    -- 贴下测居中放
    --self:createBottomPanel()
    
end
--[[--
    创建注册面板

    @param none

    @return none
]]
function RegisterScene:createPanel()
    local width, height = display.width, display.top
    local inputLayer = ccui.Layout:create()
    inputLayer:setBackGroundImage("ui/main/bg_menu.jpg")
    inputLayer:setBackGroundImageScale9Enabled(true)
    --inputLayer:setBackGroundColor(cc.c3b(0, 100, 0))
    --inputLayer:setBackGroundColorType(1)
    inputLayer:setContentSize(display.width, display.top)
    inputLayer:setPosition(display.width*0.5, display.top *0.5)
    inputLayer:setAnchorPoint(0.5, 0.5)
    inputLayer:addTo(self)

    -- 中侧注册界面
    local registerLayer=ccui.Layout:create()
    registerLayer:setBackGroundImage("ui/rank/rank_bg.png")
    registerLayer:setBackGroundImageScale9Enabled(true)
    registerLayer:setContentSize(display.width*0.8, display.top*0.3)
    registerLayer:setPosition(display.width*0.5, display.top *0.5)
    registerLayer:setAnchorPoint(0.5, 0.5)
    registerLayer:addTo(inputLayer)
    --输入框
    local locationEditbox = ccui.EditBox:create(cc.size(width *0.8, 100),"ui/rank/rank_bg.png", 0)
    locationEditbox:setAnchorPoint(0.5,0.5)
	locationEditbox:pos(width*0.4, height*0.2)
    locationEditbox:addTo(registerLayer)
    locationEditbox:registerScriptEditBoxHandler(function (eventType)
             if eventType == "began" then
                -- triggered when an edit box gains focus after keyboard is shown
            elseif eventType == "ended" then
                 -- triggered when an edit box loses focus after keyboard is hidden.
            elseif eventType == "changed" then
                 -- triggered when the edit box text was changed.
                print("cur text is ", locationEditbox:getText())
           elseif eventType == "return" then
               -- triggered when the return button was pressed or the outside area of keyboard was touched.
            end
        end)

    -- 确定
    local confirmButton = ccui.Button:create("ui/register/register.png", "ui/register/register.png")
    confirmButton:setAnchorPoint(0.5, 0.5)
    confirmButton:setContentSize(200, 50)
    confirmButton:pos(width*0.4, height*0.1)
	confirmButton:setTitleFontSize(20)
    confirmButton:addTo(registerLayer)

    -- 点击输出输入框的内容
    confirmButton:addTouchEventListener(function(sender, eventType)
		if 2 == eventType then
            local id=getUUID()
            cc.UserDefault:getInstance():setStringForKey("id",id)
            cc.UserDefault:getInstance():setStringForKey("name",locationEditbox:getText())
            local nextScene=import("app/scenes/MainScene"):new()
            display.replaceScene(nextScene)
		end
	end)
end

function getUUID()
    local curTime=os.time()
    local uuid=curTime+math.random(10000000)
    return uuid
end


function RegisterScene:onEnter()
end

function RegisterScene:onExit()
end

return RegisterScene