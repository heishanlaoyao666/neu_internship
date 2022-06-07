local player_num = 0
local code = {}
local password = {}

function addCode()
    local curTime = os.time()
    local uuid = curTime + math.random(10000000)
    player_num = player_num+1
    code[player_num] = uuid
    print(code)
end