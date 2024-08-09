extends Node2D

@onready var interaction_area: InteractionArea = $InteractionScene
@onready var interaction_scene = $InteractionScene

signal pickup_roverHand

func _ready():
	interaction_area.interact = Callable(self, "_pickup_RoverHand")
func _pickup_RoverHand():
	pickup_roverHand.emit()
	queue_free()
