extends Node2D
@onready var item_got_center_container = $UiItems/Control/ItemGotCenterContainer
@onready var data_log_container = $UiItems/Control/DataLogContainer
@onready var animation_player = $UiItems/Control/ItemGotCenterContainer/AnimationPlayer
@onready var animation_player_data_log = $UiItems/Control/DataLogContainer/AnimationPlayer_DataLog
@onready var player = $Player
@onready var objective_text = $UiItems/Control/Objectives_panel/NinePatchRect/Objectives_container/Objective_text
@onready var objective_text_2 = $UiItems/Control/Objectives_panel/NinePatchRect/Objectives_container/Objective_text2
@onready var blocking_collision = $BlockingCollision

var Objective_Done:int= 0

func _ready():
	objective_text.text= "Inspect  Previous Base"
	objective_text_2.text="Check Previous SpaceShip"

func _on_prv_space_ship_prv_spaceship_inetracted():
	item_got_center_container.visible=true
	animation_player.play("ItemPickedUp")
	Objective_Done +=1
	if Objective_Done == 2:
		blocking_collision.queue_free()
	

func _play_close_itemPickedUp():
	objective_text_2.queue_free()
	animation_player.play("ItemPickedUp_close")
	
	
func _on_button_pressed():
	animation_player_data_log.play("DataLogExit")
	
func _on_animation_player_data_log_animation_finished(anim_name):
	if anim_name == "DataLogExit":
		player.enable_move()

func _on_prv_base_camp_prv_base_camp_inetracted():
	if objective_text != null : 
		objective_text.queue_free()
		Objective_Done +=1
		if Objective_Done == 2:
			blocking_collision.queue_free()
	data_log_container.visible=true
	animation_player_data_log.play("DataLogReveal")
	player.disable_move()
