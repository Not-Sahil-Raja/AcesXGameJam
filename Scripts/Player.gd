extends CharacterBody2D

class_name Player

@onready var muzzle = $Muzzle
@onready var anim_Sprite = $AnimatedSprite2D
@onready var player_torch_light = $Player_Torch_light
@export var Bullet : PackedScene

@export var speed:float =90.0

var movement_active:bool = true

var input_movement=Vector2.ZERO
var is_moving:bool=false
var dir:String="left"
var is_sprinting: bool= false
var direction:int = -1
var muzzle_position

@export var inventory:Inventory

func _ready():
	HudItems.visible_hunger_bar()
	HudItems.start_timer()
	muzzle_position= muzzle.position
	pass

func _physics_process(delta):
	
	if movement_active:
		
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
			anim_Sprite.play("LeftMove")
			player_torch_light.rotation_degrees= 140.0
		elif dir=="right":
			anim_Sprite.flip_h=false
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
			anim_Sprite.play("Side_Idle")
			
		elif dir=="right":
			anim_Sprite.flip_h=false
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
	var bullet_instance = Bullet.instantiate() as Node2D
	bullet_instance.direction = direction
	bullet_instance.global_position = muzzle.global_position
	get_parent().add_child(bullet_instance)

func player_muzzle_position():
	if direction > 0:
		muzzle.position.x = muzzle_position.x
	elif direction < 0:
		muzzle.position.x = -muzzle_position.x
