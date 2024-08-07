extends Node2D

@onready var interaction_area: InteractionArea = $InteractionScene
@onready var sprite_2d = $Sprite2D
@onready var interaction_scene = $InteractionScene

@export var SpriteTexture:Texture
@export_enum("Disc" , "Recv") var Item : String 

var interactable
signal got_RadarItem

func _ready():
	sprite_2d.texture = SpriteTexture
	interaction_area.interact = Callable(self, "_get_RadarItem")
func _get_RadarItem():
	got_RadarItem.emit(Item)
	queue_free()

