extends Node2D
var duck_library = SaveManager.current_save_data["ducks"]
var duck_display_resource = preload("res://Game/duck_collection_frame.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	refresh_collection()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func refresh_collection():
	for child in $Collection_Container.get_children():
		child.queue_free()
	for i in range(duck_library.size()):
		var duck_ID = duck_library[i]["ID"]
		var duck_instance = duck_display_resource.instantiate()
		$Collection_Container.add_child(duck_instance)
		duck_instance.render_display(duck_ID)
		duck_instance.duck_selected.connect(_duck_selected)
		
func _duck_selected(ID):
	print("Duck loading" + str(ID))
