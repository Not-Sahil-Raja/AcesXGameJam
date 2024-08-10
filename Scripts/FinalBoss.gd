extends CharacterBody2D

@onready var pivot = $Pivot
@onready var player= get_parent().find_child("Player")
@onready var sprite_2d = $Sprite2D
@onready var progress_bar = $Boss_Ui_Elements/ProgressBar
@onready var bg_music = $Audio/BGMusic

var direction: Vector2
var DEF = 0

var health = 100:
	set(value):
		health=value
		progress_bar.value = value
		if value <= 0:
			progress_bar.visible= false
			find_child("FiniteStateMachine").change_State("Death")
		elif value <= progress_bar.max_value/2 and DEF ==0 :
			DEF=2
			find_child("FiniteStateMachine").change_State("ArmorBuff")

func _ready():
	set_physics_process(false)
	StopTheBgM()
func _process(delta):
	direction = player.position - position
	
	if direction.x <0:
		sprite_2d.flip_h= false
		pivot.position.x = 24
	else:
		sprite_2d.flip_h= true
		pivot.position.x = -24

func _physics_process(delta):
	velocity = direction.normalized() * 40
	move_and_collide(velocity* delta)

func take_damage():
	health -= 3 - DEF


func _on_laser_player_detection_body_entered(body):
	if body== player:
		HudItems.take_damage(10)

func transition_to_mainMenu():
	SceneManager.load_new_scene("res://Scenes/Levels/StartScreen.tscn","fade_to_black")

func StopTheBgM():
	HudItems.StopMusic()
	bg_music.play()
func meleeDamage():
	HudItems.take_damage(20)

