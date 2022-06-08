local targetPlatform = cc.Application:getInstance():getTargetPlatform()

local SystemConst = {

-- UserDefault中保存音效播放状态键
SOUND_KEY = "sound_key",
-- UserDefault中保存背景音乐播放状态键
MUSIC_KEY = "music_key",
-- UserDefault中保存最高记录键
HIGHSCORE_KEY = "highscore_key",

-- 安卓平台

-- 声音
bg_music_1 = "sounds/mainMainMusic.ogg",  -- 主页背景音乐
bg_music_2 = "sounds/bgMusic.ogg",  -- 游戏背景音乐
sound_1 = "sounds/buttonEffect.ogg",
sound_2 = "sounds/explodeEffect.ogg",
effectExplosion = "sounds/explodeEffect.ogg",


-- 精灵速度常量
SpriteVelocity = {
	EnemyPlane = cc.p(0, -80),
	Bullet = cc.p(0, 200)
},


-- 敌人分值
EnemyScores = 500,


-- 敌人初始生命值
EnemyInitialHitPoints = 10,


-- 我方初始生命值
FighterInitialHitPoints = 5,


-- Tag
GameSceneNodeTag = {
	Enemy = 1,
	Fighter = 2,
	Bullet = 3,
	ExplosionParticleSystem = 4,
	StatusBarScore = 5,
	StatusBarLife = 6
},

-- 字体
Font = "ui/font/FontNormal.ttf",


EnemyName = "player/small_enemy.png",
FighterName = "player/red_plane.png",
ParticleName = "particle/fire.plist",
BulletName = "player/blue_bullet.png",
ExplosionName = "animation/explosion.plist",
LifeName = "ui/battle/life.png",
ScoreName = "ui/battle/score.png"

}

return SystemConst