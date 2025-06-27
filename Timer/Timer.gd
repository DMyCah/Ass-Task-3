extends Control

var timer_start = false
var timer_length = 1
var previous_length = 1

func _ready():
	set_timer_length()
	
func set_timer_length():
	timer_length = (floor(float($Timer_Display/Hours.text))*3600) + (floor(float($Timer_Display/Minutes.text))*60) + floor(float($Timer_Display/Seconds.text))
	print(timer_length)
	if timer_length == 0:
		timer_length = previous_length
	else:
		previous_length = timer_length
	return timer_length
	
func time_left():
	$Timer.wait_time = (floor(float($Timer_Display/Hours.text))*3600) + (floor(float($Timer_Display/Minutes.text))*60) + floor(float($Timer_Display/Seconds.text))
	var timerDuration = $Timer.time_left
	#Rounds to nearest integer
	var hour = int(timerDuration)/3600
	var minute = int(timerDuration) % 3600/60
	var second = int(timerDuration)%60 
	return [hour, minute, second]
	
func timer_duration():
	$Timer.wait_time = (floor(float($Timer_Display/Hours.text))*3600) + (floor(float($Timer_Display/Minutes.text))*60) + floor(float($Timer_Display/Seconds.text))
	var timerDuration = $Timer.wait_time
	#Rounds to nearest integer
	var hour = int(timerDuration)/3600
	var minute = int(timerDuration) % 3600/60
	var second = int(timerDuration)%60
	return [hour, minute, second]


func _process(_delta):
	if timer_start == false:
		$Timer_Label.text = "%02d:%02d:%02d" % timer_duration()
		print("Changing")
	elif timer_start == true:
		$Timer_Label.text = "%02d:%02d:%02d" % time_left()


func _on_start_pressed():
	$Timer.start()
	timer_start = true
	get_parent().timer_running()


func _on_hours_text_submitted(new_text):
	$Timer.wait_time = set_timer_length()
	
func _on_minutes_text_submitted(new_text):
	$Timer.wait_time = set_timer_length()
	
func _on_seconds_text_submitted(new_text):
	$Timer.wait_time = set_timer_length()
	

func _on_add_pressed():
	$Timer.wait_time = $Timer.wait_time + 300
	print("added")
	print($Timer.wait_time)
