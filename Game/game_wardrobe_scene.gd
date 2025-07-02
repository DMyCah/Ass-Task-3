extends Node2D

#Gets the data of the item that was selected from the wardrobe to be dispalyed on the duck
func _on_item_display_item_selected(index):
	var file_path = $Wardrobe_Menu/Item_Display.get_item_metadata(index)
	#Current wardrobe tab set by menu to ensure the correct accessory is changed
	$Duck_Base.change_accessory(Globals.current_wardrobe_tab, file_path)

#Sets duck accessory to be blank
func _on_clear_accessory_button_pressed():
	$Duck_Base.change_accessory(Globals.current_wardrobe_tab, "clear")


#Saves the data of the duck to the current_save_data and then writes save data to save file
func _on_save_button_pressed():
	$Duck_Base.update_save()
	SaveManager.save_game()
	$Duck_Select_Menu.refresh_menu()
