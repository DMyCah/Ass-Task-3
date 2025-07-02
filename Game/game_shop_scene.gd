extends Control

var shop_items = Globals.item_shop
var item_display_resource = preload("res://Game/item_shop_frame.tscn")
var displaying_item_index
var duck_crate = false

# Called when the node enters the scene tree for the first time.
func _ready():
	populate_shop()
	print("\n\n\n\n")
	print(Globals.item_shop)
	print("\n\n\n\n")
	refresh_shop("Headwear/")
	update_displays_money()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func populate_shop():
	Globals.item_shop = []
	var categories = ["Headwear/","Eyewear/","Neckwear/","Wingwear/","FullBodywear/","Footwear/"]
	for category in categories:
		var directory_path = "res://Assets/ShopItems/" + category
		var directory = DirAccess.open(directory_path)
		if directory:
			directory.list_dir_begin()
			var item_name = directory.get_next()
			while item_name != "":
				if item_name.get_extension().to_lower() in ["png"]:
					Globals.item_shop.append({"item_name":item_name,"category":category,"path":directory_path+item_name, "cost":100})
				item_name = directory.get_next()
			directory.list_dir_end()

	var to_remove = []
	
	var items_owned = []
	for i in range(SaveManager.current_save_data["items_owned"].size()):
		items_owned.append(SaveManager.current_save_data["items_owned"][i]["item_name"])
	
	if SaveManager.current_save_data["items_owned"].size() != 0:
		for i in range(Globals.item_shop.size()):
			Globals.item_shop[i]["item_name"]
			if Globals.item_shop[i]["item_name"] in items_owned:
				print("\n\n\n FOUND MATCH \n\n\n")
				to_remove.append(Globals.item_shop[i])
		for i in to_remove:
			Globals.item_shop.erase(i)


func refresh_shop(category):
	for child in $Item_Container.get_children():
		child.queue_free()
	for i in range(Globals.item_shop.size()):
		if Globals.item_shop[i]["category"] == category:
			var item_path = Globals.item_shop[i]["path"]
			var item_name = Globals.item_shop[i]["item_name"]
			var item_cost = Globals.item_shop[i]["cost"]
			
			var item_instance = item_display_resource.instantiate()
			$Item_Container.add_child(item_instance)
			item_instance.render_display(item_path, item_name, item_cost, category)
			item_instance.item_selected.connect(display_item)
	print("Category" + category + "Refreshed")

func display_payment_panel(cost):
	$Payment_Panel/Icons/Icon.texture = load("res://Assets/Icons/WormIcon.png")
	$Payment_Panel/Icons/Icon2.texture = load("res://Assets/Icons/WormIcon.png")
	$Payment_Panel/Icons/Icon3.texture = load("res://Assets/Icons/WormIcon.png")
	$Payment_Panel/Current_num.text = str(SaveManager.current_save_data["money"])
	$Payment_Panel/Cost_num.text = str(cost)
	$Payment_Panel/Final.text = "Final: " + str(SaveManager.current_save_data["money"] - cost)
	if SaveManager.current_save_data["money"] - cost < 0:
		$Payment_Panel/Button.icon = load("res://Assets/Button/InsufficientFundsButton.png")
		$Payment_Panel/Button.disabled = true
	else:
		$Payment_Panel/Button.icon = load("res://Assets/Button/PurchaseButton.png")
		$Payment_Panel/Button.disabled = false

func _on_button_pressed():
	if duck_crate == true:
		var purchasing_cost = 1000
		SaveManager.current_save_data["food"] = SaveManager.current_save_data["food"] - purchasing_cost
		$Duck_Display.create_duck_save()
		$Payment_Panel.visible = false
		$Congrats_message.visible = true
		await get_tree().create_timer(3).timeout
		$Congrats_message.visible = false
	elif duck_crate == false:
		var purchasing_cost = Globals.item_shop[displaying_item_index]["cost"]
		var category = Globals.item_shop[displaying_item_index]["category"]
		SaveManager.current_save_data["items_owned"].append(Globals.item_shop[displaying_item_index])
		SaveManager.current_save_data["money"] = SaveManager.current_save_data["money"] - purchasing_cost
		populate_shop()
		refresh_shop(category)
		$Payment_Panel.visible = false
		print(SaveManager.current_save_data["items_owned"])
	update_displays_money()
	SaveManager.save_game()

func _on_clear_pressed():
	$Duck_Display.change_accessory(Globals.item_shop[displaying_item_index]["category"], "clear")
	$Payment_Panel.visible = false

func display_item(texture_path, item_cost, item_name, item_category):
	$Payment_Panel.visible = true
	display_payment_panel(item_cost)
	$Duck_Display.change_accessory(item_category, texture_path)
	for i in Globals.item_shop.size():
		if Globals.item_shop[i]["item_name"] == item_name:
			displaying_item_index = i
			break



func _on_duck_pressed():
	for child in $Item_Container.get_children():
		child.queue_free()
	$Crate.visible = true
	duck_crate = true
	$Payment_Panel.visible = false


func _on_head_pressed():
	refresh_shop("Headwear/")
	$Crate.visible = false
	duck_crate = false
	$Payment_Panel.visible = false

func _on_eye_pressed():
	refresh_shop("Eyewear/")
	$Crate.visible = false
	duck_crate = false
	$Payment_Panel.visible = false

func _on_neck_pressed():
	refresh_shop("Neckwear/")
	$Crate.visible = false
	duck_crate = false
	$Payment_Panel.visible = false

func _on_body_pressed():
	refresh_shop("FullBodywear/")
	$Crate.visible = false
	duck_crate = false
	$Payment_Panel.visible = false

func _on_wing_pressed():
	refresh_shop("Wingwear/")
	$Crate.visible = false
	duck_crate = false
	$Payment_Panel.visible = false

func _on_foot_pressed():
	refresh_shop("Footwear/")
	$Crate.visible = false
	duck_crate = false
	$Payment_Panel.visible = false





func _on_crate_gui_input(event):
	duck_crate = true
	if event is InputEventMouseButton and event.pressed:
		var cost = 1000
		$Payment_Panel.visible = true
		$Payment_Panel/Icons/Icon.texture = load("res://Assets/Icons/BreadIcon.png")
		$Payment_Panel/Icons/Icon2.texture = load("res://Assets/Icons/BreadIcon.png")
		$Payment_Panel/Icons/Icon3.texture = load("res://Assets/Icons/BreadIcon.png")
		$Payment_Panel/Current_num.text = str(SaveManager.current_save_data["food"])
		$Payment_Panel/Cost_num.text = str(cost)
		$Payment_Panel/Final.text = "Final: " + str(SaveManager.current_save_data["food"] - cost)
		if SaveManager.current_save_data["food"] - cost < 0:
			$Payment_Panel/Button.icon = load("res://Assets/Button/InsufficientFundsButton.png")
			$Payment_Panel/Button.disabled = true
		else:
			$Payment_Panel/Button.icon = load("res://Assets/Button/PurchaseButton.png")
			$Payment_Panel/Button.disabled = false

func update_displays_money():
	$Total_Money/Money.text = str(SaveManager.current_save_data["money"])
	$Total_Food/Food.text = str(SaveManager.current_save_data["food"])
