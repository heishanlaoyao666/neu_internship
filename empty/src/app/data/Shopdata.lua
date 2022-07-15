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
    函数用途：比较日期大小
    --]]
function Shopdata:compareDate(preMonth,preDay)
    self.month = tonumber(os.date("%m"))--本次月
    self.day = tonumber(os.date("%d"))--本次日
    if preMonth<=self.month then
        if preDay<self.day then
            return true--本次的时间比上次的时间大则返回true
        end
    else
        return false
    end
    --local times = os.date("%m/%d")
end
--[[
    函数用途：初始化ID
--]]
function Shopdata:initItem(shopData)
    for i = 1, 6 do
        Shopdata.ITEM[i].ID = shopData[i]["ID"]
        Shopdata.ITEM[i].SOLD_OUT = shopData[i]["SOLD_OUT"]
    end
end

--[[
    函数用途：定点时间刷新
    --]]
--[[function Shopdata:refresh()
    local time = os.date("%X")--"%H:%M:%S"
    if time =="18:09:00" then
        --清除遮罩
        for i = 1,6 do
            KnapsackData:setSoldOutState(i,false)
        end
        --更新卡牌
        KnapsackData:setITEM_ID(2,Shopdata:randomId(1))
        KnapsackData:setITEM_ID(3,Shopdata:randomId(1))
        KnapsackData:setITEM_ID(4,Shopdata:randomId(1))
        KnapsackData:setITEM_ID(5,Shopdata:randomId(2))
        KnapsackData:setITEM_ID(6,Shopdata:randomId(3))


        --Shopdata.ITEM[2].ID = Shopdata:randomId(1)
        item2:loadTexture("ui/hall/shop/Goldcoin-shop/CommodityIcon-tower_fragment/"..KnapsackData:getITEM_ID(2)..".png")
        print(KnapsackData:getITEM_ID(2))

        --Shopdata.ITEM[3].ID = Shopdata:randomId(1)
        item3:loadTexture("ui/hall/shop/Goldcoin-shop/CommodityIcon-tower_fragment/"..KnapsackData:getITEM_ID(3)..".png")
        print(KnapsackData:getITEM_ID(3))

        --Shopdata.ITEM[4].ID = Shopdata:randomId(1)
        item4:loadTexture("ui/hall/shop/Goldcoin-shop/CommodityIcon-tower_fragment/"..KnapsackData:getITEM_ID(4)..".png")
        print(KnapsackData:getITEM_ID(4))

        --Shopdata.ITEM[5].ID = Shopdata:randomId(2)
        item5:loadTexture("ui/hall/shop/Goldcoin-shop/CommodityIcon-tower_fragment/"..KnapsackData:getITEM_ID(5)..".png")
        print(KnapsackData:getITEM_ID(5))

        --Shopdata.ITEM[6].ID = Shopdata:randomId(3)
        print(KnapsackData:getITEM_ID(6))
        item6:loadTexture("ui/hall/shop/Goldcoin-shop/CommodityIcon-tower_fragment/"..KnapsackData:getITEM_ID(6)..".png")

    end
end--]]

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