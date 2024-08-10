extends Node2D
@onready var animation_player = $AnimationPlayer
@onready var story_bg = $Audio/AudioStreamPlayerBg2

func _ready():
	story_bg.play()
	animation_player.play("01")
	await animation_player.animation_finished
	animation_player.play("02")
	await animation_player.animation_finished
	animation_player.play("03")
	
	await animation_player.animation_finished
	animation_player.play("04")
	await animation_player.animation_finished	
	animation_player.play("05")
	await animation_player.animation_finished
	animation_player.play("06")
	await animation_player.animation_finished
	SceneManager.load_new_scene("res://Scenes/Levels/CrashSite.tscn","fade_to_black")
