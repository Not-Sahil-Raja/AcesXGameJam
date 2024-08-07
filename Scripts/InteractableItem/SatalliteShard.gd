extends Node2D

@onready var interaction_area: InteractionArea = $InteractionScene
@onready var sprite_2d = $Sprite2D
@onready var interaction_scene = $InteractionScene

@export var SpriteTexture:Texture


var interactable
signal got_Shard

func _ready():
	sprite_2d.texture = SpriteTexture
	interaction_area.interact = Callable(self, "_get_Shards")
func _get_Shards():
	got_Shard.emit()
	queue_free()

