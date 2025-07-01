extends Control
var Duck_ID

signal duck_selected

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func render_display(ID):
	Duck_ID = ID
	$Duck_Base.load_duck(ID)

func _on_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		emit_signal("duck_selected", Duck_ID)
