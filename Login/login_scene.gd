extends Node2D
var login_username = ""
var create_username

# Called when the node enters the scene tree for the first time.
func _ready():
	$Opening_Panel.visible = true


func _on_reset_data_button_pressed():
	#Resets all data and returns to home screen
	SaveManager.reset_game()
	get_tree().change_scene_to_file("res://Main Menu/main_menu_scene.tscn")

#Displays login screen
func _on_login_panel_button_pressed():
	$Login_Panel.visible = true
	$Opening_Panel.visible = false

#Displays create user screen
func _on_create_panel_button_pressed():
	$Create_Panel.visible = true
	$Opening_Panel.visible = false



#Updates username based on username typed
func _on_username_text_changed(new_text):
	login_username = new_text

func _on_login_pressed():
	#Sanitise input when entered by pressing the login button
	var sanitise = SaveManager.filter_input_username("username",login_username)
	if sanitise == false:
		$Filter_Detection.detection("USERNAME")
	#Prevents any harm being done by inputs if not safe
	else:
		#If username is found in databse load game and data
		if SaveManager.login(login_username) == true:
			SaveManager.load_game()
			get_tree().change_scene_to_file("res://Main Menu/main_menu_scene.tscn")
			$Login_Panel/Valid_Username_Label.visible = false
		else:
			#Displays no username found
			$Login_Panel/Valid_Username_Label.visible = true


#Updates create username based on username typed
func _on_create_username_text_changed(new_text):
	create_username = new_text

func _on_create_button_pressed():
	#Sanitise input when entered by pressing the create button
	var sanitise = SaveManager.filter_input_username("username",create_username)
	if sanitise == false:
		$Filter_Detection.detection("USERNAME")
	#Prevents any harm being done by inputs if not safe
	else:
		if create_username:
			#User is able to be successfully created and is loaded in
			if SaveManager.create_user(create_username) == true:
				SaveManager.load_game()
				get_tree().change_scene_to_file("res://Main Menu/main_menu_scene.tscn")
				$Create_Panel/Username_Taken_Label.visible = false
			else:
				#A username is found that matches the original database
				$Create_Panel/Username_Taken_Label.text = "Username Taken"
				$Create_Panel/Username_Taken_Label.visible = true
		else:
			#no username given
			print("Need username")
			$Create_Panel/Username_Taken_Label.visible = true
			$Create_Panel/Username_Taken_Label.text = "Please Enter A Username"


#Returns to the opening menu screen
func _on_back_pressed():
	$Login_Panel.visible = false
	$Create_Panel.visible = false
	$Opening_Panel.visible = true
