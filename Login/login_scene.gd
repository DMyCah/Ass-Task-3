extends Node2D
var login_username = ""
var create_username

# Called when the node enters the scene tree for the first time.
func _ready():
	$Opening_Panel.visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_reset_data_button_pressed():
	SaveManager.reset_game()
	get_tree().change_scene_to_file("res://Main Menu/main_menu_scene.tscn")


func _on_login_panel_button_pressed():
	$Login_Panel.visible = true
	$Opening_Panel.visible = false

func _on_create_panel_button_pressed():
	$Create_Panel.visible = true
	$Opening_Panel.visible = false




func _on_username_text_changed(new_text):
	login_username = new_text

func _on_login_pressed():
	var sanitise = SaveManager.filter_input_username("username",login_username)
	if sanitise == false:
		$Filter_Detection.detection("USERNAME")
	else:
		if SaveManager.login(login_username) == true:
			SaveManager.load_game()
			get_tree().change_scene_to_file("res://Main Menu/main_menu_scene.tscn")
			$Login_Panel/Valid_Username_Label.visible = false
		else:
			print("Login failed")
			$Login_Panel/Valid_Username_Label.visible = true



func _on_create_button_pressed():
	var sanitise = SaveManager.filter_input_username("username",create_username)
	if sanitise == false:
		$Filter_Detection.detection("USERNAME")
	else:
		if create_username:
			if SaveManager.create_user(create_username) == true:
				SaveManager.load_game()
				get_tree().change_scene_to_file("res://Main Menu/main_menu_scene.tscn")
				$Create_Panel/Username_Taken_Label.visible = false
			else:
				$Create_Panel/Username_Taken_Label.text = "Username Taken"
				$Create_Panel/Username_Taken_Label.visible = true
		else:
			print("Need username")
			$Create_Panel/Username_Taken_Label.visible = true
			$Create_Panel/Username_Taken_Label.text = "Please Enter A Username"


func _on_create_username_text_changed(new_text):
	create_username = new_text



func _on_back_pressed():
	$Login_Panel.visible = false
	$Create_Panel.visible = false
	$Opening_Panel.visible = true
