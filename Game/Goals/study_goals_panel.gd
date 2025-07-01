extends Control
var goals_library = SaveManager.current_save_data["goals"]
var goal_resource = preload("res://Game/Goals/goal.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(goals_library.size()):
		var goal_ID = goals_library[i]["ID"]
		var goal_instance = goal_resource.instantiate()
		$ScrollContainer/Goal_Container.add_child(goal_instance)
		goal_instance.load_goal(goal_ID)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_create_button_pressed():
	$Create_Goal_panel.visible = true


func _on_cancel_pressed():
	$Create_Goal_panel.visible = false
	$Create_Goal_panel/VBoxContainer/Goal_Input.text = ""
	$Create_Goal_panel/VBoxContainer/Target_Hours_Input.text = ""

func _on_submit_pressed():
	$Create_Goal_panel.visible = false
	$Create_Goal_panel/VBoxContainer/Goal_Input.text = ""
	$Create_Goal_panel/VBoxContainer/Target_Hours_Input.text = ""



func _on_background_shader_gui_input(event):
	if event is InputEventMouseButton:
		self.visible = false
