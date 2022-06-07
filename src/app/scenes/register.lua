register = class("register", function()
    return display.newScene("register")
end)

function register:ctor()  
end

local audio = require("framework.audio")

audio.loadFile("texture/sounds/buttonEffet.ogg", function ()
end)

function register:onEnter()
    local b2 = display.newSprite("texture/ui/main/bg_menu.jpg")
    :pos(display.cx,display.cy)
    :addTo(self)

    local inputLayer = ccui.Layout:create()
    inputLayer:setBackGroundColor(cc.c3b(255, 255, 255))
    inputLayer:setBackGroundColorType(1)
    inputLayer:setContentSize(350,50)
    inputLayer:setPosition(display.cx,display.cy)
    inputLayer:setAnchorPoint(0.5, 0.5)
    inputLayer:addTo(self)

    print("shurukuang")
    local editTxt = ccui.EditBox:create(cc.size(350,50), nill, 0)
    -- cc.size(350,100),"register.png")--输入框尺寸﹐背景图片
    editTxt:setName ( "inputTxt")
    --貌似是名字，print无用
    editTxt:setAnchorPoint(0.5,0.5)
    --偏移，第一个是x。，第二个是y
    editTxt : setPosition(display.cx,display.cy)
    --设置输入框的位置
    editTxt : setBright(true)
    --是否被点击到
    editTxt:setFontSize(40)
    --设置输入设置字体的大小
    editTxt : setMaxLength(6)
    --设置输入最大长度为6
    editTxt :setFontColor(cc.c4b(2,157,0,0))
    --设置输入的字体颜色
    editTxt : setFontName ( "simhei" )
    --设置输入的字体为simhei.ttf
    --editTxt : setInputAode(cc.EDITBOX_INPUT_MODE_NUMERIC)
    --设置数字符号键盘
    editTxt : setPlaceHolder("请输入注册的账号")
    --设置预制提示文本
    --editTxt : setReturnType(cc.KEYBOARD_RETURNTYPE_DONE)--输入键盘返回类型，done ,send , go等KEYBOARD_RETURNTYPE_DONE
    --editTxt : setInputNode(cc.EDITBOX_INPUT_MODE_NUMERIC)--输入模型﹐如整数类型，URL，电话号码等﹐会检测是否符合
    --editTxt :registerscriptEditBoxHandler(function(eventname, sender )
    --self:editboxHandle(eventname,sender ) end)--输入框的事件﹐主要有光标移进去﹐光标移出来，以及输入内容改变等
    self:addChild(editTxt,5)
    print("shurukuang")

    local confirmButton = ccui.Button:create("texture/ui/register/register.png", "texture/ui/register/register.png")

    confirmButton:setAnchorPoint(0.5, 0.5)

    confirmButton:setScale9Enabled(true)

    confirmButton:setContentSize(144, 49)

	--confirmButton:setTitleText("Select")

    confirmButton:pos(display.cx,display.cy-70)

	confirmButton:setTitleFontSize(20)

    confirmButton:addTo(self)

    -- 点击输出输入框的内容
    confirmButton:addTouchEventListener(function(sender, eventType)
		if 2 == eventType then
            audio.playEffect("texture/sounds/buttonEffet.ogg")
			print("you type string =", editTxt:getText())
            local  menu = import("src.app.scenes.menu"):new()
            display.replaceScene(menu)
		end
	end)

    print("into register")
end




function register:onExit()
end

return register