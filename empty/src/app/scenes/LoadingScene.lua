local LoadingScene = class("LoadingScene", function()
    return display.newScene("LoadingScene")
end)

function LoadingScene:ctor()
    self:loadingPanel()
end


--[[
    函数用途：加载界面，加载完毕后切换至游戏大厅
    --]]
function LoadingScene:loadingPanel()
    local loadPanel = ccui.Layout:create()--加载页面层级
    loadPanel:setContentSize(720, 1280)
    loadPanel:setAnchorPoint(0, 0)
    loadPanel:setPosition(0,0)
    loadPanel:addTo(self)

    local loadingBg = ccui.ImageView:create("ui/loading/bottomchart.jpg")--加载页面_背景图
    loadingBg:pos(display.cx,display.cy)
    loadingBg:addTo(loadPanel)

    local tips = cc.Label:createWithTTF("大厅预加载，进行中...","ui/font/fzhz.ttf",20)--文本：大厅预加载
    tips:setPosition(360,30)
    tips:setColor(cc.c3b(255,255,255))
    tips:addTo(loadPanel)

    local progressNum = 0--文本：加载进度
    local progress = cc.Label:createWithTTF(progressNum.."%","ui/font/fzhz.ttf",20)
    progress:setPosition(650,30)
    progress:setColor(cc.c3b(255,239,117))
    progress:addTo(loadPanel)

    local barProBg = cc.Sprite:create("ui/loading/processbar_bottomchart.png")--进度条背景
    barProBg:setAnchorPoint(0,0)
    barProBg:setScale(48,1)
    barProBg:setPosition(0, 0)
    barProBg:addTo(loadPanel)

    local barPro = cc.ProgressTimer:create(cc.Sprite:create("ui/loading/processbar_stretch_full.png"))--进度条组件
    barPro:setAnchorPoint(0,0)
    barPro:setPosition(cc.p(0, 0))
    barPro:setType(cc.PROGRESS_TIMER_TYPE_BAR)
    barPro:setMidpoint(cc.p(0, 0))--进度条起点位置
    barPro:setBarChangeRate(cc.p(1, 0))--进度方向为水平方向
    barPro:addTo(loadPanel)
    barPro:setPercentage(0)--起始进度为0

    local loadAction = cc.ProgressFromTo:create(6,0,57)--动作：5秒内从0到100
    local progressScheduler= cc.Director:getInstance():getScheduler()--刷新生命计时器
    local handler = progressScheduler:scheduleScriptFunc(
            function()
                if progressNum<100 then
                    progressNum = progressNum+1
                    progress:setString(progressNum.."%")
                end
            end,1/24,false)

    local callFuncAction = cc.CallFunc:create(function()--动作执行完毕回调函数
        display.replaceScene(require("app.scenes.MainScene"):new())
        cc.Director:getInstance():getScheduler():unscheduleScriptEntry(handler)
        loadPanel:setVisible(false)
    end)
    local delayTimeAction = cc.DelayTime:create(1)--延时0.1s
    local sequenceAction = cc.Sequence:create(loadAction,delayTimeAction,callFuncAction)
    barPro:runAction(sequenceAction)


end

return LoadingScene