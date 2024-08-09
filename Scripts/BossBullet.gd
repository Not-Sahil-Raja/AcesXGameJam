extends Area2D
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var player = get_parent().find_child("Player")

var acceleration:Vector2 = Vector2.ZERO
var velocity:Vector2 = Vector2.ZERO

func _physics_process(delta):
	acceleration = (player.position - position).normalized()*700
	velocity += acceleration * delta
	rotation = velocity.angle()
	velocity = velocity.limit_length(550)
	position += velocity *delta


func _on_body_entered(body):
	HudItems.take_damage(5)
	queue_free()


func _on_timer_timeout():
	queue_free()
