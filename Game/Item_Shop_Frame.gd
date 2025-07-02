extends Control

signal item_selected
var item_texture_path = ""
var item_name
var item_cost
var item_category


func render_display(texture, render_name, render_cost, category):
	#Sets instance of shop frame to have the same data as that given
	item_texture_path = texture
	$Item.texture = load(texture)
	item_name = render_name
	item_cost = render_cost
	item_category = category

#Tells the shop which item to display when it is clicked
func _on_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		emit_signal("item_selected", item_texture_path, item_cost, item_name, item_category)
