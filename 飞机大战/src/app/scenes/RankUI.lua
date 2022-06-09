local eventDispatcher = cc.Director:getInstance():getEventDispatcher()

local RankUI = class("RankUI", function()
	return display.newScene("RankUI")
end)

function RankUI:ctor()
	self:addNodeEventListener(cc.NODE_EVENT, function(e)
		if e.name == "enter" then
			self:onEnter()
		elseif e.name == "exit" then
			eventDispatcher:removeEventListener(self.eventListenerCustom_)
		end
	end)
end

function RankUI:onEnter()
	local width,height = 480,720
	local startLayer = ccui.Layout:create()
    startLayer:setBackGroundImage("res\\ui\\main\\bg_menu.jpg")
	startLayer:setBackGroundColorType(1)
    startLayer:setContentSize(cc.size(width,height))
    startLayer:setPosition(display.cx, display.cy)
    startLayer:setAnchorPoint(cc.p(0.5, 0.5))
	startLayer:addTo(self)

    display.newTTFLabel({
        text = "排行榜:",
        size = 25,
        --color = display.COLOR_WHITE
	})
    :align(display.LEFT_CENTER, 70, display.top - 130)
    :addTo(self)

    local listView = ccui.ListView:create()
    -- 以某个元素宽度做容器宽度
	listView:setContentSize(400, 300)
    listView:setAnchorPoint(0.5, 0.5)
	listView:setPosition(display.cx, display.top-380)
    listView:setDirection(1)
	listView:addTo(self)
	local score={"10000","9000","8000","7000","6000"}
    for i = 1, 5 do
        local img = ccui.ImageView:create("res\\ui\\rank\\rank_item_bg.png")
		img:setScale9Enabled(true)  --开启九宫格
		img:setContentSize(cc.size(400,70))
        listView:pushBackCustomItem(img)

		local img1 = ccui.ImageView:create("res\\ui\\rank\\rank_bg.png")
		img1:setAnchorPoint(0.5,0.5)
		img1:setScale9Enabled(true)  --开启九宫格
		img1:setContentSize(cc.size(280,50))
		img1:pos(230,35)
        img1:addTo(img)

		local font1 = ccui.Text:create("昵称" .. i, "FontNormal.ttf", 35)
        font1:addTo(img)
        font1:setAnchorPoint(0.5, 0.5)
        font1:pos(150, 40)

		local font2 = ccui.TextBMFont:create(score[i], "islandcvbignum.fnt")
		font2:setScale(0.3)
		font2:setAnchorPoint(1.0,0.5)
		font2:pos(350,35)
        font2:addTo(img)

		local font = ccui.TextBMFont:create(i, "islandcvbignum.fnt")
		font:setScale(0.5)
		font:setAnchorPoint(0.5,0.5)
		font:pos(35,35)
        font:addTo(img)
    end

    local cancelButton = ccui.Button:create("res\\ui\\back_peek0.png",
	"res\\ui\\back_peek1.png",  1)
    cancelButton:setAnchorPoint(0,1)
	cancelButton:setScale9Enabled(true)
	cancelButton:setContentSize(cc.size(130, 40))
	--cancelButton:setTitleText("Cancel")
	cancelButton:setTitleFontSize(25)
	cancelButton:addTouchEventListener(function(sender, eventType)
		if 2 == eventType then
			if cc.UserDefault:getInstance():getBoolForKey("yinxiao") then
                audio.playEffect("res\\sounds\\buttonEffet.ogg",false)
            end
			local AnotherScene=require("src\\app\\scenes\\MainScene.lua"):new()
                display.replaceScene(AnotherScene, "fade", 0.5)
		end
	end)
	cancelButton:pos(10, display.top-10 )
	cancelButton:addTo(self)

end

return RankUI

