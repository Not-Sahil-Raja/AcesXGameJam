extends Node2D

@onready var interaction_area: InteractionArea = $InteractionScene
@onready var interaction_scene = $InteractionScene
@onready var sprite_2d = $Sprite2D
@onready var collision_shape_2d = $InteractionScene/CollisionShape2D

var fixed:bool = false

const STALLITE_COMPLETE = preload("res://Assets/SpriteLogos/SatelliteItems/Stallite_Complete.png")
signal fix_Satallite
signal scanning

func _ready():
	interaction_area.interact = Callable(self, "_fix_Satallite")
func _fix_Satallite():
	if !fixed:
		fix_Satallite.emit()
	else:
		CheckConnection()

func Satallite_fixed():
	print("Fixed")
	sprite_2d.texture= STALLITE_COMPLETE 
	sprite_2d.rotation_degrees= 82.5
	sprite_2d.position.y = -42.6
	fixed= true
	
	
func CheckConnection():
	scanning.emit()
	interaction_scene.queue_free()
