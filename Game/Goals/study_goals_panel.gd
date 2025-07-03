extends Control
var goals_library = SaveManager.current_save_data["goals"]
var goal_resource = preload("res://Game/Goals/goal.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	instantiate_goals()

#Instantiates all goals in goal library
func instantiate_goals():
	for child in $ScrollContainer/Goal_Container.get_children():
		child.queue_free()
	for i in range(goals_library.size()):
		var goal_ID = goals_library[i]["ID"]
		var goal_instance = goal_resource.instantiate()
		$ScrollContainer/Goal_Container.add_child(goal_instance)
		goal_instance.load_goal(goal_ID)
		#Disables/enables goal reward
		goal_instance.reward_claimed_mission.connect(reward_notification)


func _on_create_button_pressed():
	$Create_Goal_panel.visible = true

#Resets Creating Goals panel
func _on_cancel_pressed():
	$Create_Goal_panel.visible = false
	$Create_Goal_panel/VBoxContainer/Goal_Input.text = ""
	$Create_Goal_panel/VBoxContainer/Target_Hours_Input.text = ""

#Resets Creating Goals panel
func _on_submit_pressed():
	$Create_Goal_panel.visible = false
	$Create_Goal_panel/VBoxContainer/Goal_Input.text = ""
	$Create_Goal_panel/VBoxContainer/Target_Hours_Input.text = ""

#Displays notification for claiming reward from goal
func reward_notification(Money):
	$Rewards_Notification.display_rewards_earned(Money, 0)

#If outside of goal board is clicked it hides
func _on_background_shader_gui_input(event):
	if event is InputEventMouseButton:
		for child in $ScrollContainer/Goal_Container.get_children():
			child.save_goal()
		self.visible = false
