extends Node2D

var PrevRoverInteractNum:int =0
@onready var obj_text = $UiItems/Control/Objectives_panel/NinePatchRect/Objectives_container/Objective_text
@onready var obj_text_2 = $UiItems/Control/Objectives_panel/NinePatchRect/Objectives_container/Objective_text2
@onready var pcb = $UiItems/Control/PCB
@onready var pcb_connectors = $UiItems/Control/PCB/PCB_Connectors
@onready var data_log_screen = $UiItems/Control/PCB/DataLog_Screen
@onready var Data_anim_player = $UiItems/Control/PCB/DataLog_Screen/AnimationPlayer
@onready var pcb_anim_player = $UiItems/Control/PCB/PCB_Connectors/PCB_AnimationPlayer
@onready var blocking_collision = $BlockingCollision
@onready var rover_mrr_sound = $UiItems/Control/PCB/DataLog_Screen/RoverMRRSound

var battery: bool = false
var prevButton:String

func _ready():
	obj_text.text="Find ROVER: MRR-12"

func _on_prve_rover_on_interact_prev_rover():
	PrevRoverInteractNum += 1
	
	if PrevRoverInteractNum == 1:
		obj_text.text= "Fix MRR-12 :"
		if obj_text_2!=null:
			obj_text_2.text="Find Something to Power Up"
	
	if battery:
		pcb.visible= true


func _on_mrr_battery_got_mrr_battery():
	battery= true
	obj_text_2.queue_free()


func _on_a_button_button_clicked(ButtonVal):
	CheckConnection(ButtonVal)

func _on_b_button_button_clicked(ButtonVal):
	CheckConnection(ButtonVal)
func _on_c_button_button_clicked(ButtonVal):
	CheckConnection(ButtonVal)

func _on_d_button_button_clicked(ButtonVal):
	CheckConnection(ButtonVal)

func _on_e_button_button_clicked(ButtonVal):
	CheckConnection(ButtonVal)

func CheckConnection(ButtonVal:String):
	if prevButton == "":
		prevButton= ButtonVal
		print("Prev: %s" %prevButton)
	else:
		
		if not (prevButton== "E" && ButtonVal == "C"):
			pcb_anim_player.play("Failed_Text")
			prevButton =""
			return
		else:
			pcb_connectors.queue_free()
			data_log_screen.visible=true
			Data_anim_player.play("DataLogReveal")
			await Data_anim_player.animation_finished
			rover_mrr_sound.play()


func _on_close_button_pressed():
	Data_anim_player.play("DataLogHide")
	obj_text.queue_free()
	blocking_collision.queue_free()
	if rover_mrr_sound.playing:
		rover_mrr_sound.stop()
	
