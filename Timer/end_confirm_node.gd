extends Control


#Hide the end timer confirm box
func _on_cancel_button_pressed():
	self.visible = false

func _on_confirm_button_pressed():
	self.visible = false
