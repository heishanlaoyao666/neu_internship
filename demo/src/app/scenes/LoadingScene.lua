--[[
    LoadingScene.lua
    描述：开屏加载界面
    编写：张昊煜
    修订：李昊
    检查：周星宇
]]
local LoadingScene = class("LoadingScene", function()
    return display.newScene("LoadingScene")
end)

--[[--
    构造函数

    @param none

    @return none
]]
function LoadingScene:ctor()
    -- 开屏背景 - 1280 * 720
    local indexBG = display.newSprite("image/loading/loading_bg.jpg")
    indexBG:setAnchorPoint(0.5, 0.5)
    indexBG:setPosition(display.cx, display.cy)
    self:addChild(indexBG)

    local loadingText = ccui.Text:create("大厅预加载，进行中...", "font/fzhz.ttf", 20)
    loadingText:enableOutline(cc.c4b(0, 0, 0, 255), 1) -- 2像素纯黑色描边
    loadingText:setTextColor(cc.c4b(255, 255, 255, 255))
    loadingText:setPosition(display.cx, display.cy-600)
    loadingText:addTo(self)

    local percentText = ccui.Text:create("0%", "font/fzhz.ttf", 20)
    percentText:enableOutline(cc.c4b(0, 0, 0, 255), 1) -- 2像素纯黑色描边
    percentText:setTextColor(cc.c4b(253, 239, 117, 255))
    percentText:setPosition(display.cx+300, display.cy-600)
    percentText:addTo(self)

    --创建LoadingBar的背景黑色条
    local processBarBG = display.newScale9Sprite("image/loading/processbar_bg.png", 0, 0, cc.size(720, 20))
    processBarBG:setPosition(display.cx, display.cy-630)
    self:addChild(processBarBG)


    local processBar = display.newScale9Sprite("image/loading/processbar_body.png", 0, 0, cc.size(5/100*720*2, 20))
    processBar:setPosition(0, display.cy-630)
    self:addChild(processBar)
    percentText:setString("5%")

    local processBarHead = display.newSprite("image/loading/processbar_head.png")
    processBarHead:setScale(20/15)
    processBarHead:setPosition(processBar:getContentSize().width/2+10, display.cy-630)
    self:addChild(processBarHead)

    -- 延时执行回调函数
    self:performWithDelay(function()
        processBar:setContentSize(25/100*720*2, 20)
        processBarHead:setPosition(processBar:getContentSize().width/2+10, display.cy-630)
        percentText:setString("25%")

        self:performWithDelay(function()
            processBar:setContentSize(75/100*720*2, 20)
            processBarHead:setPosition(processBar:getContentSize().width/2+10, display.cy-630)
            percentText:setString("75%")

            self:performWithDelay(function()
                processBar:setContentSize(100/100*720*2, 20)
                processBarHead:setPosition(processBar:getContentSize().width/2+10, display.cy-630)
                percentText:setString("100%")

                self:performWithDelay(function()
                    display.replaceScene(require("app.scenes.LogInAndRegisterScene"):new())
                end, 0.25)

            end, 0.25)

        end, 0.25)

    end, 1)


end

--[[--
    帧循环

    @param dt 类型：number，帧间隔，单位秒

    @return none
]]
function LoadingScene:update(dt)
end

return LoadingScene