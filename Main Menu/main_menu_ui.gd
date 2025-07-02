extends Control


# Switching between scenes for each button on main menu
func _on_timer_button_pressed():
	get_tree().change_scene_to_file("res://Timer/timer_scene.tscn")
	Globals.current_scene = "timer"

func _on_game_button_pressed():
	get_tree().change_scene_to_file("res://Game/game_collection_scene.tscn")
	Globals.current_scene = "game"

func _on_settings_button_pressed():
	get_tree().change_scene_to_file("res://Setting/settings_scene.tscn")
	Globals.current_scene = "settings"
