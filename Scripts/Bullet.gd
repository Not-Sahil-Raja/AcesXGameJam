extends Area2D

var Speed:int = 450
var direction: int 
@onready var sprite_2d = $Sprite2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if direction>0:  sprite_2d.flip_h = true
	else : sprite_2d.flip_h=false
	move_local_x(direction* Speed * delta)
	
func _on_Bullet_body_entered(body):
	queue_free()

func _on_timer_timeout():
	queue_free()



func _on_body_entered(body):
	body.take_damage()


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
