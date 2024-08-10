extends State


func enter():
	super.enter()
	anim_player.play("meleeAttack")

	
func transition():
	if owner.direction.length() > 30:
		get_parent().change_State("Follow")
		
