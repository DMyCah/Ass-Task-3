extends Control

signal scene_Changed

#Bottom navigation

func _on_timer_pressed():
	#Change scene to timer and save
	get_tree().change_scene_to_file("res://Timer/timer_scene.tscn")
	Globals.current_scene = "timer"
	$Settings_Button.visible = true
	SaveManager.save_game()

#Change scene to duck
func _on_ducks_pressed():
	#Load the last scene that was opened by the user and save
	if Globals.game_last_scene == "collection":
		get_tree().change_scene_to_file("res://Game/game_collection_scene.tscn")
		Globals.current_scene = "game_collection"
	elif Globals.game_last_scene == "inventory":
		get_tree().change_scene_to_file("res://Game/game_inventory_scene.tscn")
		Globals.current_scene = "game_inventory"
	elif Globals.game_last_scene == "wardrobe":
		get_tree().change_scene_to_file("res://Game/game_wardrobe_scene.tscn")
		Globals.current_scene = "game_wardrobe"
	elif Globals.game_last_scene == "shop":
		get_tree().change_scene_to_file("res://Game/game_shop_scene.tscn")
		Globals.current_scene = "game_shop"
	emit_signal("scene_Changed", Globals.current_scene)
	$Settings_Button.visible = true
	SaveManager.save_game()

#Change scene to settings
func _on_settings_button_pressed():
	get_tree().change_scene_to_file("res://Setting/settings_scene.tscn")
	Globals.current_scene = "settings"
	SaveManager.save_game()
	
	
