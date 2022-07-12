local Shopdata = {}
--[[
    函数用途：随机获得ID
    --]]
function Shopdata:randomId(TYPE)
    local normalArray = {"01","04","07","09","18","20"}
    local rareArray = {"03","10","14","15"}
    local epicArray = {"02","08","11","12","16","17"}
    if TYPE == 1 then
        local index = math.random(1, #normalArray)
        return normalArray[index]
    elseif TYPE == 2 then
        local index = math.random(1, #rareArray)
        return rareArray[index]
    elseif TYPE == 3 then
        local index = math.random(1, #epicArray)
        return epicArray[index]
    end
end


--[[
    函数用途：初始化ID
    --]]
function Shopdata:initID()
    math.randomseed(os.time())
    Shopdata.ITEM[2].ID = Shopdata:randomId(1)

    Shopdata.ITEM[3].ID = Shopdata:randomId(1)

    Shopdata.ITEM[4].ID = Shopdata:randomId(1)

    Shopdata.ITEM[5].ID = Shopdata:randomId(2)

    Shopdata.ITEM[6].ID = Shopdata:randomId(3)
end

Shopdata.ITEM = {
    {
        TYPE = 1,--钻石
        FRAGMENT_NUM = 100,--数量
        PRICE = 0,--价格
        ID = nil,
        ICON = "ui/hall/shop/Goldcoin-shop/ItemIcon-Diamond.png",
        SOLD_OUT = false
    },
    {
        TYPE = 2,--普通卡
        FRAGMENT_NUM = 36,
        PRICE = 360,
        ID = 01,
        SOLD_OUT = false
    },
    {
        TYPE = 2,--普通卡
        FRAGMENT_NUM = 36,
        PRICE = 360,
        ID = 01,
        SOLD_OUT = false
    },
    {
        TYPE = 2,--普通卡
        FRAGMENT_NUM = 36,
        PRICE = 360,
        ID = 01,
        SOLD_OUT = false
    },
    {
        TYPE = 3,--稀有卡
        FRAGMENT_NUM = 6,
        PRICE = 600,
        ID = 01,
        SOLD_OUT = false
    },
    {
        TYPE = 4,--史诗卡
        FRAGMENT_NUM = 1,
        PRICE = 1000,
        ID = 01,
        SOLD_OUT = false
    }

}

return Shopdata