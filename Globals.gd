extends Node

var timer_Mode = "Normal"
var work_timer_start = false
var break_timer_start = false
var current_scene = "main_menu"
var game_last_scene = "collection"
var current_wardrobe_tab = "Headwear/"
var displaying_duck_ID = ""

func load_save_data():
	timer_Mode = SaveManager.current_save_data["timer_Mode_Prefernce"]
	
func save_global_data():
	SaveManager.current_save_data["timer_Mode_Prefernce"] = timer_Mode
