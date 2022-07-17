--[[
    LadderItemComp.lua
    天梯物品组件
    描述：天梯物品组件
    编写：周星宇
    修订：李昊
    检查：张昊煜
]]
local LadderItemComp = class("LadderItemComp", require("app.ui.layer.BaseUILayout"))
local ConstDef = require("app.def.ConstDef")
local DialogManager = require("app.manager.DialogManager")
local EventDef = require("app.def.EventDef")
local EventManager = require("app.manager.EventManager")
local BoxOpenConfirmDialog = require("app.ui.layer.lobby.store.dialog.BoxOpenConfirmDialog")
local PlayerData = require("app.data.PlayerData")
local StoreData = require("app.data.StoreData")
local MsgManager = require("app.manager.MsgManager")

--[[--
    构造函数

    @param card 类型：card，卡片
    @param pieceNum 类型：number，卡片碎片数量

    @return none
]]
function LadderItemComp:ctor(index, award, tag)
    LadderItemComp.super.ctor(self)

    self.container_ = nil
    self.cardBG_ = nil
    self.cardIcon_ = nil
    self.lineFG_ = nil

    self:initParam(index, award, tag)
    self:initView()
end

--[[--
    参数初始化

    @param none

    @return none
]]
function LadderItemComp:initParam(index, award, tag)
    self.index_ = index
    self.award_ = award
    self.tag_ = tag
    self.ifGot_ = PlayerData:getIfGot(index) -- 奖励是否已经获得
    self.integral_ = PlayerData:getIntegral() -- 奖杯数
    self.point_ = 25+50*(self.index_-1) -- 奖励点
    self.ifUnlocked_ = PlayerData:getIntegral()-self.point_ >= 0 and true or false -- 奖励是否已经解锁
    self.map_ = {
        StoreData:getNormalBox(),
        StoreData:getRareBox(),
        StoreData:getEpicBox(),
        StoreData:getLegendBox()
    }
end

--[[--
    界面初始化

    @param none

    @return none
]]
function LadderItemComp:initView()

    local width, height = 0.9 * ConstDef.WINDOW_SIZE.LADDER_VIEW.WIDTH / 3, ConstDef.WINDOW_SIZE.LADDER_VIEW.HEIGHT
    self.container_ = ccui.Layout:create()
    self.container_:setContentSize(width, height)
    self:addChild(self.container_)

    local type = self.award_.TYPE

    -- 蓝色进度条背景
    local lineBG = ccui.ImageView:create("image/lobby/index/ladder/scale/blue_line.png")
    lineBG:setScale(1/3, 1)
    lineBG:setPosition(0.5 * width, 0.2 * height)
    self.container_:addChild(lineBG)

    local edgeBG = ccui.ImageView:create("image/lobby/index/ladder/scale/blue_edge.png")
    edgeBG:setScale(1)
    edgeBG:setPosition(0.5 * width, 0.2 * height)
    self.container_:addChild(edgeBG)

    -- 黄色进度条前景
    self.lineFG_ = ccui.ImageView:create("image/lobby/index/ladder/scale/yellow_line.png")
    local scale = (PlayerData:getIntegral()-50*(self.index_-1))/50
    scale = scale >= 0 and scale or 0
    scale = scale <=1 and scale or 1
    self.lineFG_:setScale(scale , 1)
    self.lineFG_:setAnchorPoint(0, 0.5)
    self.lineFG_:setPosition(0, 0.2 * height)
    self.container_:addChild(self.lineFG_)

    -- 文字
    local progressText = ccui.Text:create(self.point_, "font/fzbiaozjw.ttf", 20)
    progressText:setTextColor(cc.c4b(165, 237, 255, 255))
    progressText:enableOutline(cc.c4b(0, 0, 0, 255), 2) -- 描边
    progressText:setPosition(0.5 * width, 0.1 * height)
    self.container_:addChild(progressText)

    -- 卡片背景
    local bg = "image/lobby/index/ladder/got_border.png"
    local icon = nil

    -- 可变背景
    self.cardBG_ = ccui.Layout:create()
    self.cardBG_:setBackGroundImage(bg)
    local cardBGWidth, cardBGHeight = self.cardBG_:getBackGroundImageTextureSize().width,
    self.cardBG_:getBackGroundImageTextureSize().height
    self.cardBG_:setContentSize(cardBGWidth, cardBGHeight)
    self.cardBG_:setAnchorPoint(0.5, 0.5)
    self.cardBG_:setPosition(0.5 * width, 0.6 * height)
    self.container_:addChild(self.cardBG_)

    -- 可变图标
    self.cardIcon_ = ccui.ImageView:create(icon)
    self.cardIcon_:setAnchorPoint(0.5, 0.5)
    self.cardIcon_:setPosition(0.5*cardBGWidth, 0)
    self.cardBG_:addChild(self.cardIcon_)

    -- 奖励
    if type == 1 then -- 宝箱
        local spriteBtn = ccui.ImageView:create(self.award_.ICON)
        spriteBtn:setScale(0.75)
        spriteBtn:setAnchorPoint(0.5, 0.5)
        spriteBtn:setPosition(0.5 * cardBGWidth, 0.5 * cardBGHeight)
        self.cardBG_:addChild(spriteBtn)
    elseif type == 2 or type == 3 then -- 资源
        local spriteBtn = ccui.ImageView:create(self.award_.ICON)
        spriteBtn:setScale(1)
        spriteBtn:setPosition(0.5 * cardBGWidth, 0.6 * cardBGHeight)
        self.cardBG_:addChild(spriteBtn)
        local spriteText = ccui.Text:create(self.award_.NUM, "font/fzbiaozjw.ttf", 30)
        spriteText:setPosition(0.5 * cardBGWidth, 0.3 * cardBGHeight)
        self.cardBG_:addChild(spriteText)

    elseif type == 4 then -- 卡牌
        local spriteBtn = ccui.ImageView:create(self.award_.ICON)
        spriteBtn:setScale(1.2)
        spriteBtn:setPosition(0.5 * cardBGWidth, 0.5 * cardBGHeight)
        self.cardBG_:addChild(spriteBtn)
    end

    -- 容器事件
    self.cardBG_:addTouchEventListener(function(sender, event)
        if event == 0 then
            -- 放大事件
            local ac1 = cc.ScaleTo:create(0.1, 1.1)
            local ac2 = cc.ScaleTo:create(0.1, 1)
            local action = cc.Sequence:create(ac1, ac2)
            self.cardBG_:runAction(action)
            return true
        elseif event == 2 then
            if self.ifUnlocked_ and not self.ifGot_ then
                if type == 1 then -- 宝箱
                    local dialog = BoxOpenConfirmDialog.new(0, self.award_.ICON, self.map_[self.award_.RARITY], self.tag_)
                    DialogManager:showDialog(dialog)
                else
                    if type == 2 then -- 金币
                        PlayerData:obtainGold(self.award_.NUM)
                        EventManager:doEvent(EventDef.ID.GOLD_OBTAIN)
                    elseif type == 3 then -- 钻石
                        PlayerData:obtainDiamond(self.award_.NUM)
                        EventManager:doEvent(EventDef.ID.DIAMOND_OBTAIN)
                    elseif type == 4 then -- 卡牌
                        PlayerData:purchaseCard(self.award_.ID, self.award_.NUM, 0)
                        EventManager:doEvent(EventDef.ID.CARD_PURCHASE)
                    end

                    self.ifGot_ = true
                    PlayerData:setIfGot(self.index_, true)
                    self.cardBG_:setBackGroundImage("image/lobby/index/ladder/got_border.png")
                    self.cardIcon_:loadTexture("image/lobby/index/ladder/got_icon.png")
                    self:update()
                end
            end
            return true
        end

    end)
    self.cardBG_:setTouchEnabled(true)

    -- 钥匙
    if self.index_ == 1 then
        local key = ccui.ImageView:create("image/lobby/index/ladder/scale/key_icon.png")
        key:setScale(1)
        key:setPosition(0.05 * width, 0.22 * height)
        self.container_:addChild(key)
    end

end

--[[--
    onEnter

    @param none

    @return none
]]
function LadderItemComp:onEnter()
    EventManager:regListener(EventDef.ID.INIT_PLAYER_DATA, self, function()
        -- 更新前景
        local scale = (PlayerData:getIntegral()-50*(self.index_-1))/50
        scale = scale >= 0 and scale or 0
        scale = scale <=1 and scale or 1
        self.lineFG_:setScale(scale , 1)

        -- 卡片背景
        self.ifGot_ = PlayerData:getIfGot(self.index_)
        self.ifUnlocked_ = PlayerData:getIntegral()-self.point_ >= 0 and true or false

        local bg = nil
        local icon = nil

        if self.ifGot_ and self.ifUnlocked_ then -- 已解锁并且已获得
            bg = "image/lobby/index/ladder/got_border.png"
            icon = "image/lobby/index/ladder/got_icon.png"
        elseif self.ifUnlocked_ then -- 已解锁但是未获得
            bg = "image/lobby/index/ladder/unlocked_border.png"
            icon = nil
        else -- 未解锁
            bg = "image/lobby/index/ladder/locked_border.png"
            icon = "image/lobby/index/ladder/locked_icon.png"
        end

        -- 可变背景
        self.cardBG_:setBackGroundImage(bg)
        -- 可变图标
        self.cardIcon_:loadTexture(icon)
    end)
    EventManager:regListener(EventDef.ID.BOX_PURCHASE, self, function(tag)
        if self.tag_ == tag then
            self.ifGot_ = true -- 设置宝箱已经获得
            PlayerData:setIfGot(self.index_, true)
            self.cardBG_:setBackGroundImage("image/lobby/index/ladder/got_border.png")
            self.cardIcon_:loadTexture("image/lobby/index/ladder/got_icon.png")
            self:update()
        end
    end)
end

--[[--
    onExit

    @param none

    @return none
]]
function LadderItemComp:onExit()
    EventManager:unRegListener(EventDef.ID.INIT_PLAYER_DATA, self)
    EventManager:unRegListener(EventDef.ID.BOX_PURCHASE, self)
end

--[[--
    界面刷新

    @param none

    @return none
]]
function LadderItemComp:update()
    MsgManager:sendPlayerData() -- 向服务端更新数据
end

return LadderItemComp