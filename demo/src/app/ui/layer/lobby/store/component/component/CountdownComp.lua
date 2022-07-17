--[[
    CountdownComp.lua
    倒计时组件
    描述：倒计时组件
    编写：周星宇
    修订：李昊
    检查：张昊煜
]]
local CountdownComp = class("CountdownComp")

CountdownComp.__index = CountdownComp

CountdownComp.time = nil
CountdownComp.hour = nil   --小时
CountdownComp.minute = nil --分钟
CountdownComp.second = nil --秒钟
CountdownComp.func = nil
CountdownComp.showType = true


function CountdownComp.ctor()
    CountdownComp.winSize = cc.Director:getInstance():getWinSize()
    CountdownComp.scheduler = cc.Director:getInstance():getScheduler()
    CountdownComp.schedulerID = nil
    print("输出======CountdownComp.ctor()=========")
    print("倒计时进行中。。。。")
end
--设置倒计时到00:00:00时调用这个函数，传入的参数是一个函数
function CountdownComp.function_(f)
    CountdownComp.func = f

end

function CountdownComp.setTime(hour, minute, second)
    CountdownComp.hour = hour   --小时
    CountdownComp.minute = minute --分钟
    CountdownComp.second = second --秒钟
end

function CountdownComp.getTime()
    return CountdownComp.hour,CountdownComp.minute,CountdownComp.second
end



function CountdownComp.add_0()
    --将int类型转换为string类型
    CountdownComp.hour   = tostring(CountdownComp.hour)
    CountdownComp.minute = CountdownComp.minute .. ""
    CountdownComp.second = CountdownComp.second .. ""

    --当显示数字为个位数是，前位用补上
    if string.len(CountdownComp.hour) == 1 then
        CountdownComp.hour = "0" .. CountdownComp.hour
    end

    if string.len(CountdownComp.minute) == 1 then
        CountdownComp.minute = "0" .. CountdownComp.minute
    end

    if string.len(CountdownComp.second) == 1 then
        CountdownComp.second = "0" .. CountdownComp.second
    end
end

--创建一个Text
function CountdownComp.createText()
    --CountdownComp.time如果不等于空，就先remove掉
    if CountdownComp.time ~= nil then
        CountdownComp.time:getParent():removeChild(CountdownComp.time,true)
        CountdownComp.time = nil
    end

    local time = CountdownComp.hour .. ":" .. CountdownComp.minute .. ":" .. CountdownComp.second
    CountdownComp.time = ccui.Text:create(time, "font/fzbiaozjw.ttf", 25)

    return CountdownComp.time
end

--倒计时更新函数
function CountdownComp.anticlockwiseUpdate(time)
    --    CountdownComp.second = CountdownComp.second -1
    --加上tonumber也可以，如下面，不加也可以，lua有这个功能的
    CountdownComp.second = tonumber(CountdownComp.second) -1

    if CountdownComp.second == -1 then
        if CountdownComp.minute ~= -1 or CountdownComp.hour ~= -1 then
            CountdownComp.minute = CountdownComp.minute - 1
            CountdownComp.second = 59
            if CountdownComp.minute == -1 then
                if CountdownComp.hour ~= -1 then
                    CountdownComp.hour = CountdownComp.hour - 1
                    CountdownComp.minute = 59

                    if CountdownComp.hour == -1 then
                        --倒计时结束停止更新
                        if CountdownComp.schedulerID ~= nil then
                            CountdownComp.scheduler:unscheduleScriptEntry(CountdownComp.schedulerID)
                            CountdownComp.schedulerID = nil

                        end
                        CountdownComp.second = 0
                        CountdownComp.minute = 0
                        CountdownComp.hour = 0
                        CountdownComp.func()  --倒计时为0时，调用这个函数

                    end
                end
            end
        end
    end

    CountdownComp.second = tostring(CountdownComp.second)
    CountdownComp.minute = tostring(CountdownComp.minute)
    CountdownComp.hour = tostring(CountdownComp.hour)

    if string.len(CountdownComp.second) == 1 then
        CountdownComp.second = "0" .. CountdownComp.second
    end

    if string.len(CountdownComp.minute) == 1 then
        CountdownComp.minute = "0" .. CountdownComp.minute

    end

    if string.len(CountdownComp.hour) == 1 then
        CountdownComp.hour = "0" .. CountdownComp.hour
    end
    if CountdownComp.showType == true then
        CountdownComp.time:setString(CountdownComp.hour ..":".. CountdownComp.minute ..":".. CountdownComp.second)
    elseif CountdownComp.showType == false then
        CountdownComp.time:setString(CountdownComp.minute ..":".. CountdownComp.second)
    end
end

--倒计时刷新函数
function CountdownComp.scheduleFunc()
    --隔一秒刷新这个函数
    CountdownComp.schedulerID = CountdownComp.scheduler:scheduleScriptFunc(CountdownComp.anticlockwiseUpdate,1,false)
end

--移除这个刷新函数
function CountdownComp.remove_scheduler()
    if CountdownComp.schedulerID ~= nil then
        CountdownComp.scheduler:unscheduleScriptEntry(CountdownComp.schedulerID)
        CountdownComp.schedulerID = nil

    end
end

--重设
function CountdownComp.reset(hour,minute,second)
    CountdownComp.remove_scheduler()
    CountdownComp.hour = hour   --小时
    CountdownComp.minute = minute --分钟
    CountdownComp.second = second --秒钟
    CountdownComp.scheduleFunc()

end

function CountdownComp.remove_hour()
    if CountdownComp.time ~= nil then
        if tonumber(CountdownComp.hour) == 0 then
            --设为分钟:秒 如09:11
            CountdownComp.time:setString(CountdownComp.minute ..":".. CountdownComp.second .. "后")
            CountdownComp.showType = false
        end
    end

end

function CountdownComp.exit()
    CountdownComp.time:removeFromParent()
    CountdownComp.remove_scheduler()
    CountdownComp.time = nil
end

return CountdownComp