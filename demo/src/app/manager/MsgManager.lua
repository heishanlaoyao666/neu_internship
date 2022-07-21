--[[
    MsgManger.lua
    消息管理器
    描述：管理所有网络消息的发送
    编写：周星宇
    修订：李昊
    检查：张昊煜
]]
local MsgManager = {}
local TCP = require("app.network.TCP")
local EventManager = require("app.manager.EventManager")
local EventDef = require("app.def.EventDef")
local MsgDef = require("app.def.MsgDef")
local PlayerData = require("app.data.PlayerData")
local StoreData = require("app.data.StoreData")


--[[
    从服务器和本地文件读取完善玩家信息

    @param none

    @return none
]]
function MsgManager:recPlayerData()

    TCP.send(MsgDef.REQ_TYPE.SEND_PLAYER_DATA, {pid=PlayerData:getId(), nick=PlayerData:getName()})

    TCP.regListener(MsgDef.ACK_TYPE.PLAYER_DATA_SEND_SUCCEED, function(resp)
        -- 加载基本信息
        PlayerData:setName(resp.data.nick)
        PlayerData:setPassword(resp.data.pwd)
        PlayerData:setId(resp.data.pid)
        PlayerData:setIntegral(resp.data.integral)
        PlayerData:setHeadPortrait(resp.data.headPortrait)
        PlayerData:setGold(resp.data.gold)
        PlayerData:setDiamond(resp.data.diamond)

        -- 加载天梯奖励
        for i = 1, 10 do --初始化天梯奖励
            local index = string.format("%d", i)
            PlayerData:getLadderAward()[i] = resp.data.ladderAward[index]
        end

        -- 加载卡组信息
        local cardGroup = resp.data.cardGroup

        for i = 1, 20 do
            local index = string.format("%d", i)
            PlayerData:getCardGroup()[i]:setNum(cardGroup[index].pieceNum)
            PlayerData:getCardGroup()[i]:setLevel(cardGroup[index].level)
            PlayerData:getCardGroup()[i]:setIntensify(cardGroup[index.intensify])
        end

        -- 加载当前卡组信息
        PlayerData:setFightCardGroupIndex(resp.data.fightGroupIndex)

        local currentGroupOne = resp.data.currentGroupOne
        local currentGroupTwo = resp.data.currentGroupTwo
        local currentGroupThree = resp.data.currentGroupThree
        for i = 1, 5 do
            local index = string.format("%d", i)
            PlayerData:getCurrentCardGroup(1)[i] = PlayerData:getCardGroup()[currentGroupOne[index]]
            PlayerData:getCurrentCardGroup(2)[i] = PlayerData:getCardGroup()[currentGroupTwo[index]]
            PlayerData:getCurrentCardGroup(3)[i] = PlayerData:getCardGroup()[currentGroupThree[index]]
        end

        -- 加载金币商店领取情况
        for i = 1, 6 do
            local index = string.format("%d", i)
            PlayerData:getGoldStoreAvailability()[i] = resp.data.goldStoreAvailability[index]
        end

        EventManager:doEvent(EventDef.ID.INIT_PLAYER_DATA)

    end)
end


--[[
    向服务器发送玩家信息

    @param none

    @return none
]]
function MsgManager:sendPlayerData()

    TCP.send(MsgDef.REQ_TYPE.REC_PLAYER_DATA, {
        pid=PlayerData:getId(),
        nick=PlayerData:getName(),
        pwd=PlayerData:getPassword(),
        integral=PlayerData:getIntegral(),
        headPortrait=PlayerData:getHeadPortrait(),
        gold=PlayerData:getGold(),
        diamond=PlayerData:getDiamond(),
        fightGroupIndex=PlayerData:getFightCardGroupIndex(),
        ladderAward=PlayerData:transLadderAward(),
        goldStoreAvailability=PlayerData:transGoldStoreAvailability(),
        cardGroup=PlayerData:transCardGroup(),
        currentGroupOne=PlayerData:transCurrentGroupOne(),
        currentGroupTwo=PlayerData:transCurrentGroupTwo(),
        currentGroupThree=PlayerData:transCurrentGroupThree(),
    })

    TCP.regListener(MsgDef.ACK_TYPE.PLAYER_DATA_REC_SUCCEED, function(resp)

    end)
end

--[[
    向服务器发送开赛信息

    @param none

    @return none
]]
function MsgManager:startMapping()

    local fightGroup = PlayerData:getFightCardGroup()
    local cards = {}

    for i = 1, 5 do
        cards[string.format("%d", i)] = {
            -- 卡牌Id
            cardId=fightGroup[1]:getId(),
            -- 该等级下攻击力
            atk=fightGroup[1]:getCurAtk(),
            -- 该等级下攻击间隔
            fireCd=fightGroup[1]:getCurFireCd(),
            -- 该等级下一技能参数
            skillOne=fightGroup[1]:getCurSkillOneValue(),
            -- 二技能参数
            skillTwo=fightGroup[1]:getSkillTwoValue(),
            -- 强化一级提升的攻击力增量
            atkDelta=fightGroup[1]:getAtkEnhancedDelta(),
            --强化一级提升的一技能参数增量
            skillOneDelta=fightGroup[1]:getSkillOneEnhancedDelta(),
        }
    end

    TCP.send(MsgDef.REQ_TYPE.START_MAPPING, {
        pid=PlayerData:getId(), -- 用户ID
        nick=PlayerData:getName(), -- 用户名
        integral=PlayerData:getIntegral(), -- 奖杯数
        cards=cards
    })

    TCP.regListener( MsgDef.ACK_TYPE.MAPPING_SUCCEED, function(resp)
        EventManager:doEvent(EventDef.ID.MAPPING_SUCCEED) -- 匹配成功
    end)
end

--[[
    向服务器发送取消开赛的信息

    @param none

    @return none
]]
function MsgManager:endMapping()
    TCP.send(MsgDef.REQ_TYPE.END_MAPPING, {})
end

--[[
    玩家登录

    @param nick 昵称 string
    @param pwd 密码 string

    @return none
]]
function MsgManager:login(nick, pwd)

    TCP.send(MsgDef.REQ_TYPE.LOGIN, {nick=nick, pwd=pwd})

    TCP.regListener(MsgDef.ACK_TYPE.LOGIN_SUCCEED, function(resp)
        EventManager:doEvent(EventDef.ID.LOGIN_SUCCEED, resp) -- 登录成功
    end)
    TCP.regListener(MsgDef.ACK_TYPE.LOGIN_FAIL, function(resp)
        local errorType = resp.errorType
        EventManager:doEvent(EventDef.ID.LOGIN_FAIL, errorType) -- 登录失败
    end)

end

--[[
    玩家注册

    @param nick 昵称 string
    @param pwd 密码 string

    @return none
]]
function MsgManager:register(nick, pwd)

    TCP.send(MsgDef.REQ_TYPE.REGISTER, {nick=nick, pwd=pwd})

    TCP.regListener(MsgDef.ACK_TYPE.REGISTER_SUCCEED, function(resp)
        EventManager:doEvent(EventDef.ID.REGISTER_SUCCEED, resp) -- 注册成功
    end)
    TCP.regListener(MsgDef.ACK_TYPE.REGISTER_FAIL, function()
        EventManager:doEvent(EventDef.ID.REGISTER_FAIL) -- 注册失败
    end)

end

--[[
    请求商店数据

    @param none

    @return none
]]
function MsgManager:recStoreData()

    TCP.send(MsgDef.REQ_TYPE.SEND_STORE_DATA, {pid=PlayerData:getId(), nick=PlayerData:getName()})

    TCP.regListener(MsgDef.ACK_TYPE.STORE_DATA_SEND_SUCCEED, function(resp)
        -- 通过时间决定是否刷新
        if cc.UserDefault:getInstance():getStringForKey("date") ~= resp.date then
            cc.UserDefault:getInstance():setStringForKey("date", resp.date)
            for i = 1, 6 do
                PlayerData:setGoldStoreAvailability(i, true)
            end
        end
        StoreData:setGoldStoreCards(resp.data)
        EventManager:doEvent(EventDef.ID.GOLD_STORE_REFRESH)
    end)

end

--[[
    进入游戏

    @param none

    @return none
]]
function MsgManager:enterGame()
    -- 不需要返回消息
    TCP.send(MsgDef.REQ_TYPE.ENTER_GAME, {pid=PlayerData:getId(), nick=PlayerData:getName()})
end

--[[
    退出游戏

    @param none

    @return none
]]
function MsgManager:quitGame()
    TCP.send(MsgDef.REQ_TYPE.QUIT_GAME, {pid=PlayerData:getId(), nick=PlayerData:getName()})
end

return MsgManager