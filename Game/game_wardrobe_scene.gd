extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_item_display_item_selected(index):
	var file_path = $Wardrobe_Menu/Item_Display.get_item_metadata(index)
	$Duck_Base.change_accessory(Globals.current_wardrobe_tab, file_path)



func _on_clear_accessory_button_pressed():
	$Duck_Base.change_accessory(Globals.current_wardrobe_tab, "clear")



func _on_save_button_pressed():
	$Duck_Base.update_save()
	SaveManager.save_game()
	$Duck_Select_Menu.refresh_menu()
