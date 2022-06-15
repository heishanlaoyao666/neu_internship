
--- 用户ID生成
function getUUID()
    local curTime = os.time()
    local uuid = curTime + math.random(100000000)
    return uuid
end

