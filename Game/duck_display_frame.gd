extends Control
var Duck_ID

signal duck_selected

#Loads duck shown in its frame that matches ID given
func render_display(ID):
	Duck_ID = ID
	$Duck_Base.load_duck(ID)

#Tells wardrobe which duck has been selected from top menu and to render it
func _on_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		emit_signal("duck_selected", Duck_ID)
