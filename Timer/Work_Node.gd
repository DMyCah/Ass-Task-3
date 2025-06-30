extends Control

var timer_length = 1
var previous_length = 1

func _ready():
	#Rounds to nearest integer
	$Work_Setup_Display.load_time_display()
	set_timer_length()
	
func set_timer_length():
	timer_length = (floor(float($Work_Setup_Display/Hours_Work.text))*3600) + (floor(float($Work_Setup_Display/Minutes_Work.text))*60) + floor(float($Work_Setup_Display/Seconds_Work.text))
	#Check if timer length is = 0 and resets to previous length if it is
	if timer_length == 0:
		timer_length = previous_length
	else:
		previous_length = timer_length
		SaveManager.current_save_data["Last_Timer_Length"] = timer_length
	return timer_length
	
func time_left():
	#$Timer.wait_time = (floor(float($Timer_Display/Hours.text))*3600) + (floor(float($Timer_Display/Minutes.text))*60) + floor(float($Timer_Display/Seconds.text))
	var timerDuration = $Work_Timer.time_left
	#Rounds to nearest integer
	var hour = int(timerDuration)/3600
	var minute = int(timerDuration) % 3600/60
	var second = int(timerDuration)%60 
	return [hour, minute, second]


func timer_duration():
	$Work_Timer.wait_time = (floor(float($Work_Setup_Display/Hours_Work.text))*3600) + (floor(float($Work_Setup_Display/Minutes_Work.text))*60) + floor(float($Work_Setup_Display/Seconds_Work.text))
	var timerDuration = $Work_Timer.wait_time
	#Rounds to nearest integer
	var hour = int(timerDuration)/3600
	var minute = int(timerDuration) % 3600/60
	var second = int(timerDuration)%60
	return [hour, minute, second]

func work_load_duration():
	var timerDuration = SaveManager.current_save_data["Last_Timer_Length"]
	#Rounds to nearest integer
	var hour = int(timerDuration)/3600
	var minute = int(timerDuration) % 3600/60
	var second = int(timerDuration)%60
	return [hour, minute, second]




func _process(_delta):
	if Globals.work_timer_start == false:
		$Work_Label.text = "%02d:%02d:%02d" % timer_duration()
	elif Globals.work_timer_start == true:
		$Work_Label.text = "%02d:%02d:%02d" % time_left()


func _on_hours_text_submitted(new_text):
	$Work_Timer.wait_time = set_timer_length()
	$Work_Setup_Display.update_time_display()
	
func _on_minutes_text_submitted(new_text):
	$Work_Timer.wait_time = set_timer_length()
	$Work_Setup_Display.update_time_display()
	
func _on_seconds_text_submitted(new_text):
	$Work_Timer.wait_time = set_timer_length()
	$Work_Setup_Display.update_time_display()
	

func _on_add_pressed():
	$Work_Setup_Display/Minutes_Work.text = str(int($Work_Setup_Display/Minutes_Work.text)+5)
	$Work_Setup_Display.update_time_display()

func _on_subtract_pressed():
	$Work_Setup_Display/Minutes_Work.text = str(int($Work_Setup_Display/Minutes_Work.text)-5)
	$Work_Setup_Display.update_time_display()


func _on_start_pressed():
	Globals.work_timer_start = true
