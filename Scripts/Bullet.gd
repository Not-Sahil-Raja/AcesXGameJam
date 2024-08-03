extends Area2D

var Speed:int = 500
var direction: int 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	move_local_x(direction* Speed * delta)
	
func _on_Bullet_body_entered(body):
	queue_free()

func _on_timer_timeout():
	queue_free()
