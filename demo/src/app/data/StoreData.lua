--[[
    StoreData.lua
    商店数据
    描述：存放商店的相关信息
    编写：周星宇
    修订：李昊
    检查：张昊煜
]]

local PlayerData = require("app.data.PlayerData")
local CardInfoDef = require("app.def.CardInfoDef")
local StoreData = {}


local goldStoreCards_ = {} -- 金币商店卡牌

-- 钻石商店宝箱
local normalBox_ = {}
local rareBox_ = {}
local epicBox_ = {}
local legendBox_ = {}

local normalCards_ = {}
local rareCards_ = {}
local epicCards_ = {}
local legendCards_ = {}

--[[--
    初始化

    @param none 初始化

    @return none
]]
function StoreData:init()
    normalCards_ = PlayerData:getCardsByRarity(CardInfoDef.CARD_RAR.NORMAL)
    rareCards_ = PlayerData:getCardsByRarity(CardInfoDef.CARD_RAR.RARE)
    epicCards_ = PlayerData:getCardsByRarity(CardInfoDef.CARD_RAR.EPIC)
    legendCards_ = PlayerData:getCardsByRarity(CardInfoDef.CARD_RAR.LEGEND)
    self:initGoldStore()
    self:initDiamondStore()
end

--[[--
    获取金币商店卡牌

    @param none

    @return cards
]]
function StoreData:getGoldStoreCards()
    return goldStoreCards_
end

--[[--
    设置金币商店卡牌

    @param cards

    @return none
]]
function StoreData:setGoldStoreCards(cards)
    goldStoreCards_ = cards
end

--[[--
    刷新金币商店卡牌

    @param none

    @return none
]]
function StoreData:refreshGoldStoreCards()


end

--[[--
    初始化金币商店

    @param none

    @return none
]]
function StoreData:initGoldStore()

    goldStoreCards_ = {}
    -- 假数据

    for i = 1, 6 do
        local index = string.format("%d", i)
        goldStoreCards_[index] = { -- 资源
            type = 1, -- 金币
            cardId = "gold",
            pieceNum = 1000,
            cost = 0,
        }
    end

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
    初始化钻石商店

    @param none

    @return none
]]
function StoreData:initDiamondStore()
    self:setNormalBox()
    self:setRareBox()
    self:setEpicBox()
    self:setLegendBox()
end

--[[--
    设置普通宝箱

    @param none

    @return none
]]
function StoreData:setNormalBox()

    self:randomSelectCards(normalCards_, 2)
    self:randomSelectCards(rareCards_,1)
    self:randomSelectCards(epicCards_, 1)

    normalBox_ = { -- 40 1 1
        gold = 300,
        pieceNum = {
            normal = 40,
            rare = 1,
            epic = 1,
            legend = 0
        },
        cards = {
            { -- 1
                cardId = normalCards_[1]:getId(),
                pieceNum = 20
            },
            { -- 2
                cardId = normalCards_[2]:getId(),
                pieceNum = 20
            },
            { -- 3
                cardId = rareCards_[1]:getId(),
                pieceNum = 1
            },
            { -- 4
                cardId = epicCards_[1]:getId(),
                pieceNum = 1
            }
        }
    }
end

--[[--
    设置稀有宝箱

    @param none

    @return none
]]
function StoreData:setRareBox()

    self:randomSelectCards(normalCards_, 2)
    self:randomSelectCards(rareCards_,1)
    self:randomSelectCards(epicCards_, 1)

    rareBox_ = { -- 70 5 2
        gold = 500,
        pieceNum = {
            normal = 70,
            rare = 5,
            epic = 2,
            legend = 0
        },
        cards = {
            { -- 1
                cardId = normalCards_[1]:getId(),
                pieceNum = 35
            },
            { -- 2
                cardId = normalCards_[2]:getId(),
                pieceNum = 35
            },
            { -- 3
                cardId = rareCards_[1]:getId(),
                pieceNum = 5
            },
            { -- 4
                cardId = epicCards_[1]:getId(),
                pieceNum = 2
            }
        }
    }
end

--[[--
    设置史诗宝箱

    @param none

    @return none
]]
function StoreData:setEpicBox()

    self:randomSelectCards(normalCards_, 4)
    self:randomSelectCards(rareCards_,2)
    self:randomSelectCards(epicCards_, 1)
    self:randomSelectCards(legendCards_, 1)

    epicBox_ = { -- 300 20 5 1
        gold = 1000,
        pieceNum = {
            normal = 300,
            rare = 20,
            epic = 5,
            legend = 1
        },
        cards = {
            { -- 1
                cardId = normalCards_[1]:getId(),
                pieceNum = 75
            },
            { -- 2
                cardId = normalCards_[2]:getId(),
                pieceNum = 75
            },
            { -- 3
                cardId = normalCards_[3]:getId(),
                pieceNum = 75
            },
            { -- 4
                cardId = normalCards_[4]:getId(),
                pieceNum = 75
            },
            { -- 5
                cardId = rareCards_[1]:getId(),
                pieceNum = 10
            },
            { -- 6
                cardId = rareCards_[2]:getId(),
                pieceNum = 10
            },
            { -- 7
                cardId = epicCards_[1]:getId(),
                pieceNum = 5
            },
            { -- 8
                cardId = legendCards_[1]:getId(),
                pieceNum = 1
            }
        }
    }
end

--[[--
    设置传说宝箱

    @param none

    @return none
]]
function StoreData:setLegendBox()

    self:randomSelectCards(normalCards_, 4)
    self:randomSelectCards(rareCards_,2)
    self:randomSelectCards(epicCards_, 1)
    self:randomSelectCards(legendCards_, 1)

    legendBox_ = { -- 600 50 10 1
        gold = 2000,
        pieceNum = {
            normal = 600,
            rare = 50,
            epic = 10,
            legend = 1
        },
        cards = {
            { -- 1
                cardId = normalCards_[1]:getId(),
                pieceNum = 150
            },
            { -- 2
                cardId = normalCards_[2]:getId(),
                pieceNum = 150
            },
            { -- 3
                cardId = normalCards_[3]:getId(),
                pieceNum = 150
            },
            { -- 4
                cardId = normalCards_[4]:getId(),
                pieceNum = 150
            },
            { -- 5
                cardId = rareCards_[1]:getId(),
                pieceNum = 25
            },
            { -- 6
                cardId = rareCards_[2]:getId(),
                pieceNum = 25
            },
            { -- 7
                cardId = epicCards_[1]:getId(),
                pieceNum = 10
            },
            { -- 8
                cardId = legendCards_[1]:getId(),
                pieceNum = 1
            }
        }
    }
end


function StoreData:getNormalCards()
    return normalCards_
end

function StoreData:getRareCards()
    return rareCards_
end

function StoreData:getEpicCards()
    return epicCards_
end

function StoreData:getLegendCards()
    return legendCards_
end

function StoreData:getNormalBox()
    return normalBox_
end

function StoreData:getRareBox()
    return rareBox_
end

function StoreData:getEpicBox()
    return epicBox_
end

function StoreData:getLegendBox()
    return legendBox_
end

return StoreData