extends State

func enter():
	super.enter()
	owner.set_physics_process(true)
	anim_player.play("Idle")

func exit():
	super.exit()
	owner.set_physics_process(false)

func transition():
	var distance = owner.direction.length()
	
	if distance < 30:
		get_parent().change_State("MeleeAttack")
	elif distance >130:
		var chance = randi() % 2
		match chance:
			0:
				get_parent().change_State("SpikeAttack")
			1:
				get_parent().change_State("LaserBeam")
