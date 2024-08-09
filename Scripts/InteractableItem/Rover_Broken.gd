extends Node2D

@onready var interaction_area: InteractionArea = $InteractionScene
@onready var interaction_scene = $InteractionScene
@onready var path_follow_2d = $Path2D/PathFollow2D
@onready var rover_anim_player = $Rover_Anim_player

var speed:float = 1
var move:bool =false

signal fix_rover

func _ready():
	interaction_area.interact = Callable(self, "_fix_rover")

func _fix_rover():
	fix_rover.emit()

func remove_collision():
	interaction_scene.queue_free()

func move_rover():
	move=true
	
func _process(delta):
	if move:
		path_follow_2d.progress_ratio += delta * speed
		play_animation("movingLeft")
	
	if path_follow_2d.progress_ratio == 1:
		move=false
		play_animation("idle_left")
		

func play_animation(anim_name):
	rover_anim_player.play(anim_name)
