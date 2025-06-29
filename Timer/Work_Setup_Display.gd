extends Control

func update_time_display():
	print("Display updated")
	$Hours_Work.text = "%02d" % (get_parent().timer_duration()[0])
	$Minutes_Work.text = "%02d" % (get_parent().timer_duration()[1])
	$Seconds_Work.text = "%02d" % (get_parent().timer_duration()[2])
