GameHandler = GameHandler or {}

GameHandler.myRole = nil
GameHandler.PlaneData = nil

-- 存储 Data
GameHandler.BulletData = {}
GameHandler.EnemyData = {}

GameHandler.BulletArray = {}
GameHandler.EnemyArray = {}

GameHandler.isPause = false -- 暂停 指的是在局内暂停
GameHandler.isContinue = false -- 是否继续 指的是退出了游戏界面

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
