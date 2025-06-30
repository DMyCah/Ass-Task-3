extends Node2D

#Change to be saved depending on persons preference
var mode = SaveManager.current_save_data["timer_Mode_Prefernce"]

# Called when the node enters the scene tree for the first time.
func _ready():
	$Work_Node/Work_Label.visible = false
	$Break_Node/Break_Label.visible = false
	$End_Confirm_Node.visible = false
	if mode == "Normal":
		display_Normal()
	elif mode == "Pomodoro":
		display_Pomodoro()


func display_Normal():
	$Break_Node/Break_Setup_Display.visible = false
	$Break_Node/Break_Title.visible = false
	
func display_Pomodoro():
	$Break_Node/Break_Setup_Display.visible = true
	$Break_Node/Break_Title.visible = true



func timer_running():
	$Start_Button.visible = false
	$Normal_Button.visible = false
	$Pomodoro_Button.visible = false
	$Pause_Button.visible = true
	$End_Button.visible = true
	
	
	$Work_Node/Work_Setup_Display.visible = false
	$Work_Node/Work_Title.visible = false
	$Work_Node/Work_Label.visible = true
	
	
	$Break_Node/Break_Setup_Display.visible = false
	$Break_Node/Break_Title.visible = false
	if mode == "Pomodoro":
		$Break_Node/Break_Label.visible = true
	
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
	
	if mode == "Pomodoro":
		$Break_Node/Break_Setup_Display.visible = true
		$Break_Node/Break_Title.visible = true
	

func break_running():
	$Timer_Node/Timer_Label.visible = false

	$Break_Node/Break_Label.visible = true

func timer_end():
	$Break_Node/Break_Label.visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	mode = Globals.timer_Mode


func _on_pomodoro_pressed():
	print("Mode Pomodoro")
	Globals.timer_Mode = "Pomodoro"
	display_Pomodoro() 

func _on_normal_pressed():
	print("Mode Normal")
	Globals.timer_Mode = "Normal"
	display_Normal()


func _on_start_button_pressed():
	$Work_Node/Work_Timer.start()
	timer_running()

func _on_pause_button_pressed():
	if Globals.work_timer_start == true:
		if $Work_Node/Work_Timer.paused == false:
			$Work_Node/Work_Timer.paused = true
			$Pause_Button.text = "Resume"

		elif $Work_Node/Work_Timer.paused == true:
			$Work_Node/Work_Timer.paused = false
			$Pause_Button.text = "Pause"
	elif Globals.break_timer_start == true:
		if $Break_Node/Break_Timer.paused == false:
			$Break_Node/Break_Timer.paused = true
			$Pause_Button.text = "Resume"

		elif $Break_Node/Break_Timer.paused == true:
			$Break_Node/Break_Timer.paused = false
			$Pause_Button.text = "Pause"

func _on_end_button_pressed():
	if Globals.work_timer_start == true:
		$Work_Node/Work_Timer.paused = true
		$Pause_Button.text = "Resume"

	elif Globals.break_timer_start == true:
		$Break_Node/Break_Timer.paused = true
		$Pause_Button.text = "Resume"
	$End_Confirm_Node.visible = true

func _on_cancel_button_pressed():
	$End_Confirm_Node.visible = false

func _on_confirm_button_pressed():
	$Work_Node/Work_Timer.stop()
	$Break_Node/Break_Timer.stop()
	$Work_Node/Work_Timer.paused = false
	$Break_Node/Break_Timer.paused = false
	$Pause_Button.text = "Pause"
	timer_setup()
	




func _on_work_timer_timeout():
	$Work_Node/Work_Timer.stop()
	Globals.work_timer_start = false
	if mode == "Normal":
		timer_setup()
	elif mode == "Pomodoro":
		#$Work_Node/Work_Label.text = "%02d:%02d:%02d" % $Work_Node.timer_duration()
		print("Break start")
		Globals.break_timer_start = true
		$Break_Node/Break_Timer.start()
		


func _on_break_timer_timeout():
	$Break_Node/Break_Timer.stop()
	#if repeat == "done":
	#Create condition to loop for certain amount of times
	$Work_Node/Work_Timer.start()
	Globals.break_timer_start = false
	Globals.work_timer_start = true




