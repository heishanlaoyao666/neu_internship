--[[--
    SoundManager.lua

    描述：声音播放工具类
]]
local SoundManager = {}
local SoundDef = require("app.def.SoundDef")
local Log = require("app.util.Log")
local audio = require("framework.audio")
local UserDefault = cc.UserDefault:getInstance()

-- 常量定义桥接，为使用方便
SoundManager.DEF = SoundDef

local KEY_MUSIC_ON = "key_music_on"
local KEY_EFFECT_ON = "key_effect_on"

local isMusicOn_ = true -- 类型：boolean，是否允许播放背景音乐
local isEffectOn_ = true -- 类型：boolean，是否允许播放音效
local currentBGM_ -- 类型：string，背景音乐id

---------------------------------------------------------------------------
-- 私有函数定义
---------------------------------------------------------------------------
local _init

--[[--
    描述：播放音效

    @param id 类型：string，音效id

    @return none
]]
function SoundManager:playEffect(id)
    if not isEffectOn_ then
        return
    end

    if not isString(id) then
        Log.e("unexpect param, id=", id)
        return
    end

    Log.d("id=", id)

    audio.playEffectSync(id, false)
end

--[[--
    描述：播放背景音乐，默认循环播放

    @param id 类型：string，音乐id

    @return none
]]
function SoundManager:playBGM(id)
    if not isMusicOn_ then
        return
    end

    if not isString(id) then
        Log.e("unexpect param, id=", id)
        return
    end

    Log.d("id=", id)

    audio.playBGMSync(id, true) -- 默认循环播放

    currentBGM_ = id
end

--[[--
    描述：停止背景音乐

    @param none

    @return none
]]
function SoundManager:stopBGM()
    Log.d()

    audio.stopBGM()
end

--[[--
    描述：是否允许播放背景音乐

    @param none

    @return boolean
]]
function SoundManager:isMusicOn()
    return isMusicOn_
end

--[[--
    描述：设置是否允许播放背景音
    注意，false，若是当前有播放，停止背景音
    注意，true，检查是否播放过背景音，播放

    @param isOn 类型：boolean，是否允许播放

    @return none
]]
function SoundManager:setMusicOn(isOn)
    if not isBoolean(isOn) then
        Log.e("unexpect param, isOn=", isOn)
        return
    end

    if isOn then
        -- 因为停止背景音用的是stop，所以重新播放
        if currentBGM_ then
            SoundManager:playBGM(currentBGM_)
        end
    else
        audio.stopAll()
    end

    isMusicOn_ = isOn

    UserDefault:setBoolForKey(KEY_MUSIC_ON, isOn)
end

--[[--
    描述：是否允许播放音效

    @param none

    @return boolean
]]
function SoundManager:isEffectOn()
    return isEffectOn_
end

--[[--
    描述：设置是否允许播放音效

    @param isOn 类型：boolean，是否允许播放
    
    @return none
]]
function SoundManager:setEffectOn(isOn)
    if not isBoolean(isOn) then
        Log.e("unexpect param, isOn=", isOn)
        return
    end

    if not isOn then
        audio.stopEffect()
    end

    isEffectOn_ = isOn

    UserDefault:setBoolForKey(KEY_EFFECT_ON, isOn)
end

---------------------------------------------------------------------------
-- 私有函数实现
---------------------------------------------------------------------------

--[[
    描述：初始化

    @param none

    @return none
]]
function _init()
    isMusicOn_ = UserDefault:getBoolForKey(KEY_MUSIC_ON, false) -- TODO 默认值应该为true
    isEffectOn_ = UserDefault:getBoolForKey(KEY_EFFECT_ON, true)

    Log.d("isMusicOn_=", isMusicOn_, ", isEffectOn_=", isEffectOn_)
end

-- 文件被require时执行
_init()

return SoundManager