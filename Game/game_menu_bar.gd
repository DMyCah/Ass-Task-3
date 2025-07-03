extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$Menu_Box.visible = true

#Changes the menu tab on the top right in the game scene to its toggled state
func _on_menu_button_toggled(toggled_on):
	$Menu_Box.visible = toggled_on


#When collection/barn is clicked, save game and load
func _on_collection_button_pressed():
	SaveManager.save_game()
	get_tree().change_scene_to_file("res://Game/game_collection_scene.tscn")
	Globals.game_last_scene = "collection"
	Globals.current_scene = "game_collection"

#When wardrobe/coat hanger is clicked, save game and load
func _on_wardrobe_button_pressed():
	SaveManager.save_game()
	get_tree().change_scene_to_file("res://Game/game_wardrobe_scene.tscn")
	Globals.game_last_scene = "wardrobe"
	Globals.current_scene = "game_wardrobe"

#When Shop is clicked, save game and load
func _on_shop_button_pressed():
	SaveManager.save_game()
	get_tree().change_scene_to_file("res://Game/game_shop_scene.tscn")
	Globals.game_last_scene = "shop"
	Globals.current_scene = "game_shop"



func _on_study_goals_button_pressed():
	$Study_Goals_Panel.visible = true
	$Study_Goals_Panel.instantiate_goals()
