extends Control

var timer_duration = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	#timer_duration = (floor(float($Timer/Timer_Display/Hours.text))*3600) + (floor(float($Timer/Timer_Display/Hours.text))*60) + floor(float($Timer/Timer_Display/Hours.text))
	pass

func _on_color_rect_gui_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		timer_duration = (floor(float($Timer/Timer_Display/Hours.text))*3600) + (floor(float($Timer/Timer_Display/Hours.text))*60) + floor(float($Timer/Timer_Display/Hours.text))
		visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
