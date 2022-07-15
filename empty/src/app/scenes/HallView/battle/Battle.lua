----内容：游戏外-战斗界面
----编写人员：孙靖博、郑蕾
---修订人员：郑蕾
---最后修改日期：7/15
local Battle = class("Battle")
local Ladder = require("app.scenes.HallView.battle.Ladder")
local KnapsackData = require("app.data.KnapsackData")
local Ladderdata = require("app.data.Ladderdata")
local TreasureChestOpenObtainView = require("app.scenes.HallView.common.TreasureChestOpenObtainView")
local GeneralView = require("app.scenes.HallView.common.GeneralView")
function Battle:ctor()
end

function Battle:battlePanel()
    local battleLayer = ccui.Layout:create()
    battleLayer:setBackGroundColorOpacity(180)--设置为透明
    --battleLayer:setBackGroundColorType(1)
    battleLayer:setAnchorPoint(0, 0)
    battleLayer:setPosition(0, display.top)
    battleLayer:setContentSize(720, 1280)

    --天梯
    Ladder:ladderCreate(battleLayer)

    --开始游戏按钮
    self:playGames(battleLayer)

    return battleLayer
end

--[[
    函数用途：新游戏按钮
    --]]
function Battle:playGames(battleLayer)
    local images = {
        normal = "ui/hall/battle/Button-Battle_Mode.png",
        pressed = "",
        disabled = "ui/hall/battle/Button-Battle_Mode.png"
    }
    local NewGameBtn = ccui.Button:create(images["normal"], images["pressed"], images["disabled"])
    NewGameBtn:setAnchorPoint(cc.p(0.5 ,0.5))
    NewGameBtn:setPosition(cc.p(display.cx, display.cy+50))
    NewGameBtn:setEnabled(true)
    NewGameBtn:addTouchEventListener(function(sender, eventType)
        if eventType == ccui.TouchEventType.ended then
            local ABtn = import("app.scenes.GameView.GameScene"):new()
            display.replaceScene(ABtn,"turnOffTiles",0.5)
        end
    end)
    NewGameBtn:addTo(battleLayer)
end

return Battle