extends State
@onready var spike_shoot_area = $"../../SpikeShoot_Area"
@export var Spike_Node:PackedScene
var can_transition:bool = false

func enter():
	super.enter()
	anim_player.play("SpikeAttack")
	await anim_player.animation_finished
	shoot()
	can_transition=true

func shoot():
	var spike = Spike_Node.instantiate()
	spike.position = spike_shoot_area.position
	get_tree().current_scene.add_child(spike)

func transition():
	if can_transition:
		can_transition = false
		get_parent().change_State("Dash")
