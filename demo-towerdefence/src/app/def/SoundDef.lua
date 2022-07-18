--[[--
    SoundDef.lua

    描述：声音常量定义类
]]
local SoundDef = {}

local RES_DIR = "sound/"

-- 背景音id定义
SoundDef.BGM = {
    LOBBY  = RES_DIR .. "bgm_lobby.OGG",
    PLAY = RES_DIR .. "bgm_play.OGG",
}

-- 音效id定义
SoundDef.EFFECT = {
    BTN_CLICK = RES_DIR .. "ui_btn_click.OGG",
    -- TODO
}

return SoundDef