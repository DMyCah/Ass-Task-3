extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_timer_pressed():
	get_tree().change_scene_to_file("res://Timer/timer_scene.tscn")
	$Settings_Button.visible = true

func _on_ducks_pressed():
	if Globals.game_last_scene == "collection":
		get_tree().change_scene_to_file("res://Game/game_collection_scene.tscn")
	elif Globals.game_last_scene == "inventory":
		get_tree().change_scene_to_file("res://Game/game_inventory_scene.tscn")
	elif Globals.game_last_scene == "wardrobe":
		get_tree().change_scene_to_file("res://Game/game_wardrobe_scene.tscn")
	$Settings_Button.visible = true


func _on_settings_button_pressed():
	get_tree().change_scene_to_file("res://Setting/settings_scene.tscn")
	
