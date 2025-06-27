extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer/Timer_Label.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
func _on_timer_settings_pressed():
	$Timer_Settings.visible = true

func timer_running():
	$Timer_Settings.visible = false
	$Start.visible = false
	$Timer/Timer_Display.visible = false
	$Timer/Timer_Label.visible = true
	
