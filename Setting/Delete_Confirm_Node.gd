extends Control

#hides panel if cancel is pressed
func _on_cancel_button_pressed():
	self.visible = false

#Hides panel when confirmed is pressed
func _on_confirm_button_pressed():
	self.visible = false

#Hides panel if outside of panel is pressed
func _on_click_cancel_gui_input(event):
	if event is InputEventMouseButton:
		self.visible = false
