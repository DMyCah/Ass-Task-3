extends Control
var Duck_ID

signal duck_selected
@onready var show = $Info_display.visible

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func render_display(ID):
	Duck_ID = ID
	$Duck_Base.load_duck(ID)



func display_duck_info():
	if show == false:
		$Info_display.visible = true
		show = true
	elif show == true:
		$Info_display.visible = false
		show = false

func _on_wardrobe_button_pressed():
	emit_signal("duck_selected_collection", Duck_ID)
	get_tree().change_scene_to_file("res://Game/game_wardrobe_scene.tscn")
	Globals.displaying_duck_ID = Duck_ID
	Globals.game_last_scene = "wardrobe"
	Globals.current_scene = "game_wardrobe"



func _on_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		display_duck_info()
