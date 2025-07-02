extends Control
@onready var progress_bar = $Component_Container/Progress/Progress_Bar
@onready var Target_label = $Component_Container/Target_Hours
@onready var Complete_label = $Component_Container/Complete_Hours
@onready var Goal_TextEdit = $Component_Container/Goal_TextEdit
var goals_library = SaveManager.current_save_data["goals"]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

signal reward_claimed_mission


var goal_goal
var goal_target
var goal_complete = 0
var goal_ID
var goal_reward
var reward_claimed = false
var reward_rate = 72

func generate_goal(goal, target):
	goal_goal = goal
	goal_target = float(target)
	goal_ID = 1
	goal_reward = int(target/reward_rate)
	if target == 3600:
		goal_reward = 50
	progress_update()

func create_goal(goal, target):
	generate_goal(goal, target)
	if goals_library.size() > 0:
		var last = goals_library[goals_library.size() - 1]
		var Last_ID = last["ID"]
		goal_ID = Last_ID + 1
		goals_library.append(get_goal_data())
	else:
		goals_library.append(get_goal_data())
		print(SaveManager.current_save_data)
	goal_target = target
	$Component_Container/Goal_TextEdit.text = goal
	#$Component_Container/Target_Hours.text = "Target: " + str(goal_target/3600)
	#$Component_Container/Complete_Hours.text = "Complete: " + str(goal_complete/3600)
	$Component_Container/Progress/Progress_Bar.max_value = goal_complete
	$Reward.text = "+ " + str(goal_reward)
	set_text_display(goals_library.size()-1)
	save_goal()
	
	
	

func progress_update():
	$Component_Container/Progress/Progress_Bar.value = goal_complete/goal_target

func reward_unlock():
	if reward_claimed == false:
		if goal_complete < goal_target:
			$Reward.disabled = true
		elif goal_complete >= goal_target:
			$Reward.disabled = false
	else:
		$Reward/Icon.visible = false
		$Reward.text = "Claimed"

func _on_reward_pressed():
	if reward_claimed == false:
		SaveManager.current_save_data["money"] += goal_reward
		emit_signal("reward_claimed_mission", goal_reward)
		$Reward.disabled = true
		reward_claimed = true
		save_goal()


func load_goal(ID):
	for i in range(goals_library.size()):
		if ID == goals_library[i]["ID"]:
			goal_ID = ID
			goal_goal = goals_library[i]["Goal"]
			goal_target = goals_library[i]["Target"]
			goal_complete = goals_library[i]["Complete"]
			goal_reward = goals_library[i]["Reward"]
			reward_claimed = goals_library[i]["RewardClaimed"]

			$Component_Container/Goal_TextEdit.text = goals_library[i]["Goal"]
			$Reward.text = "+ " + str(goals_library[i]["Reward"])
			set_text_display(i)
			progress_update()
			reward_unlock()


func set_text_display(index):
	var target_seconds = (goals_library[index]["Target"])
	var target_hour = float(target_seconds)/3600
	target_hour = ceil(target_hour/0.5)*0.5
	var target_minute = (int(target_seconds) % 3600)/60
	target_minute = ceil(target_minute/5)*5
	if (target_hour) > 1:
		if target_minute == 0:
			$Component_Container/Target_Hours.text = "Target: " + str(target_hour) + " hours"
		else:
			$Component_Container/Target_Hours.text = "Target: " + str(target_hour) + " hour " + str(target_minute) + " minutes"
	elif target_hour == 1 and target_minute == 0:
		$Component_Container/Target_Hours.text = "Target: " + str(target_hour) + " hour"
	else:
		$Component_Container/Target_Hours.text = "Target: " + str(target_minute) + " minutes"

	var complete_seconds = (goals_library[index]["Complete"])
	var complete_hour = int(complete_seconds)/3600
	complete_hour = ceil(complete_hour/0.5)*0.5
	var complete_minute = int(complete_seconds) % 3600/60
	complete_minute = ceil(complete_minute/5)*5
	if float(complete_hour) > 1:
		if complete_minute != 0:
			$Component_Container/Complete_Hours.text = "Target: " + str(complete_hour) + " hours"
		else:
			$Component_Container/Complete_Hours.text = "Target: " + str(complete_hour) + " hour " + str(complete_minute) + " minutes"
	elif float(complete_hour) == 1.0 and int(complete_minute) == 0:
		$Component_Container/Complete_Hours.text = "Target: " + str(complete_hour) + " hour"
	else:
		$Component_Container/Complete_Hours.text = "Target: " + str(complete_minute) + " minutes"


func _on_goal_text_edit_text_changed():
	
	if Goal_TextEdit.get_line_count() == 1:
		Goal_TextEdit.scroll_fit_content_height = true
	else:
		Goal_TextEdit.scroll_fit_content_height = false
	#Ensure top line displayed after pressing enter
	var line = Goal_TextEdit.get_caret_line()-1
	Goal_TextEdit.scroll_vertical = line

	#Dynamically adjust size of text edit	
	var line_count = Goal_TextEdit.get_line_count()
	var line_height = Goal_TextEdit.get_line_height()
	var desired_height = line_count * line_height + 4
	Goal_TextEdit.custom_minimum_size.y = min(desired_height, 90)
	
	var sanitise = SaveManager.filter_input_username("other",Goal_TextEdit.text)
	if sanitise == false:
		Goal_TextEdit.text = goal_goal
		$Filter_Detection.detection("INPUT")
	else:
		goal_goal = Goal_TextEdit.text





func _on_delete_goal_button_pressed():
	$Confirm_Delete.visible = true
	for i in range(goals_library.size()):
		if goal_ID == goals_library[i]["ID"]:
			goals_library.remove_at(i)
			SaveManager.save_game()
			break


func _on_cancel_pressed():
	$Confirm_Delete.visible = false

func _on_confirm_pressed():
	queue_free()
	$Confirm_Delete.visible = false

func get_goal_data():
	return {
		"ID":goal_ID,
		"Goal":goal_goal,
		"Target":goal_target,
		"Complete": goal_complete,
		"Reward":goal_reward,
		"RewardClaimed":reward_claimed
	}

func set_goal_data():
	goal_goal = $Component_Container/Goal_TextEdit.text

func _on_save_goal_button_pressed():
	progress_update()
	save_goal()

func save_goal():
	set_goal_data()
	for i in range(goals_library.size()):
		if goals_library[i]["ID"] == goal_ID:
			goals_library[i] = get_goal_data()
	SaveManager.save_game()
