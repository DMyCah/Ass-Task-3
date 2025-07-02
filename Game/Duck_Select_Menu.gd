extends HBoxContainer
var duck_library = SaveManager.current_save_data["ducks"]
var duck_display_resource = preload("res://Game/duck_display_frame.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	refresh_menu()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func refresh_menu():
	for child in $Duck_Scroller/Duck_Container.get_children():
		child.queue_free()
	for i in range(duck_library.size()):
		var duck_ID = duck_library[i]["ID"]
		var duck_instance = duck_display_resource.instantiate()
		$Duck_Scroller/Duck_Container.add_child(duck_instance)
		duck_instance.render_display(duck_ID)
		duck_instance.duck_selected.connect(_duck_selected)

func _duck_selected(ID):
	print("Duck loading" + str(ID))
	$"../Duck_Base".load_duck(ID)
