extends Node

var Hunger:int = 75
var Oxygen:int = 103.5
@onready var timer:Timer = $Full_Screen_Control/Top_Control/BarsTimer
@onready var hunger_bar:TextureProgressBar = $Full_Screen_Control/Top_Control/Bars_hud/HungerBar
@onready var oxygen_bar:TextureProgressBar = $Full_Screen_Control/Top_Control/Bars_hud/OxygenBar
@onready var health_bar = $Full_Screen_Control/Top_Control/Bars_hud/HealthBar
@onready var bars_hud = $Full_Screen_Control/Top_Control/Bars_hud


func _process(delta):
	timer.wait_time = 3.0

func _on_timer_timeout():
	if oxygen_bar.value > 53.5:
		decrease_bar(oxygen_bar , 5)
	else :
		decrease_bar(health_bar, 5)
	
func start_timer()->void:
	
	timer.start()

func stop_timer()->void:
	timer.stop()

func visible_bar()->void:
	bars_hud.visible = true

func decrease_bar(bar:TextureProgressBar , dVal : float):
	var tween : Tween = create_tween()
	tween.tween_property(bar, "value", bar.value - dVal, 0.7)

func oxygen_refill()->void:
	oxygen_bar.value=Oxygen
