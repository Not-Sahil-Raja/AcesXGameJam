extends ParallaxLayer

@export var Sky_BG_Speed : float = 5

func _process(delta):
	self.motion_offset.x += Sky_BG_Speed * delta
