class_name StartScreen extends Control




func _on_button_pressed():
	SceneManager.load_new_scene("res://Scenes/Levels/CrashSite.tscn","fade_to_black")
