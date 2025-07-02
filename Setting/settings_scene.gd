extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	Globals.current_scene = 'settings'
	#hides top left settings button when settings is opened
	$CanvasLayer/Scene_Changer/Settings_Button.visible = false


func _on_reset_data_button_pressed():
	$Reset_Confirm_Node.visible = true

#Resets data confirmation when clicked
func _on_confirm_button_pressed():
	SaveManager.reset_data()

#Delete data confirmation when clicked
func _on_delete_confirm_button_pressed():
	SaveManager.delete_data()
	#Return to Login screen
	get_tree().change_scene_to_file("res://Login/login_scene.tscn")


func _on_delete_data_button_pressed():
	$Delete_Confirm_Node.visible = true


func _on_sign_out_button_pressed():
	SaveManager.sign_out()
