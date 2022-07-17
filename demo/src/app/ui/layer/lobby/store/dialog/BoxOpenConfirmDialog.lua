--[[
    BoxOpenConfirmDialog.lua
    宝箱开启确认弹窗
    描述：宝箱开启确认弹窗
    编写：周星宇
    修订：李昊
    检查：张昊煜
]]
local BoxOpenConfirmDialog = class("BoxOpenConfirmDialog", require("app.ui.layer.BaseUILayout"))
local BoxOpenObtainDialog = require("app.ui.layer.lobby.store.dialog.dialog.BoxOpenObtainDialog")
local PlayerData = require("app.data.PlayerData")
local EventDef = require("app.def.EventDef")
local EventManager = require("app.manager.EventManager")
local FailDialog = require("app.ui.layer.lobby.general.dialog.FailDialog")
local DialogManager = require("app.manager.DialogManager")
local ConstDef = require("app.def.ConstDef")
local eventDispatcher = cc.Director:getInstance():getEventDispatcher()

--[[--
    构造函数

    @param cost 类型：number，花费
    @param boxSprite 类型：string，宝箱精灵图片
    @param boxCards 类型：boxCard，宝箱内容
    @param tag 类型：number，宝箱标识符(只在天梯中有用)

    @return none
]]
function BoxOpenConfirmDialog:ctor(cost, boxSprite, boxCards, tag)
    BoxOpenConfirmDialog.super.ctor(self)

    self.container_ = nil -- 全局容器

    self.boxCards_ = boxCards
    self.gold_ = boxCards.gold
    self.cost_ = cost
    self.boxSprite_ = boxSprite
    self.normalPieceNum_ = boxCards.pieceNum.normal
    self.rarePieceNum_ = boxCards.pieceNum.rare
    self.epicPieceNum_ = boxCards.pieceNum.epic
    self.legendPieceNum_ = boxCards.pieceNum.legend
    self.tag_ = tag

    -- 加载音效资源
    audio.loadFile("audio/open_box.ogg", function() end)

    self:initView()
    self:hideView()
end

--[[--
    界面初始化

    @param none

    @return none
]]
function BoxOpenConfirmDialog:initView()

    self.container_ = ccui.Layout:create()
    self.container_:setContentSize(display.width, display.height)
    self.container_:setAnchorPoint(0.5, 0.5)
    self.container_:setPosition(display.width/2, display.height/2)
    self.container_:setBackGroundColor(cc.c3b(0, 0, 0))
    self.container_:setBackGroundColorType(1)
    self.container_:setCascadeOpacityEnabled(false) -- 穿透
    self.container_:setOpacity(0.8 * 255)
    self:addChild(self.container_)

    -- 弹窗背景
    local dialog = ccui.Layout:create()
    dialog:setBackGroundImage("image/lobby/general/boxconfirm/dialog_bg.png")
    local dialogWidth, dialogHeight = dialog:getBackGroundImageTextureSize().width, dialog:getBackGroundImageTextureSize().height
    dialog:setContentSize(dialogWidth, dialogHeight)
    dialog:setAnchorPoint(0.5, 0.5)
    dialog:setPosition(display.width/2, display.height/2)
    self.container_:addChild(dialog)

    -- 关闭按钮
    local closeBtn = ccui.Button:create("image/lobby/store/gold/dialog/close_btn.png")
    closeBtn:setPosition(1*dialogWidth, 2.075*dialogHeight)
    closeBtn:addClickEventListener(function()
        self:hideView()
    end)
    self.container_:addChild(closeBtn)

    -- 金币
    local goldBG = ccui.ImageView:create("image/lobby/general/boxconfirm/gold_bg.png")
    goldBG:setPosition(0.2*dialogWidth, 0.5*dialogHeight)
    dialog:addChild(goldBG)

    local goldIcon = ccui.ImageView:create("image/lobby/general/boxconfirm/gold_icon.png")
    goldIcon:setPosition(0.2*dialogWidth, 0.55*dialogHeight)
    dialog:addChild(goldIcon)

    local goldNum = ccui.Text:create(self.gold_, "font/fzbiaozjw.ttf", 24)
    goldNum:setTextColor(cc.c4b(165, 237, 255, 255))
    goldNum:enableOutline(cc.c4b(0, 0, 0, 255), 1) -- 描边
    goldNum:setPosition(0.2*dialogWidth, 0.38*dialogHeight)
    dialog:addChild(goldNum)

    -- 普通卡牌
    local normalCardSprite = ccui.ImageView:create("image/lobby/general/boxconfirm/normal_icon.png")
    normalCardSprite:setPosition(0.4*dialogWidth, 0.6*dialogHeight)
    dialog:addChild(normalCardSprite)

    local normalCardName = ccui.Text:create("普通", "font/fzhzgbjw.ttf", 20)
    normalCardName:setTextColor(cc.c4b(214, 214, 231, 255))
    normalCardName:enableOutline(cc.c4b(20, 20, 66, 255), 2) -- 描边
    normalCardName:setPosition(0.52*dialogWidth, 0.65*dialogHeight)
    dialog:addChild(normalCardName)

    local normalPieceNum = string.format("x%d", self.normalPieceNum_)
    local normalCardNum = ccui.Text:create(normalPieceNum, "font/fzbiaozjw.ttf", 25)
    normalCardNum:setTextColor(cc.c4b(214, 214, 231, 255))
    normalCardNum:enableOutline(cc.c4b(15, 16, 59, 255), 1) -- 描边
    normalCardNum:setPosition(0.52*dialogWidth, 0.55*dialogHeight)
    dialog:addChild(normalCardNum)

    -- 稀有卡牌
    local rareCardSprite = ccui.ImageView:create("image/lobby/general/boxconfirm/rare_icon.png")
    rareCardSprite:setPosition(0.65*dialogWidth, 0.6*dialogHeight)
    dialog:addChild(rareCardSprite)

    local rareCardName = ccui.Text:create("稀有", "font/fzhzgbjw.ttf", 20)
    rareCardName:setTextColor(cc.c4b(79, 187, 245, 255))
    rareCardName:enableOutline(cc.c4b(20, 20, 66, 255), 2) -- 描边
    rareCardName:setPosition(0.77*dialogWidth, 0.65*dialogHeight)
    dialog:addChild(rareCardName)

    local rarePieceNum = string.format("x%d", self.rarePieceNum_)
    local rareCardNum = ccui.Text:create(rarePieceNum, "font/fzbiaozjw.ttf", 25)
    rareCardNum:setTextColor(cc.c4b(79, 187, 245, 255))
    rareCardNum:enableOutline(cc.c4b(15, 16, 59, 255), 1) -- 描边
    rareCardNum:setPosition(0.77*dialogWidth, 0.55*dialogHeight)
    dialog:addChild(rareCardNum)

    -- 史诗卡牌
    local epicCardSprite = ccui.ImageView:create("image/lobby/general/boxconfirm/epic_icon.png")
    epicCardSprite:setPosition(0.4*dialogWidth, 0.35*dialogHeight)
    dialog:addChild(epicCardSprite)

    local epicCardName = ccui.Text:create("史诗", "font/fzhzgbjw.ttf", 20)
    epicCardName:setTextColor(cc.c4b(210, 102, 249, 255))
    epicCardName:enableOutline(cc.c4b(20, 20, 66, 255), 2) -- 描边
    epicCardName:setPosition(0.52*dialogWidth, 0.4*dialogHeight)
    dialog:addChild(epicCardName)

    local epicPieceNum = string.format("x%d", self.epicPieceNum_)
    local epicCardNum = ccui.Text:create(epicPieceNum, "font/fzbiaozjw.ttf", 25)
    epicCardNum:setTextColor(cc.c4b(210, 102, 249, 255))
    epicCardNum:enableOutline(cc.c4b(15, 16, 59, 255), 1) -- 描边
    epicCardNum:setPosition(0.52*dialogWidth, 0.3*dialogHeight)
    dialog:addChild(epicCardNum)


    -- 传奇卡牌
    local legendCardSprite = ccui.ImageView:create("image/lobby/general/boxconfirm/legend_icon.png")
    legendCardSprite:setPosition(0.65*dialogWidth, 0.35*dialogHeight)
    dialog:addChild(legendCardSprite)

    local legendCardName = ccui.Text:create("传奇", "font/fzhzgbjw.ttf", 20)
    legendCardName:setTextColor(cc.c4b(250, 198, 17, 255))
    legendCardName:enableOutline(cc.c4b(20, 20, 66, 255), 2) -- 描边
    legendCardName:setPosition(0.77*dialogWidth, 0.4*dialogHeight)
    dialog:addChild(legendCardName)

    local legendPieceNum = string.format("x%d", self.legendPieceNum_)
    local legendCardNum = ccui.Text:create(legendPieceNum, "font/fzbiaozjw.ttf", 25)
    legendCardNum:setTextColor(cc.c4b(250, 198, 17, 255))
    legendCardNum:enableOutline(cc.c4b(15, 16, 59, 255), 1) -- 描边
    legendCardNum:setPosition(0.77*dialogWidth, 0.3*dialogHeight)
    dialog:addChild(legendCardNum)

    -- 开启宝箱按钮
    local openBtn = ccui.Button:create("image/lobby/general/boxconfirm/open_btn.png")
    openBtn:setPosition(0.5*dialogWidth, -0.05*dialogHeight)
    openBtn:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)

        if event.name == "began" then
            -- 放大事件
            local ac1 = cc.ScaleTo:create(0.1, 1.1)
            local ac2 = cc.ScaleTo:create(0.1, 1)
            local action = cc.Sequence:create(ac1, ac2)
            openBtn:runAction(action)
            return true
        else
            local state = PlayerData:purchaseBox(self.cost_, self.boxCards_)
            if state == 0 then
                audio.playEffect("audio/open_box.ogg", false)
                local dialog = BoxOpenObtainDialog.new(self.boxCards_)
                -- doEvent与showDialog的顺序影响self.tag_
                EventManager:doEvent(EventDef.ID.BOX_PURCHASE, self.tag_)
                DialogManager:showDialog(dialog)
                print("Purchase success!")
            else
                local dialog = FailDialog.new(ConstDef.FAIL_CODE.PURCHASE_DIAMOND_DEFICIENCY)
                DialogManager:showDialog(dialog)
                print("Diamond is not enough!")
            end
        end
    end)
    openBtn:setTouchEnabled(true)
    dialog:addChild(openBtn)

    -- 宝箱精灵图片
    local boxSpriteImg = ccui.ImageView:create(self.boxSprite_)
    boxSpriteImg:setScale(1.5)
    boxSpriteImg:setPosition(0.5*display.width, 0.72*display.height)
    self.container_:addChild(boxSpriteImg)


    -- 事件监听(空白处关闭)
    self.listener_ = cc.EventListenerTouchOneByOne:create()
    self.listener_:registerScriptHandler(function(touch, event)
        if self.isListening_ then
            local touchPosition = touch:getLocation()
            local x = dialog:getPositionX()
            local y = dialog:getPositionY()
            local nodeSize = dialog:getContentSize()

            local rect = cc.rect(x - nodeSize.width/2, y - nodeSize.height/2,
                    nodeSize.width, nodeSize.height)

            if not cc.rectContainsPoint(rect, touchPosition) then -- 点击黑色遮罩关闭弹窗
                self:hideView()
            end

            return true
        end
        return false
    end, cc.Handler.EVENT_TOUCH_BEGAN)

    eventDispatcher:addEventListenerWithSceneGraphPriority(self.listener_, self)

end

return BoxOpenConfirmDialog