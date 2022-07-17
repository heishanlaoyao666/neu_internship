--[[
    StoreData.lua
    商店数据
    描述：商店数据数据
    编写：周星宇
    修订：李昊
    检查：张昊煜
]]

local StoreData = {}

StoreData.goldStoreCards_ = {} -- 金币商店卡牌

StoreData.normalCardsId_ = {"1", "4", "7", "9", "18", "20"}
StoreData.rareCardsId_ = {"3", "10", "14", "15"}
StoreData.epicCardsId_ = {"2", "8", "11", "12", "16", "17"}


--[[--
    初始化

    @param none 初始化

    @return none
]]
function StoreData:init()
    self:refreshGoldStoreCards()
end

--[[--
    生成随机数

    @param s
    @param e

    @return none
]]
function StoreData:randomSelectNumber(s, e)
    math.randomseed(tostring(os.time()):reverse():sub(1, 6))
    return math.random(s, e)
end

--[[--
    随机选取一定数量卡片，在原表上进行修改

    @param tb
    @param num

    @return none
]]
function StoreData:randomSelectCards(tb, num)
    local length = #tb
    for i = 1, num do
        local ri = self:randomSelectNumber(i, length)
        local tmp = tb[i]
        tb[i] = tb[ri]
        tb[ri] = tmp
    end
end

--[[--
    刷新金币商店卡牌

    @param none

    @return none
]]
function StoreData:refreshGoldStoreCards()

    self.goldStoreCards_ = {}

    -- 假数据
    if self:randomSelectNumber(0, 1) == 0 then
        self.goldStoreCards_["1"] = { -- 资源
            type = 1, -- 金币
            cardId = "gold",
            pieceNum = 1000,
            cost = 0,
        }
    else
        self.goldStoreCards_["1"] = {
            type = 2, -- 钻石
            cardId = "diamond",
            pieceNum = 50,
            cost = 0,
        }
    end

    self:randomSelectCards(self.normalCardsId_, 3)
    for i = 1, 3 do
        self.goldStoreCards_[string.format("%d", i+1)] = { -- 普通卡
            type = 3, -- 卡片
            cardId = self.normalCardsId_[i],
            pieceNum = 36,
            cost = 360,
        }
    end

    self:randomSelectCards(self.rareCardsId_, 1)
    self.goldStoreCards_["5"] = { -- 稀有卡
        type = 3, -- 卡片
        cardId = self.rareCardsId_[1],
        pieceNum = 6,
        cost = 600,
    }

    self:randomSelectCards(self.epicCardsId_, 1)
    self.goldStoreCards_["6"] = { -- 史诗卡
        type = 3, -- 卡片
        cardId = self.epicCardsId_[1],
        pieceNum = 1,
        cost = 1000,
    }
end



return StoreData