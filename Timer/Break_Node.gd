extends Control

var break_length = 1
var previous_length = 1

func _ready():
	#Gets last used time length
	var timerDuration = SaveManager.current_save_data["Last_Break_Length"]
	$Break_Setup_Display.load_time_display()
	set_break_length()

#Sets the length of the break
func set_break_length():
	break_length = (floor(float($Break_Setup_Display/Hours_Break.text))*3600) + (floor(float($Break_Setup_Display/Minutes_Break.text))*60) + floor(float($Break_Setup_Display/Seconds_Break.text))
	#Check if timer length is = 0 and resets to previous length if it is
	if break_length == 0:
		break_length = previous_length
	else:
		previous_length = break_length
		SaveManager.current_save_data["Last_Break_Length"] = break_length
	return break_length


#Sets the break timers wait time to the values types in the text boxes
func break_duration():
	$Break_Timer.wait_time = (floor(float($Break_Setup_Display/Hours_Break.text))*3600) + (floor(float($Break_Setup_Display/Minutes_Break.text))*60) + floor(float($Break_Setup_Display/Seconds_Break.text))
	var breakDuration = $Break_Timer.wait_time
	#Rounds to nearest integer
	var hour = int(breakDuration)/3600
	var minute = int(breakDuration) % 3600/60
	var second = int(breakDuration)%60
	return [hour, minute, second]

#Gets the timer duration in the format "hours, minutes seconds"
func break_load_duration():
	var timerDuration = SaveManager.current_save_data["Last_Break_Length"]
	#Rounds to nearest integer
	var hour = int(timerDuration)/3600
	var minute = int(timerDuration) % 3600/60
	var second = int(timerDuration)%60
	return [hour, minute, second]

#Display the break time left when running
func break_left():
	var breakDuration = $Break_Timer.time_left
	#Rounds to nearest integer
	var hour = int(breakDuration)/3600
	var minute = int(breakDuration) % 3600/60
	var second = int(breakDuration)%60 
	return [hour, minute, second]

#Updates label depending on if the timer is running or not
func _process(_delta):
	if Globals.break_timer_start == false:
		#Not running so the lenght of the timer
		$Break_Label.text = "%02d:%02d:%02d" % break_duration()
	elif Globals.break_timer_start == true:
		#Running so time left
		$Break_Label.text = "%02d:%02d:%02d" % break_left()


#Set displays of text to what is entered and change break time to match
func _on_hours_text_submitted(new_text):
	$Break_Timer.wait_time = set_break_length()
	$Break_Setup_Display.update_time_display()
	
func _on_minutes_text_submitted(new_text):
	$Break_Timer.wait_time = set_break_length()
	$Break_Setup_Display.update_time_display()
	
func _on_seconds_text_submitted(new_text):
	$Break_Timer.wait_time = set_break_length()
	$Break_Setup_Display.update_time_display()
	

#Adds 5 minutes and updates display to fit
func _on_add_pressed():
	$Break_Setup_Display/Minutes_Break.text = str(int($Break_Setup_Display/Minutes_Break.text)+5)
	$Break_Setup_Display.update_time_display()

#Subtracts 5 minutes and updates display to fit
func _on_subtract_pressed():
	$Break_Setup_Display/Minutes_Break.text = str(int($Break_Setup_Display/Minutes_Break.text)-5)
	$Break_Setup_Display.update_time_display()
