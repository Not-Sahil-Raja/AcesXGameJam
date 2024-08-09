extends State
 
var can_transition : bool = false
 
func enter():
	super.enter()
	anim_player.play("armor_buff")
	await anim_player.animation_finished
	can_transition = true
 
func transition():
	if can_transition:
		can_transition = false
		get_parent().change_State("Follow")
