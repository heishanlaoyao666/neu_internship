RANK_BG_PATH="D:/quick-cocos2dx-community/test/src/app/scenes/picture/ui/rank/rank_bg.png"
ISLANDCVBIGNUM_FNT_PATH="D:/quick-cocos2dx-community/test/src/app/scenes/picture/ui/rank/islandcvbignum.fnt"
FONTNORMAL_TTF_PATH="D:/quick-cocos2dx-community/test/src/app/scenes/picture/ui/font/FontNormal.ttf"
MENU_BG_PATH="D:/quick-cocos2dx-community/test/src/app/scenes/picture/ui/main/bg_menu.jpg"
MENU_CONTINUE_PATH="D:/quick-cocos2dx-community/test/src/app/scenes/picture/ui/main/continue_menu2.png"
MENU_NEWGAME_PATH="D:/quick-cocos2dx-community/test/src/app/scenes/picture/ui/main/new_game2.png"
MENU_SETTING_PATH="D:/quick-cocos2dx-community/test/src/app/scenes/picture/ui/main/shezhi2_cover.png"
MENU_RANK_PATH="D:/quick-cocos2dx-community/test/src/app/scenes/picture/ui/main/rank_menu2.png"
require("D:/quick-cocos2dx-community/test/src/app/scenes/RegisterScene.lua")
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

--[[--
    构造函数

    @param none

    @return none
]]
function MainScene:ctor()
    local bg=display.newSprite(MENU_BG_PATH,display.cx,display.cy)
    self:add(bg)
    -- 贴左上放
    --self:createLeftTopPanel()

    -- 贴下测居中放
    self:createPanel()
    
    --MainScene:createMenu()
end

--[[--
    创建左上方面板

    @param none

    @return none
]]

function MainScene:createLeftTopPanel()
    local width, height = 480, 720
    local inputLayer = ccui.Layout:create()
    inputLayer:setBackGroundColor(cc.c3b(100, 0, 0))
    inputLayer:setBackGroundColorType(1)
    inputLayer:setContentSize(480, 720)
    inputLayer:setPosition(10, display.top - 10)
    inputLayer:setAnchorPoint(0, 1)
    inputLayer:addTo(self)

    -- 上测居中对齐
    -- size， respath， 0普通图片 1合集（plist)图片
    local locationEditbox = ccui.EditBox:create(cc.size(width - 10, 40), RANK_BG_PATH, 0)
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
    local confirmButton = ccui.Button:create(RANK_BG_PATH, RANK_BG_PATH)
    confirmButton:setAnchorPoint(0.5, 1)
    confirmButton:setScale9Enabled(true)
    confirmButton:setContentSize(80, 40)
	confirmButton:setTitleText("Select")
    confirmButton:pos(width * 0.5, height - 55)
	confirmButton:setTitleFontSize(20)
    confirmButton:addTo(inputLayer)

    -- 点击输出输入框的内容
    confirmButton:addTouchEventListener(function(sender, eventType)
		if 2 == eventType then
			print("you type string =", locationEditbox:getText())
		end
	end)
end

function MainScene:createPanel()
    local width, height = display.width, display.height
    local bottomLayer = ccui.Layout:create()
    --bottomLayer:setBackGroundColor(cc.c4b(0, 0, 0,0))
    bottomLayer:setBackGroundColorType(0)
    --bottomLayer:setBackGroundColorOpacity(180)
    bottomLayer:setContentSize(width, height)
    bottomLayer:setPosition(display.cx+150,0)
    bottomLayer:setAnchorPoint(0.5, 0)
    bottomLayer:addTo(self)
    
    local newgameButton = ccui.Button:create(MENU_NEWGAME_PATH,MENU_NEWGAME_PATH)
    newgameButton:setAnchorPoint(0.5, 0.5)
    newgameButton:setScale9Enabled(true)
    --newgameButton:setContentSize(80, 40)
    newgameButton:pos(display.cx*0.4, height - 200)
	--newgameButton:setTitleFontSize(20)
    newgameButton:addTo(bottomLayer)
    newgameButton:addClickEventListener(function(sender, eventType)
		--local Loginscene=require("D:/quick-cocos2dx-community/test/src/app/scenes/RegisterScene.lua")
        --local transition=display.wrapSceneWithTransition(Loginscene,"fade",0.5)
        --display.replaceScene()
        app:enterScene("RegisterScene", nil, "fade", 0.8)

	end)
    newgameButton:setPressedActionEnabled(true)
    
    local continueButton = ccui.Button:create(MENU_CONTINUE_PATH,MENU_CONTINUE_PATH)
    continueButton:setAnchorPoint(0.5, 0.5)
    continueButton:setScale9Enabled(true)
    --newgameButton:setContentSize(80, 40)
    continueButton:pos(display.cx*0.4, height - 250)
	--continueButton:setTitleFontSize(20)
    continueButton:addTo(bottomLayer)
    continueButton:setPressedActionEnabled(true)

    local rankButton = ccui.Button:create(MENU_RANK_PATH,MENU_RANK_PATH)
    rankButton:setAnchorPoint(0.5, 0.5)
    rankButton:setScale9Enabled(true)
    --newgameButton:setContentSize(80, 40)
    rankButton:pos(display.cx*0.4, height - 300)
	--rankButton:setTitleFontSize(20)
    rankButton:addTo(bottomLayer)
    rankButton:setPressedActionEnabled(true)
    
    local settingButton = ccui.Button:create(MENU_SETTING_PATH,MENU_SETTING_PATH)
    settingButton:setAnchorPoint(0.5, 0.5)
    settingButton:setScale9Enabled(true)
    --newgameButton:setContentSize(80, 40)
    settingButton:pos(display.cx*0.4, height - 350)
	--rankButton:setTitleFontSize(20)
    settingButton:addTo(bottomLayer)
    settingButton:setPressedActionEnabled(true)
    settingButton:addClickEventListener(function(sender, eventType)
		--local Loginscene=require("D:/quick-cocos2dx-community/test/src/app/scenes/RegisterScene.lua")
        --local transition=display.wrapSceneWithTransition(Loginscene,"fade",0.5)
        --display.replaceScene()
        app:enterScene("SettingScene", nil, "fade", 0.8)
	end)
    --img
    --[[local temp = ccui.ImageView:create(MENU_CONTINUE_PATH)
    local listView = ccui.ListView:create()
    -- 以某个元素宽度做容器宽度
	listView:setContentSize(temp:getContentSize().width, height)
    listView:setAnchorPoint(0, 0.5)
	listView:setPosition(10, height*0.1 )
    listView:setDirection(1)
	listView:addTo(bottomLayer)
    
    local img = ccui.ImageView:create(MENU_NEWGAME_PATH)
    listView:pushBackCustomItem(img)
    img = ccui.ImageView:create(MENU_CONTINUE_PATH)
    listView:pushBackCustomItem(img)
    img = ccui.ImageView:create(MENU_RANK_PATH)
    listView:pushBackCustomItem(img)
    img = ccui.ImageView:create(MENU_SETTING_PATH)
    listView:pushBackCustomItem(img)]]
    

    --[[local bmFontlistView = ccui.ListView:create()
	bmFontlistView:setContentSize(180, height -10)
    bmFontlistView:setAnchorPoint(0, 0.5)
	bmFontlistView:setPosition(200, height * 0.5)
    bmFontlistView:setDirection(1)
	bmFontlistView:addTo(bottomLayer)
    for i = 1, 15 do
        local font = ccui.TextBMFont:create(tostring(math.random(1, 100)), ISLANDCVBIGNUM_FNT_PATH)
        bmFontlistView:pushBackCustomItem(font)
    end--]]

    --ttf
    --[[local txtListView = ccui.ListView:create()
	txtListView:setContentSize(width * 0.5, 100)
    txtListView:setAnchorPoint(1, 0.5)
	txtListView:setPosition(width - 10, height * 0.5)
    txtListView:setDirection(2)
	txtListView:addTo(bottomLayer)
    for i = 1, 15 do
        local font = ccui.Text:create(" 我是谁 ",FONTNORMAL_TTF_PATH, 25)
        txtListView:pushBackCustomItem(font)
    end--]]

    --[[local itemWidth, itemHeight = 100, 100
    local testView = ccui.ListView:create()
	testView:setContentSize(width * 0.5, itemHeight)
    testView:setAnchorPoint(1, 0)
	testView:setPosition(width - 10, 10)
    testView:setDirection(2)
	testView:addTo(bottomLayer)
    for i = 1, 15 do
        local itemLayer = ccui.Layout:create()
        itemLayer:setBackGroundColor(cc.c3b(math.random(100, 200), math.random(100, 200), math.random(100, 200)))
        itemLayer:setBackGroundColorType(1)
        itemLayer:setContentSize(itemWidth, itemHeight)
        itemLayer:addTo(testView)

        local font = ccui.Text:create(" btn" .. i .. " ", FONTNORMAL_TTF_PATH, 25)
        font:addTo(itemLayer)
        font:setAnchorPoint(0.5, 1)
        font:pos(itemWidth * 0.5, itemHeight)

        local btn = ccui.Button:create(RANK_BG_PATH, RANK_BG_PATH)
        btn:setAnchorPoint(0.5, 0)
        btn:setScale9Enabled(true)
        btn:setContentSize(itemWidth, 50)
        btn:setTitleText(" btn" .. i .. " ")
        btn:pos(itemWidth * 0.5, 0)
        btn:setTitleFontSize(20)
        btn:addTo(itemLayer)

        -- 点击输出输入框的内容
        btn:addTouchEventListener(function(sender, eventType)
            if 2 == eventType then
                print("you click btn =", font:getString())
            end
        end)
    end]]

end

function  MainScene:createMenu()
    local continueItem=ccui.MenuItemImage:create(MENU_CONTINUE_PATH,MENU_CONTINUE_PATH)
    continueItem:setPosition(display.CX+50,display.top-200)
    function  menuItemSettingCallback(sender)
        -- body
        cclog("touch")
    end
    continueItem:registerScriptEditBoxHandler(menuItemSettingCallback(sender))
end


return MainScene
