
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)



function MainScene:ctor()


    --1.加载精灵帧
    --display.addSpirteFrames("plane.plist","back_peek1.png")
    --2.背景图片
    display.newSprite("bg_menu.jpg")
        :pos(display.cx,display.cy)
        :addTo(self)

    -- local label = display.newTTFLabel({
    --     text = "Hello, World",
    --     size = 64,
    -- })
    -- label:align(display.CENTER, display.cx, display.cy)
    -- label:addTo(self)

    self:createLeftTopPanel()




    --注册按钮
    local images = {
        normal = "register/register.png",
        pressed = "register/register.png",
        disabled = "register/register.png"
    }

    local registerBtn = ccui.Button:create(images["normal"], images["pressed"], images["disabled"])
    registerBtn:setAnchorPoint(cc.p(0.5 ,0.5))
    -- 居中
    registerBtn:setPosition(cc.p(display.cx, display.cy))
    -- 设置缩放程度
    registerBtn:setScale(0.5, 0.5)
    -- 设置是否禁用(false为禁用)
    registerBtn:setEnabled(true)
    registerBtn:addClickEventListener(function()
        print("lalala")
    end)

    registerBtn:addTouchEventListener(function(sender, eventType)
	 	if eventType == ccui.TouchEventType.ended then
	 		local registerBtn = import("app.scenes.SecScene"):new()
            display.replaceScene(registerBtn,"turnOffTiles",0.5)
            print(transform)
	 	end
	end)

    self:addChild(registerBtn, 4)

    -- local editTxt= ccui.EditBox:create(cc.size(350,100), "rank_bg.png",0) 
    -- --输入框尺寸，背景图 片 
    -- editTxt:setName("inputTxt") 
    -- editTxt:setAnchorPoint(0.5,0.5) 
    -- editTxt:setPosition(970,515) --设置输入框的位置 
    -- editTxt:setFontSize(100) --设置输入设置字体的大小 
    -- editTxt:setMaxLength(6) --设置输入最大长度为6 
    -- editTxt:setFontColor(cc.c4b(124,92,63,255)) --设置输入的字体颜色 
    -- --editTxt:setFontName("simhei") --设置输入的字体为simhei.ttf 
    -- -- editTxt:setInputMode(cc.EDITBOX_INPUT_MODE_NUMERIC) --设置数字符号键盘 
    -- -- editTxt:setPlaceHolder("请输入账号") --设置预制提示文本 
    -- -- editTxt:setReturnType(cc.KEYBOARD_RETURNTYPE_DONE) --输入键盘返回类型，done， send，go等KEYBOARD_RETURNTYPE_DONE 
    -- -- editTxt:setInputMode(cc.EDITBOX_INPUT_MODE_NUMERIC) --输入模型，如整数类型，URL， 电话号码等，会检测是否符合 
    -- -- editTxt:registerScriptEditBoxHandler(function(eventname,sender) 
    -- -- self:editboxHandle(eventname,sender) end) --输入框的事件，主要有光标移进去，光标移出来， 以及输入内容改变等 
    -- self:addChild(editTxt,5)
    -- --输入框事件处理
    -- -- function Ui:editboxHandle(strEventName,sender) 
    -- --     if strEventName == "began" then 
    -- --         sender:setText("") --光标进入，清空内容/ 选择全部
    -- --     elseif strEventName == "ended" then --当编辑框失去焦点并 且键盘消失的时候被调用 
    -- --     elseif strEventName == "return" then --当用户点击编辑框的 键盘以外的区域，或者键盘的Return按钮被点击时所调用 
    -- --     elseif strEventName == "changed" then --输入内容改变时调用 
    -- --     end
    -- -- end

    


end

function MainScene:createLeftTopPanel()
    local width, height = 300, 200
    
    local inputLayer = ccui.Layout:create()
    -- inputLayer:setBackGroundColor(cc.c4b(100, 0, 0,0))
    -- inputLayer:setBackGroundColorType(1)
    inputLayer:setContentSize(300, 200)
    inputLayer:setPosition(display.cx-150, display.top - 300)
    inputLayer:setAnchorPoint(0, 1)
    inputLayer:addTo(self)

    -- 上测居中对齐
    -- size， respath， 0普通图片 1合集（plist)图片
    local locationEditbox = ccui.EditBox:create(cc.size(width - 10, 40), "rank_bg.png", 0)
    locationEditbox:setAnchorPoint(0.5,1)
	locationEditbox:pos(width * 0.5, height)
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
    -- local confirmButton = ccui.Button:create("rank_bg.png", "rank_bg.png")
    -- confirmButton:setAnchorPoint(0.5, 1)
    -- confirmButton:setScale9Enabled(true)
    -- confirmButton:setContentSize(80, 40)
	-- confirmButton:setTitleText("Select")
    -- confirmButton:pos(width * 0.5, height - 55)
	-- confirmButton:setTitleFontSize(20)
    -- confirmButton:addTo(inputLayer)

    -- 点击输出输入框的内容
    -- confirmButton:addTouchEventListener(function(sender, eventType)
	-- 	if 2 == eventType then
	-- 		print("you type string =", locationEditbox:getText())
	-- 	end
	-- end)

     --注册按钮
    local images = {
        normal = "register/register.png",
        pressed = "register/register.png",
        disabled = "register/register.png"
    }

    local registerBtn = ccui.Button:create(images["normal"], images["pressed"], images["disabled"])
    registerBtn:setAnchorPoint(cc.p(0.5 ,0.5))
    -- 居中
    registerBtn:setPosition(cc.p(display.cx, display.cy-100))
    -- 设置缩放程度
    registerBtn:setScale(0.5, 0.5)
    -- 设置是否禁用(false为禁用)
    registerBtn:setEnabled(true)
    registerBtn:addClickEventListener(function()
        print("lalala")
    end)

    registerBtn:addTouchEventListener(function(sender, eventType)
        local name = locationEditbox:getText()


	 	if ((name ~=nil and name~="")and eventType == ccui.TouchEventType.ended )then
	 		local registerBtn = import("app.scenes.SecScene"):new()
            display.replaceScene(registerBtn,"turnOffTiles",0.5)
            print(transform)
        else
            print("不行")
	 	end
	end)

    self:addChild(registerBtn, 4)
end

function MainScene:onEnter()
end

function MainScene:onExit()
end



















-- function MainScene:ctor()
--     local label = display.newTTFLabel({
--         text = "Hello, World",
--         size = 64,
--     })
--     label:align(display.CENTER, display.cx, display.cy)
--     label:addTo(self)
-- end

-- function MainScene:onEnter()
-- end

-- function MainScene:onExit()
-- end




-- --[[--
--     构造函数

--     @param none

--     @return none
-- ]]
-- function MainScene:ctor()
--     -- 贴左上放
--     self:createLeftTopPanel()

--     -- 贴下测居中放
--     self:createBottomPanel()

-- end



-- --[[--
--     创建左上方面板

--     @param none

--     @return none
-- ]]


-- function MainScene:createLeftTopPanel()
--     local width, height = 300, 200
--     local inputLayer = ccui.Layout:create()
--     inputLayer:setBackGroundColor(cc.c3b(100, 0, 0))
--     inputLayer:setBackGroundColorType(1)
--     inputLayer:setContentSize(300, 200)
--     inputLayer:setPosition(10, display.top - 10)
--     inputLayer:setAnchorPoint(0, 1)
--     inputLayer:addTo(self)

--     -- 上测居中对齐
--     -- size， respath， 0普通图片 1合集（plist)图片
--     local locationEditbox = ccui.EditBox:create(cc.size(width - 10, 40), "rank_bg.png", 0)
--     locationEditbox:setAnchorPoint(0.5,1)
-- 	locationEditbox:pos(width * 0.5, height)
--     locationEditbox:addTo(inputLayer)
--     locationEditbox:registerScriptEditBoxHandler(function (eventType)
--              if eventType == "began" then
--                 -- triggered when an edit box gains focus after keyboard is shown
--             elseif eventType == "ended" then
--                  -- triggered when an edit box loses focus after keyboard is hidden.
--             elseif eventType == "changed" then
--                  -- triggered when the edit box text was changed.
--                 print("cur text is ", locationEditbox:getText())
--            elseif eventType == "return" then
--                -- triggered when the return button was pressed or the outside area of keyboard was touched.
--             end
--         end)

--     -- 确定
--     local confirmButton = ccui.Button:create("rank_bg.png", "rank_bg.png")
--     confirmButton:setAnchorPoint(0.5, 1)
--     confirmButton:setScale9Enabled(true)
--     confirmButton:setContentSize(80, 40)
-- 	confirmButton:setTitleText("Select")
--     confirmButton:pos(width * 0.5, height - 55)
-- 	confirmButton:setTitleFontSize(20)
--     confirmButton:addTo(inputLayer)

--     -- 点击输出输入框的内容
--     confirmButton:addTouchEventListener(function(sender, eventType)
-- 		if 2 == eventType then
-- 			print("you type string =", locationEditbox:getText())
-- 		end
-- 	end)
-- end

-- --[[--
--     创建下方居中面板

--     @param none

--     @return none
-- ]]
-- function MainScene:createBottomPanel()
--     local width, height = display.width - 30, 400
--     local bottomLayer = ccui.Layout:create()
--     bottomLayer:setBackGroundColor(cc.c3b(100, 100, 100))
--     bottomLayer:setBackGroundColorType(1)
--     bottomLayer:setContentSize(width, height)
--     bottomLayer:setPosition(display.cx, 10)
--     bottomLayer:setAnchorPoint(0.5, 0)
--     bottomLayer:addTo(self)

--     --img
--     local temp = ccui.ImageView:create("rank_bg.png")
--     local listView = ccui.ListView:create()
--     -- 以某个元素宽度做容器宽度
-- 	listView:setContentSize(temp:getContentSize().width, height -10)
--     listView:setAnchorPoint(0, 0.5)
-- 	listView:setPosition(10, height * 0.5)
--     listView:setDirection(1)
-- 	listView:addTo(bottomLayer)
--     for i = 1, 5 do
--         local img = ccui.ImageView:create("rank_bg.png")
--         listView:pushBackCustomItem(img)
--     end

--     local bmFontlistView = ccui.ListView:create()
-- 	bmFontlistView:setContentSize(180, height -10)
--     bmFontlistView:setAnchorPoint(0, 0.5)
-- 	bmFontlistView:setPosition(200, height * 0.5)
--     bmFontlistView:setDirection(1)
-- 	bmFontlistView:addTo(bottomLayer)
--     for i = 1, 15 do
--         local font = ccui.TextBMFont:create(tostring(math.random(1, 100)), "islandcvbignum.fnt")
--         bmFontlistView:pushBackCustomItem(font)
--     end

--     --ttf
--     local txtListView = ccui.ListView:create()
-- 	txtListView:setContentSize(width * 0.5, 100)
--     txtListView:setAnchorPoint(1, 0.5)
-- 	txtListView:setPosition(width - 10, height * 0.5)
--     txtListView:setDirection(2)
-- 	txtListView:addTo(bottomLayer)
--     for i = 1, 15 do
--         local font = ccui.Text:create(" 我是谁 ", "FontNormal.ttf", 25)
--         txtListView:pushBackCustomItem(font)
--     end

--     local itemWidth, itemHeight = 100, 100
--     local testView = ccui.ListView:create()
-- 	testView:setContentSize(width * 0.5, itemHeight)
--     testView:setAnchorPoint(1, 0)
-- 	testView:setPosition(width - 10, 10)
--     testView:setDirection(2)
-- 	testView:addTo(bottomLayer)
--     for i = 1, 15 do
--         local itemLayer = ccui.Layout:create()
--         itemLayer:setBackGroundColor(cc.c3b(math.random(100, 200), math.random(100, 200), math.random(100, 200)))
--         itemLayer:setBackGroundColorType(1)
--         itemLayer:setContentSize(itemWidth, itemHeight)
--         itemLayer:addTo(testView)

--         local font = ccui.Text:create(" btn" .. i .. " ", "FontNormal.ttf", 25)
--         font:addTo(itemLayer)
--         font:setAnchorPoint(0.5, 1)
--         font:pos(itemWidth * 0.5, itemHeight)

--         local btn = ccui.Button:create("rank_bg.png", "rank_bg.png")
--         btn:setAnchorPoint(0.5, 0)
--         btn:setScale9Enabled(true)
--         btn:setContentSize(itemWidth, 50)
--         btn:setTitleText(" btn" .. i .. " ")
--         btn:pos(itemWidth * 0.5, 0)
--         btn:setTitleFontSize(20)
--         btn:addTo(itemLayer)

--         -- 点击输出输入框的内容
--         btn:addTouchEventListener(function(sender, eventType)
--             if 2 == eventType then
--                 print("you click btn =", font:getString())
--             end
--         end)
--     end
-- end


return MainScene
