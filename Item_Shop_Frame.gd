extends Control

signal item_selected
var item_texture_path = ""
var item_name
var item_cost
var item_category

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func render_display(texture, render_name, render_cost, category):
	item_texture_path = texture
	$Item.texture = load(texture)
	item_name = render_name
	item_cost = render_cost
	item_category = category

func _on_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		emit_signal("item_selected", item_texture_path, item_cost, item_name, item_category)
