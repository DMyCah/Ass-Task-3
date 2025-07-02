extends Node2D

#Change to be saved depending on persons preference
var mode = SaveManager.current_save_data["timer_Mode_Prefernce"]
var mission_selected
var total_time = 0
var previous_time_elapsed = 0
var option_index = 0
var rewards_currency
var rewards_food

#Determines display on load
func _ready():
	$Work_Node/Work_Label.visible = false
	$Break_Node/Break_Label.visible = false
	$End_Confirm_Node.visible = false
	if mode == "Normal":
		display_Normal()
	elif mode == "Pomodoro":
		display_Pomodoro()
	fill_missions()

#Show break time if pomodoro
func display_Normal():
	$Break_Node/Break_Setup_Display.visible = false
	$Break_Node/Break_Title.visible = false

func display_Pomodoro():
	$Break_Node/Break_Setup_Display.visible = true
	$Break_Node/Break_Title.visible = true


#Displays for when the timer is running
func timer_running():
	$Start_Button.visible = false
	$Normal_Button.visible = false
	$Pomodoro_Button.visible = false
	$Pause_Button.visible = true
	$End_Button.visible = true
	
	
	$Work_Node/Work_Setup_Display.visible = false
	$Work_Node/Work_Label.visible = true
	
	
	$Break_Node/Break_Setup_Display.visible = false
	if mode == "Pomodoro":
		$Break_Node/Break_Label.visible = true
	
#Displays for when the timer is being set up, not running
func timer_setup():
	$Start_Button.visible = true
	$Normal_Button.visible = true
	$Pomodoro_Button.visible = true
	$Pause_Button.visible = false
	$End_Button.visible = false
	
	$Work_Node/Work_Setup_Display.visible = true
	$Work_Node/Work_Title.visible = true
	$Work_Node/Work_Label.visible = false
	
	$Break_Node/Break_Label.visible = false
	
	$End_Confirm_Node.visible = false
	
	$Top_Layer/Background.texture = load("res://Assets/Backgrounds/Pond.png")
	
	if mode == "Pomodoro":
		$Break_Node/Break_Setup_Display.visible = true
		$Break_Node/Break_Title.visible = true
	#Resets time to calculate rewards per timer
	previous_time_elapsed = 0
	total_time = 0



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	mode = Globals.timer_Mode


#Change modes when buttons pressed
func _on_pomodoro_pressed():
	Globals.timer_Mode = "Pomodoro"
	display_Pomodoro() 

func _on_normal_pressed():
	Globals.timer_Mode = "Normal"
	display_Normal()

#Begin timer and set the mission to the option selected
func _on_start_button_pressed():
	_on_missions_option_item_selected(option_index)
	$Work_Node/Work_Timer.start()
	$Top_Layer/Background.texture = load("res://Assets/Backgrounds/PondWorm.png")
	timer_running()

#Calculates the time elapsed and adds to the total completion time of the mission
func add_time_complete(time_elapsed):
	var adding = time_elapsed - previous_time_elapsed
	previous_time_elapsed = time_elapsed
	total_time = adding + total_time
	if mission_selected != null:
		mission_selected["Complete"] = (int(mission_selected["Complete"]) + adding)
		SaveManager.save_game()

#Stops timer currently running
func _on_pause_button_pressed():
	if Globals.work_timer_start == true:
		if $Work_Node/Work_Timer.paused == false:
			$Work_Node/Work_Timer.paused = true
			$Pause_Button.text = "Resume"

		elif $Work_Node/Work_Timer.paused == true:
			$Work_Node/Work_Timer.paused = false
			$Pause_Button.text = "Pause"
		add_time_complete($Work_Node/Work_Timer.wait_time - $Work_Node/Work_Timer.time_left)
		
	elif Globals.break_timer_start == true:
		if $Break_Node/Break_Timer.paused == false:
			$Break_Node/Break_Timer.paused = true
			$Pause_Button.text = "Resume"

		elif $Break_Node/Break_Timer.paused == true:
			$Break_Node/Break_Timer.paused = false
			$Pause_Button.text = "Pause"


#Pauses the timers and displays the end confirm screen
func _on_end_button_pressed():
	if Globals.work_timer_start == true:
		$Work_Node/Work_Timer.paused = true
		$Pause_Button.text = "Resume"
		add_time_complete($Work_Node/Work_Timer.wait_time - $Work_Node/Work_Timer.time_left)

	elif Globals.break_timer_start == true:
		$Break_Node/Break_Timer.paused = true
		$Pause_Button.text = "Resume"
	$End_Confirm_Node.visible = true

func _on_cancel_button_pressed():
	$End_Confirm_Node.visible = false

#Ends timers
func _on_confirm_button_pressed():
	$Work_Node/Work_Timer.stop()
	$Break_Node/Break_Timer.stop()
	$Work_Node/Work_Timer.paused = false
	$Break_Node/Break_Timer.paused = false
	$Pause_Button.text = "Pause"
	
	if mission_selected != null:
		#Checks if the mission selected has been completed
		check_mission_complete()
	#Rewards user after calculating rewards
	calculate_rewards(total_time)
	$Rewards_Notification.display_rewards_earned(rewards_currency, rewards_food)
	#Reset timer
	timer_setup()
	SaveManager.save_game()
	



#When timer ends naturally
func _on_work_timer_timeout():
	$Work_Node/Work_Timer.stop()
	Globals.work_timer_start = false
	add_time_complete($Work_Node/Work_Timer.wait_time - $Work_Node/Work_Timer.time_left)
	calculate_rewards(total_time)
	$Rewards_Notification.display_rewards_earned(rewards_currency, rewards_food)
	previous_time_elapsed = 0
	total_time = 0
	#Reset timer
	if mode == "Normal":
		#End if normal
		SaveManager.save_game()
		timer_setup()
	elif mode == "Pomodoro":
		#If pomodoro, beings the break timer
		Globals.break_timer_start = true
		$Break_Node/Break_Timer.start()
	if mission_selected != null:
		#Checks if mission is completed after work timer finishes
		check_mission_complete()
		


func _on_break_timer_timeout():
	#Starts work timer
	$Break_Node/Break_Timer.stop()
	$Work_Node/Work_Timer.start()
	Globals.break_timer_start = false
	Globals.work_timer_start = true


#Fills options bar with the name of the goals
func fill_missions():
	var goals_list = SaveManager.current_save_data["goals"]
	for goal in goals_list:
		var goal_text =  goal["Goal"]
		$Missions_Option.add_item(goal_text)



func _on_missions_option_item_selected(index):
	option_index = index
	if index != 0:
		#Set mission to the index given from the saved data of goals
		mission_selected = SaveManager.current_save_data["goals"][index-1]
	else:
		#Option 0 is no mission so dont set a mission
		mission_selected = null

func check_mission_complete():
	if mission_selected["Complete"] >= mission_selected["Target"]:
			print("Mission Complete!")

#Calculates the rewards based on time elapsed and adds to total
func calculate_rewards(time):
	rewards_currency = int(time/10)
	rewards_food = int(time/10)
	SaveManager.current_save_data["money"] += rewards_currency
	SaveManager.current_save_data["food"] += rewards_food
