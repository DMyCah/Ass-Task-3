extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$Menu_Box.visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_menu_button_toggled(toggled_on):
	$Menu_Box.visible = toggled_on



func _on_collection_button_pressed():
	get_tree().change_scene_to_file("res://Game/game_collection_scene.tscn")
	Globals.game_last_scene = "collection"

func _on_inventory_button_pressed():
	get_tree().change_scene_to_file("res://Game/game_inventory_scene.tscn")
	Globals.game_last_scene = "inventory"

func _on_wardrobe_button_pressed():
	get_tree().change_scene_to_file("res://Game/game_wardrobe_scene.tscn")
	Globals.game_last_scene = "wardrobe"
