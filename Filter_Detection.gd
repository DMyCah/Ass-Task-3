extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func detection(type):
	self.visible = true
	$Panel/Line1.text = "INVALID: " + type + " MADE."
	if type == "USERNAME":
		$Panel/Line2.text = "ENSURE ONLY NON-MALICIOUS CHARACTERS ARE USED\nLIMIT USERNAME TO 1-20 CHARACTERS"
	elif type == "INPUT":
		$Panel/Line2.text = "ENSURE ONLY NON-MALICIOUS CHARACTERS ARE USED\nLIMIT TEXT INPUTS TO 100 CHARACTERS"
	await get_tree().create_timer(5).timeout
	self.visible = false
