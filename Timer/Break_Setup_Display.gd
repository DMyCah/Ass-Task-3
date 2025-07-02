extends Control

#Sets the displayed text to the LOADING duration
func load_time_display():
	$Hours_Break.text = "%02d" % (get_parent().break_load_duration()[0])
	$Minutes_Break.text = "%02d" % (get_parent().break_load_duration()[1])
	$Seconds_Break.text = "%02d" % (get_parent().break_load_duration()[2])

#Sets the displayed text to the CURRENT duration set
func update_time_display():
	$Hours_Break.text = "%02d" % (get_parent().break_duration()[0])
	$Minutes_Break.text = "%02d" % (get_parent().break_duration()[1])
	$Seconds_Break.text = "%02d" % (get_parent().break_duration()[2])
