extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	populate_Item_Display("Headwear/")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func populate_Item_Display(type):
	print("type")
	var items_owned_list = SaveManager.current_save_data["items_owned"]
	Globals.current_wardrobe_tab = type
	var display_list = []
	for i in range(items_owned_list.size()):
		if items_owned_list[i]["category"] == type:
			display_list.append(items_owned_list[i]["item_name"])
	
	var folder_path = "res://Assets/ShopItems/"+type
	var dir = DirAccess.open(folder_path)
	if dir:
		var files = dir.get_files()
		for file_name in files:
			if file_name in display_list:
				if file_name.get_extension().to_lower() in ["png"]:
					var image_path = folder_path + file_name
					var icon = load(image_path)
					var index = $Item_Display.add_item("", icon)
					$Item_Display.set_item_metadata(index, image_path)



func _on_headwear_tab_pressed():
	$Item_Display.clear()
	populate_Item_Display("Headwear/")

func _on_eyewear_tab_pressed():
	$Item_Display.clear()
	populate_Item_Display("Eyewear/")

func _on_neckwear_tab_pressed():
	$Item_Display.clear()
	populate_Item_Display("Neckwear/")

func _on_full_bodywear_tab_pressed():
	$Item_Display.clear()
	populate_Item_Display("FullBodywear/")

func _on_wingwear_tab_pressed():
	$Item_Display.clear()
	populate_Item_Display("Wingwear/")

func _on_footwear_tab_pressed():
	$Item_Display.clear()
	populate_Item_Display("Footwear/")



