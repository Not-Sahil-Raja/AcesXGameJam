extends Node

@onready var timer:Timer = $Full_Screen_Control/Top_Control/BarsTimer
@onready var hunger_bar:TextureProgressBar = $Full_Screen_Control/Top_Control/Bars_hud/HungerBar
@onready var oxygen_bar:TextureProgressBar = $Full_Screen_Control/Top_Control/Bars_hud/OxygenBar
@onready var health_bar = $Full_Screen_Control/Top_Control/Bars_hud/HealthBar
@onready var bars_hud = $Full_Screen_Control/Top_Control/Bars_hud
@onready var bg_music = $BgMusic
@onready var damageMusic = $Damage
@onready var guide = $Full_Screen_Control/Guide
@onready var anim_palyer = $Anim_palyer


var maxHunger:int = 75
var maxOxygen:int = 103.5
var maxHelath:int = 98
var guide_showing:bool=false


func _process(delta):
	timer.wait_time = 3.0

func _on_timer_timeout():
	if oxygen_bar.value > 53.5:
		decrease_bar(oxygen_bar , 1)
	elif oxygen_bar.value <= 53.5 :
		decrease_bar(health_bar, 1)
	if hunger_bar.value>25.5:
		decrease_bar(hunger_bar,.5)
	elif hunger_bar.value <= 25.5:
		decrease_bar(oxygen_bar,1)
	
	CheckPlayerDead()
	
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
	oxygen_bar.value=maxOxygen

func CheckPlayerDead()->void:
	#print(.value)
	if health_bar.value <= 30:
		get_tree().call_group("player" , "dead")
		

func take_damage(dmgAmnt):
	decrease_bar(health_bar, dmgAmnt)
	CheckPlayerDead()
	damageMusic.play()
	
func resetHud():
	oxygen_bar.value=maxOxygen
	health_bar.value= maxHelath
	hunger_bar.value= maxHunger

func recover(bar:String, value:int):
	match bar:
		"o2":
			oxygen_bar.value += value
			oxygen_bar.value = min(oxygen_bar.value , maxOxygen)
		"health":
			health_bar.value += value
			health_bar.value = min(health_bar.value , maxHelath)
		"hunger":
			hunger_bar.value += value
			hunger_bar.value = min(hunger_bar.value , maxHunger)

func playMusic():
	bg_music.play()

func StopMusic():
	bg_music.stop()
	
func ShowGuide():
	if !guide_showing:
		guide_showing=true
		anim_palyer.play("Guide_Reveal")
		await anim_palyer.animation_finished
		guide_showing=false


func _on_guide_button_pressed():
	ShowGuide()
