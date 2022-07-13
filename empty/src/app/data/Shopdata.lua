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
    --向服务器发消息
    math.randomseed(os.time())
    Shopdata.ITEM[2].ID = Shopdata:randomId(1)

    Shopdata.ITEM[3].ID = Shopdata:randomId(1)

    Shopdata.ITEM[4].ID = Shopdata:randomId(1)

    Shopdata.ITEM[5].ID = Shopdata:randomId(2)

    Shopdata.ITEM[6].ID = Shopdata:randomId(3)
end

--[[
    函数用途：定点时间刷新
    --]]
function Shopdata:refresh()
    local time = os.date("%X")--"%H:%M:%S"
    if time =="14:44:00" then
        --清除遮罩
        for i = 1,6 do
            Shopdata.ITEM[i].SOLD_OUT = false
        end
        --更新卡牌
        Shopdata.ITEM[2].ID = Shopdata:randomId(1)
        item2:loadTexture("ui/hall/shop/Goldcoin-shop/CommodityIcon-tower_fragment/"..Shopdata.ITEM[2].ID..".png")
        print(Shopdata.ITEM[2].ID)

        Shopdata.ITEM[3].ID = Shopdata:randomId(1)
        item3:loadTexture("ui/hall/shop/Goldcoin-shop/CommodityIcon-tower_fragment/"..Shopdata.ITEM[3].ID..".png")
        print(Shopdata.ITEM[3].ID)

        Shopdata.ITEM[4].ID = Shopdata:randomId(1)
        item4:loadTexture("ui/hall/shop/Goldcoin-shop/CommodityIcon-tower_fragment/"..Shopdata.ITEM[4].ID..".png")
        print(Shopdata.ITEM[4].ID)

        Shopdata.ITEM[5].ID = Shopdata:randomId(2)
        item5:loadTexture("ui/hall/shop/Goldcoin-shop/CommodityIcon-tower_fragment/"..Shopdata.ITEM[5].ID..".png")
        print(Shopdata.ITEM[5].ID)

        Shopdata.ITEM[6].ID = Shopdata:randomId(3)
        print(Shopdata.ITEM[6].ID)
        item6:loadTexture("ui/hall/shop/Goldcoin-shop/CommodityIcon-tower_fragment/"..Shopdata.ITEM[6].ID..".png")

    end
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
--[[--
    --商店数据变成表

    @param none

    @return none
]]
function Shopdata:getDataTable()
    local table = {
        loginname = KnapsackData:getName(),
    }
    table.shopData={}
    for i = 1, 6 do
        table.shopData[i]={}
        table.shopData[i].ID=self.ITEM[i].ID --商品id
        table.shopData[i].SOLD_OUT=self.ITEM[i].SOLD_OUT_ --是否购买
    end
    --塔阵容数据
    return table
end
return Shopdata