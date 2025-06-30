extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	Globals.current_scene = 'settings'
	$CanvasLayer/Scene_Changer/Settings_Button.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_reset_data_button_pressed():
	$Reset_Confirm_Node.visible = true

func _on_confirm_button_pressed():
	SaveManager.reset_data()

func _on_delete_confirm_button_pressed():
	SaveManager.delete_data()
	get_tree().change_scene_to_file("res://Login/login_scene.tscn")


func _on_delete_data_button_pressed():
	$Delete_Confirm_Node.visible = true


func _on_sign_out_button_pressed():
	SaveManager.sign_out()
