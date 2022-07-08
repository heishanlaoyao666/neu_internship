local TowerInfo = class("TowerInfo")
--[[--
    构造函数

    @param i 类型:第i个
    @param plyaer 类型:player,玩家数据
    
    @return none
]]
function TowerInfo:ctor(i,player)
    --类型:table 塔信息 .id_(塔id) .level_(塔等级) .grade_(塔强化等级)
    local tower=player:getTowerArray()[i]
    print("创建"..i..tower.id_)
    local towerBtn=ccui.Button:create(string.format("ui/battle/Battle interface/Tower/tower_%u.png",tower.id_))
    towerBtn:setAnchorPoint(0.5, 0)
    towerBtn:addTouchEventListener(function(sender, eventType)
        if eventType == 2 then
            print(i)
            player:upTowerGrade(i)
            updateUI(i)
        end
    end)
    --强化等级信息
    local img=display.newSprite(string.format("ui/battle/Battle interface/Grade/LV.%u.png",tower.grade_))
    img:setAnchorPoint(0.5,1)
    img:setPosition(50,0)
    img:setScale(1.5)
    towerBtn:addChild(img)
    --强化等级所需费用
    local sp = ccui.ImageView:create("ui/battle/Battle interface/bg-sp.png")
    sp:setAnchorPoint(0, 0)
    sp:setScale(100/124)
    towerBtn:addChild(sp)

    local spLaber_ = cc.Label:createWithTTF(player:getTowerGradeCost(i),"ui/font/fzbiaozjw.ttf",20)
    spLaber_:setAnchorPoint(0, 0)
    spLaber_:setPosition(40, 5)
    towerBtn:addChild(spLaber_)
    --角标
    local res = "ui/battle/Battle interface/Angle sign-Tower_type/TowerType-"
    local as_tt= display.newSprite(string.format(res..TowerDef.TABLE[tower.id_].TYPE..".png"))

    as_tt:setAnchorPoint(0.5,0.5)
    as_tt:setPosition(75,80)
    towerBtn:addChild(as_tt)

    function updateUI(j)
        print("进行更新了么")
        print(j)
        local newtower=player:getTowerArray()[j]
        print(newtower.grade_)
        img:setTexture(string.format(string.format("ui/battle/Battle interface/Grade/LV.%u.png",newtower.grade_)))
        spLaber_:setString(player:getTowerGradeCost(j))
    end
    return towerBtn
end

return TowerInfo