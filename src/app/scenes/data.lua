local data = {}

function data:addCode()
    local curTime = os.time()
    local uuid = curTime + math.random(10000000)
    player_num = player_num+1
    code[player_num] = uuid
    print(code)
    uid = io.open("uid.txt","a+")
    io.output(uid) 
    io.write(uid.."\n")
end

function data:getSetting()
    setting = io.open("setting.txt","a+")
    io.input(setting) 
    return io.read(),io.read("*l")
end

