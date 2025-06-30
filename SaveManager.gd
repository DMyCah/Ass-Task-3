extends Node
var current_save_data = {}
var default_save_data = {
		"username": "",
		"timer_Mode_Prefernce": "Normal",
		"Last_Timer_Length":"3300",
		"Last_Break_Length":"300",
		"ducks":[
			
		],
		"money":"0",
		"food":"0"
	}
var saves_dir = DirAccess.open("user://saves")
var save_file = "DevTestData.save"

func _ready():
	DirAccess.open("user://").make_dir_recursive("user://saves")

func new_save(username):
	current_save_data = default_save_data
	current_save_data["username"] = username
	save_file = username + ".save"
	save_game()

func save_game():
	Globals.save_global_data()
	var file = FileAccess.open("user://saves/"+save_file, FileAccess.WRITE)
	file.store_string(JSON.stringify(current_save_data))
	file.close()
	print("New game saved.", current_save_data)



func reset_data():
	if FileAccess.file_exists("user://saves/"+save_file):
		var file = FileAccess.open("user://saves/"+save_file, FileAccess.WRITE)
		file.store_string(JSON.stringify(default_save_data))
		file.close()
		current_save_data = default_save_data
		print("Data Reset")
		print(current_save_data)
	else:
		print("No save found.")

func delete_data():
	DirAccess.remove_absolute("user://saves/"+save_file)

func load_game():
	var file = FileAccess.open("user://saves/"+save_file, FileAccess.READ)
	var content = file.get_as_text()
	file.close()
	current_save_data = JSON.parse_string(content)
	Globals.load_save_data()
	print("Game loaded:", current_save_data)

func login(username):
	saves_dir.list_dir_begin()
	var file = saves_dir.get_next()
	while file != "":
		var searching_file = FileAccess.open("user://saves/"+file, FileAccess.READ)
		var content = JSON.parse_string(searching_file.get_as_text())
		searching_file.close()
		if content["username"] == username:
			save_file = file
			print("Found user:", username,"{", save_file, "}")
			return true
			break
		file = saves_dir.get_next()
	saves_dir.list_dir_end()
	#No user found
	print("No user found")
	return false


func create_user(username):
	print("creating user")
	saves_dir.list_dir_begin()
	var file = saves_dir.get_next()
	while file != "":
		var searching_file = FileAccess.open("user://saves/"+file, FileAccess.READ)
		var content = JSON.parse_string(searching_file.get_as_text())
		searching_file.close()
		if content["username"] == username:
			print("User: ", username, "already taken")
			return false
			break
		file = saves_dir.get_next()
	saves_dir.list_dir_end()
	#Username Valid
	new_save(username)
	return true

func sign_out():
	save_game()
	current_save_data = default_save_data
	print("\n\nRESET DATA")
	print(current_save_data)
	get_tree().change_scene_to_file("res://Login/login_scene.tscn")
	print("Signed out")
