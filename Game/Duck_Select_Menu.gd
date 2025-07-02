extends HBoxContainer
var duck_library = SaveManager.current_save_data["ducks"]
var duck_display_resource = preload("res://Game/duck_display_frame.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	#Refresh menu of ducks in wardrobe to ensure new ducks bought are loaded in
	refresh_menu()


func refresh_menu():
	#Clears all children in the menu already
	for child in $Duck_Scroller/Duck_Container.get_children():
		child.queue_free()
	#Finds all the ducks in the library and instances each of them
	for i in range(duck_library.size()):
		var duck_ID = duck_library[i]["ID"]
		var duck_instance = duck_display_resource.instantiate()
		$Duck_Scroller/Duck_Container.add_child(duck_instance)
		duck_instance.render_display(duck_ID)
		#Connects the signal to each duck instanced
		duck_instance.duck_selected.connect(_duck_selected)

#When a duck is clicked in the menu, a signal is sent telling the displaying duck to change
func _duck_selected(ID):
	$"../Duck_Base".load_duck(ID)
