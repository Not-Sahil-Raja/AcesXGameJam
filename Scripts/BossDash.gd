extends State

var can_transition: bool = false

func enter():
	super.enter()
	anim_player.play("IntoGround")
	await dash()
	await anim_player.animation_finished
	anim_player.play("glowing")
	await anim_player.animation_finished
	can_transition= true

func dash():
	var tween = create_tween()
	tween.tween_property(owner, "position" , player.position, 0.8)
	await tween.finished

func transition():
	if can_transition:
		can_transition=false
		
		get_parent().change_State("Follow")
