GameHandler = GameHandler or {}

GameHandler.myRole = nil
GameHandler.PlaneData = nil

-- 存储 Data
GameHandler.RankData = {}

GameHandler.BulletData = {}
GameHandler.EnemyData = {}

GameHandler.BulletArray = {}
GameHandler.EnemyArray = {}

GameHandler.isPause = false -- 暂停 指的是在局内暂停
GameHandler.isContinue = UserDefault:getBoolForKey(ConstantsUtil.CONTINUE_KEY, false) -- 是否继续 指的是退出了游戏界面

function GameHandler.updateContinue(val)
    GameHandler.isContinue = val
    UserDefault:setBoolForKey(ConstantsUtil.CONTINUE_KEY, GameHandler.isContinue)
end

function GameHandler.cleanupData()
    GameHandler.PlaneData = nil
    GameHandler.BulletData = {}
    GameHandler.EnemyData = {}
end

function GameHandler.cleanupView()
    for i = 1, #(GameHandler.BulletArray) do
        GameHandler.BulletArray[i]:removeFromParent()
    end
    GameHandler.BulletArray = {}
    --
    for i = 1, #(GameHandler.EnemyArray) do
        GameHandler.EnemyArray[i]:removeFromParent()
    end
    GameHandler.EnemyArray = {}
    --
    if GameHandler.myRole ~= nil then
        GameHandler.myRole = nil
    end
end

function GameHandler.toSaveGame()
    local tmpBulletData = {}
    for i = 1, #(GameHandler.BulletData) do
        table.insert(tmpBulletData, GameHandler.BulletData[i]:data2Json())
    end
    local tmpEnemyData = {}
    for i = 1, #(GameHandler.EnemyData) do
        table.insert(tmpEnemyData, GameHandler.EnemyData[i]:data2Json())
    end

    local obj = {
        planeData = GameHandler.PlaneData:data2Json(),
        bulletData = tmpBulletData,
        enemyData = tmpEnemyData
    }
    return obj
end

function GameHandler.toLoadGame(obj)
    GameHandler.PlaneData = obj.planeData
    GameHandler.BulletData = obj.bulletData
    GameHandler.EnemyData = obj.enemyData
end

function GameHandler.toSaveRank()
    local tmpRankData = {}
    for i = 1, #(GameHandler.RankData) do
        table.insert(tmpRankData, GameHandler.RankData[i]:data2Json())
    end
    local obj = {
        rankData = tmpRankData
    }
end

function GameHandler.toLoadRank(obj)
    GameHandler.RankData = obj.rankData
end

return GameHandler
