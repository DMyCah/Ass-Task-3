extends LineEdit


#Sets its text to be in the format of "00", maximum of 2, filled in by 0 if empty space
func _on_text_submitted(new_text):
	if int(new_text) >= 60:
		new_text = int(new_text) - 60
	self.text = "%02d" % int(new_text)
	
