
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()

    --开始游戏按钮
    local images = {
        normal = "ui/hall/battle/Button-Battle_Mode.png",
        pressed = "",
        disabled = "ui/hall/battle/Button-Battle_Mode.png"
    }

    local NewGameBtn = ccui.Button:create(images["normal"], images["pressed"], images["disabled"])
    NewGameBtn:setAnchorPoint(cc.p(0.5 ,0.5))
    -- 居中
    NewGameBtn:setPosition(cc.p(display.cx, display.cy))
    -- 设置缩放程度
    NewGameBtn:setScale(0.5, 0.5)
    -- 设置是否禁用(false为禁用)
    NewGameBtn:setEnabled(true)
    -- registerBtn:addClickEventListener(function()
    --     print("lalala")
    -- end)

    NewGameBtn:addTouchEventListener(function(sender, eventType)
	 	if eventType == ccui.TouchEventType.ended then
	 		local ABtn = import("app.scenes.GameView.GameScene"):new()
            display.replaceScene(ABtn,"turnOffTiles",0.5)
            print(transform)
	 	end
	end)

    self:addChild(NewGameBtn, 4)
    --self:loading()
end

function MainScene:createMiddleMiddlePanel()

end

function MainScene:loading()--启动界面，未完成,适用于分辨率：720x1280

    local tips = cc.Label:createWithTTF("大厅预加载，进行中...","ui/font/fzhz.ttf",20)
    tips:setPosition(360,30)
    tips:setColor(cc.c3b(255,255,255))
    tips:addTo(self)

    local progressNum = 0
    local progress = cc.Label:createWithTTF(progressNum,"ui/font/fzhz.ttf",20)
    progress:setPosition(700,30)
    progress:setColor(cc.c3b(255,239,117))
    progress:addTo(self)
    local progressScheduler = cc.Director:getInstance():getScheduler()--刷新得分计时器
    local progressHandler = progressScheduler:scheduleScriptFunc(
            function()
                progressNum = progressNum + 3
                progress:setString(progressNum)
            end,0.15,false)

    local barProBg = cc.Sprite:create("ui/loading/processbar_bottomchart.png")  -- 条形进度条背景
    barProBg:setAnchorPoint(0,0)
    barProBg:setScale(48,1)
    barProBg:setPosition(0, 0)
    barProBg:addTo(self)

    local sprite = cc.Sprite:create("ui/loading/processbar_stretch_full.png")--进度条实际进度

    local barPro = cc.ProgressTimer:create(sprite)  -- 创建进度条
    --barPro:setPosition(0, 0)
    --[[
        setType：设置进度条类型
        cc.PROGRESS_TIMER_TYPE_RADIAL为圆形
        cc.PROGRESS_TIMER_TYPE_BAR为条形
    ]]
    barPro:setType(cc.PROGRESS_TIMER_TYPE_BAR)
    --[[
        setMidpoint：设置进度条的起点位置：cc.p(x, y)
        cc.p(0, 0)为左下角
        cc.p(1, 1)为右上角
        e.g.
        cc.p(0, y)：x为0，不管y为0还是1，水平方向的起点为最左边，则进度条减少的方向为从右到左
        cc.p(x, 1)：y为1，不管x为0还是1，垂直方向的起点为最上边，则进度条减少的方向为从下到上
    ]]
    barPro:setMidpoint(cc.p(0, 0))
    --[[
        setBarChangeRate：设置垂直和水平方向的进度：cc.p(x, y)
        x和y分别为水平方向和垂直方向，其值均为0或1，0表示该方向没有进度，1表示该方向有进度
        e.g.
        cc.p(1, 0)表示水平方向有进度，垂直方向无进度
        cc.p(1, 1)表示水平和垂直方向都有进度
    ]]
    barPro:setBarChangeRate(cc.p(1, 0))
    local size = barProBg:getContentSize()
    barPro:setPosition(cc.p(size.width/2+70, size.height/2))
    barPro:addTo(self)
    barPro:setPercentage(0)  -- 设置进度：0-100
    local action1 = cc.ProgressFromTo:create(5,0,100)
    --local action = cc.RepeatForever:create(action1)
    barPro:runAction(action1)




end


function MainScene:onEnter()
end

function MainScene:onExit()
end

return MainScene
