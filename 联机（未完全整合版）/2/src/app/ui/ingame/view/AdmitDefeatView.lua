--[[--
    认输界面
    AdmitDefeatView.lua
]]

local AdmitDefeatView = class("AdmitDefeatView",function()
    return display.newColorLayer(cc.c4b(100, 100, 100, 100))
end)

local GameData = require("app.data.ingame.GameData")
local ConstDef = require("app.def.ingame.ConstDef")

--[[--
    构造函数

    @param none

    @return none
]]
function AdmitDefeatView:ctor()
    self.adSprite_ = nil
    self.okBtn_ = nil
    self.cancelBtn_ = nil
    self.adText_ = nil

    self:initView()
end

--[[--
    界面初始化

    @param none

    @return none
]]
function AdmitDefeatView:initView()
    --认输界面
    self.adSprite_ = cc.Sprite:create("artcontent/battle(ongame)/admitdefeat_confirmationpopup/basemap_popup.png")
    self.adSprite_:setPosition(display.cx, display.cy)
    self.adSprite_:addTo(self)

    --认输文字说明
    self.adText_ = ccui.Text:create("是否认输,放弃该场战斗?","artcontent/font/fzhzgbjw.ttf",32)
    self.adText_:setPosition(270, 180)
    self.adText_:addTo(self.adSprite_)

    --确定认输按钮
    self.okBtn_ = ccui.Button:create("artcontent/battle(ongame)/admitdefeat_confirmationpopup/button_ok.png")
    self.okBtn_:setPosition(400, 80)
    self.okBtn_:addTouchEventListener(function(sender, eventType)
        if eventType == 2 then
            GameData:setGameState(ConstDef.GAME_STATE.SETTLEMENT_DEFEAT)
            self:setVisible(false)
            audio.playEffect("sounds/ui_btn_click.OGG")
        end
    end)
    self.okBtn_:addTo(self.adSprite_)

    --取消认输按钮
    self.cancelBtn_ = ccui.Button:create("artcontent/battle(ongame)/admitdefeat_confirmationpopup/button_cancel.png")
    self.cancelBtn_:setPosition(130, 80)
    self.cancelBtn_:addTouchEventListener(function(sender, eventType)
        if eventType == 2 then
            self:hideView(function()
                GameData:setGameState(ConstDef.GAME_STATE.PLAY)
                audio.playEffect("sounds/ui_btn_click.OGG")
            end)
        end
    end)
    self.cancelBtn_:addTo(self.adSprite_)

    -- 屏蔽点击
    self:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
        if event.y > 800 or event.y < 480 then
            self:hideView(function()
                GameData:setGameState(ConstDef.GAME_STATE.PLAY)
            end)
        end
        if event.name == "began" then
            return true
        end
    end)
    self:setTouchEnabled(true)
end

--[[--
    显示界面

    @param none

    @return none
]]
function AdmitDefeatView:showView()
    self:setVisible(true)
    self.adSprite_:setScale(0)
    self.adSprite_:runAction(cc.ScaleTo:create(0.15, 1))
end

--[[--
    隐藏界面

    @param callback 类型：function，动画完成回调

    @return none
]]
function AdmitDefeatView:hideView(callback)
    self.adSprite_:runAction(cc.Sequence:create(
        cc.ScaleTo:create(0.15, 0), cc.CallFunc:create(function()
            self:setVisible(false)
            if callback then
                callback()
            end
        end)
    ))
end

return AdmitDefeatView