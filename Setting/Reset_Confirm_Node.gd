extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_cancel_button_pressed():
	self.visible = false

func _on_confirm_button_pressed():
	self.visible = false

func _on_click_cancel_gui_input(event):
	if event is InputEventMouseButton:
		self.visible = false
