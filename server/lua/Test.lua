
local playerOneScore = 10000
local playerTwoScore = 12000

local playerOneTrophy = 325
local playerTwoTrophy = 445

function judge()
    if math.abs(playerOneTrophy-playerTwoTrophy) <= 200 then
        if playerOneScore > playerTwoScore then
            playerOneTrophy = playerOneTrophy + math.random(35, 40)
            playerTwoTrophy = playerTwoTrophy - math.random(30, 35)
        elseif playerOneScore < playerTwoScore then
            playerTwoTrophy = playerTwoTrophy + math.random(35, 40)
            playerOneTrophy = playerOneTrophy - math.random(30, 35)
        end
    else
        if playerOneTrophy < playerTwoTrophy then
            if playerOneScore < playerTwoScore then
                playerOneTrophy = playerOneTrophy - math.random(25, 30)
                playerTwoTrophy = playerTwoTrophy + math.random(30, 35)
            elseif playerOneScore > playerTwoScore then
                playerOneTrophy = playerOneTrophy + math.random(40, 45)
                playerTwoTrophy = playerTwoTrophy - math.random(35, 40)
            end
        elseif playerOneTrophy > playerTwoTrophy then
            if playerOneScore < playerTwoScore then
                playerOneTrophy = playerOneTrophy - math.random(35, 40)
                playerTwoTrophy = playerTwoTrophy + math.random(40, 45)
            elseif playerOneScore > playerTwoScore then
                playerOneTrophy = playerOneTrophy + math.random(30, 35)
                playerTwoTrophy = playerTwoTrophy - math.random(25, 30)
            end
        end
    end
end