extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	Globals.current_scene = 'settings'
	$CanvasLayer/Scene_Changer/Settings_Button.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
