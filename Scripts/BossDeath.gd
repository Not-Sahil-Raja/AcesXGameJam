extends State

func enter():
	super.enter()
	anim_player.play("death")
	await anim_player.animation_finished
	anim_player.play("boss_slained")
