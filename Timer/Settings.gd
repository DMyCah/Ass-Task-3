extends Control

#Change to be saved depending on persons preference
var mode = "Normal"

func display_Normal():
	$Break_Display.visible = false
	
func display_Pomodoro():
	$Break_Display.visible = true

# Called when the node enters the scene tree for the first time.
func _ready():
	if mode == "Normal":
		display_Normal()
	elif mode == "Pomodoro":
		display_Pomodoro()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_normal_pressed():
	display_Normal()
	
func _on_pomodoro_pressed():
	display_Pomodoro()
