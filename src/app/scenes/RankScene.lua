--- 排行榜页面
local SystemConst = require("app.utils.SystemConst")
local audio = require("framework.audio")
local defaults = cc.UserDefault:getInstance()

local RankScene = class("RankScene", function()
    return display.newScene("RankScene")
end)

function RankScene:ctor()

    self.size = cc.Director:getInstance():getWinSize()

    -- 背景
    local bg = cc.Sprite:create(SystemConst.MENU_BG_NAME)
    bg:setPosition(cc.p(self.size.width/2, self.size.height/2))
    bg:setScale(0.8, 0.8)
    self:addChild(bg)

    -- 返回
    local backImages = {
        normal = SystemConst.BACK_BUTTON_NORMAL,
        pressed = SystemConst.BACK_BUTTON_PRESSED,
        disabled = SystemConst.BACK_BUTTON_DISABLED
    }

    local backBtn = ccui.Button:create(backImages["normal"], backImages["pressed"], backImages["disabled"])
    -- 设置锚点
    backBtn:setAnchorPoint(cc.p(0 ,1))
    -- 居中
    backBtn:setPosition(cc.p(display.left, display.top))
    -- 设置缩放程度
    backBtn:setScale(0.75, 0.75)
    -- 设置是否禁用(false为禁用)
    backBtn:setEnabled(true)
    backBtn:addClickEventListener(function ()

        if defaults:getBoolForKey(SystemConst.SOUND_KEY) then
            audio.loadFile(SystemConst.BUTTON_EFFECT, function ()
                audio.playEffect(SystemConst.BUTTON_EFFECT, false)
            end)
        end

        cc.Director:getInstance():popScene()
    end)

    self:addChild(backBtn, 4)

    -- 排行榜列表 

    -- 文字数据
    local list = self.readFromFile()

    local layer = ccui.Layout:create()
    layer:setBackGroundColor(cc.c3b(24, 78, 168))
    layer:setBackGroundColorType(1)
    layer:setContentSize(300, 400)
    layer:setPosition(display.cx, 150)
    layer:setAnchorPoint(0.5, 0)
    layer:setCascadeOpacityEnabled(true)
    layer:setOpacity(0.5 * 255)
    layer:addTo(self)


    self.rankColTopListView = ccui.ListView:create()
    self.rankColBottomListView = ccui.ListView:create()
    self.nameColListView = ccui.ListView:create()
    self.scoreColListView = ccui.ListView:create()
    self.backRowListView = ccui.ListView:create()

    -- 项背景列表
    self.backRowListView:setContentSize(300, 400)
    self.backRowListView:setPosition(30, 120)
    self.backRowListView:setDirection(1)

    local title = ccui.ImageView:create(SystemConst.RANK_TITLE_BG)
    self.backRowListView:pushBackCustomItem(title)

    for i = 1, 5 do
        local img = ccui.ImageView:create(SystemConst.RANK_ITEM_BG)
        img:setScale(0.95, 0.95)
        self.backRowListView:pushBackCustomItem(img)
    end

    self:addChild(self.backRowListView, 4)


    -- 排名分列表

    self.rankColTopListView:setContentSize(70, 350)
    self.rankColTopListView:setPosition(30, 150)
    self.rankColTopListView:setDirection(1)
    for i = 1, 3 do
        local font = ccui.TextBMFont:create(tostring(i), SystemConst.BMF_FONT)
        font:setScale(0.4, 0.4)

        self.rankColTopListView:pushBackCustomItem(font)
    end

    -- 设置高度间隔
    self.rankColTopListView:setItemsMargin(-38)

    self:addChild(self.rankColTopListView, 4)


    self.rankColBottomListView:setContentSize(70, 130)
    self.rankColBottomListView:setPosition(60, 142)
    self.rankColBottomListView:setDirection(1)
    for i = 4, 5 do
        self.rankColBottomListView:pushBackCustomItem(ccui.Text:create(i, "FontNormal.ttf", 40))
    end

    -- 设置高度间隔
    self.rankColBottomListView:setItemsMargin(28)

    self:addChild(self.rankColBottomListView, 4)


    -- 姓名分列表
    self.nameColListView:setContentSize(100, 300)
    self.nameColListView:setPosition(150, 160)
    self.nameColListView:setDirection(1)
    for i = 1, 5 do
        self.nameColListView:pushBackCustomItem(ccui.Text:create(list[i]['name'], "FontNormal.ttf", 25))
    end

    -- 设置高度间隔
    self.nameColListView:setItemsMargin(41)

    self:addChild(self.nameColListView, 4)

    -- 得分分列表
    self.scoreColListView:setContentSize(100, 300)
    self.scoreColListView:setPosition(230, 160)
    self.scoreColListView:setDirection(1)
    for i = 1, 5 do
        self.scoreColListView:pushBackCustomItem(ccui.Text:create(list[i]['score'], "FontNormal.ttf", 25))
    end

    -- 设置高度间隔
    self.scoreColListView:setItemsMargin(41)

    self:addChild(self.scoreColListView, 4)

end

function RankScene:onEnter()
end

function RankScene:onExit()
end


-- 读文件
function RankScene.readFromFile()
    local writablePath = cc.FileUtils:getInstance():getWritablePath()
    print("writable Path = ", writablePath)
    local f = io.open(writablePath .. SystemConst.JSON_RANK, "r")
    io.input(f)
    local temp = io.read("*a")
    print(temp)
    io.close(f)
    local tb = json.decode(temp)
    return tb
end

return RankScene
