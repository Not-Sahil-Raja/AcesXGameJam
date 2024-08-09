extends Node2D

@onready var blocking_collision = $BlockingCollision

func _on_robohand_pickup_rover_hand():
	blocking_collision.queue_free()
