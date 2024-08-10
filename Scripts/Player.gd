class_name Player
extends CharacterBody2D

@onready var camera_2d = $Camera2D
@onready var muzzle = $Muzzle
@onready var anim_Sprite = $AnimatedSprite2D
@onready var player_torch_light = $Player_Torch_light
@onready var ui_elements = $UIElements
@onready var ui_anim_player = $Ui_anim_player
@onready var shooting_music_player = $Shooting_Music_player

@export var CAMERA_ZOOM:Vector2 = Vector2( 1.0, 1.0)
@export var Bullet : PackedScene
@export var CameraLimits :Dictionary={
	"left" : -1317,
	"right": 513,
	"top": -100000,
	"bottom":103
}
@export var speed:float =90.0
@export var inventory:Inventory
@export var Torch : bool
@export var _can_Shoot:bool

var movement_active:bool = true
var input_movement=Vector2.ZERO
var is_moving:bool=false
var dir:String="left"
var is_sprinting: bool= false
var direction:int = -1
var muzzle_position
var shooting:bool = false


func _ready():
	player_torch_light.visible= !Torch
	camera_2d.limit_left = CameraLimits["left"]
	camera_2d.limit_right = CameraLimits["right"]
	camera_2d.limit_top = CameraLimits["top"]
	camera_2d.limit_bottom = CameraLimits["bottom"]
	
	camera_2d.zoom= CAMERA_ZOOM
	
	HudItems.visible_bar()
	HudItems.start_timer()
	muzzle_position= muzzle.position
	pass

func _physics_process(delta):
	if Input.is_action_just_pressed("refil"):
		HudItems.oxygen_refill()
	
	if movement_active:
		if _can_Shoot:
			if Input.is_action_just_pressed("Shoot"):
				shoot()
		
		player_muzzle_position()
		
		if Input.is_action_pressed("Sprint"):
			is_sprinting= true
		else:
			is_sprinting= false
			
		if is_sprinting:
			speed= 95.0
		else:
			speed= 90.0
		move()
	

func move():
	
	if Input.is_action_pressed("left"):
		velocity= Vector2.LEFT*speed
		is_moving=true
		dir="left"
		direction= -1
		
	elif Input.is_action_pressed("right"):
		velocity= Vector2.RIGHT*speed
		is_moving=true
		dir="right"
		direction= 1
		
	elif Input.is_action_pressed("up"):
		velocity= Vector2.UP*speed
		is_moving=true
		dir="up"
		
	elif Input.is_action_pressed("down"):
		velocity= Vector2.DOWN*speed
		is_moving=true
		dir="down"
	
	else:
		velocity=Vector2.ZERO
		is_moving=false
		
		
	
	move_and_slide()
	
	if is_moving==true:
		if dir=="left":
			anim_Sprite.flip_h=true
			if shooting:
				anim_Sprite.play("Shooting&Moving")
				await anim_Sprite.animation_finished
				shooting= false
			else:
				anim_Sprite.play("LeftMove")
			player_torch_light.rotation_degrees= 140.0
		elif dir=="right":
			anim_Sprite.flip_h=false
			if shooting:
				anim_Sprite.play("Shooting&Moving")
				await anim_Sprite.animation_finished
				shooting= false
			else:
				anim_Sprite.play("LeftMove")
			player_torch_light.rotation_degrees= 40.0
		elif dir=="up":
			anim_Sprite.play("UpMove")
			
		elif dir== "down":
			anim_Sprite.play("DownMove")
			player_torch_light.rotation_degrees= 90.0
	elif is_moving==false:
		if dir=="left":
			anim_Sprite.flip_h=true
			if shooting:
				anim_Sprite.play("Shooting")
				await anim_Sprite.animation_finished
				shooting= false
			else:
				anim_Sprite.play("Side_Idle")
			
		elif dir=="right":
			anim_Sprite.flip_h=false
			if shooting:
				anim_Sprite.play("Shooting")
				await anim_Sprite.animation_finished
				shooting= false
			else:
				anim_Sprite.play("Side_Idle")
		elif dir=="up":
			anim_Sprite.play("Up_Idle")
		elif dir== "down":
			anim_Sprite.play("Down_Idle")

func _on_player_hurtbox_area_entered(area):
	if area.has_method("collect"):
		print(area.name)
		area.collect(inventory)

func disable_move():
	movement_active= false

func enable_move():
	movement_active = true

func shoot()->void:
	shooting=true
	var bullet_instance = Bullet.instantiate() as Node2D
	
	bullet_instance.direction = direction
	bullet_instance.global_position = muzzle.global_position
	get_parent().add_child(bullet_instance)
	shooting_music_player.play()
	

func player_muzzle_position():
	if direction > 0:
		muzzle.position.x = muzzle_position.x
		
	elif direction < 0:
		muzzle.position.x = -muzzle_position.x

func dead()->void:
	
	disable_move()
	ui_elements.visible=true
	ui_anim_player.play("Dead")
	await ui_anim_player.animation_finished
	HudItems.resetHud()
	get_tree().reload_current_scene()


