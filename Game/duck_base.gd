extends CharacterBody2D

var duck_dictionary = SaveManager.current_save_data["ducks"]


var ID
var Body
var Headwear
var Eyewear
var Neckwear
var FullBodywear
var Wingwear
var Footwear
var Name
var Experience
var Level

func _ready():
	set_data()
	if !duck_dictionary:
		create_duck_save()
		Globals.displaying_duck_ID = SaveManager.current_save_data["ducks"][0]["ID"]
	if get_parent().get_name() == "Game_Wardrobe_Scene":
		load_duck(Globals.displaying_duck_ID)
	

#Changes the texture on each individual part based on the path for the png given and which part to change
func change_accessory(type, new_accessory_path):
	if type == "Headwear/":
		if new_accessory_path == "clear":
			$Headwear.texture = null
			Headwear = null
		else:
			$Headwear.texture = load(new_accessory_path)
			Headwear = new_accessory_path
	elif type == 'Eyewear/':
		if new_accessory_path == "clear":
			$Eyewear.texture = null
			Eyewear = null
		else:
			$Eyewear.texture = load(new_accessory_path)
			Eyewear = new_accessory_path
	elif type == 'Neckwear/':
		if new_accessory_path == "clear":
			$Neckwear.texture = null
			Neckwear = null
		else:
			$Neckwear.texture = load(new_accessory_path)
			Neckwear = new_accessory_path
	elif type == 'Footwear/':
		if new_accessory_path == "clear":
			$Footwear.texture = null
			Footwear = null
		else:
			$Footwear.texture = load(new_accessory_path)
			Footwear = new_accessory_path
	elif type == 'Wingwear/':
		if new_accessory_path == "clear":
			$Wingwear.texture = null
			Wingwear = null
		else:
			$Wingwear.texture = load(new_accessory_path)
			Wingwear = new_accessory_path
	elif type == 'FullBodywear/':
		if new_accessory_path == "clear":
			$FullBodywear.texture = null
			FullBodywear = null
		else:
			$FullBodywear.texture = load(new_accessory_path)
			FullBodywear = new_accessory_path


func load_duck(Loading_ID):
	ID = Loading_ID
	var loading = duck_dictionary[find_duck_Index_with_ID(Loading_ID)]
	if loading["Body"]:
		Body = loading["Body"]
		$Body.texture = load(Body)
	else:
		print("Error loading body for duck: ")

	if loading["Headwear"]:
		Headwear = loading["Headwear"]
		$Headwear.texture = load(Headwear)
	else:
		$Headwear.texture = null
		Headwear = null

	if loading["Eyewear"]:
		Eyewear = loading["Eyewear"]
		$Eyewear.texture = load(Eyewear)
	else:
		$Eyewear.texture = null
		Eyewear = null

	if loading["Neckwear"]:
		Neckwear = loading["Neckwear"]
		$Neckwear.texture = load(Neckwear)
	else:
		$Neckwear.texture = null
		Neckwear = null

	if loading["FullBodywear"]:
		FullBodywear = loading["FullBodywear"]
		$FullBodywear.texture = load(FullBodywear)
	else:
		$FullBodywear.texture = null
		FullBodywear = null

	if loading["Wingwear"]:
		Wingwear = loading["Wingwear"]
		$Wingwear.texture = load(Wingwear)
	else:
		$Wingwear.texture = null
		Wingwear = null

	if loading["Footwear"]:
		Footwear = loading["Footwear"]
		$Footwear.texture = load(Footwear)
	else:
		$Footwear.texture = null
		Footwear = null

	Name = loading["Name"]



#Saving a ducks data


func get_duck_data():
	return {
		"ID": ID,
		"Name": Name,
		"Body": Body,
		"Headwear": Headwear,
		"Eyewear": Eyewear,
		"Neckwear": Neckwear,
		"FullBodywear": FullBodywear,
		"Wingwear": Wingwear,
		"Footwear": Footwear,
		"Experience": Experience,
		"Level": Level
	}



func create_duck_save():
	generate_duck()
	if duck_dictionary.size() > 0:
		var last = duck_dictionary[duck_dictionary.size() - 1]
		var Last_ID = last["ID"]
		ID = Last_ID + 1
		duck_dictionary.append(get_duck_data())
	else:
		duck_dictionary.append(get_duck_data())
		print(SaveManager.current_save_data)

func generate_duck():
	var directory = DirAccess.open("res://Assets/Bodies")
	var files = []
	directory.list_dir_begin()
	var file_name = directory.get_next()
	while file_name != "":
		if file_name.get_extension().to_lower() in ["png"]:
			files.append(file_name)
		file_name = directory.get_next()
	directory.list_dir_end()
	Body = "res://Assets/Bodies/" + files[randi_range(0,files.size()-1)]
	$Body.texture = load(Body)
	


func update_save():
	print(ID)
	for i in range(duck_dictionary.size()):
		if duck_dictionary[i]["ID"] == ID:
			duck_dictionary[i] = get_duck_data()

func find_duck_Index_with_ID(finding_ID):
	for i in range(duck_dictionary.size()):
		if duck_dictionary[i]["ID"] == finding_ID:
			return i

func change_name(new_name):
	Name = new_name
	update_save()


func set_data():
	ID = 1
	Name = "MyFirstDuck"
	Experience = 0.0
	Level = 1



func _duck_selected_wardrobe(Selected_ID):
	load_duck(Selected_ID)

