extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_memo_button_pressed():
	get_tree().change_scene_to_file("res://Memo/Memo_Scene.tscn")


func _on_calender_button_pressed():
	get_tree().change_scene_to_file("res://Calender/calender_scene.tscn")


func _on_timer_button_pressed():
	get_tree().change_scene_to_file("res://Timer/timer_scene.tscn")


func _on_game_button_pressed():
	get_tree().change_scene_to_file("res://Game/game_scene.tscn")


func _on_settings_button_pressed():
	get_tree().change_scene_to_file("res://Setting/settings_scene.tscn")
