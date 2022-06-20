local BaseLayer = require("app.scenes.BaseLayer")
local TestCase = class("Test_TCP", BaseLayer)

local SimpleTCP = require("framework.SimpleTCP")
local ByteArray = require("framework.ByteArray")
local json = require("framework.json")
local scheduler = require("framework.scheduler")

local HEART_BEAT_INTERVAL = 5

local STATE_CONNECTED = 1
local STATE_CLOSED    = 2
local STATE_FAILED    = 3

local KEY_TYPE = "type"
local KEY_PLAYER_ID = "playerid"
local KEY_NICKNAME = "nick"
local KEY_HP = "hp"
local KEY_MAX_HP = "maxhp"
local KEY_SCORE = "score"
local KEY_RANK = "rank"
local KEY_RANKLIST = "ranklist"
local KEY_HEART_BEAT = "serial"

local MSG_TYPE = {
    REQ_BEGIN = 1,
    REQ_HPCHANGED = 2,
    REQ_UPLOAD_SCORE = 3,
    REQ_HEART_BEAT = 4,
    ACK_BEGIN = 524288 + 1,
    ACK_GAMEOVER = 524288 + 2,
    ACK_RANK = 524288 + 3,
    ACK_HEART_BEAT = 524288 + 4,
}

local socket_
local state_
local hp_

local __package
local __handleMsg
local __handleMsgData

function TestCase:ctor()
	self.super.ctor(self)

    self.reqHeartSerial_ = 1
    self.lastAckTime_ = 0
    self.lastHeartSerial_ = 1

    print("xjhssg tcp -------------------------- ", SimpleTCP._VERSION)
    socket_ = SimpleTCP.new("192.168.20.86", 33333, function(event, data)
        __handleMsg(self, event, data)
    end)
    socket_:connect()

    local start = display.newSprite("button.png")
	start:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
		if event.name == "began" then
			return true
        elseif event.name == "ended" then
            self:requestBegin()
		end
	end)
	start:setTouchMode(cc.TOUCH_MODE_ONE_BY_ONE) -- default mode
	start:setTouchEnabled(true)
	start:pos(150, display.cy):addTo(self)
	start:setScale(0.5)

    local injured = display.newSprite("button.png")
	injured:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
		if event.name == "began" then
			return true
        elseif event.name == "ended" then
            self:requestHPChanged(hp)
		end
	end)
	injured:setTouchMode(cc.TOUCH_MODE_ONE_BY_ONE) -- default mode
	injured:setTouchEnabled(true)
	injured:pos(450, display.cy):addTo(self)
	injured:setScale(0.5)
end

function TestCase:requestBegin()
    if not socket_ or state_ ~= STATE_CONNECTED then
        return
    end

    local msg = {}
    msg[KEY_TYPE] = MSG_TYPE.REQ_BEGIN
    msg[KEY_PLAYER_ID] = 1112
    msg[KEY_NICKNAME] = "xujh"
    msg[KEY_HP] = 0
    socket_:send(__package(msg))
end

function TestCase:requestHPChanged(hp)
    if not socket_ or state_ ~= STATE_CONNECTED then
        return
    end

    local msg = {}
    msg[KEY_TYPE] = MSG_TYPE.REQ_HPCHANGED
    msg[KEY_PLAYER_ID] = 1112
    msg[KEY_HP] = hp_
    hp_ = hp_ - 1
    socket_:send(__package(msg))
end

function TestCase:requestUploadScore(score)
    if not socket_ or state_ ~= STATE_CONNECTED then
        return
    end

    local msg = {}
    msg[KEY_TYPE] = MSG_TYPE.REQ_UPLOAD_SCORE
    msg[KEY_PLAYER_ID] = 1112
    msg[KEY_SCORE] = tonumber(score or 0)
    socket_:send(__package(msg))
end

function TestCase:requestHeartBeat(serial)
    if not socket_ or state_ ~= STATE_CONNECTED then
        return
    end

    local msg = {}
    msg[KEY_TYPE] = MSG_TYPE.REQ_HEART_BEAT
    msg[KEY_PLAYER_ID] = 1112
    msg[KEY_HEART_BEAT] = serial
    socket_:send(__package(msg))
end

function __package(msg)
    local json = json.encode(msg or {})
    local array = ByteArray.new()
    array:setPos(1)
    array:writeInt(#json)
    array:writeStringBytes(json)
    return array:getPack()
end

function __handleMsg(self, event, data)
    if type(event) ~= "string" then
        error("event type is invalid")
    end

    local curTime = os.time()
    if self.lastAckTime_ ~= 0 and curTime - self.lastAckTime_ > 30 then
        print("hadn't recieve ack too long, close the connection")
        socket_:close()
        socket_ = nil
        return
    else
        self.lastAckTime_ = curTime
    end

    if event == SimpleTCP.EVENT_CONNECTING then
        print("connecting ...")
    elseif event == SimpleTCP.EVENT_CONNECTED then
        state_ = STATE_CONNECTED
        -- register heart beat loop schedule, 5s req once
        self.heartScheduler_ = scheduler.scheduleGlobal(function(dt)
            self:requestHeartBeat(self.reqHeartSerial_)
            self.reqHeartSerial_ = self.reqHeartSerial_ + 1
        end, HEART_BEAT_INTERVAL)
    elseif event == SimpleTCP.EVENT_FAILED then
        state_ = STATE_CLOSED
    elseif event == SimpleTCP.EVENT_CLOSED then
        state_ = STATE_CLOSED
    elseif event == SimpleTCP.EVENT_DATA then
        if data then
            __handleMsgData(self, data)
        end
    else
        error("event type is unknown")
    end
end

function __handleMsgData(self, content)
    local ba = ByteArray.new()
    ba:writeBuf(content)
    ba:setPos(1)
    local len = ba:readInt()
    local data = json.decode(ba:readStringBytes(len))

    local msgType = data[KEY_TYPE]
    if msgType == MSG_TYPE.ACK_BEGIN then
        hp_ = data[KEY_MAX_HP]
        print("begin game ----------------- max hp ", hp_)

    elseif msgType == MSG_TYPE.ACK_GAMEOVER then
        print("game  over ------------------ ")
        self:requestUploadScore(99)
        if self.heartScheduler_ then
            scheduler.unscheduleGlobal(self.heartScheduler_)
        end
    elseif msgType == MSG_TYPE.ACK_HEART_BEAT then
        local serverHeartSerial = data[KEY_HEART_BEAT]
        print("[ACK] heart beat server ", serverHeartSerial, ", client ", self.lastHeartSerial_)
        -- packet loss more than 3 times
        if serverHeartSerial - self.lastHeartSerial_ > 3 then
            socket_:close()
            socket_ = nil
            return
        end
        self.lastHeartSerial_ = serverHeartSerial
    elseif msgType == MSG_TYPE.ACK_RANK then
        local rankList = data[KEY_RANKLIST]
        print("type ranklist ", type(rankList))
        dump(rankList)
    end
end

return TestCase