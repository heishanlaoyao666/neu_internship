--[[
    Queue.lua
    描述：队列
    编写：周星宇
    修订：
    检查：
]]

local Queue = {
    capacity_ = 0, -- 最大容量
    length_ = 0, -- 当前长度
    head_ = 0,
    tail_ = 0,
    list_ = {}
}

--[[
    创建函数

    @param capacity 队列容量

    @return none
]]
function Queue:new(capacity)
    local queue = {}
    self.__index = self
    setmetatable(queue, self)
    queue:initQueue(capacity)
    return queue
end

--[[
    初始化队列

    @param capacity 队列容量

    @return none
]]
function Queue:initQueue(capacity)
    self.capacity_ = capacity
    self.length_ = 0 -- 当前长度
    self.head_ = 0
    self.tail_ = 0
    self.list_ = {}
end

--[[
    删除队列

    @param none

    @return none
]]
function Queue:deleteQueue()
    self.list_ = nil
    self.length_ = 0
    self.head_ = 0
    self.tail_ = 0
end

--[[
    清空队列

    @param none

    @return none
]]
function Queue:clearQueue()
    self.length_ = 0
    self.head_ = 0
    self.tail_ = 0
end

--[[
    判断队列是否为空

    @param none

    @return boolean
]]
function Queue:isQueueEmpty()
    if 0 == self.length_ then
        return true
    end
    return false
end

--[[
    判断队列是否为满

    @param none

    @return boolean
]]
function Queue:isQueueFull()
    if self.capacity_ == self.length_ then
        return true
    end
    return false
end

--[[
    获取队列长度(当前条目数)

    @param none

    @return number
]]
function Queue:getQueueLength()
    return self.length_
end

--[[
    入队

    @param data

    @return boolean
]]
function Queue:enQueue(data)
    self.list_[self.tail_ % self.capacity_] = data
    self.tail_ = self.tail_ + 1
    self.length_ = self.length_ + 1
end

--[[
    出队

    @param none

    @return data 出队的元素
]]
function Queue:deQueue()
    local temp = self.list_[self.head_]
    self.head_ = (self.head_ + 1) % self.capacity_
    self.length_ = self.length_ - 1
    return temp
end

--[[
    遍历队列元素

    @param none

    @return number
]]
function Queue:traverseQueue()
    for i = self.head_ , self.length_ + self.head_ - 1 do
        print("打印队列中的元素",self.list_[i % self.capacity_])
    end
end

return Queue
