extends Control

#Sets the displayed text to the LOADING duration
func load_time_display():
	print("Display updated")
	$Hours_Work.text = "%02d" % (get_parent().work_load_duration()[0])
	$Minutes_Work.text = "%02d" % (get_parent().work_load_duration()[1])
	$Seconds_Work.text = "%02d" % (get_parent().work_load_duration()[2])

#Sets the displayed text to the CURRENT duration set
func update_time_display():
	print("Display updated")
	$Hours_Work.text = "%02d" % (get_parent().timer_duration()[0])
	$Minutes_Work.text = "%02d" % (get_parent().timer_duration()[1])
	$Seconds_Work.text = "%02d" % (get_parent().timer_duration()[2])
