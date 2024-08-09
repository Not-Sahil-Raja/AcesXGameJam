extends Node2D

@onready var satallite = $Satallite
@onready var rover_broken = $Rover_Broken
@onready var scanning_center_container = $UiItems/Control/ScanningCenterContainer
@onready var scanning_anim = $UiItems/Control/ScanningCenterContainer/Scanning
@onready var screen_timer = $UiItems/Control/ScanningCenterContainer/Screen_Timer
@onready var objectives_container = $UiItems/Control/Objectives_panel/NinePatchRect/Objectives_container
@onready var objective_text = $UiItems/Control/Objectives_panel/NinePatchRect/Objectives_container/Objective_text
@onready var objective_text_2 = $UiItems/Control/Objectives_panel/NinePatchRect/Objectives_container/Objective_text2
@onready var block_road = $BlockRoad
@onready var shape_ship_broken = $"ShapeShip_Items/ShapeShip Broken"

var rover

var shards:int = 3
var Disc:int = 1
var Recv:int = 1 
var GasCan:int = 1
var Satallite_fixing:bool = false
var Rover_Fixing:bool = false

func _ready():
	update_Objectivetext1()
	update_Objectivetext2()
	
# Pickup Solar Panel
func _on_satallite_shards_got_shard():
	shards -= 1
	update_Objectivetext1()

func update_Objectivetext1()->void:
	objective_text.text="Find Shards: (%s/3)"  %str(3- shards)
	if shards == 0:
		objective_text.text= "Attach the Solar Panel to Satallite"

func update_Objectivetext2()->void:
	objective_text_2.text="Find Disc (%s/1) & Receiver (%s/1)"  %[str(1- Disc) ,str(1-Recv)]
	if !Disc && !Recv:
		objective_text_2.text= "Attach the Full Disc to Satallite"

#Disc and Radar

func _on_disc__recv_got_radar_item(ItemType):
	if ItemType == "Disc":
		Disc -= 1
	elif ItemType == "Recv":
		Recv -= 1
	update_Objectivetext2()



func _on_satallite_fix_satallite():
	if  !shards && !Disc && !Recv:
		satallite.Satallite_fixed()
		objective_text.text="Check For The Signal"
		objective_text_2.queue_free()
	else:
		print("Get all items")


func _on_satallite_scanning():
	screen_timer.start()
	get_tree().paused = true
	scanning_center_container.visible = true
	scanning_anim.play("Scanning For Connection")
	
	
func _on_screen_timer_timeout():
	get_tree().paused = false
	objective_text.queue_free()
	scanning_center_container.queue_free()
	Satallite_fixing= true
	
	if Rover_Fixing && Satallite_fixing:
		block_road.queue_free()



func _on_rover_broken_fix_rover():
	if !GasCan:
		rover_broken.remove_collision()
		Rover_Fixing=true
		var rover_anim_player : AnimationPlayer= rover_broken.find_child("Rover_Anim_player")
		rover_anim_player.play("on_Fixed")
		await rover_anim_player.animation_finished
		rover_broken.move_rover()
		
		if Rover_Fixing && Satallite_fixing:
			block_road.queue_free()
			

func _on_rover_gascan_got_gas_can():
	GasCan-= 1


	
