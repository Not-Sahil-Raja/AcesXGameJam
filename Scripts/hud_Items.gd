extends Node

var Hunger:int = 100
@onready var timer:Timer = $Full_Screen_Control/Timer
@onready var hunger_bar:ProgressBar = $Full_Screen_Control/HungerBar


func _process(delta):
	timer.wait_time = 3.0

func _on_timer_timeout():
	print("Hunger")
	Hunger -= 1
	hunger_bar.value= Hunger
	print(Hunger)

func start_timer()->void:
	
	timer.start()

func stop_timer()->void:
	timer.stop()

func visible_hunger_bar()->void:
	hunger_bar.visible= true
