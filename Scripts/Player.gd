extends CharacterBody2D
@onready var anim_Sprite = $AnimatedSprite2D

@export var speed:float =150.0
var input_movement=Vector2.ZERO
var is_moving:bool=false
var dir:String=""


func _physics_process(delta):
	move()

func move():
	if Input.is_action_pressed("left"):
		velocity= Vector2.LEFT*speed
		is_moving=true
		dir="left"
		
	elif Input.is_action_pressed("right"):
		velocity= Vector2.RIGHT*speed
		is_moving=true
		dir="right"
		
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
			anim_Sprite.flip_h=false
			anim_Sprite.play("LeftMove")
		elif dir=="right":
			anim_Sprite.flip_h=true
			anim_Sprite.play("LeftMove")
		elif dir=="up":
			anim_Sprite.play("UpMove")
		elif dir== "down":
			anim_Sprite.play("DownMove")
	elif is_moving==false:
		anim_Sprite.play("Idle")
	
