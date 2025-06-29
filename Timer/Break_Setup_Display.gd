extends Control

func update_time_display():
	print("Display updated")
	$Hours_Break.text = "%02d" % (get_parent().break_duration()[0])
	$Minutes_Break.text = "%02d" % (get_parent().break_duration()[1])
	$Seconds_Break.text = "%02d" % (get_parent().break_duration()[2])
