extends Control

var shop_items = Globals.item_shop
var item_display_resource = preload("res://Game/item_shop_frame.tscn")
var displaying_item_index
var duck_crate = false
var displaying_item_name

# Called when the node enters the scene tree for the first time.
func _ready():
	#Load in all shop items and start on the headwear tab
	populate_shop()
	refresh_shop("Headwear/")
	update_displays_money()

#Sets the shop items to be whatever is not owned by the user
func populate_shop():
	Globals.item_shop = []
	var categories = ["Headwear/","Eyewear/","Neckwear/","Wingwear/","FullBodywear/","Footwear/"]
	for category in categories:
		#Folder path for each categorie of accessories assets
		var directory_path = "res://Assets/ShopItems/" + category
		#Allows folder to be read
		var directory = DirAccess.open(directory_path)
		if directory:
			#Begins reading items in folder
			directory.list_dir_begin()
			#Gets first asset in folder
			var item_name = directory.get_next()
			#item_name is referncing an asset
			while item_name != "":
				#Check if it is an asset.png
				if item_name.get_extension().to_lower() in ["png"]:
					#Sets data and adds to item_shop list
					Globals.item_shop.append({"item_name":item_name,"category":category,"path":directory_path+item_name, "cost":100})
				item_name = directory.get_next()
			directory.list_dir_end()

	var to_remove = []
	
	var items_owned = []
	#Adds all items owned NAMES to a local list
	for i in range(SaveManager.current_save_data["items_owned"].size()):
		items_owned.append(SaveManager.current_save_data["items_owned"][i]["item_name"])
	
	if SaveManager.current_save_data["items_owned"].size() != 0:
		for i in range(Globals.item_shop.size()):
			Globals.item_shop[i]["item_name"]
			#Checks if item in shops name matches item owned
			if Globals.item_shop[i]["item_name"] in items_owned:
				#adds to removal list
				to_remove.append(Globals.item_shop[i])
		#Removes all items in list
		#Done seperately so that index still functions correctly rather than deleting an item when it is found and changing the index
		for i in to_remove:
			Globals.item_shop.erase(i)


func refresh_shop(category):
	#Removes children displayed in shop
	for child in $Item_Container.get_children():
		child.queue_free()
		
	#Clear duck accessory display
	if displaying_item_index:
		#Specifically find index here using the name rather than using displaying_item_index as the length of 
		#the array changes without displaying_item_index being updated
		for i in SaveManager.current_save_data["items_owned"].size():
			if SaveManager.current_save_data["items_owned"][i]["item_name"] == displaying_item_name:
				$Duck_Display.change_accessory(SaveManager.current_save_data["items_owned"][i]["category"], "clear")
				break
		for i in Globals.item_shop.size():
			if Globals.item_shop[i]["item_name"] == displaying_item_name:
				$Duck_Display.change_accessory(Globals.item_shop[i]["category"], "clear")
				break
		$Payment_Panel.visible = false
	
	for i in range(Globals.item_shop.size()):
		#Iterates through all items in the shop and checks if they are in the category requests
		if Globals.item_shop[i]["category"] == category:
			var item_path = Globals.item_shop[i]["path"]
			var item_name = Globals.item_shop[i]["item_name"]
			var item_cost = Globals.item_shop[i]["cost"]
			
			#Creates instances of each item frame to be displayed in the menu for purchase
			var item_instance = item_display_resource.instantiate()
			$Item_Container.add_child(item_instance)
			item_instance.render_display(item_path, item_name, item_cost, category)
			item_instance.item_selected.connect(display_item)



#Displays the blue right hand corner panel with the monetary values
func display_payment_panel(cost):
	#Sets little icon to display a worm
	$Payment_Panel/Icons/Icon.texture = load("res://Assets/Icons/WormIcon.png")
	$Payment_Panel/Icons/Icon2.texture = load("res://Assets/Icons/WormIcon.png")
	$Payment_Panel/Icons/Icon3.texture = load("res://Assets/Icons/WormIcon.png")
	#Value of currently owned worms
	$Payment_Panel/Current_num.text = str(SaveManager.current_save_data["money"])
	$Payment_Panel/Cost_num.text = str(cost)
	#Owned worms - cost
	$Payment_Panel/Final.text = "Final: " + str(SaveManager.current_save_data["money"] - cost)
	#Sets the display so that if insufficient funds, you cannot purchase
	if SaveManager.current_save_data["money"] - cost < 0:
		$Payment_Panel/Button.icon = load("res://Assets/Button/InsufficientFundsButton.png")
		$Payment_Panel/Button.disabled = true
	else:
		$Payment_Panel/Button.icon = load("res://Assets/Button/PurchaseButton.png")
		$Payment_Panel/Button.disabled = false


#Purchase button that processes depending on if you are purchasing a duck or accessory
func _on_button_pressed():
	if duck_crate == true:
		var purchasing_cost = 1000
		SaveManager.current_save_data["food"] = SaveManager.current_save_data["food"] - purchasing_cost
		$Duck_Display.create_duck_save()
		$Payment_Panel.visible = false
	elif duck_crate == false:
		var purchasing_cost = Globals.item_shop[displaying_item_index]["cost"]
		var category = Globals.item_shop[displaying_item_index]["category"]
		SaveManager.current_save_data["items_owned"].append(Globals.item_shop[displaying_item_index])
		SaveManager.current_save_data["money"] = SaveManager.current_save_data["money"] - purchasing_cost
		#Rerenders the menu to show the removed item and saves data
		populate_shop()
		refresh_shop(category)
		$Payment_Panel.visible = false
	
	update_displays_money()
	SaveManager.save_game()

#Removes the item selected in the category tab from the wooden display duck
func _on_clear_pressed():
	$Duck_Display.change_accessory(Globals.item_shop[displaying_item_index]["category"], "clear")
	$Payment_Panel.visible = false

#Gets all the data to display the accessory on the duck and the purchase information for purchase
func display_item(texture_path, item_cost, item_name, item_category):
	$Payment_Panel.visible = true
	display_payment_panel(item_cost)
	$Duck_Display.change_accessory(item_category, texture_path)
	for i in Globals.item_shop.size():
		if Globals.item_shop[i]["item_name"] == item_name:
			displaying_item_index = i
			displaying_item_name = item_name
			break


#When the duck tab is pressed, changes the purchase mode to duck crate
func _on_duck_pressed():
	for child in $Item_Container.get_children():
		child.queue_free()
	$Crate.visible = true
	duck_crate = true
	$Payment_Panel.visible = false


#Reloads shop with Category of accessory only
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






#Processes display for payment panel to show the duck crate purchase informatoin
func _on_crate_gui_input(event):
	duck_crate = true
	if event is InputEventMouseButton and event.pressed:
		var cost = 1000
		$Payment_Panel.visible = true
		#Displays little bread icon
		$Payment_Panel/Icons/Icon.texture = load("res://Assets/Icons/BreadIcon.png")
		$Payment_Panel/Icons/Icon2.texture = load("res://Assets/Icons/BreadIcon.png")
		$Payment_Panel/Icons/Icon3.texture = load("res://Assets/Icons/BreadIcon.png")
		#Currently held bread
		$Payment_Panel/Current_num.text = str(SaveManager.current_save_data["food"])
		$Payment_Panel/Cost_num.text = str(cost)
		#Bread - cost
		$Payment_Panel/Final.text = "Final: " + str(SaveManager.current_save_data["food"] - cost)
		#If you can afford or not
		if SaveManager.current_save_data["food"] - cost < 0:
			$Payment_Panel/Button.icon = load("res://Assets/Button/InsufficientFundsButton.png")
			$Payment_Panel/Button.disabled = true
		else:
			$Payment_Panel/Button.icon = load("res://Assets/Button/PurchaseButton.png")
			$Payment_Panel/Button.disabled = false

#changes display of money after purchases
func update_displays_money():
	$Total_Money/Money.text = str(SaveManager.current_save_data["money"])
	$Total_Food/Food.text = str(SaveManager.current_save_data["food"])
