local targetPlatform = cc.Application:getInstance():getTargetPlatform()

local SystemConst = {

	-- key
	SOUND_KEY = "sound_key", -- UserDefault中保存音效播放状态键
	MUSIC_KEY = "music_key", -- UserDefault中保存背景音乐播放状态键
	HIGH_SCORE_KEY = "high_score_key", -- UserDefault中保存最高记录键

	-- 声音
	INDEX_BG_MUSIC = "sounds/mainMainMusic.ogg",  -- 主页背景音乐
	GAME_BG_MUSIC = "sounds/bgMusic.ogg",  -- 游戏背景音乐
	BUTTON_EFFECT = "sounds/buttonEffect.ogg",
	EXPLODE_EFFECT = "sounds/explodeEffect.ogg",
	SHIP_DESTROY_EFFECT = "sounds/shipDestroyEffect.ogg",
	FIRE_EFFECT = "sounds/fireEffect.ogg",

	-- Json
	JSON_STATE = "res/json/info.json",
	JSON_RANK = "res/json/rank.json",

	-- 分值与生命值
	ENEMY_SCORE = 500,
	ENEMY_INITIAL_HIT_POINTS = 5,
	FIGHTER_INITIAL_HIT_POINTS = 1,

	-- 字体
	FONT = "ui/font/FontNormal.ttf",
	BMF_FONT = "ui/rank/islandcvbignum.fnt",

	-- 图片与特效
	ENEMY_NAME = "player/small_enemy.png",
	FIGHTER_NAME = "player/red_plane.png",
	PARTICLE_NAME = "particle/fire.plist",
	BULLET_NAME = "player/blue_bullet.png",
	EXPLODE_NAME = "animation/explosion.plist",
	LIFE_NAME = "ui/battle/life.png",
	SCORE_NAME = "ui/battle/score.png",
	GAME_BG_NAME = "img_bg/bg.jpg",
	MENU_BG_NAME = "ui/main/bg_menu.jpg",
	ENEMY_PLANE_NAME = "player/red_plane.png",

	-- 按钮
	PAUSE_BUTTON_NORMAL = "ui/battle/uiPause.png",
	PAUSE_BUTTON_PRESSED = "ui/battle/uiPause.png",
	PAUSE_BUTTON_DISABLED = "ui/battle/uiPause.png",

	PAUSE_BUTTON_BACK_ROOM_NORMAL = "ui/continue/pauseBackRoom.png",
	PAUSE_BUTTON_BACK_ROOM_PRESSED = "ui/continue/pauseBackRoom.png",
	PAUSE_BUTTON_BACK_ROOM_DISABLED = "ui/continue/pauseBackRoom.png",

	PAUSE_BUTTON_RESUME_NORMAL = "ui/continue/pauseResume.png",
	PAUSE_BUTTON_RESUME_PRESSED = "ui/continue/pauseResume.png",
	PAUSE_BUTTON_RESUME_DISABLED = "ui/continue/pauseResume.png",

	INDEX_BUTTON_NEW_GAME_NORMAL = "ui/main/new_game1.png",
	INDEX_BUTTON_NEW_GAME_PRESSED = "ui/main/new_game2.png",
	INDEX_BUTTON_NEW_GAME_DISABLED = "ui/main/new_game1.png",

	INDEX_BUTTON_RESUME_NORMAL = "ui/main/continue_menu1.png",
	INDEX_BUTTON_RESUME_PRESSED = "ui/main/continue_menu2.png",
	INDEX_BUTTON_RESUME_DISABLED = "ui/main/continue_menu3.png",

	INDEX_BUTTON_RANK_NORMAL = "ui/main/rank_menu1.png",
	INDEX_BUTTON_RANK_PRESSED = "ui/main/rank_menu2.png",
	INDEX_BUTTON_RANK_DISABLED = "ui/main/rank_menu1.png",

	INDEX_BUTTON_SETTINGS_NORMAL = "ui/main/setting_menu1.png",
	INDEX_BUTTON_SETTINGS_PRESSED = "ui/main/setting_menu2.png",
	INDEX_BUTTON_SETTINGS_DISABLED = "ui/main/setting_menu1.png",

	BACK_BUTTON_NORMAL = "ui/back_peek0.png",
	BACK_BUTTON_PRESSED = "ui/back_peek1.png",
	BACK_BUTTON_DISABLED = "ui/back_peek0.png",

	MUSIC_CHECKBOX_OPEN = "ui/setting/open.png",
	MUSIC_CHECKBOX_CLOSE = "ui/setting/close.png",

	REGISTER_BUTTON_NORMAL = "ui/register/register.png",
	REGISTER_BUTTON_PRESSED = "ui/register/register2.png",
	REGISTER_BUTTON_DISABLED = "ui/register/register.png",

	GAME_OVER_BUTTON_BACK = "ui/gameover/back.png",
	GAME_OVER_BUTTON_RESTART = "ui/gameover/restart.png",

	-- RANK
	RANK_TITLE_BG = "ui/rank/rank_title_bg.png",
	RANK_ITEM_BG = "ui/rank/rank_item_bg.png",


	-- 精灵速度常量
	ENEMY_VELOCITY = cc.p(0, -80),
	BULLET_VELOCITY = cc.p(0, 200),

	-- Flag
	IF_CONTINUE = "if_continue",



	-- Tag
	GameSceneNodeTag = {
		Enemy = 1,
		Fighter = 2,
		Bullet = 3,
		ExplosionParticleSystem = 4,
		StatusBarScore = 5,
		StatusBarLife = 6
	},
}

return SystemConst