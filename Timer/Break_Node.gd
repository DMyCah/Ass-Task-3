extends Control

var break_length = 1
var previous_length = 1

func _ready():
	set_break_length()
	
func set_break_length():
	break_length = (floor(float($Break_Setup_Display/Hours_Break.text))*3600) + (floor(float($Break_Setup_Display/Minutes_Break.text))*60) + floor(float($Break_Setup_Display/Seconds_Break.text))
	
	#Check if timer length is = 0 and resets to previous length if it is
	if break_length == 0:
		break_length = previous_length
	else:
		previous_length = break_length
	return break_length
	
func break_left():
	var breakDuration = $Break_Timer.time_left
	#Rounds to nearest integer
	var hour = int(breakDuration)/3600
	var minute = int(breakDuration) % 3600/60
	var second = int(breakDuration)%60 
	return [hour, minute, second]
	
func break_duration():
	$Break_Timer.wait_time = (floor(float($Break_Setup_Display/Hours_Break.text))*3600) + (floor(float($Break_Setup_Display/Minutes_Break.text))*60) + floor(float($Break_Setup_Display/Seconds_Break.text))
	var breakDuration = $Break_Timer.wait_time
	#Rounds to nearest integer
	var hour = int(breakDuration)/3600
	var minute = int(breakDuration) % 3600/60
	var second = int(breakDuration)%60
	return [hour, minute, second]


func _process(_delta):
	if Globals.break_timer_start == false:
		$Break_Label.text = "%02d:%02d:%02d" % break_duration()
		#print("Changing")
	elif Globals.break_timer_start == true:
		$Break_Label.text = "%02d:%02d:%02d" % break_left()


func _on_break_timeout():
	pass

func _on_hours_text_submitted(new_text):
	$Break_Timer.wait_time = set_break_length()
	$Break_Setup_Display.update_time_display()
	
func _on_minutes_text_submitted(new_text):
	$Break_Timer.wait_time = set_break_length()
	$Break_Setup_Display.update_time_display()
	
func _on_seconds_text_submitted(new_text):
	$Break_Timer.wait_time = set_break_length()
	$Break_Setup_Display.update_time_display()
	

func _on_add_pressed():
	$Break_Setup_Display/Minutes_Break.text = str(int($Break_Setup_Display/Minutes_Break.text)+5)
	$Break_Setup_Display.update_time_display()


func _on_subtract_pressed():
	$Break_Setup_Display/Minutes_Break.text = str(int($Break_Setup_Display/Minutes_Break.text)-5)
	$Break_Setup_Display.update_time_display()
