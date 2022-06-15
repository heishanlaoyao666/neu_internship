
local RankScene = class("RankScene", function()
    return display.newScene("RankScene")
end)

function RankScene:ctor()
    --主界面背景图
    display.newSprite("bg_menu.jpg")
           :pos(display.cx,display.cy)
           :addTo(self)
    self:backPanel()
    self:rankingPanel()

end

--[[
    函数用途：返回按钮
    --]]
function RankScene:backPanel()
    --按钮：返回主菜单
    local backButton = ccui.Button:create("ui/back_peek0.png","ui/back_peek1.png")
    backButton:setScale(1,1)
    backButton:pos(80 , 690)
    backButton:setAnchorPoint(0.5,0.5)
    backButton:addTouchEventListener(function(sender,eventType)
        if eventType == ccui.TouchEventType.ended then--场景跳转回主菜单
            self:playEffect("sounds/buttonEffet.ogg")
            local mainScene = import("app.scenes.MainScene"):new()
            display.replaceScene(mainScene,"turnOffTiles",0.5)
            print(transform)
        end
    end)
    backButton:addTo(self)
end

function RankScene:rankingPanel()
    --层：显示排行榜
    local rankingLayer = ccui.Layout:create()
    --rankingLayer:setBackGroundColor(cc.c3b(100, 0, 0))--设置为红色
    rankingLayer:setBackGroundColorOpacity(180)--设置为透明
    --rankingLayer:setBackGroundColorType(1)
    rankingLayer:setContentSize(300, 480)
    rankingLayer:setPosition(90, display.top - 100)
    rankingLayer:setAnchorPoint(0, 1)
    rankingLayer:addTo(self)

    rank1 = display.newSprite("ui/rank/rank_item_bg.png")--排行榜底部填充UI
                      :setScale(1.3,1)
                      :pos(150,430)
                      :setAnchorPoint(0.5,0.5)
                      :addTo(rankingLayer)
    rank2 = display.newSprite("ui/rank/rank_item_bg.png")--排行榜底部填充UI
                   :setScale(1.3,1)
                   :pos(150,350)
                   :setAnchorPoint(0.5,0.5)
                   :addTo(rankingLayer)
    rank3 = display.newSprite("ui/rank/rank_item_bg.png")--排行榜底部填充UI
                   :setScale(1.3,1)
                   :pos(150,270)
                   :setAnchorPoint(0.5,0.5)
                   :addTo(rankingLayer)
    rank4 = display.newSprite("ui/rank/rank_item_bg.png")--排行榜底部填充UI
                   :setScale(1.3,1)
                   :pos(150,190)
                   :setAnchorPoint(0.5,0.5)
                   :addTo(rankingLayer)
    rank5 = display.newSprite("ui/rank/rank_item_bg.png")--排行榜底部填充UI
                   :setScale(1.3,1)
                   :pos(150,110)
                   :setAnchorPoint(0.5,0.5)
                   :addTo(rankingLayer)



    rank_bg1 = display.newSprite("ui/rank/rank_bg.png")--排行榜底部填充UI
                   :setScale(1.2,0.5)
                   :pos(190,430)
                   :setAnchorPoint(0.5,0.5)
                   :addTo(rankingLayer)
    rank_bg2 = display.newSprite("ui/rank/rank_bg.png")--排行榜底部填充UI
                      :setScale(1.2,0.5)
                      :pos(190,350)
                      :setAnchorPoint(0.5,0.5)
                      :addTo(rankingLayer)
    rank_bg3 = display.newSprite("ui/rank/rank_bg.png")--排行榜底部填充UI
                      :setScale(1.2,0.5)
                      :pos(190,270)
                      :setAnchorPoint(0.5,0.5)
                      :addTo(rankingLayer)
    rank_bg4 = display.newSprite("ui/rank/rank_bg.png")--排行榜底部填充UI
                      :setScale(1.2,0.5)
                      :pos(190,190)
                      :setAnchorPoint(0.5,0.5)
                      :addTo(rankingLayer)
    rank_bg5 = display.newSprite("ui/rank/rank_bg.png")--排行榜底部填充UI
                      :setScale(1.2,0.5)
                      :pos(190,110)
                      :setAnchorPoint(0.5,0.5)
                      :addTo(rankingLayer)
    --BMFont名次图标
    label1 = cc.Label:createWithBMFont("ui/rank/islandcvbignum.fnt", 1);
    label1:setScale(0.5,0.5)
    label1:setAnchorPoint(0.5,0.5)
    label1:setPosition(135,570)
    label1:addTo(self)

    label2 = cc.Label:createWithBMFont("ui/rank/islandcvbignum.fnt", 2);
    label2:setScale(0.5,0.5)
    label2:setAnchorPoint(0.5,0.5)
    label2:setPosition(135,490)
    label2:addTo(self)

    label3 = cc.Label:createWithBMFont("ui/rank/islandcvbignum.fnt", 3);
    label3:setScale(0.5,0.5)
    label3:setAnchorPoint(0.5,0.5)
    label3:setPosition(135,410)
    label3:addTo(self)

    --BMFont分数
    score1 = cc.Label:createWithBMFont("ui/rank/islandcvbignum.fnt", 1200);
    score1:setScale(0.4,0.4)
    score1:setAnchorPoint(0.5,0.5)
    score1:setPosition(300,570)
    score1:addTo(self)

    score2 = cc.Label:createWithBMFont("ui/rank/islandcvbignum.fnt", 1100);
    score2:setScale(0.4,0.4)
    score2:setAnchorPoint(0.5,0.5)
    score2:setPosition(300,490)
    score2:addTo(self)

    score3 = cc.Label:createWithBMFont("ui/rank/islandcvbignum.fnt", 1000);
    score3:setScale(0.4,0.4)
    score3:setAnchorPoint(0.5,0.5)
    score3:setPosition(300,410)
    score3:addTo(self)

    --TTF名次
    label4 = cc.Label:createWithTTF("4","font/FontNormal.ttf",100)
    label4:setScale(0.5,0.5)
    label4:setAnchorPoint(0.5,0.5)
    label4:setPosition(135,335)
    label4:addTo(self)

    label5 = cc.Label:createWithTTF("5","font/FontNormal.ttf",100)
    label5:setScale(0.5,0.5)
    label5:setAnchorPoint(0.5,0.5)
    label5:setPosition(135,255)
    label5:addTo(self)

    --TTF分数
    score4 = cc.Label:createWithTTF("900","font/FontNormal.ttf",100)
    score4:setScale(0.5,0.5)
    score4:setAnchorPoint(0.5,0.5)
    score4:setPosition(300,335)
    score4:addTo(self)

    score5 = cc.Label:createWithTTF("100","font/FontNormal.ttf",100)
    score5:setScale(0.5,0.5)
    score5:setAnchorPoint(0.5,0.5)
    score5:setPosition(300,255)
    score5:addTo(self)

end


--[[
    函数用途：播放按钮音效
    --]]
function RankScene:playEffect(path)
    local effectPath = path
    local audio = require("framework.audio")
    audio.loadFile(effectPath,function()
        audio.playEffect(effectPath,false)
    end)
end


function RankScene:onEnter()

end

function RankScene:onExit()
end

return RankScene
