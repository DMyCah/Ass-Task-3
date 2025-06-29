extends LineEdit


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_text_submitted(new_text):
	if int(new_text) >= 60:
		new_text = int(new_text) - 60
	self.text = "%02d" % int(new_text)
	
