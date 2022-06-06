RANK_BG_PATH="D:/quick-cocos2dx-community/test/src/app/scenes/picture/ui/rank/rank_bg.png"
require("src/app/scenes/json.lua")
local RegisterScene = class("RegisterScene", function()
    return display.newScene("app/scenes/RegisterScene.lua")
end)

function  RegisterScene:ctor()
    self:createRegisterPanel()
end

function RegisterScene:createRegisterPanel()
    local width, height = 480, 720
    local inputLayer = ccui.Layout:create()
    inputLayer:setBackGroundColor(cc.c3b(0, 50, 0))
    inputLayer:setBackGroundColorType(1)
    inputLayer:setContentSize(480, 720)
    inputLayer:setPosition(10, display.top - 10)
    inputLayer:setAnchorPoint(0, 1)
    inputLayer:addTo(self)

    -- 上测居中对齐
    -- size， respath， 0普通图片 1合集（plist)图片
    local locationEditbox = ccui.EditBox:create(cc.size(width - 10, 40), RANK_BG_PATH, 0)
    locationEditbox:setPlaceHolder("                        请输入昵称")
    locationEditbox:setFontColor(cc.c3b(0,0,0))
    locationEditbox:setAnchorPoint(0.5,1)
	locationEditbox:pos(width * 0.5, height-200)
    locationEditbox:addTo(inputLayer)
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
    local confirmButton = ccui.Button:create(RANK_BG_PATH, RANK_BG_PATH)
    confirmButton:setAnchorPoint(0.5, 1)
    confirmButton:setScale9Enabled(true)
    confirmButton:setContentSize(80, 40)
	confirmButton:setTitleText("确定")
    confirmButton:pos(width * 0.5, height - 300)
	confirmButton:setTitleFontSize(20)
    confirmButton:addTo(inputLayer)
    confirmButton:setPressedActionEnabled(true)
    local userdata={id,name}
    confirmButton:addClickEventListener(function(sender, eventType)
        userdata.name=locationEditbox:getText()
        userdata.id=getUUID()
        local string=json.encode(userdata)
		io.writefile("src/app/scenes/userId.txt", string, "a+")
	end)


    -- 点击输出输入框的内容
    --[[confirmButton:addTouchEventListener(function(sender, eventType)
		if 2 == eventType then
			print("you type string =", locationEditbox:getText())
		end
	end)--]]
end

function getUUID()
    local curTime=os.time()
    local uuid=curTime+math.random(10000000)
    return uuid-- body
end
return RegisterScene